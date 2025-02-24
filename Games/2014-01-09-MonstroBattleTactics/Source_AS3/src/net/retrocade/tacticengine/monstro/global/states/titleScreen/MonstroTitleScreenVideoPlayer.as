
package net.retrocade.tacticengine.monstro.global.states.titleScreen {
    import flash.events.Event;
    import flash.events.NetStatusEvent;
	import flash.media.Video;
    import flash.net.NetConnection;
    import flash.net.NetStream;
    import flash.utils.setTimeout;

    import net.retrocade.retrocamel.core.RetrocamelDisplayManager;
    import net.retrocade.tacticengine.core.IDisposable;
    import net.retrocade.tacticengine.monstro.global.core.MonstroConsts;

    public class MonstroTitleScreenVideoPlayer implements IDisposable {

        private var _videoRatio:Number = 1024 / 768;
        private var _video:Video;
        private var _netConnection:NetConnection;
        private var _netStream:NetStream;
        private var _finishCallback:Function;
        //noinspection JSFieldCanBeLocal
        private var _duration:int;
        private var _realVideoWidth:Number = 1024;
        private var _realVideoHeight:Number = 768;

        private var _isStarted:Boolean = false;

        public function MonstroTitleScreenVideoPlayer(videoPath:String, finishCallback:Function) {
            CF::desktop {
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

                _video.addEventListener(Event.ENTER_FRAME, onEnterFrame);

                onEnterFrame(null);

                _isStarted = true;
            }
            CF::flash {
                setTimeout(finishCallback, 100);
            }
        }

        public function dispose():void {
            if (_video) {
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
            _realVideoWidth = 1024;//data.width; // 1024
            _realVideoHeight = 768;//data.height; // 768
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
            return _video ? _video.alpha : 0;
        }

        public function set alpha(value:Number):void {
            if (_video) {
                _video.alpha = value;
            }
        }

        public function get x():Number{
            return _video ? _video.x : 0;
        }

        public function get y():Number{
            return _video ? _video.y : 0;
        }

        public function get scale():Number{
            return _video ? _video.width / _realVideoWidth : 1;
        }

		public function get width():Number{
			return _video ? _video.width : 1;
		}

        public function endVideo():void{
            if (_netStream){
                _netStream.seek(_duration);
                killWithFire();
            }
        }

        private function onNetStatusEvent(event:NetStatusEvent):void {
			if (event.info.code === "NetStream.Play.StreamNotFound"){
				killWithFire();
			} else if (event.info.code == "NetStream.Buffer.Empty" && _isStarted){
                killWithFire();
            }
        }

        private function killWithFire():void {
            _finishCallback();
        }
    }
}
