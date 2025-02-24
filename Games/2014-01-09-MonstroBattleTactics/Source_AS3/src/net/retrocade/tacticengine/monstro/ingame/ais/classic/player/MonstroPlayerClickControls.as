
package net.retrocade.tacticengine.monstro.ingame.ais.classic.player {

	import flash.geom.Point;

    import net.retrocade.retrocamel.global.RetrocamelEventsQueue;
    import net.retrocade.retrocamel.interfaces.IRetrocamelUpdatable;
    import net.retrocade.tacticengine.core.Eventer;
    import net.retrocade.tacticengine.core.IDisposable;
    import net.retrocade.tacticengine.core.MonstroField;
    import net.retrocade.tacticengine.core.Tile;
    import net.retrocade.tacticengine.core.injector.injectCreate;
    import net.retrocade.tacticengine.monstro.global.core.MonstroConsts;
    import net.retrocade.tacticengine.monstro.global.core.SmartTouch;
    import net.retrocade.tacticengine.monstro.global.core.VoicesSfx;
    import net.retrocade.tacticengine.monstro.global.states.MonstroStateIngame;
    import net.retrocade.tacticengine.monstro.gui.helpers.MonstroCursorManager;
    import net.retrocade.tacticengine.monstro.gui.render.MonstroFieldRenderer;
    import net.retrocade.tacticengine.monstro.gui.render.MonstroUnitClip;
    import net.retrocade.tacticengine.monstro.ingame.ais.classic.enemyai.MonstroEnemyAI;
    import net.retrocade.tacticengine.monstro.ingame.entities.MonstroEntity;
    import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventDisplayAttackStats;
    import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventDisplayTrapStats;
    import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventDisplayUnitStats;
    import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventEndTurn;
    import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventMissionFinished;
    import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventTurnProcessHasChanged;
    import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventUndo;
    import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventUnitHit;
    import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventUnitMoved;
	import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventWindowClosed;
	import net.retrocade.tacticengine.monstro.ingame.undo.UndoBitTrap;
    import net.retrocade.tacticengine.monstro.ingame.undo.UndoBitUnit;
    import net.retrocade.tacticengine.monstro.ingame.undo.UndoManager;
    import net.retrocade.tacticengine.monstro.ingame.utils.MonstroPathmapper;

    public class MonstroPlayerClickControls implements IRetrocamelUpdatable, IDisposable {
        [Inject]
        public var field:MonstroField;
        [Inject]
        public var fieldRenderer:MonstroFieldRenderer;
        [Inject]
        public var ingameState:MonstroStateIngame;

        private var _enemyAi:MonstroEnemyAI;
        private var _enemyUnits:Vector.<MonstroEntity>;
        private var _playerUnits:Vector.<MonstroEntity>;

        private var _globalMousePosition:Point = new Point();
        private var _selectedUnit:MonstroEntity;
        private var _selectedUnitClip:MonstroUnitClip;
        private var _currentlySelectedUnitGhost:MonstroUnitClip;
        private var _currentlySelectedUnitTargets:Vector.<Tile>;
		private var _wasMouseDownLastStep:Boolean;

		private var _enemySimulationGhost:MonstroUnitClip;

        private var _unitPositionTile:Tile;
		private var _currentlyMarkedEntity:MonstroEntity;
        private var _markedTilesAttackable:Vector.<Tile>;
        private var _markedTilesAttackableNow:Vector.<Tile>;
        private var _markedTilesReachable:Vector.<Tile>;
        private var _markedTilesReachableByEnemy:Vector.<Tile>;

		private var _markedTileEnemyMovement:Tile;
		private var _markedTileEnemyAttack:Tile;

        private var _lastHoveredTile:Tile;
        private var _recalculateNow:Boolean;

        public function MonstroPlayerClickControls() {
            _enemyAi = injectCreate(MonstroEnemyAI);

            Eventer.listen(MonstroEventTurnProcessHasChanged.NAME, cleanupDisplay, this);
            Eventer.listen(MonstroEventMissionFinished.NAME, cleanupDisplay, this);
            Eventer.listen(MonstroEventUndo.NAME, deselectCurrentUnit, this);
            Eventer.listen(MonstroEventEndTurn.NAME, deselectCurrentUnit, this);
			Eventer.listen(MonstroEventUndo.NAME, resetLastTile, this);
			Eventer.listen(MonstroEventEndTurn.NAME, resetLastTile, this);
            Eventer.listen(MonstroEventUndo.NAME, resetAi, this);
            Eventer.listen(MonstroEventEndTurn.NAME, resetAi, this);
            Eventer.listen(MonstroEventUnitMoved.NAME, resetAi, this);
			Eventer.listen(MonstroEventWindowClosed.NAME, forceRecalculate, this);
        }

        public function dispose():void {
			Eventer.releaseContext(this);

            unmarkTiles();

			if (_currentlySelectedUnitGhost){
				fieldRenderer.removeGhost(_currentlySelectedUnitGhost);
				_currentlySelectedUnitGhost.dispose();
			}

			if (_enemySimulationGhost){
				fieldRenderer.removeGhost(_enemySimulationGhost);
				_enemySimulationGhost.dispose();
			}

			_enemyAi.destroy();
			_enemyAi = null;

            field = null;
            fieldRenderer = null;
        }

        public function update():void {
            var hoveredTile:Tile = calculateHoveredTile();

            if (_recalculateNow) {
                recalculate(hoveredTile);
            }

			if (_enemyAi.isRunning){
				_enemyAi.update();
			}

			CF::enableCheats{
                if (SmartTouch.isSingleTouchDown && SmartTouch.isCtrlDown && hoveredTile && hoveredTile.entity) {
                    hoveredTile.entity.receiveDamage(99);
                }
            }

            if (isNewClick) {
                updateClicking(hoveredTile);
            } else {
                updateReleased(hoveredTile);
            }

			markEnemySimulation(hoveredTile);

			_lastHoveredTile = hoveredTile;
            _wasMouseDownLastStep = SmartTouch.isSingleTouchDown;
        }

		private function markEnemySimulation(hoveredTile:Tile):void {
			if (canDisplayEnemyPrediction(hoveredTile)) {
				_markedTileEnemyMovement = _enemyAi.getTargetTile();
				var entity:MonstroEntity = _enemyAi.getBestAttackableUnit(_markedTileEnemyMovement, _enemyAi.unit);
				_markedTileEnemyAttack = entity ? entity.tile : null;
				remarkTiles();

				_enemySimulationGhost = fieldRenderer.makeUnitGhost(_enemyAi.unit);
				_enemySimulationGhost.visible = true;
				_enemySimulationGhost.x = _markedTileEnemyMovement.x * MonstroConsts.tileWidth;
				_enemySimulationGhost.y = _markedTileEnemyMovement.y * MonstroConsts.tileHeight;

				if (_markedTileEnemyMovement.x < _enemyAi.unit.x){
					_enemySimulationGhost.mirror = true;
				} else if (_markedTileEnemyMovement.x > _enemyAi.unit.x){
					_enemySimulationGhost.mirror = false;
				}

				if (_markedTileEnemyAttack){
					if (_markedTileEnemyMovement.x > _markedTileEnemyAttack.x){
						_enemySimulationGhost.mirror = true;
					} else if (_markedTileEnemyMovement.x < _markedTileEnemyAttack.x){
						_enemySimulationGhost.mirror = false;
					}
				}
			}
		}

		private function canDisplayEnemyPrediction(hoveredTile:Tile):Boolean{
			var isMouseOverTrackedUnit:Boolean = (hoveredTile && hoveredTile.entity === _enemyAi.unit);
			var isMouseOverNotTrackedUnit:Boolean = (hoveredTile && hoveredTile.entity && hoveredTile.entity !== _enemyAi.unit);
			var isTrackedUnitSelected:Boolean = _enemyAi.unit === _selectedUnit;
			var isFinishedAndNotSet:Boolean = _enemyAi.isFinished && !_markedTileEnemyMovement;

			return isFinishedAndNotSet && !isMouseOverNotTrackedUnit && (isMouseOverTrackedUnit || isTrackedUnitSelected);
		}

		private function forceRecalculate():void{
			_recalculateNow = true;
			_lastHoveredTile = null;
		}

        public function recalculate(hoveredTile:Tile):void {
            if (_selectedUnit && _selectedUnit.hasMoved === true) {
                deselectCurrentUnit();
            }

			_enemyAi.reset();

			_currentlyMarkedEntity = null;

            if (_selectedUnit) {
                showTileMarksFor(_selectedUnit);
                _selectedUnitClip.isUnitBlinking = true;
                _unitPositionTile = _selectedUnit.tile;
                _currentlySelectedUnitTargets = _selectedUnit.getAttackableTilesWithTargets();

				if (hoveredTile === _selectedUnit.tile && _selectedUnit.controlledBy.isPlayer()){
					MonstroCursorManager.setCursorEndUnitTurn();
				}
            }
            _recalculateNow = false;
        }

        private function updateClicking(hoveredTile:Tile):void {
            var hoveredEntity:MonstroEntity = hoveredTile ? hoveredTile.entity : null;

            hideGhost();

            if (hoveredEntity) {
                if (hoveredEntity === _selectedUnit && _selectedUnit.controlledBy.isPlayer()) {
                    endSelectedUnitTurn()
                } else if (canAttackTileNow(hoveredTile)) {
                    attackUnit(_selectedUnit, hoveredEntity);
                } else if (!hoveredEntity.hasMoved) {
                    selectUnit(hoveredEntity);
                }
            } else if (_selectedUnit) {
                if (_selectedUnit.controlledBy.isPlayer()) {
                    if (_markedTilesReachable.indexOf(hoveredTile) > -1) {
                        moveUnit(_selectedUnit, hoveredTile);
                    } else {
                        deselectCurrentUnit();
                    }
                } else {
                    deselectCurrentUnit();
                }
            }
        }

        private function updateReleased(hoveredTile:Tile):void {
            if (hoveredTile === _lastHoveredTile) {
                return;
            }

            new MonstroEventDisplayAttackStats(false);
            MonstroCursorManager.resetCursor();
            hideGhost();

            var hoveredEntity:MonstroEntity = hoveredTile ? hoveredTile.entity : null;

			calculateEnemyAction(hoveredEntity);

            if (hoveredEntity) {
                if (hoveredEntity === _selectedUnit) {
                    showTileMarksFor(_selectedUnit);
                    if (_selectedUnit.controlledBy.isPlayer()) {
                        MonstroCursorManager.setCursorEndUnitTurn();
                    }
                } else if (canAttackTileNow(hoveredTile)) {
                    showTileMarksFor(_selectedUnit);

                    new MonstroEventDisplayAttackStats(true, false, _selectedUnit, hoveredEntity);
                    MonstroCursorManager.setCursorToAttack();
                } else if (couldAttackTile(hoveredTile)) {
                    showTileMarksFor(hoveredEntity);

                    new MonstroEventDisplayAttackStats(true, false, _selectedUnit, hoveredEntity);
					MonstroCursorManager.setCursorToAttackBlocked();
                } else {
                    new MonstroEventDisplayUnitStats(hoveredEntity);
					if (isEntityInteractable(hoveredEntity)){
						showTileMarksFor(hoveredEntity);
					} else {
						showTileMarksFor(_selectedUnit);
					}
                }
            } else {
                if (_selectedUnit) {
					new MonstroEventDisplayUnitStats(_selectedUnit);
                    showTileMarksFor(_selectedUnit);

                    if (_selectedUnit.controlledBy.isPlayer() && _markedTilesReachable && _markedTilesReachable.indexOf(hoveredTile) > -1) {
                        fieldRenderer.markTile(hoveredTile, MonstroConsts.MARK_TYPE_MOVE_TARGET);
                        showGhost(hoveredTile.x, hoveredTile.y);
                    } else {
                        hideGhost();
                    }
                } else {
					showTileMarksFor(null);
				}

                if (hoveredTile && hoveredTile.floor.trap) {
                    new MonstroEventDisplayTrapStats(hoveredTile.floor.trap);

                } else if (!_selectedUnit){
                    new MonstroEventDisplayUnitStats(null);
                }
            }
        }

		private function endSelectedUnitTurn():void {
			RetrocamelEventsQueue.add(MonstroConsts.EVENT_UNIT_DOUBLE_CLICKED);
			RetrocamelEventsQueue.add(MonstroConsts.EVENT_UNIT_TURN_ENDED, _selectedUnit);

			UndoManager.instance.startNewStep(field);
			UndoManager.instance.addBit(new UndoBitUnit(_selectedUnit));
			UndoManager.instance.commitStep();

			_selectedUnit.hasMoved = true;
			deselectCurrentUnit();
		}

        public function showGhost(x:uint, y:uint):void {
            _currentlySelectedUnitGhost.visible = true;
            _currentlySelectedUnitGhost.x = x * MonstroConsts.tileWidth;
            _currentlySelectedUnitGhost.y = y * MonstroConsts.tileHeight;
        }

        public function hideGhost():void {
            if (_currentlySelectedUnitGhost) {
                _currentlySelectedUnitGhost.visible = false;
            }
        }

        private function selectUnit(unit:MonstroEntity):void {
            deselectCurrentUnit();

			RetrocamelEventsQueue.add(MonstroConsts.EVENT_UNIT_SELECTED, unit);

			new MonstroEventDisplayAttackStats(false);
			new MonstroEventDisplayUnitStats(unit);

            _selectedUnit = unit;
            _unitPositionTile = unit.tile;
            _selectedUnitClip = fieldRenderer.getUnitClipForEntity(unit);
            _currentlySelectedUnitTargets = unit.getAttackableTilesWithTargets();
            _currentlySelectedUnitGhost = fieldRenderer.makeUnitGhost(unit);
            _currentlySelectedUnitGhost.visible = false;
            _selectedUnitClip.isUnitBlinking = true;
            showTileMarksFor(unit);

			if (_selectedUnit.controlledBy.isPlayer()){
                VoicesSfx.playReady(_selectedUnit.unitType);
				MonstroCursorManager.setCursorEndUnitTurn();
			}
        }

        private function deselectCurrentUnit():void {
            if (_selectedUnit) {
				new MonstroEventDisplayUnitStats(null);

				RetrocamelEventsQueue.add(MonstroConsts.EVENT_UNIT_DESELECTED, _selectedUnit);
                _selectedUnitClip.isUnitBlinking = false;
                unmarkTiles();
                fieldRenderer.removeGhost(_currentlySelectedUnitGhost);
                _currentlySelectedUnitGhost.dispose();
                _currentlySelectedUnitTargets = null;
                _unitPositionTile = null;
                _selectedUnit = null;
            }
        }

		private function resetLastTile():void {
			_lastHoveredTile = null;
		}

        private function showTileMarksFor(entity:MonstroEntity):void {
			if (entity === _currentlyMarkedEntity){
				if (entity === null){
					unmarkTiles();
				}
				return;
			}

            unmarkTiles();

            if (entity && !entity.hasMoved) {
				RetrocamelEventsQueue.add(MonstroConsts.EVENT_SHOW_TILEMARKS, entity);

                if (entity.controlledBy.isPlayer()) {
                    _markedTilesReachable = entity.getMovableTiles();
                    _markedTilesAttackable = entity.getExpandedAttackableTiles(_markedTilesReachable);
                    _markedTilesAttackableNow = entity.getAttackableTilesWithTargets();

                } else if (entity.controlledBy.isEnemy()) {
                    _markedTilesReachableByEnemy = entity.getMovableTiles();
                    _markedTilesAttackable = entity.getExpandedAttackableTiles(_markedTilesReachableByEnemy);
                    _markedTilesAttackableNow = entity.getAttackableTilesWithTargets();
                }

                removeTileFromVector(_markedTilesReachable, entity.tile);
                removeTileFromVector(_markedTilesReachableByEnemy, entity.tile);
                removeTileFromVector(_markedTilesAttackable, entity.tile);

                remarkTiles();
            }
        }

        private function unmarkTiles():void {
			_currentlyMarkedEntity = null;

            if (_markedTilesReachable) {
                fieldRenderer.markTiles(_markedTilesReachable, MonstroConsts.MARK_TYPE_RESET);
            }
            if (_markedTilesReachableByEnemy) {
                fieldRenderer.markTiles(_markedTilesReachableByEnemy, MonstroConsts.MARK_TYPE_RESET);
            }
            if (_markedTilesAttackable) {
                fieldRenderer.markTiles(_markedTilesAttackable, MonstroConsts.MARK_TYPE_RESET);
            }
            if (_selectedUnit) {
                fieldRenderer.markTile(_selectedUnit.tile, MonstroConsts.MARK_TYPE_RESET);
            }
            if (_unitPositionTile) {
                fieldRenderer.markTile(_unitPositionTile, MonstroConsts.MARK_TYPE_RESET);
            }

			if (_markedTileEnemyAttack){
				fieldRenderer.markTile(_markedTileEnemyAttack, MonstroConsts.MARK_TYPE_RESET);
			}
			if (_markedTileEnemyMovement){
				fieldRenderer.markTile(_markedTileEnemyMovement, MonstroConsts.MARK_TYPE_RESET);
			}
            _markedTilesReachable = null;
            _markedTilesReachableByEnemy = null;
            _markedTilesAttackable = null;
            _markedTilesAttackableNow = null;
			_markedTileEnemyAttack = null;
			_markedTileEnemyMovement = null;

			if (_enemySimulationGhost){
				fieldRenderer.removeGhost(_enemySimulationGhost);
				_enemySimulationGhost.dispose();
				_enemySimulationGhost = null;
			}
        }

        private function remarkTiles():void {
            fieldRenderer.markTiles(_markedTilesAttackable, MonstroConsts.MARK_TYPE_ATTACKABLE);
            fieldRenderer.markTiles(_markedTilesReachable, MonstroConsts.MARK_TYPE_MOVE);
            fieldRenderer.markTiles(_markedTilesReachableByEnemy, MonstroConsts.MARK_TYPE_ENEMY_MOVE);
            fieldRenderer.markTiles(_markedTilesAttackableNow, MonstroConsts.MARK_TYPE_ATTACK_TARGET);

            if (_selectedUnit && _selectedUnit.controlledBy.isPlayer()) {
                fieldRenderer.markTile(_selectedUnit.tile, MonstroConsts.MARK_TYPE_SELECTED_UNIT);
            }
            if (_selectedUnit && _selectedUnit.controlledBy.isEnemy()) {
                fieldRenderer.markTile(_selectedUnit.tile, MonstroConsts.MARK_TYPE_ENEMY_SELECTED_UNIT);
            }

			if (_markedTileEnemyAttack){
				fieldRenderer.markTile(_markedTileEnemyAttack, MonstroConsts.MARK_TYPE_ATTACK_TARGET);
			}
			if (_markedTileEnemyMovement){
				fieldRenderer.markTile(_markedTileEnemyMovement, MonstroConsts.MARK_TYPE_MOVE_TARGET);
			}
        }

        private function calculateHoveredTile():Tile {
            _globalMousePosition.x = SmartTouch.hoverX;
            _globalMousePosition.y = SmartTouch.hoverY;
            fieldRenderer.globalToLocal(_globalMousePosition);

            var x:int = _globalMousePosition.x / MonstroConsts.tileWidth | 0;
            var y:int = _globalMousePosition.y / MonstroConsts.tileHeight | 0;

            return field.getTileAt(x, y);
        }

        private function get isNewClick():Boolean {
            return _wasMouseDownLastStep == false && SmartTouch.isSingleTouchDown;
        }

        private function cleanupDisplay():void {
            unmarkTiles();
            MonstroCursorManager.resetCursor();
        }

        private function canAttackTileNow(tile:Tile):Boolean {
            return couldAttackTile(tile) && _currentlySelectedUnitTargets.indexOf(tile) > -1 && _selectedUnit.controlledBy.isPlayer() && (tile.entity.controlledBy.isEnemy() || tile.entity.unitType.isBreakableTile);
        }

        private function couldAttackTile(tile:Tile):Boolean {
            if (!tile || !tile.entity || !_selectedUnit) {
                return false;
            }

			if (!_selectedUnit.controlledBy.canAttack((tile.entity.controlledBy))){
				return false;
			}

            return tile.entity.attackable || tile.entity.unitType.isBreakableTile;
        }

		private function isEntityInteractable(entity:MonstroEntity):Boolean{
			return entity && (entity.attackable || entity.getStatistics().attackRangeMax > 0 || entity.getStatistics().movesMax > 0);
		}

        private function moveUnit(unit:MonstroEntity, targetTile:Tile):void {
            VoicesSfx.playMove(unit.unitType);
			RetrocamelEventsQueue.add(MonstroConsts.EVENT_UNIT_MOVED, unit);

            SmartTouch.flushSingleTouch();

            _selectedUnitClip.isUnitBlinking = false;
            RetrocamelEventsQueue.add(MonstroConsts.EVENT_DRAGGED_MOVED_UNIT);

            UndoManager.instance.startNewStep(field);
            UndoManager.instance.addBit(new UndoBitUnit(unit));
            if (targetTile.floor.trap) {
                UndoManager.instance.addBit(new UndoBitTrap(targetTile.floor.trap));
            }
            UndoManager.instance.commitStep();

            var startTile:Tile = unit.tile;
            var path:Vector.<Tile> = MonstroPathmapper.getPathFromTo(unit.x, unit.y, targetTile.x, targetTile.y,
                    unit, field);
            var distance:int = MonstroPathmapper.getDistance(unit.x, unit.y, targetTile.x, targetTile.y, unit,
                    field);

            new MonstroEventUnitMoved(unit, path);
			unit.tilesMoved += distance;
            unit.move(targetTile.x, targetTile.y);
            unit.onMoved(startTile, targetTile, distance);

            _recalculateNow = true;
        }

        private function attackUnit(attacker:MonstroEntity, defender:MonstroEntity):void {
			RetrocamelEventsQueue.add(MonstroConsts.EVENT_UNIT_ATTACKED_OTHER_UNIT, attacker);
			RetrocamelEventsQueue.add(MonstroConsts.EVENT_UNIT_WAS_ATTACKED, defender);

            SmartTouch.isFastforwardTouch = false;

            UndoManager.instance.startNewStep(field);
            UndoManager.instance.addBit(new UndoBitUnit(attacker));
            UndoManager.instance.addBit(new UndoBitUnit(defender));
            UndoManager.instance.commitStep();

            RetrocamelEventsQueue.add(MonstroConsts.EVENT_DRAGGED_ATTACKED_ENEMY);

            new MonstroEventUnitHit(attacker, defender);
            attacker.attackOtherUnit(defender);
            attacker.hasMoved = true;

            deselectCurrentUnit();

			MonstroCursorManager.resetCursor();
			new MonstroEventDisplayAttackStats(false);
			new MonstroEventDisplayUnitStats(defender);
			new MonstroEventDisplayUnitStats(defender.isAlive > 0 ? defender : null);
        }

		private function calculateEnemyAction(entity:MonstroEntity):void{
			if (!entity){
				entity = _selectedUnit;
			}

			resetUnitsList();

			if (entity && entity.controlledBy.isEnemy() && entity !== _enemyAi.unit){
				_enemyAi.friendlyUnits = _enemyUnits;
				_enemyAi.hostileUnits = _playerUnits;

				_enemyAi.startForUnit(entity);
			}
		}

        private function resetUnitsList():void {
            _enemyUnits = new Vector.<MonstroEntity>();
            _playerUnits = new Vector.<MonstroEntity>();

            var entities:Vector.<MonstroEntity> = field.getAllEntities();
            for each(var entity:MonstroEntity in entities) {
				if (!entity.isAlive){
					continue;
				}

                if (entity.controlledBy.isPlayer()) {
                    _playerUnits.push(entity as MonstroEntity);
                } else if (entity.controlledBy.isEnemy()) {
                    _enemyUnits.push(entity as MonstroEntity);
                }
            }

            _enemyUnits = _enemyUnits.sort(function (entityA:MonstroEntity, entityB:MonstroEntity):Number {
                if (entityA.movementOrder != entityB.movementOrder) {
                    return entityA.movementOrder - entityB.movementOrder;

                } else if (entityA.y != entityB.y) {
                    return entityA.y - entityB.y;

                } else {
                    return entityA.x - entityB.x;
                }
            });
        }

		private function resetAi():void{
			_enemyAi.reset();
		}

        private function removeTileFromVector(vector:Vector.<Tile>, tile:Tile):void {
            if (!vector) {
                return;
            }

            while (true) {
                var index:int = vector.indexOf(tile);

                if (index !== -1) {
                    vector[index] = vector[vector.length - 1];
                    vector.length -= 1;
                } else {
                    break;
                }
            }
        }
    }
}
