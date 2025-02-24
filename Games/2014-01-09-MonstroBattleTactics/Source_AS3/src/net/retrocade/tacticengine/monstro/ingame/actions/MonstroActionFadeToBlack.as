package net.retrocade.tacticengine.monstro.ingame.actions {
    import net.retrocade.retrocamel.display.layers.RetrocamelLayerStarling;
    import net.retrocade.tacticengine.monstro.global.core.MonstroConsts;
    import net.retrocade.tacticengine.monstro.global.core.MonstroGfx;
    import net.retrocade.utils.UtilsNumber;

    import starling.display.Image;

    public class MonstroActionFadeToBlack extends MonstroAction{
        private var _layer:RetrocamelLayerStarling;
        private var _black:Image;

        public function MonstroActionFadeToBlack(callback:Function) {
            super(callback);
        }

        override public function update():Boolean{
            if (!_layer){
                init();
            }

            _black.alpha = UtilsNumber.approach(_black.alpha, 1, 0.1, 0.01);
            _black.width = MonstroConsts.gameWidth;
            _black.height = MonstroConsts.gameHeight;

            return _black.alpha == 1;
        }

		public override function resize():void {
			_black.width = MonstroConsts.gameWidth;
			_black.height = MonstroConsts.gameHeight;
		}

        private function init():void{
            _layer = new RetrocamelLayerStarling();
            _layer.inputEnabled = false;
            _black = MonstroGfx.getBlackColor();
            _black.alpha = 0;

            _layer.add(_black);
        }

        override public function dispose():void{
            _black.dispose();
            _layer.dispose();

            _black = null;
            _layer = null;

            super.dispose();
        }

        override public function get canHaveMultipleInstances():Boolean {
            return false;
        }
    }
}
