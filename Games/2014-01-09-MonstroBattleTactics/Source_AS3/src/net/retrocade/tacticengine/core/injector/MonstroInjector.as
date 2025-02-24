
package net.retrocade.tacticengine.core.injector {
    import org.swiftsuspenders.Injector;

    public class MonstroInjector {
        private static var _injector:Injector = new Injector();

        public static function create(clazz:Class, ...initParams):*{
            var instance:Object = _injector.instantiate(clazz);

            if (instance.hasOwnProperty("init")){
                var initFunction:Function = instance.init as Function;
                if (initFunction.length != initParams.length){
                    throw new ArgumentError("Invalid number of init parameters");
                }

                initFunction.apply(instance, initParams);
            }

            return instance;
        }

        public static function fill(object:Object):void{
            _injector.injectInto(object);
        }

        public static function mapValue(whenAskedFor:Class, useValue:Object):void{
            unmap(whenAskedFor);
            _injector.mapValue(whenAskedFor, useValue);
        }

        public static function unmap(clazz:Class):void{
            if (_injector.hasMapping(clazz)){
                _injector.unmap(clazz);
            }
        }

        public static function prepareClass(className:Class):void{
            _injector.cacheClassMappingsAsync(className);
        }
    }
}
