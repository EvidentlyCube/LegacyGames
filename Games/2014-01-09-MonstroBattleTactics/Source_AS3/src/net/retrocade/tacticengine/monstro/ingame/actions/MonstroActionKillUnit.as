package net.retrocade.tacticengine.monstro.ingame.actions{
    import net.retrocade.tacticengine.core.injector.MonstroInjector;
    import net.retrocade.tacticengine.monstro.global.core.MonstroGameplayDefinition;
    import net.retrocade.tacticengine.monstro.global.core.MonstroSfx;
    import net.retrocade.tacticengine.monstro.global.core.SmartTouch;
    import net.retrocade.tacticengine.monstro.global.core.VoicesSfx;
    import net.retrocade.tacticengine.monstro.ingame.actions.subaction.MonstroSubactionPoof;
    import net.retrocade.tacticengine.monstro.ingame.entities.MonstroEntity;
    import net.retrocade.tacticengine.monstro.gui.render.MonstroUnitClip;
    import net.retrocade.tacticengine.monstro.global.enum.EnumUnitType;

    public class MonstroActionKillUnit extends MonstroAction{
        [Inject]
        public var gameplayDefinition:MonstroGameplayDefinition;

        private var _unitGraphic:MonstroUnitClip;
        private var _unitObject:MonstroEntity;
        private var _started:Boolean = false;
        private var _subactionPuff:MonstroSubactionPoof;

        public function MonstroActionKillUnit(){
            super(null);
        }

        public function init(unitGraphic:MonstroUnitClip, unitObject:MonstroEntity):void{
            _unitGraphic = unitGraphic;
            _unitObject = unitObject;
        }

        override public function update():Boolean{
            if (!_started){
                _subactionPuff = MonstroInjector.create(
                    MonstroSubactionPoof,
                    _unitGraphic.absoluteCenter,
                    _unitGraphic.absoluteMiddle,
                    MonstroSubactionPoof.TYPE_RED,
                    _unitGraphic.parent
                );

                playKillSound();
                _started = true;
            }

            _unitGraphic.alpha -= fadeDelta;
            _subactionPuff.update(poofFadeDelta);

            if (_unitGraphic.alpha <= 0 && !_subactionPuff.isPlaying){
                _unitGraphic.visible = false;
                return true;
            }

            return false;
        }

        private function get fadeDelta():Number{
            if (SmartTouch.isRightButtonDown){
                return 1;
            } else {
                return gameplayDefinition.gameSpeed;
            }
        }

        private function get poofFadeDelta():Number{
            if (SmartTouch.isRightButtonDown){
                return 4;
            } else {
                return 1;
            }
        }

        private function playKillSound():void{
            if (VoicesSfx.playDie(_unitObject.unitType)){
                return;
            }

            if (_unitObject.isHuman()){
                switch(_unitObject.unitType){
                    case(EnumUnitType.FLAG_KING):
                        MonstroSfx.playHumanKilledKing();
                        break;
                    default:
                        MonstroSfx.playHumanKilledGeneric();
                        break;
                }

            } else {
                switch(_unitObject.unitType){
                    case(EnumUnitType.SLIME):
                        MonstroSfx.playMonsterKilledSlime();
                        break;
                    case(EnumUnitType.SHROOM):
                        MonstroSfx.playMonsterKilledMushroom();
                        break;
                    case(EnumUnitType.FLAG_BRAIN):
                        MonstroSfx.playMonsterKilledBrain();
                        break;
                    default:
                        MonstroSfx.playMonsterKilledGeneric();
                        break;
                }
            }
        }


        override public function dispose():void{
            super.dispose();
            if (_subactionPuff){
                _subactionPuff.dispose();
            }
            _subactionPuff = null;
            _unitGraphic = null;
        }
    }
}