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

    public class MonstroActionSlideLevelIn extends MonstroAction{
        private var _fieldRenderer:MonstroFieldRenderer;

        private var _startX:Number;
        private var _endX:Number;

        private var _layers:MonstroDisplayGroup;
        private var _timer:Number = 0;

        public function MonstroActionSlideLevelIn(fieldRenderer:MonstroFieldRenderer, callback:Function) {
            super(callback);

            _fieldRenderer = fieldRenderer;

            _layers = new MonstroDisplayGroup();
            _layers.addElement(_fieldRenderer.layerFloor.layer);
            _layers.addElement(_fieldRenderer.layerAnimatedFloor.layer);
            _layers.addElement(_fieldRenderer.layerRects.layer);
            _layers.addElement(_fieldRenderer.layerSprites.layer);

            _endX = _layers.x;
            _startX = -_layers.width - Monstro.hudSpacer;

            update();
        }

        override public function update():Boolean{
            _layers.x = _startX + (_endX - _startX) * rEasing.cubicOut(_timer);
            _timer += 0.015625;

            return _timer >= 1;
        }

        override public function destruct():void{
            _layers.x = _endX;
            _layers.destruct();
            _fieldRenderer = null;

            super.destruct();
        }
    }
}
