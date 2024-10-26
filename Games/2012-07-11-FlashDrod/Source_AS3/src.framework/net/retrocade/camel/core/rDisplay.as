package net.retrocade.camel.core{
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
    import flash.geom.Matrix;
    import flash.ui.Mouse;

    import net.retrocade.camel.layers.rLayer;
    import net.retrocade.camel.rLang;
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
        retrocamel_int static var _game          :Sprite;

        /**
         * Sprite containing the cursor
         */
        retrocamel_int static var _cursor        :Sprite;

        retrocamel_int static var _offsetX       :Number = 0;

        retrocamel_int static var _offsetY       :Number = 0;

        public static var cursorScale            :Number = 1;

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
            _game      = new Sprite();
            _cursor    = new Sprite();

            _application.addChild(_game);
            _application.addChild(_windows);
            _application.addChild(_cursor);
            _application.addChild(_tooltip);

            _cursor.mouseEnabled  = false;
            _cursor.mouseChildren = false;
        }

        /**
         * Adds layer to the game display
         * @param layer Layer to be added
         */
        public static function addLayer(layer:rLayer):void{
            _game.addChild(layer.displayObject);
        }

        /**
         * Adds layer to the game display
         * @param layer Layer to be added
         */
        public static function addLayerAt(layer:rLayer, index:uint = 0):void{
            _game.addChildAt(layer.displayObject, index);
        }

        /**
         * Removes layer from the display
         * @param layer Layer to be removed from the game's display
         */
        public static function removeLayer(layer:rLayer):void{
            if (_game.contains(layer.displayObject))
                _game.removeChild(layer.displayObject);
        }

        /**
         * Scrolls all layers to the specified coordinates
         * @param x X position of scroll
         * @param y Y position of scroll
         */
        public static function scrollTo(x:Number, y:Number):void{
            var l:uint = _game.numChildren;
            while(l--)
                rLayer(_game.getChildAt(l)).scrollTo(x, y);
        }

        /**
         * Calls Clear on all layers
         */
        public static function layersClear():void{
            var l:uint = _game.numChildren;
            while(l--){
                rLayer(_game.getChildAt(l)).clear();
            }
        }

        /**
         * Sets the background to specified color
         * @param color RGB value of the color
         */
        public static function setBackgroundColor(color:uint):void{
            _application.graphics.clear();
            _application.graphics.beginFill(color);
            _application.graphics.drawRect(0, 0, rCore._settings.SIZE_SWF_WIDTH, rCore._settings.SIZE_SWF_HEIGHT);
            _application.graphics.endFill();
        }

        /**
         * Sets the background to the specified bitmapData
         * @param bitmapData BitmapData to fill the background
         */
        public static function setBackgroundImage(bitmapData:BitmapData):void{
            _application.graphics.clear();
            _application.graphics.beginBitmapFill(bitmapData);
            _application.graphics.drawRect(0, 0, rCore._settings.SIZE_GAME_WIDTH, rCore._settings.SIZE_GAME_HEIGHT);
            _application.graphics.endFill();
        }

        public static function setBackgroundGradient(colors:Array, ratios:Array, alphas:Array, rotation:Number):void{
            var matrix:Matrix = new Matrix();
            matrix.createGradientBox(rCore._settings.SIZE_GAME_WIDTH, rCore._settings.SIZE_GAME_HEIGHT, rotation);
            _application.graphics.clear();
            _application.graphics.beginGradientFill(GradientType.LINEAR, colors, alphas, ratios, matrix);
            _application.graphics.drawRect(0, 0, rCore._settings.SIZE_GAME_WIDTH, rCore._settings.SIZE_GAME_HEIGHT);
            _application.graphics.endFill();
        }

        public static function setOffset(x:Number, y:Number):void{
            _offsetX = _windows.x = _game.x = x;
            _offsetY = _windows.y = _game.y = y;
        }

        /**
         * Blocks all input on the game layers, primarily used by rWindows
         */
        retrocamel_int static function block():void {
            _game.mouseChildren = false;
        }

        /**
         * Enables the input on the game layers, primarily used by rWindows
         */
        retrocamel_int static function unblock():void {
            _game.mouseChildren = true;
        }
    }
}