package net.retrocade.random {
    public class Random {
        private static var _defaultEngineType:RandomEngineType;
        private static var _defaultEngine:IRandomEngine;


        public static function createEngine(type:RandomEngineType = null):IRandomEngine{
            if (!type){
                type = _defaultEngineType || RandomEngineType.KISS;
            }

            var randomEngine:IRandomEngine = new (type.engineClass);
            randomEngine.randomizeSeed();

            return randomEngine;
        }

        public static function get defaultEngineType():RandomEngineType {
            return _defaultEngineType;
        }

        public static function set defaultEngineType(value:RandomEngineType):void {
            if (_defaultEngineType !== value){
                _defaultEngineType = value;

                _defaultEngine = createEngine(_defaultEngineType);
            }
        }

        public static function get defaultEngine():IRandomEngine {
            if (!_defaultEngine){
                defaultEngineType = RandomEngineType.LGM_1969;
            }

            return _defaultEngine;
        }
    }
}
