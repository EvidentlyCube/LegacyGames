package net.retrocade.tacticengine.monstro.actions{
    import net.retrocade.tacticengine.monstro.core.Monstro;
    import net.retrocade.tacticengine.monstro.core.MonstroSfx;
    import net.retrocade.tacticengine.monstro.core.SmartTouch;
    import net.retrocade.tacticengine.monstro.entities.MonstroEntity;
    import net.retrocade.tacticengine.monstro.entities.MonstroEntityFactory;
    import net.retrocade.tacticengine.monstro.render.MonstroUnitClip;

    public class MonstroActionHitUnit extends MonstroAction{
        private var _unit:MonstroUnitClip;
        private var _unitObject:MonstroEntity;
        private var _unitStartX:int;
        private var _unitStartY:int;
        private var _momentum:Number;
        private var _power:Number;

        private var _started:Boolean = false;

        public function MonstroActionHitUnit(unit:MonstroUnitClip, unitObject:MonstroEntity, onFinished:Function = null){
            super(onFinished);

            _unit = unit;
            _unitObject = unitObject;

            _unitStartX = unit.x;
            _unitStartY = unit.y;
            
            _momentum = 0;
            _power = Monstro.tileWidth / 4;
        }
        
        override public function update():Boolean{
            if (!_started){
                playHitSound();
                _started = true;
            }

            _momentum += Math.PI * 0.7391;
            _power -= powerDelta;
            
            if (_power <= 0){
                _unit.x = _unitStartX;
                _unit.y = _unitStartY;
                return true;
            } else {
                _unit.x = _unitStartX + Math.sin(_momentum) * _power;
            }
            
            return false;
        }

        private function get powerDelta():Number{
            if (!SmartTouch.isSingleTouchDown){
                return 0.30;
            } else {
                return 5;
            }
        }

        private function playHitSound():void{
            switch(_unitObject.name){
                case(MonstroEntityFactory.NAME_BEETHRO): MonstroSfx.playBeethroHit(); break;
                case(MonstroEntityFactory.NAME_CITIZEN): MonstroSfx.playCitizenHit(); break;
                case(MonstroEntityFactory.NAME_STALWART): MonstroSfx.playStalwartHit(); break;
                case(MonstroEntityFactory.NAME_SLAYER): MonstroSfx.playSlayerHit(); break;
                case(MonstroEntityFactory.NAME_GOBLIN): MonstroSfx.playGoblinHit(); break;
                default: MonstroSfx.playMonserHit(); break;
            }
        }

        override public function destruct():void{
            super.destruct();

            _unit = null;
        }
    }
}