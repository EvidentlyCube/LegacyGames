
package net.retrocade.tacticengine.monstro.ingame.ais.classic.player {

    import flash.geom.Point;
    import flash.utils.getTimer;

    import net.retrocade.retrocamel.global.RetrocamelEventsQueue;
    import net.retrocade.retrocamel.interfaces.IRetrocamelUpdatable;
    import net.retrocade.tacticengine.core.Eventer;
    import net.retrocade.tacticengine.core.MonstroField;
    import net.retrocade.tacticengine.core.IDisposable;
    import net.retrocade.tacticengine.core.Tile;
	import net.retrocade.tacticengine.core.injector.injectCreate;
	import net.retrocade.tacticengine.monstro.global.core.MonstroConsts;
    import net.retrocade.tacticengine.monstro.global.core.SmartTouch;
    import net.retrocade.tacticengine.monstro.global.states.MonstroStateIngame;
    import net.retrocade.tacticengine.monstro.gui.helpers.MonstroCursorManager;
    import net.retrocade.tacticengine.monstro.gui.render.MonstroFieldRenderer;
    import net.retrocade.tacticengine.monstro.gui.render.MonstroUnitClip;
	import net.retrocade.tacticengine.monstro.ingame.ais.classic.enemyai.MonstroEnemyAI;
    import net.retrocade.tacticengine.monstro.ingame.entities.MonstroEntity;
    import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventDisplayAttackStats;
    import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventDisplayUnitStats;
    import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventMissionFinished;
    import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventTurnProcessHasChanged;
    import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventUnitHit;
    import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventUnitMoved;
	import net.retrocade.tacticengine.monstro.ingame.undo.UndoBitTrap;
	import net.retrocade.tacticengine.monstro.ingame.undo.UndoManager;
    import net.retrocade.tacticengine.monstro.ingame.undo.UndoBitUnit;
    import net.retrocade.tacticengine.monstro.ingame.utils.MonstroPathmapper;
    import net.retrocade.utils.UtilsNumber;

    public class MonstroPlayerDragAndDropControls implements IRetrocamelUpdatable, IDisposable {
        [Inject]
        public var field:MonstroField;
        [Inject]
        public var fieldRenderer:MonstroFieldRenderer;
        [Inject]
        public var ingameState:MonstroStateIngame;
        private var _wasMouseDownLastStep:Boolean = false;
        private var _isDraggingUnit:Boolean = false;
        private var _draggedUnit:MonstroEntity;
        private var _draggedUnitOffsetX:int;
        private var _draggedUnitOffsetY:int;
        private var _draggedUnitGraphic:MonstroUnitClip;
        private var _tilesMovable:Vector.<Tile>;
        private var _tilesPossibleToAttack:Vector.<Tile>;
        private var _tilesAttackableEntities:Vector.<Tile>;
        private var _tilesAttackableNow:Vector.<Tile>;
        private var _tilesHoveredUnit:Vector.<Tile>;
        private var _currentlyHoveredTile:Tile;
        private var _currentlyMarkedEntity:MonstroEntity;
        private var _doubleClickTime:Number;
        private var _doubleClickX:int;
        private var _doubleClickY:int;
        private var _lastActedUnit:MonstroEntity;
        private var _lastActedUnitTargets:Vector.<Tile>;
        private var _globalMousePosition:Point = new Point();
		private var _monsterTileBlinkAnimation:Number = 0;

		private var _enemyAi:MonstroEnemyAI;
		private var _monsterUnits:Vector.<MonstroEntity>;
		private var _hostileUnits:Vector.<MonstroEntity>;

        public function MonstroPlayerDragAndDropControls() {
			_enemyAi = injectCreate(MonstroEnemyAI);

            Eventer.listen(MonstroEventTurnProcessHasChanged.NAME, cleanupDisplay, this);
            Eventer.listen(MonstroEventMissionFinished.NAME, cleanupDisplay, this);
        }

		public function dispose():void {
			Eventer.releaseContext(this);

			unmarkTiles();

			field = null;
			fieldRenderer = null;

			_draggedUnit = null;
			_currentlyHoveredTile = null;
			_currentlyMarkedEntity = null;

			_lastActedUnit = null;
			_lastActedUnitTargets = null;
			_globalMousePosition = null;

			if (_draggedUnitGraphic) {
				fieldRenderer.removeGhost(_draggedUnitGraphic);
				_draggedUnitGraphic = null;
			}
		}

        public function update():void {
			_monsterTileBlinkAnimation += 0.05;

            _globalMousePosition.x = SmartTouch.hoverX;
            _globalMousePosition.y = SmartTouch.hoverY;
            fieldRenderer.globalToLocal(_globalMousePosition);

            var x:int = _globalMousePosition.x / MonstroConsts.tileWidth | 0;
            var y:int = _globalMousePosition.y / MonstroConsts.tileHeight | 0;

            var tile:Tile = field.getTileAt(x, y);

            updateSub(tile);
			updateTilesWithTargets();
        }

        private function cleanupDisplay():void {
            _currentlyHoveredTile = null;
            _currentlyMarkedEntity = null;
            unmarkTiles();
            MonstroCursorManager.resetCursor();
        }

        private function updateSub(hoveredTile:Tile):void {
			if (_enemyAi.isRunning){
				_enemyAi.update();
			}

			if (hoveredTile && hoveredTile.entity === _enemyAi.unit && _enemyAi.isFinished){
				var targetTile:Tile = _enemyAi.getTargetTile();
				var bestTarget:MonstroEntity = _enemyAi.getBestAttackableUnit(targetTile, _enemyAi.unit);
				_tilesAttackableEntities = new <Tile>[];
				if (targetTile){
					_tilesAttackableEntities.push(targetTile);
				}
				if (bestTarget){
					_tilesAttackableEntities.push(bestTarget.tile);
				}
				markTiles();
			}


            if (_isDraggingUnit) {
                updateSubDragging(hoveredTile);

            } else if (isInDoubleClickSequence()) {
                updateSubDoubleClick(hoveredTile);

            } else {
                updateSubNoAction(hoveredTile);
            }

            _wasMouseDownLastStep = SmartTouch.isSingleTouchDown;
        }

        private function updateSubDragging(hoveredTile:Tile):void {
            _draggedUnitGraphic.x = _globalMousePosition.x + _draggedUnitOffsetX;
            _draggedUnitGraphic.y = _globalMousePosition.y + _draggedUnitOffsetY;

            var lastHoveredTile:Tile = _currentlyHoveredTile;
            _currentlyHoveredTile = hoveredTile;

            if (isDragEnding()) {
                RetrocamelEventsQueue.add(MonstroConsts.EVENT_UNIT_RELEASED, _currentlyHoveredTile);
                new MonstroEventDisplayAttackStats(false);
				new MonstroEventDisplayUnitStats(_draggedUnit);
                endDrag(hoveredTile);

            } else if (hoveredTile != lastHoveredTile) {
                new MonstroEventDisplayAttackStats(false);
				new MonstroEventDisplayUnitStats(_draggedUnit);

                remarkTile(lastHoveredTile);

                _draggedUnitGraphic.visible = true;

                if (_currentlyHoveredTile) {
                    if (_tilesMovable && _tilesMovable.indexOf(hoveredTile) !== -1) {
                        fieldRenderer.markTile(hoveredTile, MonstroConsts.MARK_TYPE_MOVE_TARGET);
                        MonstroCursorManager.setCursorToDragging();

                    } else if (_tilesAttackableNow && _tilesAttackableNow.indexOf(hoveredTile) !== -1) {
                        _draggedUnitGraphic.visible = false;
                        MonstroCursorManager.setCursorToAttack();

                    } else if (isOverEnemyUnit(hoveredTile)) {
                        MonstroCursorManager.setCursorToAttackBlocked();

                    } else if (hoveredTile && !hoveredTile.entity) {
                        MonstroCursorManager.setCursorToDraggingBlocked();

                    } else {
                        MonstroCursorManager.setCursorToDraggingBlocked();
                    }
                }

                if (isOverEnemyUnit(hoveredTile)) {
                    showAttackStats(_draggedUnit, hoveredTile.entity);
                }
            }
        }

        private function showAttackStats(attacker:MonstroEntity, target:MonstroEntity):void {
			if (attacker && target){
            	new MonstroEventDisplayAttackStats(true, false, attacker, target);
			}
        }

        private static function isOverPlayerUnit(hoveredTile:Tile):Boolean {
            return hoveredTile && hoveredTile.entity && hoveredTile.entity.controlledBy.isPlayer();
        }

        private static function isOverEnemyUnit(hoveredTile:Tile):Boolean {
            return hoveredTile && hoveredTile.entity && !hoveredTile.entity.controlledBy.isPlayer();
        }

        private function updateSubDoubleClick(hoveredTile:Tile):void {
            if (!_currentlyHoveredTile) {
                updateSubNoAction(hoveredTile);
            }

            if (isDoubleClickSequenceEnding(hoveredTile)) {
                endDoubleClickSequence(hoveredTile);

            } else if (isNewClick() && isOverPlayerUnit(hoveredTile)) {
                RetrocamelEventsQueue.add(MonstroConsts.EVENT_UNIT_DOUBLE_CLICKED);
                RetrocamelEventsQueue.add(MonstroConsts.EVENT_UNIT_STOPPED);

				UndoManager.instance.startNewStep(field);
				UndoManager.instance.addBit(new UndoBitUnit(hoveredTile.entity));
				UndoManager.instance.commitStep();

                hoveredTile.entity.hasMoved = true;

                _lastActedUnit = null;
                _lastActedUnitTargets = null;

                endDoubleClickSequence(hoveredTile);

            } else {
                MonstroCursorManager.setCursorEndUnitTurn();
            }
        }

        private function endDoubleClickSequence(hoveredTile:Tile):void {
            _doubleClickTime = NaN;
            _currentlyHoveredTile = null;
            updateSub(hoveredTile);
        }

        private function isDoubleClickSequenceEnding(hoveredTile:Tile):Boolean {
            return hoveredTile != _currentlyHoveredTile || getTimer() > _doubleClickTime + 500 || UtilsNumber.distance(_globalMousePosition.x,
                    _globalMousePosition.y, _doubleClickX, _doubleClickY) > 20;
        }

        private function updateSubNoAction(hoveredTile:Tile):void {
            var lastHoveredTile:Tile = _currentlyHoveredTile;
            _currentlyHoveredTile = hoveredTile;

            if (!_currentlyHoveredTile) {
                new MonstroEventDisplayUnitStats(null);
                if (_lastActedUnit) {
                    fieldRenderer.getUnitClipForEntity(_lastActedUnit).isUnitBlinking = false;
                }

                unmarkTiles();
                MonstroCursorManager.resetCursor();

            } else if (_currentlyHoveredTile != lastHoveredTile) {
                unmarkTiles();

                new MonstroEventDisplayUnitStats(_currentlyHoveredTile.entity);
                if (_lastActedUnit) {
                    fieldRenderer.getUnitClipForEntity(_lastActedUnit).isUnitBlinking = false;
                }

                if (_currentlyHoveredTile.entity) {
                    resetTilesList(_currentlyHoveredTile.entity);
                    new MonstroEventDisplayUnitStats(_currentlyHoveredTile.entity);

					if (_currentlyHoveredTile.entity.controlledBy.isEnemy()){
						resetUnitsList();
						_enemyAi.friendlyUnits = controllableUnits;
						_enemyAi.hostileUnits = hostileUnits;

						_enemyAi.startForUnit(_currentlyHoveredTile.entity);
					}
                }

                if (canGrabTile(hoveredTile)) {
                    MonstroCursorManager.setCursorToGrab();

                } else if (isSubjectToLastActedUnit(hoveredTile)) {
                    showAttackStats(_lastActedUnit, hoveredTile.entity);
                    MonstroCursorManager.setCursorToAttack();
                    fieldRenderer.getUnitClipForEntity(_lastActedUnit).isUnitBlinking = true;

                } else {
                    new MonstroEventDisplayAttackStats(false);
                    MonstroCursorManager.resetCursor();
                }
            }

            CF::enableCheats{
                if (SmartTouch.isSingleTouchDown && SmartTouch.isCtrlDown && hoveredTile && hoveredTile.entity){
                    hoveredTile.entity.receiveDamage(99);
                }
            }

            if (isNewClick() && isSubjectToLastActedUnit(hoveredTile) && tileContainsAttackableEntity(hoveredTile)) {
                RetrocamelEventsQueue.add(MonstroConsts.EVENT_UNIT_CLICK_TO_ATTACK);
                fieldRenderer.getUnitClipForEntity(_lastActedUnit).isUnitBlinking = false;
                attackUnit(_lastActedUnit, hoveredTile.entity);

            } else if (isDragStarting(hoveredTile)) {
                startDrag(hoveredTile);
            }
        }

        private function isSubjectToLastActedUnit(hoveredTile:Tile):Boolean {
            return _lastActedUnit && !_lastActedUnit.hasMoved && _lastActedUnitTargets.indexOf(hoveredTile) !== -1;
        }

        private function initDoubleClickSequence():void {
            _doubleClickTime = getTimer();
            _doubleClickX = _globalMousePosition.x;
            _doubleClickY = _globalMousePosition.y;
        }

        private function isNewClick():Boolean {
            return _wasMouseDownLastStep == false && SmartTouch.isSingleTouchDown;
        }

        private function startDrag(hoveredTile:Tile):void {
            RetrocamelEventsQueue.add(MonstroConsts.EVENT_UNIT_GRABBED, _currentlyHoveredTile);

            _isDraggingUnit = true;

            _draggedUnit = hoveredTile.entity;
            _draggedUnitGraphic = fieldRenderer.makeUnitGhost(_draggedUnit);
            _draggedUnitOffsetX = _draggedUnitGraphic.x - _globalMousePosition.x;
            _draggedUnitOffsetY = _draggedUnitGraphic.y - _globalMousePosition.y;

            MonstroCursorManager.setCursorToDragging();

            SmartTouch.scrollingEnabled = false;

            initDoubleClickSequence();
        }

        private function endDrag(hoveredTile:Tile):void {
            if (canMoveToTile(hoveredTile)) {
                RetrocamelEventsQueue.add(MonstroConsts.EVENT_UNIT_RELEASED_MOVE, _currentlyHoveredTile);
                moveUnit(hoveredTile);
            } else {
                RetrocamelEventsQueue.add(MonstroConsts.EVENT_UNIT_RELEASED_NO_MOVE, _currentlyHoveredTile);
            }

            _lastActedUnit = _draggedUnit;
            _lastActedUnitTargets = _draggedUnit.getAttackableTilesWithTargets();

            if (canAttackTile(hoveredTile)) {
                RetrocamelEventsQueue.add(MonstroConsts.EVENT_UNIT_RELEASED_ATTACK, _currentlyHoveredTile);
                attackUnit(_draggedUnit, hoveredTile.entity);
            }

			if (hoveredTile){
//				fieldRenderer.markTile(hoveredTile, MonstroConsts.MARK_TYPE_MOVE_TARGET);
			}

            cleanupEndDrag();
//            updateSub(hoveredTile);
        }

        private function canMoveToTile(hoveredTile:Tile):Boolean {
            return hoveredTile != null && hoveredTile.entity == null && hoveredTile.canStandOn(_draggedUnit) && _tilesMovable && _tilesMovable.indexOf(hoveredTile) !== -1;
        }

        private function canAttackTile(hoveredTile:Tile):Boolean {
            return tileContainsAttackableEntity(hoveredTile) &&
                _tilesAttackableNow &&
                _tilesAttackableNow.indexOf(hoveredTile) !== -1;
        }

		private function tileContainsAttackableEntity(hoveredTile:Tile):Boolean{
			return hoveredTile != null &&
				hoveredTile.entity &&
				(hoveredTile.entity.controlledBy.isEnemy() || hoveredTile.entity.unitType.isBreakableTile);
		}

        private function cleanupEndDrag():void {
            new MonstroEventDisplayAttackStats(false);
			new MonstroEventDisplayUnitStats(_draggedUnit);

            fieldRenderer.removeGhost(_draggedUnitGraphic);

            _isDraggingUnit = false;
            _draggedUnit = null;
            _draggedUnitGraphic = null;

            SmartTouch.scrollingEnabled = true;

            _currentlyHoveredTile = null;
        }

        private function moveUnit(hoveredTile:Tile):void {
            RetrocamelEventsQueue.add(MonstroConsts.EVENT_DRAGGED_MOVED_UNIT);

			UndoManager.instance.startNewStep(field);
			UndoManager.instance.addBit(new UndoBitUnit(_draggedUnit));
			if (hoveredTile.floor.trap){
				UndoManager.instance.addBit(new UndoBitTrap(hoveredTile.floor.trap));
			}
			UndoManager.instance.commitStep();

			var startTile:Tile = _draggedUnit.tile;
            var path:Vector.<Tile> = MonstroPathmapper.getPathFromTo(_draggedUnit.x, _draggedUnit.y, hoveredTile.x, hoveredTile.y,
                    _draggedUnit, field);
            var distance:int = MonstroPathmapper.getDistance(_draggedUnit.x, _draggedUnit.y, hoveredTile.x, hoveredTile.y, _draggedUnit,
                    field);

            new MonstroEventUnitMoved(_draggedUnit, path);
            _draggedUnit.move(hoveredTile.x, hoveredTile.y);
            _draggedUnit.onMoved(startTile, hoveredTile, distance);
        }

        private function attackUnit(attacker:MonstroEntity, defender:MonstroEntity):void {
            SmartTouch.isFastforwardTouch = false;

			UndoManager.instance.startNewStep(field);
			UndoManager.instance.addBit(new UndoBitUnit(attacker));
			UndoManager.instance.addBit(new UndoBitUnit(defender));
			UndoManager.instance.commitStep();

            RetrocamelEventsQueue.add(MonstroConsts.EVENT_DRAGGED_ATTACKED_ENEMY);

            new MonstroEventUnitHit(attacker, defender);
            attacker.attackOtherUnit(defender);
            attacker.hasMoved = true;

            _lastActedUnit = null;
            _lastActedUnitTargets = null;

        }

        private function isDragStarting(tile:Tile):Boolean {
            return SmartTouch.isSingleTouchDown && !_isDraggingUnit && !_wasMouseDownLastStep && canGrabTile(tile);
        }

        private function isDragEnding():Boolean {
            return !SmartTouch.isSingleTouchDown && _isDraggingUnit;
        }

        private function remarkTile(tile:Tile):void {
            if (_tilesMovable && _tilesMovable.indexOf(tile) !== -1) {
                fieldRenderer.markTile(tile, MonstroConsts.MARK_TYPE_MOVE);
            }
        }

        private static function canGrabTile(tile:Tile):Boolean {
            return isOverPlayerUnit(tile) && !tile.entity.hasMoved;
        }

        private function isInDoubleClickSequence():Boolean {
            return !isNaN(_doubleClickTime);
        }

        private function resetTilesList(entity:MonstroEntity):void {
            unmarkTiles();

            _currentlyMarkedEntity = entity;

            if (entity && !entity.hasMoved) {
                _tilesAttackableNow = entity.getAttackableTilesWithTargets();
                _tilesMovable = entity.getMovableTiles();
                _tilesPossibleToAttack = entity.getExpandedAttackableTiles(_tilesMovable);
                _tilesAttackableEntities = getTilesWithAttackableEntities(entity, _tilesPossibleToAttack);

                markTiles();
            }
        }

		private function getTilesWithAttackableEntities(currentEntity:MonstroEntity, tiles:Vector.<Tile>):Vector.<Tile>{
			var markedTiles:Vector.<Tile> = new Vector.<Tile>();

			for each(var tile:Tile in tiles){
				if (tile.entity && tile.entity.controlledBy !== currentEntity.controlledBy){
					markedTiles.push(tile);
				}
			}

			return markedTiles;
		}

        private function markTiles():void {
            if (_currentlyMarkedEntity && _currentlyMarkedEntity.controlledBy.isEnemy()) {
                fieldRenderer.markTiles(_tilesPossibleToAttack, MonstroConsts.MARK_TYPE_ATTACKABLE);
                fieldRenderer.markTiles(_tilesMovable, MonstroConsts.MARK_TYPE_MOVE);
            } else {
                fieldRenderer.markTiles(_tilesPossibleToAttack, MonstroConsts.MARK_TYPE_ATTACKABLE);
                fieldRenderer.markTiles(_tilesMovable, MonstroConsts.MARK_TYPE_MOVE);
                fieldRenderer.markTiles(_tilesAttackableNow, MonstroConsts.MARK_TYPE_ATTACK_TARGET);
            }

			if (_currentlyMarkedEntity){
				_tilesHoveredUnit = new <Tile>[_currentlyMarkedEntity.tile];
            	fieldRenderer.markTile(_currentlyMarkedEntity.tile, MonstroConsts.MARK_TYPE_MOVE_TARGET);
			}

			updateTilesWithTargets();
        }

		private function updateTilesWithTargets():void{
			if (_tilesAttackableEntities){
				fieldRenderer.markTiles(_tilesAttackableEntities, MonstroConsts.MARK_TYPE_ATTACK_TARGET);
			}
		}

        private function unmarkTiles():void {
            if (_tilesMovable) {
                fieldRenderer.markTiles(_tilesMovable, MonstroConsts.MARK_TYPE_RESET);
                _tilesMovable = null;
            }

            if (_tilesPossibleToAttack) {
                fieldRenderer.markTiles(_tilesPossibleToAttack, MonstroConsts.MARK_TYPE_RESET);
                _tilesPossibleToAttack = null;
            }

            if (_tilesAttackableNow) {
                fieldRenderer.markTiles(_tilesAttackableNow, MonstroConsts.MARK_TYPE_RESET);
                _tilesAttackableNow = null;
            }

            if (_tilesAttackableEntities) {
                fieldRenderer.markTiles(_tilesAttackableEntities, MonstroConsts.MARK_TYPE_RESET);
				_tilesAttackableEntities = null;
            }

            if (_tilesHoveredUnit) {
                fieldRenderer.markTiles(_tilesHoveredUnit, MonstroConsts.MARK_TYPE_RESET);
				_tilesHoveredUnit = null;
            }

            _isDraggingUnit = false;
        }

		private function get controllableUnits():Vector.<MonstroEntity> {
			return _monsterUnits;
		}

		private function get hostileUnits():Vector.<MonstroEntity> {
			return _hostileUnits;
		}

		private function resetUnitsList():void {
			_monsterUnits = new Vector.<MonstroEntity>();
			_hostileUnits = new Vector.<MonstroEntity>();

			var entities:Vector.<MonstroEntity> = field.getAllEntities();
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

	}
}
