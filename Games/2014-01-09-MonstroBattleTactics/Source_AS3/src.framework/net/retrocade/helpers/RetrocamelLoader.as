

package net.retrocade.helpers{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.utils.ByteArray;

	public class RetrocamelLoader extends Loader{
		public var successCallback:Function;
		public var failureCallback:Function;

		public function RetrocamelLoader(dataOrUrl:Object, success:Function = null, failure:Function = null){
			super();

			successCallback = success;
			failureCallback = failure;

			contentLoaderInfo.addEventListener(Event.COMPLETE,              onComplete);
			contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,       onError);

			if (dataOrUrl is String){
				var urlRequest:URLRequest = new URLRequest(dataOrUrl as String);
				load(urlRequest);
			} else if (dataOrUrl is ByteArray){
				loadBytes(dataOrUrl as ByteArray);
			}
		}

		private function onComplete(e:Event):void{
			if (successCallback != null)
				if (successCallback.length == 1)
					successCallback(e);
				else
					successCallback();

			unset();
		}

		private function onError(e:Event):void{
			if (failureCallback != null)
				if (failureCallback.length == 1)
					failureCallback(e);
				else
					failureCallback();

			unset();
		}

		private function unset():void{
			contentLoaderInfo.removeEventListener(Event.COMPLETE,        onComplete);
			contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onError);

			successCallback = null;
			failureCallback = null;
		}
	}
}