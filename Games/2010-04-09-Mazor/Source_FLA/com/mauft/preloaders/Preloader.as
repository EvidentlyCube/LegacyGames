package com.mauft.preloaders{
    import flash.display.LoaderInfo;
    import flash.display.MovieClip;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.events.ProgressEvent;

    public class Preloader extends MovieClip{
        public static var DEBUG:Boolean = false;
        
        private   var _loaderInfo    :LoaderInfo;
        private   var _finishCallback:Function;
        private   var _errorCallback :Function;
        
        protected var _progress      :Number;
        
        public function Preloader(loaderInfo:LoaderInfo, finishCallback:Function = null, errorCallback:Function = null){
            _loaderInfo     = loaderInfo;
            _finishCallback = finishCallback;
            _errorCallback  = errorCallback;
            
            if (!DEBUG){
                _loaderInfo.addEventListener(ProgressEvent.PROGRESS, loadProgress);
                _loaderInfo.addEventListener(Event.COMPLETE,         loadComplete);
                _loaderInfo.addEventListener(IOErrorEvent.IO_ERROR,  loadError);
            } else {
                addEventListener(Event.ENTER_FRAME, function():void{ _progress = (_progress + 0.01) % 1; update(); });
           }
        }
        
        protected function update():void{}
        
        final private function loadComplete(e:Event):void{
            unsetLoaders();
            
            if (_finishCallback != null){
                _finishCallback();
            }
        }
        
        final private function loadProgress(e:ProgressEvent):void{
            if (DEBUG){
               _progress = (_progress + 0.01) % 1;
            } else {
               _progress = e.bytesLoaded / e.bytesTotal;
            }
            
            update();
        }
        
        final private function loadError(e:IOErrorEvent):void{
            unsetLoaders();
            
            if (_errorCallback != null){
                _errorCallback();
            }
        }
        
        final private function unsetLoaders():void{
            _loaderInfo.removeEventListener(Event.COMPLETE,         loadComplete);
            _loaderInfo.removeEventListener(ProgressEvent.PROGRESS, loadProgress);
            _loaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,  loadError);
        }
    }
}