

package net.retrocade.helpers{
    import flash.errors.IOError;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.events.SecurityErrorEvent;
    import flash.net.URLLoader;
    import flash.net.URLLoaderDataFormat;
    import flash.net.URLRequest;
    import flash.net.URLRequestMethod;
    import flash.net.URLVariables;

    /**
     * ...
     * @author Maurycy Zarzycki
     */
    public class RetrocamelUrlLoader extends URLLoader{

        private var _successCallback:Function;
        private var _failureCallback:Function;

        private var _urlRequest  :URLRequest;
        private var _urlVariables:URLVariables;

        private var _isFinished  :Boolean = false;

        public function get isFinished():Boolean{
            return _isFinished;
        }

        private var _inProgress:Boolean = true;

        public function get inProgress():Boolean {
            return _inProgress;
        }

        /**
         * Useful for storing additional information in the loader
         */
        public var metaData:*;


        override public function close():void {
            super.close();

            _isFinished = true;
            _inProgress = false;
        }

        /******************************************************************************************************/
        /**                                                                                        FUNCTIONS  */
        /******************************************************************************************************/

        public function RetrocamelUrlLoader(url:String, data:Object = null, successCallback:Function = null, failureCallback:Function = null, dataFormat:String = "text"){
            super(null);

            _urlVariables = new URLVariables();
            for(var i:String in data)
                _urlVariables[i] = data[i];

            _urlRequest        = new URLRequest(url);
            _urlRequest.data   = _urlVariables;
            _urlRequest.method = URLRequestMethod.POST;

            this.dataFormat = dataFormat;

            _successCallback = successCallback;
            _failureCallback = failureCallback;

            if (_successCallback != null)
                addEventListener(Event.COMPLETE, onSuccess);

            if (_failureCallback != null){
                addEventListener(IOErrorEvent.IO_ERROR, onError);
                addEventListener(SecurityErrorEvent.SECURITY_ERROR, onError);
            }

            load(_urlRequest);
        }

        private function onSuccess(e:Event):void{
            _isFinished = true;
            _inProgress = false;

            if (_successCallback != null){
                if (_successCallback.length == 1)
                    _successCallback(data);
                else
                    _successCallback();
            }

            clearListeners();
        }

        private function onError(e:*):void{
            _isFinished = true;
            _inProgress = false;

            if (_failureCallback != null) {
                if (_failureCallback.length == 1)
                    _failureCallback(e);
                else
                    _failureCallback();
            }

            clearListeners();
        }

        private function clearListeners():void{
            removeEventListener(Event.COMPLETE, onSuccess);
            removeEventListener(IOErrorEvent.IO_ERROR, onError);
            removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onError);

            _successCallback = null;
            _failureCallback = null;
        }
    }
}