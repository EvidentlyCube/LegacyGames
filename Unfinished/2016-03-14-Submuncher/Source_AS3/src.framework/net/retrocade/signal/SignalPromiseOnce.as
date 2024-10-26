package net.retrocade.signal{
    public class SignalPromiseOnce{
        private var _listeners:Vector.<Function>;
        private var _wasCalled:Boolean;
        private var _callParams:Array;

        public function SignalPromiseOnce(){
            _listeners = new Vector.<Function>();
        }

        public function add(callback:Function):void{
            if (_wasCalled){
                callFunction(callback);
            } else {
                if (_listeners.indexOf(callback) === -1){
                    _listeners.push(callback);
                }
            }

        }

        public function remove(callback:Function):void{
            var index:int = _listeners.indexOf(callback);

            if (index !== -1){
                _listeners.splice(index, 1);
            }
        }

        public function call(...args):void{
            _callParams = args;

            for each(var callback:Function in _listeners){
                callFunction(callback);
            }

            _listeners.length = 0;
        }

        private function callFunction(callback:Function):void {
            if (callback.length === 0) {
                callback();
            } else {
                callback.apply(null, _callParams);
            }
        }

        public function clear():void{
            _listeners.length = 0;
        }
    }
}
