
package net.retrocade.tacticengine.monstro.global.states.titleScreen {
	import flash.events.Event;
	import flash.events.NetStatusEvent;
	import flash.media.SoundTransform;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;

	import net.retrocade.retrocamel.core.RetrocamelDisplayManager;
	import net.retrocade.tacticengine.core.IDisposable;
	import net.retrocade.tacticengine.monstro.global.core.MonstroConsts;
	import net.retrocade.tacticengine.monstro.global.core.MonstroData;

	public class MonstroRetrocadeLogoVideoPlayer implements IDisposable {

		private var _videoRatio:Number = 1920 / 1080;
		private var _video:Video;
		private var _netConnection:NetConnection;
		private var _netStream:NetStream;
		private var _finishCallback:Function;
		//noinspection JSFieldCanBeLocal
		private var _duration:int;
		private var _realVideoWidth:Number = 1920;
		private var _realVideoHeight:Number = 1080;

		private var _isStarted:Boolean = false;

		public function MonstroRetrocadeLogoVideoPlayer(videoPath:String, finishCallback:Function) {
			_finishCallback = finishCallback;

			_video = new Video(10, 10);
			RetrocamelDisplayManager.flashApplication.addChild(_video);

			_netConnection = new NetConnection();
			_netConnection.connect(null);

			_netStream = new NetStream(_netConnection);
			_netStream.addEventListener(NetStatusEvent.NET_STATUS, onNetStatusEvent);
			_netStream.client = this;

			_video.attachNetStream(_netStream);
			_netStream.play(videoPath);
			if (MonstroData.getMusicEnabled()){
				_netStream.soundTransform = new SoundTransform(MonstroData.getMusicVolume());
			} else {
				_netStream.soundTransform = new SoundTransform(0);
			}

			_video.addEventListener(Event.ENTER_FRAME, onEnterFrame);

			onEnterFrame(null);

			_isStarted = true;
		}

		public function stop():void {
			_netStream.pause();
		}

		public function dispose():void {
			CF::desktop {
				_video.removeEventListener(Event.ENTER_FRAME, onEnterFrame);

				RetrocamelDisplayManager.flashApplication.removeChild(_video);

				_video.clear();
				_netStream.close();
				_netConnection.close();

				_video = null;
				_netStream = null;
				_netConnection = null;

				_finishCallback = null
			}
		}

		//noinspection JSUnusedGlobalSymbols
		public function onMetaData(data:Object):void {
			_realVideoWidth = 1920;//data.width; // 1024
			_realVideoHeight = 1080;//data.height; // 768
			_videoRatio = _realVideoWidth / _realVideoHeight;

			_duration = 4.04;//data.duration; // 4.04`

			onEnterFrame(null);
		}

		//noinspection JSUnusedGlobalSymbols,JSUnusedLocalSymbols
		public function onXMPData(infoObject:Object):void {
		}

		//noinspection JSUnusedGlobalSymbols
		public function onPlayStatus(data:Object):void {
			if (data && data.code && data.code == "NetStream.Play.Complete") {
				killWithFire();
			}
		}

		private function onEnterFrame(event:Event):void {
			var screenRatio:Number = MonstroConsts.gameWidth / MonstroConsts.gameHeight;

			if (screenRatio < _videoRatio) {
				_video.width = MonstroConsts.gameWidth;
				_video.height = MonstroConsts.gameWidth / _videoRatio;
			} else {
				_video.height = MonstroConsts.gameHeight;
				_video.width = MonstroConsts.gameHeight * _videoRatio;
			}

			_video.x = (MonstroConsts.gameWidth - _video.width) / 2 | 0;
			_video.y = (MonstroConsts.gameHeight - _video.height) / 2 | 0;
		}

		public function get alpha():Number {
			return _video.alpha;
		}

		public function set alpha(value:Number):void {
			_video.alpha = value;
		}

		public function get x():Number {
			return _video.x;
		}

		public function get y():Number {
			return _video.y;
		}

		public function get scale():Number {
			return _video.width / _realVideoWidth;
		}

		public function get width():Number {
			return _video.width;
		}

		public function endVideo():void {
			if (_netStream) {
				_netStream.seek(_duration);
				killWithFire();
			}
		}

		private function onNetStatusEvent(event:NetStatusEvent):void {
			if (event.info.code === "NetStream.Play.StreamNotFound"){
				killWithFire();
			} else if (event.info.code == "NetStream.Buffer.Empty" && _isStarted) {
				killWithFire();
			}
		}

		private function killWithFire():void {
			_finishCallback();
		}
	}
}
