package net.retrocade.stats.outputs
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.SharedObject;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;

    import net.retrocade.stats.core.StatsData;
    import net.retrocade.utils.USecure;
    import net.retrocade.utils.printf;

    public class RemoteStatsOutput extends EventDispatcher implements IStatsOutput
	{
		private var _queuedData:Vector.<StatsData>;
		private var _currentUploadedData:Vector.<StatsData>;

		private var _urlLoader:URLLoader;
		private var _queueNextUpload:Boolean = false;

        private var _apiUrl:String;
        private var _project:String;
        private var _secretKey:String;
        private var _secretSalt:String;
        private var _userid:String;

		private var _cacheSharedObject:SharedObject;
		private var _cacheId:String;

		public function RemoteStatsOutput(apiUrl:String, secretKey:String, secretSalt:String, project:String, userid:String)
		{
			if (!apiUrl || apiUrl.length == 0)
			{
				throw new ArgumentError("apiUrl has to point to a valid URL");
			}

			_queuedData = new Vector.<StatsData>();
			_currentUploadedData = new Vector.<StatsData>();

            _apiUrl = apiUrl;
            _project = project;
			_secretKey = secretKey;
			_secretSalt = secretSalt;
            _userid = userid;
			_cacheId = generateCacheId();

			_cacheSharedObject = SharedObject.getLocal(_cacheId);

			importCache();
		}

		public function addData(entry:StatsData):void
		{
			_queuedData.push(entry);
			cacheData.push(entry);
			_cacheSharedObject.flush();
		}

		public function pushAllData():void
		{
			if (_urlLoader)
			{
				_queueNextUpload = true;
				return;
			}

			if (_queuedData.length == 0)
			{
				return;
			}

			_queueNextUpload = false;

			createUrlLoader();

			var urlRequest:URLRequest = new URLRequest(_apiUrl);
			var urlVariables:URLVariables = new URLVariables();

			var index:int = 0;

            /**
             * POST Params:
             *  - String $project
             *  - String $checksum
             *  - String $userid
             *  - String[] $key
             *  - String[] $value
             *  - String[] $timestamp
             *  - String[] $meta
             *  - String[] $hash
             */

            urlVariables['project'] = _project;
            urlVariables['checksum'] = _secretKey;
            urlVariables['userid'] = _userid;

			for each(var data:StatsData in _queuedData)
			{
                urlVariables[printf('key[%%]', index)] = data.key;
                urlVariables[printf('value[%%]', index)] = data.value;
                urlVariables[printf('timestamp[%%]', index)] = data.timestamp;
                urlVariables[printf('hash[%%]', index)] = hashData(data);

                extractMeta(index, urlVariables, data);
				_currentUploadedData.push(data);
				index++;
			}

			urlRequest.method = URLRequestMethod.POST;
			urlRequest.data = urlVariables;

			_urlLoader.load(urlRequest);
		}

        private function extractMeta(rowIndex:int,  urlVariables:URLVariables, statsData:StatsData):void{
            if (statsData.metaLength){
                for (var key:String in statsData.meta){
                    urlVariables[printf('meta[%%][%%]', rowIndex, key)] = statsData.meta[key];
                }
            }
        }

        private function hashData(statsData:StatsData):String{
			return "";
            // return MD5.encrypt(
                    // _secretSalt + statsData.key + statsData.value + statsData.timestamp + statsData.metaLength
            // );
        }

		private function createUrlLoader():void{
			_urlLoader = new URLLoader();
			_urlLoader.addEventListener(Event.COMPLETE, onLoadComplete);
			_urlLoader.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			_urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
		}

		private function destroyUrlLoader():void{
			_urlLoader.removeEventListener(Event.COMPLETE, onLoadComplete);
			_urlLoader.removeEventListener(IOErrorEvent.IO_ERROR, onIOError);
			_urlLoader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
			_urlLoader = null;

			_currentUploadedData.length = 0;
		}

		private function onLoadComplete(e:Event):void{
			removeSentFromCache();

			destroyUrlLoader();

			if (_queueNextUpload)
			{
				pushAllData();
			}
		}

		private function onIOError( e:IOErrorEvent):void{
			destroyUrlLoader();
		}

		private function onSecurityError(e:SecurityErrorEvent):void{
			destroyUrlLoader();
		}

		private function removeSentFromCache():void{
			for each(var data:StatsData in _currentUploadedData)
			{
				var index:int = _queuedData.indexOf(data);

				if (index != -1)
				{
					_queuedData.splice(index, 1);
				}

				index = cacheData.indexOf(data);
				if (index != -1)
				{
					cacheData.splice(index, 1);
				}
			}

			_cacheSharedObject.flush();
		}

		private function importCache():void
		{
			if (!_cacheSharedObject.data[_cacheId])
			{
				_cacheSharedObject.data[_cacheId] = [];
				return;
			}

			for each(var data:StatsData in cacheData)
			{
				_queuedData.push(data);
			}

			pushAllData();
		}

		public function get dataCount():uint
		{
			return _queuedData.length;
		}

		public function clearData():void
		{
			_queuedData.length = 0;
		}

		private function generateCacheId():String{
			var cacheID:String = USecure.hashStringJenkins(_apiUrl + _secretKey).toString();

			return cacheID;
		}

		public function get cacheData():Array{
			return _cacheSharedObject.data[_cacheId];
		}
	}
}