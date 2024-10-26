/**
 * Created with IntelliJ IDEA.
 * User: Ryc
 * Date: 21.03.13
 * Time: 00:11
 * To change this template use File | Settings | File Templates.
 */
package net.retrocade.tacticengine.monstro.actions {
    import net.retrocade.camel.effects.rEasing;
    import net.retrocade.tacticengine.monstro.core.Monstro;
    import net.retrocade.tacticengine.monstro.render.MonstroDisplayGroup;
    import net.retrocade.tacticengine.monstro.render.MonstroFieldRenderer;
    import net.retrocade.utils.UNumber;

    public class MonstroActionSlideLevelOut extends MonstroAction{
        private var _fieldRenderer:MonstroFieldRenderer;

        private var _startX:Number;

        private var _layers:MonstroDisplayGroup;
        private var _timer:Number = 0;

        public function MonstroActionSlideLevelOut(fieldRenderer:MonstroFieldRenderer, callback:Function) {
            super(callback);

            _fieldRenderer = fieldRenderer;

            _layers = new MonstroDisplayGroup();
            _layers.addElement(_fieldRenderer.layerFloor.layer);
            _layers.addElement(_fieldRenderer.layerAnimatedFloor.layer);
            _layers.addElement(_fieldRenderer.layerRects.layer);
            _layers.addElement(_fieldRenderer.layerSprites.layer);
        }

        override public function update():Boolean{
            if (isNaN(_startX)){
                init();
            }

            _layers.x = _startX + (endX - _startX) * rEasing.cubicIn(_timer);
            _timer += 0.015625;

            return _timer >= 1;
        }

        private function init():void{
            _startX = _layers.x;
        }

        override public function destruct():void{
            _layers.x = endX;
            _layers.destruct();
            _fieldRenderer = null;

            super.destruct();
        }

        private function get endX():Number{
            return Monstro.gameWidth + Monstro.hudSpacer;
        }
    }
}
