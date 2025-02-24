package net.retrocade.tacticengine.monstro.ingame.actions {
    import net.retrocade.tacticengine.core.injector.MonstroInjector;
    import net.retrocade.tacticengine.monstro.global.core.MonstroGameplayDefinition;
    import net.retrocade.tacticengine.monstro.global.core.MonstroSfx;
    import net.retrocade.tacticengine.monstro.global.core.SmartTouch;
    import net.retrocade.tacticengine.monstro.gui.render.MonstroUnitClip;
    import net.retrocade.tacticengine.monstro.ingame.actions.subaction.MonstroSubactionPoof;

    public class MonstroActionDestroyFakeWall extends MonstroAction {
        [Inject]
        public var gameplayDefinition:MonstroGameplayDefinition;

        private var _unitGraphic:MonstroUnitClip;
        private var _started:Boolean = false;
        private var _poofSubaction:MonstroSubactionPoof;

        public function MonstroActionDestroyFakeWall() {
            super(null);

        }

        public function init(unitGraphic:MonstroUnitClip):void{
            _unitGraphic = unitGraphic;
        }

        override public function update():Boolean {
            if (!_started) {
                createPuff();
                playDestroySound();
                _started = true;
            }

            _poofSubaction.update(fadeDelta);

            if (!_poofSubaction.isPlaying || _poofSubaction.currentFrame >= 4){
                _unitGraphic.isDestroyed = true;
            }

            return !_poofSubaction.isPlaying;
        }

        private function get fadeDelta():Number{
            if (SmartTouch.isRightButtonDown){
                return 3;
            } else {
                return 1;
            }
        }

        override public function dispose():void {
            super.dispose();
            _poofSubaction.dispose();
            _poofSubaction = null;
            _unitGraphic = null;
        }

        private function createPuff():void {
            _poofSubaction = MonstroInjector.create(
                MonstroSubactionPoof,
                _unitGraphic.center,
                _unitGraphic.middle,
                MonstroSubactionPoof.TYPE_WHITE,
                _unitGraphic.parent
            );
        }

        private static function playDestroySound():void {
            MonstroSfx.playFakeWallCrumble();
        }
    }
}