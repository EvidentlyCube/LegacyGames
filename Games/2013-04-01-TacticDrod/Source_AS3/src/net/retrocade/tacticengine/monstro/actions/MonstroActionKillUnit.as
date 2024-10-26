package net.retrocade.tacticengine.monstro.actions{
    import net.retrocade.tacticengine.monstro.core.MonstroSfx;
    import net.retrocade.tacticengine.monstro.core.SmartTouch;
    import net.retrocade.tacticengine.monstro.entities.MonstroEntity;
    import net.retrocade.tacticengine.monstro.entities.MonstroEntityFactory;
    import net.retrocade.tacticengine.monstro.render.MonstroUnitClip;

    public class MonstroActionKillUnit extends MonstroAction{
        private var _unitGraphic:MonstroUnitClip;
        private var _unitObject:MonstroEntity;
        private var _started:Boolean = false;
        
        public function MonstroActionKillUnit(unitGraphic:MonstroUnitClip, unitObject:MonstroEntity, onFinished:Function = null){
            super(onFinished);

            _unitGraphic = unitGraphic;
            _unitObject = unitObject;
        }
        
        override public function update():Boolean{
            if (!_started){
                playKillSound();
                _started = true;
            }

            _unitGraphic.alpha -= fadeDelta;

            if (_unitGraphic.alpha <= 0){
                _unitGraphic.visible = false;
                return true;
            }
            
            return false;
        }

        private function get fadeDelta():Number{
            if (!SmartTouch.isSingleTouchDown){
                return 0.125;
            } else {
                return 1;
            }
        }

        private function playKillSound():void{
            switch(_unitObject.name){
                case(MonstroEntityFactory.NAME_BEETHRO): MonstroSfx.playBeethroDie(); break;
                case(MonstroEntityFactory.NAME_CITIZEN): MonstroSfx.playCitizenDie(); break;
                case(MonstroEntityFactory.NAME_STALWART): MonstroSfx.playStalwartDie(); break;
                case(MonstroEntityFactory.NAME_SLAYER): MonstroSfx.playSlayerDie(); break;
                case(MonstroEntityFactory.NAME_GOBLIN): MonstroSfx.playGoblinDie(); break;
                case(MonstroEntityFactory.NAME_TARBABY): MonstroSfx.playTarBabyDie(); break;
                default: MonstroSfx.playMonsterDie(); break;
            }
        }

        override public function destruct():void{
            super.destruct();
            _unitGraphic = null;
        }
    }
}