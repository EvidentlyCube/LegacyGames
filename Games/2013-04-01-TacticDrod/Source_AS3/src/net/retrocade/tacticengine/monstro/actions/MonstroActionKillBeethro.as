package net.retrocade.tacticengine.monstro.actions{
    import net.retrocade.tacticengine.monstro.core.MonstroConst;
    import net.retrocade.tacticengine.monstro.core.MonstroFunctions;
    import net.retrocade.tacticengine.monstro.core.MonstroSfx;
    import net.retrocade.tacticengine.monstro.entities.MonstroEntity;
    import net.retrocade.tacticengine.monstro.entities.MonstroEntityFactory;
    import net.retrocade.tacticengine.monstro.render.MonstroUnitClip;
    import net.retrocade.utils.Rand;

    import starling.display.Image;

    public class MonstroActionKillBeethro extends MonstroAction{
        private var _unitGraphic:MonstroUnitClip;
        private var _unitObject:MonstroEntity;
        private var _started:Boolean = false;
        
        public function MonstroActionKillBeethro(unitGraphic:MonstroUnitClip, unitObject:MonstroEntity, onFinished:Function = null){
            super(onFinished);

            _unitGraphic = unitGraphic;
            _unitObject = unitObject;
        }
        
        override public function update():Boolean{
            if (!_started){
                playKillSound();
                _started = true;
            }

            _unitGraphic.alpha -= 0.007;

            if (Rand.om < 0.2){
                _unitGraphic.direction = Rand.from(
                        MonstroFunctions.nextOrientationCCW(_unitGraphic.direction),
                        MonstroFunctions.nextOrientationCW(_unitGraphic.direction)
                );
            }

            if (_unitGraphic.alpha <= 0){
                _unitGraphic.removeFromParent();
                return true;
            }
            
            return false;
        }

        private function playKillSound():void{
            MonstroSfx.playBeethroDie();
        }

        override public function destruct():void{
            super.destruct();
            _unitGraphic = null;
        }
    }
}