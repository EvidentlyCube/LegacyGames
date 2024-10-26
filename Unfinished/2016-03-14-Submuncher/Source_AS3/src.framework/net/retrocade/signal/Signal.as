package net.retrocade.signal{
    public class Signal{
        private var _listeners:Vector.<Function>;
        private var _isDirty:Boolean;

        public function Signal(){
            _listeners = new Vector.<Function>();
            _isDirty = false;
        }

        public function add(callback:Function):void{
            if (_listeners.indexOf(callback) === -1){
                _listeners.push(callback);
            }
        }

        public function remove(callback:Function):void{
            var index:int = _listeners.indexOf(callback);

            if (index !== -1){
                _listeners[index] = null;
                _isDirty = true;
            }
        }

        public function call(...args):void{
            cleanupDirty();

            for each(var callback:Function in _listeners){
                if (callback.length === 0){
                    callback();
                } else {
                    callback.apply(null, args);
                }
            }
        }

        public function dispose():void{
            _listeners.length = 0;
            _listeners = null;
        }

        private function cleanupDirty():void {
            if (_isDirty){
                var l  :uint = _listeners.length;
                var i  :uint = 0;
                var gap:uint = 0;

                for (;i < l; i++){
                    if (_listeners[i] == null){
                        gap++;

                    } else if (gap){
                        _listeners[i - gap] = _listeners[i];
                    }
                }

                _listeners.length -= gap;
                _isDirty = false;
            }
        }
    }
}
