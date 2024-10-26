package net.retrocade.starling{
    import flash.display.Stage;
    import flash.geom.Rectangle;

    import net.retrocade.camel.global.rCursor;

    import net.retrocade.camel.global.rDisplay;
    import net.retrocade.camel.global.retrocamel_int;
    import net.retrocade.camel.interfaces.rIStarlingRoot;

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

        private static var _isInitialized:Boolean = false;

        public static function initialize(root:Class, stage:Stage, viewPort:Rectangle = null, onInitializeCallback:Function = null):void{
            _initializeCallback = onInitializeCallback;

            checkRootClass(root);

            Starling.multitouchEnabled = true;

            _starlingInstance = new Starling(root, stage, viewPort, null, 'auto', 'baseline');
            _starlingInstance.addEventListener(Event.ROOT_CREATED, onStarlingCreated);
            _starlingInstance.antiAliasing = 0;
            _starlingInstance.start();

            _starlingInstance.simulateMultitouch = false;
        }

        public static function get juggler():Juggler{
            return _starlingInstance.juggler;
        }

        private static function onStarlingCreated(e:Event):void{
            _isInitialized = true;

            _starlingRoot = e.data as Sprite;
            rDisplay.initializeStarling(_starlingRoot.stage);
            rCursor.initializeStarling();

            if (_initializeCallback != null){
                _initializeCallback();
            }

            rIStarlingRoot(_starlingRoot).init();
        }

        private static function checkRootClass(cls:Class):void{
            var instance:* = new cls;

            if (!(instance is Sprite)){
                throw new ArgumentError("Passed class should extends starling.display.Sprite");
            }

            if (!(instance is rIStarlingRoot)){
                throw new ArgumentError("Passed class should implements rIStarlingRoot");
            }
        }

        public static function get isInitialized():Boolean {
            return _isInitialized;
        }
    }
}