
package net.retrocade.tacticengine.monstro.ingame.actions {
    import net.retrocade.retrocamel.effects.RetrocamelEasings;
    import net.retrocade.tacticengine.core.Eventer;
    import net.retrocade.tacticengine.monstro.global.core.MonstroConsts;
    import net.retrocade.tacticengine.monstro.gui.render.MonstroDisplayGroup;
    import net.retrocade.tacticengine.monstro.gui.render.MonstroFieldRenderer;
    import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventLockHud;
    import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventResize;
    import net.retrocade.utils.UtilsNumber;

    public class MonstroActionSlideLevelIn extends MonstroAction{
        private var _fieldRenderer:MonstroFieldRenderer;

        private var _startX:Number;
        private var _endX:Number;

        private var _layers:MonstroDisplayGroup;
        private var _timer:Number = 0;

        private var _isInitialized:Boolean = false;

        public function MonstroActionSlideLevelIn(fieldRenderer:MonstroFieldRenderer, callback:Function) {
            super(callback);

            _fieldRenderer = fieldRenderer;

            _layers = new MonstroDisplayGroup();
            _layers.addElement(_fieldRenderer.layerFloor.layer);
            _layers.addElement(_fieldRenderer.layerAnimatedFloor.layer);
            _layers.addElement(_fieldRenderer.layerRects.layer);
            _layers.addElement(_fieldRenderer.layerSprites.layer);

            Eventer.listen(MonstroEventResize.NAME, onStageResized, this);

            _endX = _layers.x;
            _startX = -_layers.width - MonstroConsts.hudSpacer;

            update();
        }

		override public function dispose():void{
			Eventer.releaseContext(this);

			_layers.dispose();
			_fieldRenderer = null;

			super.dispose();
		}

        override public function update():Boolean{
            if (!_isInitialized){
                _isInitialized = true;
                new MonstroEventLockHud(true);
            }

            _layers.x = _startX + (_endX - _startX) * RetrocamelEasings.cubicOut(_timer);
            _timer += 0.015625;

            return _timer >= 1
        }

        private function onStageResized():void{
            _endX = (MonstroConsts.gameWidth - _layers.width) / 2;
            _layers.alignMiddle();
        }

        override public function get canHaveMultipleInstances():Boolean {
            return false;
        }


		override public function get shouldSkipFrameAfterFinished():Boolean {
			return false;
		}
	}
}
