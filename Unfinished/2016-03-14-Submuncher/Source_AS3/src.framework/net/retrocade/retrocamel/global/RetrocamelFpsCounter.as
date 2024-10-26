package net.retrocade.retrocamel.global{
    import flash.utils.getTimer;

    import net.retrocade.retrocamel.core.retrocamel_int;

    public class RetrocamelFpsCounter{
        private static var _nextCountReset:Number;
        private static var _framesCounted:uint;
        private static var _lastFramesCounted:uint;
        private static var _traceFps:Boolean;

        retrocamel_int static function init():void{
            _nextCountReset = getTimer() + 1000;
            _framesCounted = 0;
            _lastFramesCounted = 0;
        }

        retrocamel_int static function update():void{
            if (getTimer() > _nextCountReset){
                _lastFramesCounted = _framesCounted;
                _framesCounted = 1;
                _nextCountReset = getTimer() + 1000;

                if (_traceFps){
                    trace(fps);
                }
            } else {
                _framesCounted++;
            }
        }

        public static function get fps():uint{
            return _lastFramesCounted;
        }


        public static function get traceFps():Boolean{
            return _traceFps;
        }

        public static function set traceFps(value:Boolean):void{
            _traceFps = value;
        }
    }
}
