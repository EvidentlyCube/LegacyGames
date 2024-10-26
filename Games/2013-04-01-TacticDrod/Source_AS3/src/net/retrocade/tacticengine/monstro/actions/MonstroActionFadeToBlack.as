package net.retrocade.tacticengine.monstro.actions {
    import net.retrocade.camel.layers.rLayerStarling;
    import net.retrocade.tacticengine.monstro.core.Monstro;
    import net.retrocade.tacticengine.monstro.core.MonstroGfx;
    import net.retrocade.utils.UNumber;

    import starling.display.Image;

    public class MonstroActionFadeToBlack extends MonstroAction{
        private var _layer:rLayerStarling;
        private var _black:Image;

        public function MonstroActionFadeToBlack(callback:Function) {
            super(callback);
        }

        override public function update():Boolean{
            if (!_layer){
                init();
            }

            _black.alpha = UNumber.approach(_black.alpha, 1, 0.1, 0.01);
            _black.width = Monstro.gameWidth;
            _black.height = Monstro.gameHeight;

            return _black.alpha == 1;
        }

        private function init():void{
            _layer = new rLayerStarling();
            _layer.inputEnabled = false;
            _black = MonstroGfx.getBlackColor();
            _black.alpha = 0;

            _layer.add(_black);
        }

        override public function destruct():void{
            _black.dispose();
            _layer.dispose();

            _black = null;
            _layer = null;

            super.destruct();
        }
    }
}
