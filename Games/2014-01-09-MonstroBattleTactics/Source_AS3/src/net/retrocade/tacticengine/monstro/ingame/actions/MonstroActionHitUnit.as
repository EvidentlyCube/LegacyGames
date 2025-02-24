package net.retrocade.tacticengine.monstro.ingame.actions{
	import net.retrocade.tacticengine.core.injector.MonstroInjector;
	import net.retrocade.tacticengine.monstro.global.core.MonstroConsts;
    import net.retrocade.tacticengine.monstro.global.core.MonstroGameplayDefinition;
    import net.retrocade.tacticengine.monstro.global.core.MonstroSfx;
    import net.retrocade.tacticengine.monstro.global.core.SmartTouch;
    import net.retrocade.tacticengine.monstro.global.core.VoicesSfx;
    import net.retrocade.tacticengine.monstro.global.enum.EnumFxType;
	import net.retrocade.tacticengine.monstro.ingame.actions.subaction.MonstroSubactionWeaponDamage;
	import net.retrocade.tacticengine.monstro.ingame.entities.MonstroEntity;
    import net.retrocade.tacticengine.monstro.gui.render.MonstroUnitClip;
    import net.retrocade.tacticengine.monstro.global.enum.EnumUnitType;

    import starling.utils.Color;

    public class MonstroActionHitUnit extends MonstroAction{
        [Inject]
        public var gameplayDefinition:MonstroGameplayDefinition;

        private var _defenderClip:MonstroUnitClip;
        private var _unitAttacker:MonstroEntity;
        private var _unitDefender:MonstroEntity;
        private var _unitStartX:int;
        private var _unitStartY:int;
        private var _momentum:Number;
        private var _power:Number;
        private var _startingPower:Number;

		private var _subactionWeaponDamage:MonstroSubactionWeaponDamage;

        private var _started:Boolean = false;

        public function MonstroActionHitUnit(){
            super(null);
        }

        public function init(unit:MonstroUnitClip, unitAttacker:MonstroEntity, unitDefender:MonstroEntity, onFinished:Function = null):void{
            _callback = onFinished;

            _defenderClip = unit;
            _unitAttacker = unitAttacker;
            _unitDefender = unitDefender;

            _momentum = 0;
            _startingPower = _power = MonstroConsts.tileWidth / 6;
        }

        override public function update():Boolean{
            if (!_started){
				_subactionWeaponDamage = MonstroInjector.create(
					MonstroSubactionWeaponDamage,
					_defenderClip.absoluteCenter,
					_defenderClip.absoluteMiddle,
					getFxType(),
					_defenderClip.parent
				);

                _unitStartX = _defenderClip.x;
                _unitStartY = _defenderClip.y;

                playAttackSound();
                playHitSound();
                _started = true;
            }

            _defenderClip.color = Color.rgb(255, 255 - 255 * _power / _startingPower, 255 - 255 * _power / _startingPower);

            _momentum += Math.PI * 0.3391;
            _power *= 0.8;

			_subactionWeaponDamage.update(weaponAnimationDelta);

            if (_power <= 0.1 && !_subactionWeaponDamage.isPlaying){
                _defenderClip.x = _unitStartX;
                _defenderClip.y = _unitStartY;

                _defenderClip.color = 0xFFFFFF;

                return true;
            } else {
                _defenderClip.x = _unitStartX + Math.sin(_momentum) * _power;
            }

            return false;
        }

		private function get weaponAnimationDelta():Number{
			if (SmartTouch.isRightButtonDown){
				return 4;
			} else {
				return 1;
			}
		}

		private function getFxType():EnumFxType{
			if (!_unitAttacker){
				return EnumFxType.POINT;
			}

			switch(_unitAttacker.unitType){
				case(EnumUnitType.ARCHER):
					return EnumFxType.VERTICAL_SIMPLE;

				case(EnumUnitType.GARGOYLE):
				case(EnumUnitType.MANTICORE):
					return EnumFxType.CLAWS;

				case(EnumUnitType.SLIME):
				case(EnumUnitType.GOO):
				case(EnumUnitType.SHROOM):
					return EnumFxType.POINT;

				case(EnumUnitType.MINOTAUR):
					return EnumFxType.VERTICAL;

				case(EnumUnitType.CAVALRY):
					return EnumFxType.DIAGONAL;

				case(EnumUnitType.GRUNT):
				case(EnumUnitType.KNIGHT):
				case(EnumUnitType.SOLDIER):
					return EnumFxType.SLASH;

				case(EnumUnitType.PIKEMAN):
					return EnumFxType.HORIZONTAL;

				default:
					return EnumFxType.POINT;
			}
		}

        private function playAttackSound():void{
            if (!_unitAttacker){
                return;
            }

            if (_unitAttacker.isHuman()){
                switch(_unitAttacker.unitType){
                    case(EnumUnitType.ARCHER):
                        MonstroSfx.playHumanAttacksBowman();
                        break;
                    case(EnumUnitType.FLAG_KING):
                        MonstroSfx.playHumanHitKing();
                        break;
                    default:
                        MonstroSfx.playHumanAttacksGeneric();
                        break;
                }

            } else {
                switch(_unitAttacker.unitType){
                    case(EnumUnitType.SLIME):
                        MonstroSfx.playMonsterAttacksSlime();
                        break;
                    case(EnumUnitType.SHROOM):
                        MonstroSfx.playMonsterAttacksMushroom();
                        break;
                    default:
                        MonstroSfx.playMonsterAttacksGeneric();
                        break;
                }
            }
        }

        private function playHitSound():void{
            if (VoicesSfx.playHit(_unitDefender.unitType)){
                return;
            }

            if (_unitDefender.isHuman()){
                switch(_unitDefender.unitType){
                    case(EnumUnitType.FLAG_KING):
                        MonstroSfx.playHumanHitKing();
                        break;
                    default:
                        MonstroSfx.playHumanHitGeneric();
                        break;
                }

            } else {
                switch(_unitDefender.unitType){
                    case(EnumUnitType.SLIME):
                        MonstroSfx.playMonsterHitSlime();
                        break;
                    case(EnumUnitType.SHROOM):
                        MonstroSfx.playMonsterHitMushroom();
                        break;
                    case(EnumUnitType.FLAG_BRAIN):
                        MonstroSfx.playMonsterHitBrain();
                        break;
                    case(EnumUnitType.FAKE_WALL):
                    case(EnumUnitType.BONFIRE):
                    case(EnumUnitType.LANTERN):
                    case(EnumUnitType.TORCH):
                        break;
                    default:
                        MonstroSfx.playMonsterHitGeneric();
                        break;
                }
            }
        }

        private function get powerDelta():Number{
            if (SmartTouch.isRightButtonDown){
                return 5;
            } else {
                return gameplayDefinition.gameSpeed * 5;
            }
        }

        override public function dispose():void{
            super.dispose();

			if (_subactionWeaponDamage){
				_subactionWeaponDamage.dispose();
			}
			_subactionWeaponDamage = null;
            _defenderClip = null;
            _unitAttacker = null;
            _unitDefender = null;
        }
    }
}