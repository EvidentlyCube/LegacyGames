/**
 * Created with IntelliJ IDEA.
 * User: Ryc
 * Date: 21.03.13
 * Time: 00:11
 * To change this template use File | Settings | File Templates.
 */
package net.retrocade.tacticengine.monstro.actions {
    import net.retrocade.camel.layers.rLayerStarling;
    import net.retrocade.tacticengine.monstro.core.Monstro;
    import net.retrocade.tacticengine.monstro.core.MonstroGfx;
    import net.retrocade.utils.UNumber;

    import starling.display.Image;

    public class MonstroActionFadeFromBlack extends MonstroAction{
        private var _layer:rLayerStarling;
        private var _black:Image;

        public function MonstroActionFadeFromBlack() {
            super(null);

            _layer = new rLayerStarling();
            _layer.inputEnabled = false;
            _black = MonstroGfx.getBlackColor();

            _layer.add(_black);

            update();
        }

        override public function update():Boolean{
            _black.alpha = UNumber.approach(_black.alpha, 0, 0.1, 0.01);
            _black.width = Monstro.gameWidth;
            _black.height = Monstro.gameHeight;

            return _black.alpha == 0;
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