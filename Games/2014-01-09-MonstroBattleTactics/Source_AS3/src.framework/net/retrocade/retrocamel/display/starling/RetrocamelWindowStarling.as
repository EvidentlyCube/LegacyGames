

package net.retrocade.retrocamel.display.starling {
	import net.retrocade.retrocamel.core.RetrocamelWindowsManager;
	import net.retrocade.retrocamel.core.retrocamel_int;
	import net.retrocade.retrocamel.interfaces.IRetrocamelWindow;

	import starling.display.Sprite;

	use namespace retrocamel_int;

	/**
	 * ...
	 * @author Maurycy Zarzycki
	 */
	public class RetrocamelWindowStarling extends Sprite implements IRetrocamelWindow {
		/****************************************************************************************************************/
		/**                                                                                                  VARIABLES  */
		/****************************************************************************************************************/

		/**
		 * Should this window block input to all underlying windows?
		 */
		protected var _blockUnder:Boolean = true;

		public function get blockUnder():Boolean {
			return _blockUnder;
		}

		/**
		 * Should the game be paused when this window is displayed?
		 */
		protected var _pauseGame:Boolean = true;

		public function get pauseGame():Boolean {
			return _pauseGame;
		}


		// ::::::::::::::::::::::::::::::::::::::::::::::
		// :: Helpers
		// ::::::::::::::::::::::::::::::::::::::::::::::

		/**
		 * HELPER: Value of touchab;e before block
		 */
		private var _lastTouchable:Boolean = true;

		private var _isBlocked:Boolean = false;

		public function isBlocked():Boolean {
			return _isBlocked;
		}


		/****************************************************************************************************************/
		/**                                                                                                  FUNCTIONS  */
		/****************************************************************************************************************/

		/**
		 * Adds the window to display and show it
		 */
		public function show():void {
			RetrocamelWindowsManager.addWindow(this);
		}

		/**
		 * Remove the window from the display
		 */
		public function hide():void {
			RetrocamelWindowsManager.removeWindow(this);
		}

		public function resize():void {
		}

		/**
		 * Called by windows manager when window above it blocks this one
		 */
		public function block():void {
			if (_isBlocked) {
				return;
			}

			_isBlocked = true;
			_lastTouchable = touchable;

			touchable = false;
		}

		public function unblock():void {
			_isBlocked = false;
			touchable = _lastTouchable
		}

		public function update():void {
		}

		public function set blockUnder(value:Boolean):void {
			_blockUnder = value;
		}

		public function set pauseGame(value:Boolean):void {
			_pauseGame = value;
		}

		protected function makeUntouchable():void {
			_lastTouchable = false;
			touchable = false;
		}

		protected function makeTouchable():void {
			_lastTouchable = true;
			touchable = true;
		}


		override public function set touchable(value:Boolean):void {
			super.touchable = value;
		}
	}
}