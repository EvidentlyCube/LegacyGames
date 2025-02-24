
package net.retrocade.tacticengine.monstro.ingame.actions {
    import net.retrocade.retrocamel.effects.RetrocamelEasings;
    import net.retrocade.tacticengine.monstro.global.core.MonstroConsts;
    import net.retrocade.tacticengine.monstro.gui.render.MonstroDisplayGroup;
    import net.retrocade.tacticengine.monstro.gui.render.MonstroFieldRenderer;
    import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventLockHud;
    import net.retrocade.utils.UtilsNumber;

    public class MonstroActionSlideLevelOut extends MonstroAction{
        private var _fieldRenderer:MonstroFieldRenderer;

        private var _startX:Number;

        private var _layers:MonstroDisplayGroup;
        private var _timer:Number = 0;

        override public function get canHaveMultipleInstances():Boolean {
            return false;
        }

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

            _layers.x = _startX + (endX - _startX) * RetrocamelEasings.cubicIn(_timer);
            _timer += 0.015625;

            return _timer >= 1;
        }

        private function init():void{
            _startX = _layers.x;
            new MonstroEventLockHud(true);
        }

        override public function dispose():void{
            new MonstroEventLockHud(false);

            _layers.x = endX;
            _layers.dispose();
            _fieldRenderer = null;

            super.dispose();
        }

        private function get endX():Number{
            return MonstroConsts.gameWidth + MonstroConsts.hudSpacer;
        }

		override public function get shouldSkipFrameAfterFinished():Boolean {
			return false;
		}
    }
}
