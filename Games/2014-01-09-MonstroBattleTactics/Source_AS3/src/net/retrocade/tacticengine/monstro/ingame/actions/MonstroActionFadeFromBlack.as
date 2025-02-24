
package net.retrocade.tacticengine.monstro.ingame.actions {
    import net.retrocade.retrocamel.display.layers.RetrocamelLayerStarling;
    import net.retrocade.tacticengine.monstro.global.core.MonstroConsts;
    import net.retrocade.tacticengine.monstro.global.core.MonstroGfx;
    import net.retrocade.utils.UtilsNumber;

    import starling.display.Image;
    import starling.textures.TextureSmoothing;

    public class MonstroActionFadeFromBlack extends MonstroAction{
        private var _layer:RetrocamelLayerStarling;
        private var _black:Image;

        public function MonstroActionFadeFromBlack() {
            super(null);

            _layer = new RetrocamelLayerStarling();
            _layer.inputEnabled = false;
            _black = MonstroGfx.getBlackColor();
            _black.smoothing = TextureSmoothing.NONE;

            _layer.add(_black);

            update();
        }

        override public function update():Boolean{
            _black.alpha = UtilsNumber.approach(_black.alpha, 0, 0.1, 0.01);
			resize();
			return _black.alpha == 0;
        }

		public override function resize():void {
			_black.width = MonstroConsts.gameWidth;
			_black.height = MonstroConsts.gameHeight;
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