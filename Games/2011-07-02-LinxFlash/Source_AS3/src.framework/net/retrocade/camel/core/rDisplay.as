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
    import flash.display.StageQuality;
    import flash.display.StageDisplayState;
    import flash.events.Event;
    import flash.geom.Matrix;
    import flash.ui.Mouse;

    import net.retrocade.camel.layers.rLayer;
    import net.retrocade.utils.UGraphic;
    import net.retrocade.utils.UString;

    use namespace retrocamel_int;

    /**
     * ...
     * @author Maurycy Zarzycki
     */
    public class rDisplay{

		private static var _quality: String = StageQuality.HIGH;

		public static function get quality(): String {
			return _quality;
		}

		private static var _scaleX:Number = 1;

		public static function get scaleX():Number {
			return _scaleX;
		}

		private static var _scaleY:Number = 1;

		public static function get scaleY():Number {
			return _scaleY;
		}

		private static var _scaleToFit:Boolean = true;

		public static function get scaleToFit():Boolean {
			return _scaleToFit;
		}

		public static function set scaleToFit(value:Boolean):void {
			_scaleToFit = value;
			onStageResize();
		}

		private static var _scaleToInteger:Boolean = true;

		public static function get scaleToInteger():Boolean {
			return _scaleToInteger;
		}

		public static function set scaleToInteger(value:Boolean):void {
			_scaleToInteger = value;
			onStageResize();
		}

		public static function set quality(value: String): void {
			if (value != _quality) {
				_quality = value;
				onStageResize();
			}
		}
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

		private static var _shadingLayer:Sprite;

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
			_shadingLayer = new Sprite();

            _application.addChild(_game);
            _application.addChild(_windows);
            _application.addChild(_cursor);
            _application.addChild(_tooltip);
			_application.addChild(_shadingLayer);

            _cursor.mouseEnabled  = false;
            _cursor.mouseChildren = false;

			stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE
			rDisplay.scaleToFit = true;
			rDisplay.scaleToInteger = false;

			onStageResize();
			stage.addEventListener(Event.RESIZE, onStageResize);
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

        public static function setBackgroundGradient(colors:Array, ratios:Array, alphas:Array, rotation:Number):void{
            var matrix:Matrix = new Matrix();
            matrix.createGradientBox(rCore.settings.gameWidth, rCore.settings.gameHeight, rotation);
            _application.graphics.clear();
            _application.graphics.beginGradientFill(GradientType.LINEAR, colors, alphas, ratios, matrix);
            _application.graphics.drawRect(0, 0, rCore.settings.gameWidth, rCore.settings.gameHeight);
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


		retrocamel_int static function onStageResize():void {
			_stage.quality = _quality;

			var hSpacing:Number = 0;
			var vSpacing:Number = 0;

			if (_scaleToFit) {
				var maxScaleX:Number = _stage.stageWidth / rCore.settings.gameWidth;
				var maxScaleY:Number = _stage.stageHeight / rCore.settings.gameHeight;

				var maxScale:Number = Math.min(maxScaleX, maxScaleY);
				if (_scaleToInteger) {
					maxScale = Math.floor(maxScale);
				}

				setScale(maxScale, maxScale);

				var newWidth:Number = maxScale * rCore.settings.gameWidth;
				var newHeight:Number = maxScale * rCore.settings.gameHeight;

				hSpacing = (_stage.stageWidth - newWidth) / 2;
				vSpacing = (_stage.stageHeight - newHeight) / 2;
			} else {
				_shadingLayer.graphics.clear();
				setScale(1, 1);

				hSpacing = (_stage.stageWidth - rCore.settings.gameWidth) / 2;
				vSpacing = (_stage.stageHeight - rCore.settings.gameHeight) / 2;
			}

			setOffset(hSpacing, vSpacing);

			_shadingLayer.graphics.clear();
			_shadingLayer.graphics.beginFill(0);
			_shadingLayer.graphics.drawRect(-hSpacing, -vSpacing, _stage.stageWidth, vSpacing);
			_shadingLayer.graphics.beginFill(0);
			_shadingLayer.graphics.drawRect(-hSpacing, rCore.settings.gameHeight, _stage.stageWidth, vSpacing);
			_shadingLayer.graphics.beginFill(0);
			_shadingLayer.graphics.drawRect(-hSpacing, 0, hSpacing, rCore.settings.gameHeight);
			_shadingLayer.graphics.beginFill(0);
			_shadingLayer.graphics.drawRect(rCore.settings.gameWidth, 0, hSpacing, rCore.settings.gameHeight);
			_shadingLayer.graphics.endFill();
		}

		public static function setScale(scaleX:Number, scaleY:Number):void {
			_scaleX = scaleX;
			_scaleY = scaleY;

			_application.scaleX = _scaleX;
			_application.scaleY = _scaleY;
		}
		public static function toggleFullScreen():void {
			try {
				if (_stage.displayState === StageDisplayState.NORMAL) {
					_stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE
				} else {
					_stage.displayState = StageDisplayState.NORMAL;
				}
			} catch (e:Error) {
				trace(e.message);
				// Silently consume
			}
		}

    }
}