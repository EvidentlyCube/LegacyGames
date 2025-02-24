package net.retrocade.tacticengine.monstro.ingame.ais.classic {
    import net.retrocade.tacticengine.core.Eventer;
    import net.retrocade.tacticengine.core.MonstroField;
    import net.retrocade.tacticengine.core.Tile;
    import net.retrocade.tacticengine.core.injector.injectCreate;
    import net.retrocade.tacticengine.monstro.global.core.MonstroConsts;
	import net.retrocade.tacticengine.monstro.global.enum.EnumUnitController;
	import net.retrocade.tacticengine.monstro.ingame.ais.classic.enemyai.MonstroEnemyAI;
	import net.retrocade.tacticengine.monstro.ingame.ais.common.IMonstroTurnProcess;
    import net.retrocade.tacticengine.monstro.gui.render.MonstroFieldRenderer;
    import net.retrocade.tacticengine.monstro.ingame.actions.MonstroActionShowAttackStats;
    import net.retrocade.tacticengine.monstro.ingame.entities.MonstroEntity;
    import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventCenterOnUnit;
    import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventDisplayAttackStats;
	import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventDisplayUnitStats;
	import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventMarkTiles;
    import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventNewAction;
    import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventUnitHit;
    import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventUnitKilled;
    import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventUnitMoved;
    import net.retrocade.tacticengine.monstro.ingame.undo.UndoManager;
	import net.retrocade.tacticengine.monstro.ingame.undo.UndoBitUnit;
	import net.retrocade.tacticengine.monstro.ingame.utils.MonstroPathmapper;

    public class MonstroEnemyTurnProcess implements IMonstroTurnProcess {
        [Inject]
        public var fieldRenderer:MonstroFieldRenderer;
        [Inject]
        public var field:MonstroField;
        private var _enabled:Boolean = true;
        private var _monsterUnits:Vector.<MonstroEntity>;
        private var _hostileUnits:Vector.<MonstroEntity>;
        private var _ai:MonstroEnemyAI;
        private var _unitAttacker:MonstroEntity;
        private var _unitDefender:MonstroEntity;

        public function MonstroEnemyTurnProcess() {}

        public function init():void {
            _ai = injectCreate(MonstroEnemyAI);

            Eventer.listen(MonstroEventUnitKilled.NAME, resetUnitsList, this);

            resetUnitsList();
        }

		public function dispose():void {
			Eventer.releaseContext(this);

			_ai.destroy();

			fieldRenderer = null;
			field = null;
			_monsterUnits = null;
			_hostileUnits = null;
			_ai = null;
			_unitAttacker = null;
			_unitDefender = null;
		}

        public function start():void {
            resetUnitsList();

            for each(var unit:MonstroEntity in _monsterUnits) {
                unit.onTurnStarted();
            }
        }

        public function stop():void {
            for each(var unit:MonstroEntity in _monsterUnits) {
                unit.onTurnEnded();
            }

            MonstroPathmapper.stopCache();
			field.currentTurn++;

            enabled = false;
        }

        public function update():Boolean {
            if (_ai.isRunning) {
                if (_ai.update()) {
                    MonstroPathmapper.stopCache();
                    fieldRenderer.markTile(_ai.unit.tile, MonstroConsts.MARK_TYPE_RESET);
                    performMove();
                }
            } else {
                var unit:MonstroEntity = getNextUnit();

                if (unit) {
                    _ai.friendlyUnits = controllableUnits;
                    _ai.hostileUnits = hostileUnits;

                    _ai.startForUnit(unit);
                    fieldRenderer.markTile(unit.tile, MonstroConsts.MARK_TYPE_MOVE);
                } else {
                    return true;
                }
            }

            return false;
        }

        public function onUndo():void {
        }

        private function getNextUnit():MonstroEntity {
            for each(var unit:MonstroEntity in _monsterUnits) {
                if (!unit.hasMoved) {
                    if (unit.unitType.isFlag()) {
                        unit.hasMoved = true;
                    } else {
                        return unit;
                    }
                }
            }

            return null;
        }

        private function performMove():void {
            var targetTile:Tile = _ai.getTargetTile();
            var unit:MonstroEntity = _ai.unit;

            var path:Vector.<Tile> = MonstroPathmapper.getPathFromTo(unit.x, unit.y,
                targetTile.x, targetTile.y, unit, field);

            new MonstroEventCenterOnUnit(unit);

            if (targetTile.canStandOn(unit) && targetTile.entity != unit) {
                new MonstroEventUnitMoved(unit, path);

				var distance:int = MonstroPathmapper.getDistance(unit.x, unit.y, targetTile.x, targetTile.y, unit,
					field);

				unit.tilesMoved += distance;
                unit.move(targetTile.x, targetTile.y);
            }

			if (unit.isAlive) {
				tryToAttack(unit);
			}
		}

		private function tryToAttack(unit:MonstroEntity):void {
			_unitAttacker = unit;
			_unitDefender = _ai.getBestAttackableUnit(unit.tile, unit);

			if (_unitDefender && !unit.hasMoved) {
				new MonstroEventMarkTiles(_unitAttacker.tile, MonstroConsts.MARK_TYPE_MOVE_TARGET);
				new MonstroEventMarkTiles(_unitDefender.tile, MonstroConsts.MARK_TYPE_ATTACK_TARGET);

				new MonstroEventNewAction(new MonstroActionShowAttackStats(
					true, true, _unitAttacker, _unitDefender
				));

				new MonstroEventUnitHit(
					_unitAttacker,
					_unitDefender,
					onAttackFinished
				);

				new MonstroEventNewAction(new MonstroActionShowAttackStats(
					false
				));

				new MonstroEventMarkTiles(_unitAttacker.tile, MonstroConsts.MARK_TYPE_RESET);
				new MonstroEventMarkTiles(_unitDefender.tile, MonstroConsts.MARK_TYPE_RESET);

			} else {
				unit.hasMoved = true;
			}
		}

		private function onAttackFinished():void {
			_unitAttacker.attackOtherUnit(_unitDefender);
			new MonstroEventDisplayAttackStats(false);
			new MonstroEventDisplayUnitStats(null);

			_unitAttacker.hasMoved = true;
        }

        private function resetUnitsList():void {
            _monsterUnits = new Vector.<MonstroEntity>();
            _hostileUnits = new Vector.<MonstroEntity>();

            var entities:Vector.<MonstroEntity> = field.getLivingEntities();
            for each(var entity:MonstroEntity in entities) {
                if (entity.controlledBy.isPlayer()) {
                    _hostileUnits.push(entity as MonstroEntity);
                } else if (entity.controlledBy.isEnemy()) {
                    _monsterUnits.push(entity as MonstroEntity);
                }
            }

            _monsterUnits = _monsterUnits.sort(function (entityA:MonstroEntity, entityB:MonstroEntity):Number {
                if (entityA.movementOrder != entityB.movementOrder) {
                    return entityA.movementOrder - entityB.movementOrder;

                } else if (entityA.y != entityB.y) {
                    return entityA.y - entityB.y;

                } else {
                    return entityA.x - entityB.x;
                }
            });
        }

        public function get enabled():Boolean {
            return _enabled;
        }

        public function set enabled(value:Boolean):void {
            _enabled = value;
        }

        public function get controllableUnits():Vector.<MonstroEntity> {
            return _monsterUnits;
        }

        public function get hostileUnits():Vector.<MonstroEntity> {
            return _hostileUnits;
        }

		public function get controlledBy():EnumUnitController {
			return EnumUnitController.ENEMY;
		}
	}
}