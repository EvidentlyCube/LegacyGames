package net.retrocade.starling{
    import flash.display.Stage;
    import flash.geom.Rectangle;

    import net.retrocade.camel.global.retrocamel_int;

    import starling.animation.Juggler;
    import starling.core.Starling;
    import starling.display.Sprite;
    import starling.events.Event;

    use namespace retrocamel_int;

    public class rStarling{
        retrocamel_int static var _starlingInstance:Starling;
        retrocamel_int static var _starlingRoot    :Sprite;

        public static function get starlingInstance():Starling{
            return _starlingInstance;
        }

        public static function get starlingRoot():Sprite{
            return _starlingRoot;
        }

        private static var _initializeCallback:Function;

        public static function initialize(root:Class, stage:Stage, viewPort:Rectangle = null, onInitializeCallback:Function = null):void{
            _initializeCallback = onInitializeCallback;

            Starling.multitouchEnabled = true;

            _starlingInstance = new Starling(root, stage, viewPort, null, 'auto', 'baseline');
            _starlingInstance.addEventListener(Event.ROOT_CREATED, onStarlingCreated);
            _starlingInstance.antiAliasing = 16;
            _starlingInstance.start();

            _starlingInstance.simulateMultitouch = false;
        }

        public static function get juggler():Juggler{
            return _starlingInstance.juggler;
        }

        private static function onStarlingCreated(e:Event):void{
            _starlingRoot = e.data as Sprite;

            if (_initializeCallback != null)
                _initializeCallback();
        }
    }
}