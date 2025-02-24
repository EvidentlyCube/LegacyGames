package net.retrocade.tacticengine.monstro.global.core {
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.KeyboardEvent;

	import net.retrocade.constants.KeyConst;

	public class MonstroEscapeBlocker{
		private static var _isEscapeDown:Boolean;
		private static var _isEscapeDownTimer:uint;


		public static function flush():void {
			_isEscapeDown = false;
		}

		public static function get isEscapeDown():Boolean {
			return _isEscapeDown;
		}

		public static function initialize(root:DisplayObject):void {
			root.stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			root.stage.addEventListener(KeyboardEvent.KEY_DOWN, keyUpHandler);
			root.stage.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}

		private static function keyDownHandler(event:KeyboardEvent):void {
			if (event.keyCode === KeyConst.ESCAPE) {
				_isEscapeDown = true;
				_isEscapeDownTimer = 3;

				event.stopImmediatePropagation();
				event.preventDefault();
			}
		}

		private static function keyUpHandler(event:KeyboardEvent):void {
			if (event.keyCode === KeyConst.ESCAPE) {
				_isEscapeDown = false;
			}
		}

		private static function enterFrameHandler(event:Event):void {
			if (_isEscapeDownTimer > 0) {
				if (--_isEscapeDownTimer === 0) {
					_isEscapeDown = false;
				}
			}
		}
	}
}
