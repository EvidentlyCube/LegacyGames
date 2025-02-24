


package net.retrocade.tacticengine.monstro.gui.windows {
	import net.retrocade.retrocamel.core.RetrocamelWindowsManager;
	import net.retrocade.retrocamel.display.starling.RetrocamelWindowStarling;
	import net.retrocade.tacticengine.monstro.global.core.MonstroConsts;
	import net.retrocade.tacticengine.monstro.global.core.MonstroGfx;

	import starling.display.Image;

	public class MonstroWindowModal extends RetrocamelWindowStarling{
		private static var _instance:MonstroWindowModal = new MonstroWindowModal();

        public static function show():MonstroWindowModal{
			_instance.show();

			return _instance;
        }

        private var _modal:Image;
		private var _isHiding:Boolean;

		public function MonstroWindowModal() {
			_blockUnder = false;
			_pauseGame = false;
		}

		override public function show():void{
			if (RetrocamelWindowsManager.hasWindow(this)){
				return;
			}

            super.show();

			_isHiding = false;

            _modal = MonstroGfx.getBlackColor();
            addChild(_modal);

            _modal.alpha = 0.0;

            resize();
        }

        override public function hide():void {
            removeChildren();

            _modal.dispose();
            _modal = null;

            super.hide();
        }

        override public function resize():void {
            super.resize();

            _modal.width = MonstroConsts.gameWidth;
            _modal.height = MonstroConsts.gameHeight;
        }

		override public function update():void {
			if (_isHiding){
				_modal.alpha -= 0.05;

				if (_modal.alpha <= 0){
					if (RetrocamelWindowsManager.numWindows === 1){
						hide();
					} else {
						_modal.alpha = 0;
					}
				}
			} else {
				if (_modal.alpha < 0.6){
					_modal.alpha += 0.05;
				}

				if (RetrocamelWindowsManager.numWindows === 1 && RetrocamelWindowsManager.hasWindow(this)){
					_isHiding = true;
				}
			}
		}

		public function startHiding():void{
			_isHiding = true;
		}

		public function cancelHiding():void{
			_isHiding = false;
		}
	}
}