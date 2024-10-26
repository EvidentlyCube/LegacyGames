package {
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageDisplayState;
	import flash.display.StageQuality;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;

	public class ModernDisplay {
		public static var SCALE_MODE_NO_SCALE: uint = 0;
		public static var SCALE_MODE_INTEGER_SCALE: uint = 1;
		public static var SCALE_MODE_FIT_SCALE: uint = 2;

		private static var _main:DisplayObjectContainer;
		private static var _stage:Stage;
		private static var _quality: String = StageQuality.HIGH;
		private static var _offsetX:Number = 0;
		private static var _offsetY:Number = 0;
		private static var _scaleX:Number = 1;
		private static var _scaleY:Number = 1;
		private static var _scaleMode: uint = 2;

		private static var _gameWidth: Number = 1;
		private static var _gameHeight: Number = 1;

		private static var _mouseX:int = 0;
		private static var _mouseY:int = 0;

		private static var _maskingBevel:Sprite;

		public static function get stage():Stage {
			return _stage;
		}

		public static function get offsetX():Number {
			return _offsetX;
		}

		public static function get quality(): String {
			return _quality;
		}

		public static function set quality(value: String): void {
			if (value != _quality) {
				_quality = value;
				onStageResize(null);
			}
		}

		public static function get offsetY():Number {
			return _offsetY;
		}

		public static function get scaleX():Number {
			return _scaleX;
		}

		public static function get scaleY():Number {
			return _scaleY;
		}

		public static function get scaleMode(): uint {
			return _scaleMode;
		}

		public static function set scaleMode(value: uint): void {
			if (
				value !== SCALE_MODE_NO_SCALE
				&& value !== SCALE_MODE_INTEGER_SCALE
				&& value !== SCALE_MODE_FIT_SCALE
			) {
				value = _scaleMode;
			}

			if (_scaleMode !== value) {
				_scaleMode = value;

				onStageResize(null);
			}
		}

		public static function Init(
			main:DisplayObjectContainer,
			stage:Stage,
			gameWidth: Number,
			gameHeight: Number
		):void {
			_stage = stage;
			_main = main;
			_gameWidth = gameWidth;
			_gameHeight = gameHeight

			_stage.addEventListener(Event.RESIZE, onStageResize);

			_maskingBevel = new Sprite();
			_main.addChild(_maskingBevel);

			_stage.align = StageAlign.TOP_LEFT;
			_stage.scaleMode = StageScaleMode.NO_SCALE;

			_stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			_stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			_stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			_stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);

			_main.addEventListener(Event.ENTER_FRAME, fixMaskingBevel)
			_main.addEventListener(Event.EXIT_FRAME, fixMaskingBevel)
			_main.addEventListener(Event.FRAME_CONSTRUCTED, fixMaskingBevel)
			_main.addEventListener(Event.RENDER, fixMaskingBevel)

			onStageResize(null);

			toggleFullScreen();
		}

		private static function fixMaskingBevel(event:Event):void {
			if (!_main.contains(_maskingBevel)) {
				_main.addChild(_maskingBevel);
			} else {
				_main.setChildIndex(_maskingBevel, _main.numChildren - 1);
			}
		}

		private static function onKeyDown(event:KeyboardEvent):void {
			switch(event.keyCode) {
				case(Keyboard.F4):
					if (scaleMode === SCALE_MODE_FIT_SCALE) {
						scaleMode = SCALE_MODE_NO_SCALE;
					} else {
						scaleMode++;
					}
					break;

				case(Keyboard.F9):
					if (quality === StageQuality.HIGH) {
						quality = StageQuality.LOW;
					} else if (quality === StageQuality.LOW) {
						quality = StageQuality.MEDIUM;
					} else {
						quality = StageQuality.HIGH;
					}
					break;

				case(Keyboard.F11):
					toggleFullScreen();
					break;

				case(Keyboard.ENTER):
					if (event.altKey) {
						toggleFullScreen();
					}
					break;
			}
		}

		private static function onMouseMove(e:MouseEvent):void {
			_mouseX = e.stageX;
			_mouseY = e.stageY;
		}

		private static function onMouseDown(e:MouseEvent):void {
			_mouseX = e.stageX;
			_mouseY = e.stageY;
		}

		private static function onMouseUp(e:MouseEvent):void {
			_mouseX = e.stageX;
			_mouseY = e.stageY;
		}

		private static function onStageResize(e:Event):void {
			if (!_stage) {
				return;
			}

			var x:Number = 0;
			var y:Number = 0;

			_stage.quality = _quality;

			if (_scaleMode !== SCALE_MODE_NO_SCALE) {
				var maxScaleX:Number = _stage.stageWidth / _gameWidth;
				var maxScaleY:Number = _stage.stageHeight / _gameHeight;

				var maxScale:Number = Math.min(maxScaleX, maxScaleY);
				if (_scaleMode === SCALE_MODE_INTEGER_SCALE) {
					maxScale = Math.floor(maxScale);
				}

				setScale(maxScale, maxScale);

				var newWidth:Number = maxScale * _gameWidth;
				var newHeight:Number = maxScale * _gameHeight;

				x = (_stage.stageWidth - newWidth) / 2;
				y = (_stage.stageHeight - newHeight) / 2;
			} else {
				_maskingBevel.graphics.clear();
				setScale(1, 1);

				x = (_stage.stageWidth - _gameWidth) / 2;
				y = (_stage.stageHeight - _gameHeight) / 2;
			}

			_offsetX = x;
			_offsetY = y;

			_main.x = _offsetX;
			_main.y = _offsetY;

			_maskingBevel.graphics.clear();
			_maskingBevel.graphics.beginFill(0);
			_maskingBevel.graphics.drawRect(-x, -y, _stage.stageWidth, y);
			_maskingBevel.graphics.beginFill(0);
			_maskingBevel.graphics.drawRect(-x, _gameHeight, _stage.stageWidth, y);
			_maskingBevel.graphics.beginFill(0);
			_maskingBevel.graphics.drawRect(-x, 0, x, _gameHeight);
			_maskingBevel.graphics.beginFill(0);
			_maskingBevel.graphics.drawRect(_gameWidth, 0, x, _gameHeight);
			_maskingBevel.graphics.endFill();
		}

		private static function setScale(scaleX:Number, scaleY:Number):void {
			_scaleX = scaleX;
			_scaleY = scaleY;

			_main.scaleX = _scaleX;
			_main.scaleY = _scaleY;
		}

		public static function toggleFullScreen():void {
			try {
				if (_stage.displayState === StageDisplayState.NORMAL) {
					_stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE
				} else {
					_stage.displayState = StageDisplayState.NORMAL;
				}
			} catch (e:Error) {
				// Silently consume
			}
		}
	}
}