package net.retrocade.camel.global{
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.DisplayObject;
    import flash.display.DisplayObjectContainer;
    import flash.display.GradientType;
    import flash.display.InteractiveObject;
    import flash.display.MovieClip;
    import flash.display.Shape;
    import flash.display.Sprite;
    import flash.display.Stage;
    import flash.events.Event;
    import flash.geom.Matrix;
    import flash.ui.Mouse;

    import net.retrocade.camel.layers.rLayer;
    import net.retrocade.camel.objects.rBitmap;
    import net.retrocade.utils.UDisplay;
    import net.retrocade.utils.UGraphic;
    import net.retrocade.utils.UString;

    use namespace retrocamel_int;

    /**
     * ...
     * @author Maurycy Zarzycki
     */
    public class rDisplay{

        /**
         * Shortcut to the instance of the stage
         */
        retrocamel_int static var _stage         :Stage;

        /**
         * Retrieves the stage
         */
        public static function get stage():Stage{
            return _stage;
        }

        /**
         * Shortcut to the instance of the main application
         */
        retrocamel_int static var _application   :MovieClip;

        public static function get application():DisplayObjectContainer{
            return _application;
        }

        /**
         * Shortcut to the instance of the tooltip
         */
        retrocamel_int static var _tooltip       :rTooltip;

        /**
        * An optional Border
        */
        retrocamel_int static var _border        :Shape;

        /**
         * Shortcut to the instance of Windows Manager
         */
        retrocamel_int static var _windows       :rWindows;

        /**
         * Sprite containing all layers
         */
        retrocamel_int static var _layers          :Sprite;

        /**
         * Sprite containing the cursor
         */
        retrocamel_int static var _cursor        :Sprite;

        retrocamel_int static var _offsetX       :Number = 0;

        retrocamel_int static var _offsetY       :Number = 0;

        /**
         * Scale of the cursor, used to align it to a grid if the game is scaled.
         * Eg. setting it to 2 will make the cursor always move by two pixels
         */
        public static var cursorScale            :Number = 1;

        /**
         * Whether to focefully hide the cursor.
         */
        public static var cursorHidden           :Boolean = false;

        /**
         * Instance of the cursor
         */
        public static function get cursor():DisplayObject{
            if (_cursor.numChildren)
                return _cursor.getChildAt(0);

            return null;
        }

        /**
         * @private
         */
        public static function set cursor(graphic:DisplayObject):void{
            if (_cursor.numChildren)
                _cursor.removeChildAt(0);

            if (graphic){
                _cursor.addChild(graphic);
                if (graphic is InteractiveObject){
                    InteractiveObject(graphic).mouseEnabled = false;
                }
                Mouse.hide();
            } else {
                Mouse.show();
            }
        }

        /**
         * @private
         * Initializes the display list
         */
        retrocamel_int static function initialize(main:MovieClip, stage:Stage):void{
            _stage       = stage;
            _application = main;

            _tooltip   = new rTooltip();
            _windows   = new rWindows();
            _layers      = new Sprite();
            _cursor    = new Sprite();

            _application.addChild(_layers);
            _application.addChild(_windows);
            _application.addChild(_cursor);
            _application.addChild(_tooltip);

            _cursor.mouseEnabled  = false;
            _cursor.mouseChildren = false;

            _stage.addEventListener(Event.RESIZE, onStageResize);
        }

        /**
         * Adds layer to the game display
         * @param layer Layer to be added
         */
        public static function addLayer(layer:rLayer):void{
            _layers.addChild(layer.displayObject);
        }

        /**
         * Adds layer to the game display
         * @param layer Layer to be added
         */
        public static function addLayerAt(layer:rLayer, index:uint = 0):void{
            _layers.addChildAt(layer.displayObject, index);
        }

        /**
         * Removes layer from the display
         * @param layer Layer to be removed from the game's display
         */
        public static function removeLayer(layer:rLayer):void{
            if (_layers.contains(layer.displayObject))
                _layers.removeChild(layer.displayObject);
        }

        /**
         * Scrolls all layers to the specified coordinates
         * @param x X position of scroll
         * @param y Y position of scroll
         */
        public static function scrollTo(x:Number, y:Number):void{
            var l:uint = _layers.numChildren;
            while(l--)
                rLayer(_layers.getChildAt(l)).scrollTo(x, y);
        }

        /**
         * Calls Clear on all layers
         */
        public static function layersClear():void{
            var l:uint = _layers.numChildren;

            while(l--){
                rLayer(_layers.getChildAt(l)).clear();
            }
        }

        /**
         * Sets the background to specified color
         * @param color RGB value of the color
         */
        public static function setBackgroundColor(color:uint):void{
            _application.graphics.clear();
            _application.graphics.beginFill(color);
            _application.graphics.drawRect(0, 0, rCore.settings.swfWidth, rCore.settings.swfHeight);
            _application.graphics.endFill();
        }

        /**
         * Sets the background to the specified bitmapData
         * @param bitmapData BitmapData to fill the background
         */
        public static function setBackgroundImage(bitmapData:BitmapData):void{
            _application.graphics.clear();
            _application.graphics.beginBitmapFill(bitmapData);
            _application.graphics.drawRect(0, 0, rCore.settings.gameWidth, rCore.settings.gameHeight);
            _application.graphics.endFill();
        }

        private static var _backgroundImageBitmap:rBitmap;

        /**
         * Sets the background to the specified bitmapData
         * @param bitmapData BitmapData to fill the background
         */
        public static function setBackgroundImageBitmap(bitmap:rBitmap):void{
            if (_backgroundImageBitmap != bitmap){
                if (_backgroundImageBitmap && _application.contains(_backgroundImageBitmap))
                    _application.removeChild(_backgroundImageBitmap);

                _backgroundImageBitmap = bitmap;

                _application.addChildAt(bitmap, 0);
            }

            UDisplay.scaleDisplayObject(bitmap, rCore.settings.gameWidth, rCore.settings.gameHeight, UDisplay.NO_BORDER);
            bitmap.alignCenter();
            bitmap.alignMiddle();
        }

        /**
         * Sets the background to a given gradient.
         * @param colors Array of colors
         * @param ratios Array of ratios
         * @param alphas Array of alphas
         * @param rotation Rotation (in radians)
         */
        public static function setBackgroundGradient(colors:Array, ratios:Array, alphas:Array, rotation:Number):void{
            var matrix:Matrix = new Matrix();
            matrix.createGradientBox(rCore.settings.gameWidth, rCore.settings.gameHeight, rotation);
            _application.graphics.clear();
            _application.graphics.beginGradientFill(GradientType.LINEAR, colors, alphas, ratios, matrix);
            _application.graphics.drawRect(0, 0, rCore.settings.gameWidth, rCore.settings.gameHeight);
            _application.graphics.endFill();
        }

        public static function setOffset(x:Number, y:Number):void{
            _offsetX = _windows.x = _layers.x = x;
            _offsetY = _windows.y = _layers.y = y;
        }

        /**
         * Blocks all input on the game layers, primarily used by rWindows
         */
        retrocamel_int static function block():void {
            _layers.mouseChildren = false;
        }

        /**
         * Enables the input on the game layers, primarily used by rWindows
         */
        retrocamel_int static function unblock():void {
            _layers.mouseChildren = true;
        }

        retrocamel_int static function onStageResize(e:Event):void{
            if (_backgroundImageBitmap)
                setBackgroundImageBitmap(_backgroundImageBitmap);
        }
    }
}