package net.retrocade.retrocamel.core {
    public class RetrocamelLateCall {
        private static var _calls:Array = [];
        private static var _registeredCallsNumber:uint = 0;

        public static function registerCall(func:Function, params:Array = null):void{
            _calls[_registeredCallsNumber++] = [func, params ? params : []];
        }

        public static function hasCallTo(func:Function):Boolean{
            for (var i:int = 0; i < _registeredCallsNumber; i++){
                if (_calls[i][0] === func){
                    return true;
                }
            }

            return false;
        }

        retrocamel_int static function performCalls():void{
            for (var i:int = 0; i < _registeredCallsNumber; i++){
                _calls[i][0].apply(null, _calls[i][1]);
            }

            _registeredCallsNumber = 0;
        }
    }
}
