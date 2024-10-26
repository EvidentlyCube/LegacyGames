package net.retrocade.tacticengine.monstro.ais.player{
    import net.retrocade.tacticengine.core.Eventer;
    import net.retrocade.tacticengine.core.Field;
	import net.retrocade.tacticengine.core.Tile;
    import net.retrocade.tacticengine.monstro.actions.MonstroUnitStepData;
    import net.retrocade.tacticengine.monstro.core.Monstro;
    import net.retrocade.tacticengine.monstro.core.MonstroSfx;
    import net.retrocade.tacticengine.monstro.entities.MonstroEntity;
    import net.retrocade.tacticengine.monstro.entities.MonstroEntityFactory;
    import net.retrocade.tacticengine.monstro.events.MonstroEventDisplayAttackStats;
    import net.retrocade.tacticengine.monstro.events.MonstroEventStopUnit;
    import net.retrocade.tacticengine.monstro.events.MonstroEventTransition;
    import net.retrocade.tacticengine.monstro.events.MonstroEventUndo;
    import net.retrocade.tacticengine.monstro.events.MonstroEventUnitHit;
	import net.retrocade.tacticengine.monstro.events.MonstroEventUnitMoved;
    import net.retrocade.tacticengine.monstro.events.MonstroEventDisplayUnitStats;
    import net.retrocade.tacticengine.monstro.events.MonstroEventUnitSelected;
    import net.retrocade.tacticengine.monstro.render.MonstroFieldRenderer;
    import net.retrocade.tacticengine.monstro.undo.UndoBitUnit;
    import net.retrocade.tacticengine.monstro.undo.UndoManager;
    import net.retrocade.tacticengine.monstro.utils.MonstroPathmapper;

	public class MonstroPlayerThreadPlayerUnit implements IMonsroPlayerTurnProcessThread{
		private var _unit:MonstroEntity;
		private var _field:Field;
		private var _renderer:MonstroFieldRenderer;
		
		private var _approachableTiles:Vector.<Tile>;
        private var _potentiallyAttackableTiles:Vector.<Tile>;
        private var _attackableTiles  :Vector.<Tile>;
        
        private var _markedTile:Tile;

        private var _startingUnitX:int = -1;
        private var _startingUnitY:int = -1;

        private var _isFinished:Boolean = false;
		
		public function set field(value:Field):void{
			_field = value;
		}
		
		public function set fieldRenderer(value:MonstroFieldRenderer):void{
			_renderer = value;
		}

        public function MonstroPlayerThreadPlayerUnit(){
            UndoManager.instance.startNewStep();

            Eventer.listen(MonstroEventStopUnit.NAME, onEndUnitMove);
        }

        public function update():Boolean{
            return _isFinished;
        }

		public function click(tileX:int, tileY:int):Boolean{
			var tile:Tile = _field.getTileAt(tileX, tileY);

            if (!tile){
                return true;
            }

            if (!_unit){
                _unit = tile.entity as MonstroEntity;

                new MonstroEventDisplayUnitStats(_unit);
                new MonstroEventUnitSelected(_unit);

                switch(_unit.name){
                    case(MonstroEntityFactory.NAME_BEETHRO): MonstroSfx.playBeethroStart(); break;
                    case(MonstroEntityFactory.NAME_CITIZEN): MonstroSfx.playCitizenStart(); break;
                    case(MonstroEntityFactory.NAME_STALWART): MonstroSfx.playStalwartStart(); break;
                }

                _startingUnitX = _unit.x;
                _startingUnitY = _unit.y;

                fetchAndMarkTiles();

                return false;

            } else if (!tile.entity){
                return clickForMove(tile);

            } else {
                return clickForAttack(tile);
            }

		}

		private function clickForMove(tile:Tile):Boolean{
			if (_approachableTiles.indexOf(tile) === -1){
				return true;
			}

            if (Monstro.singleClickActions){
                _markedTile = tile;
            }

            if (_markedTile == tile){
                var path:Vector.<MonstroUnitStepData> = MonstroPathmapper.getPathFromTo(_unit.x, _unit.y, tile.x, tile.y, _unit, _field);
                var distance:int = MonstroPathmapper.getDistance(_unit.x, _unit.y, tile.x, tile.y, _unit, _field);

                UndoManager.instance.addBit(new UndoBitUnit(_unit));

                if (_unit.move(tile.x, tile.y) || tile.entity == _unit){
                    new MonstroEventUnitMoved(_unit, path, onMovementFinished);

                    _unit.movesLeft -= distance;

                    clearTiles();
                }

                _markedTile = null;
            } else {
                if (_markedTile){
                    _renderer.markTile(_markedTile, Monstro.MARK_MOVABLE);
                    _markedTile = null;
                }

                _markedTile = tile;
                _renderer.markTile(tile, Monstro.MARK_MOVE_TO);
            }

            return false;
		}

        private function clickForAttack(tile:Tile):Boolean{
            if (_attackableTiles.indexOf(tile) === -1 || !tile.entity){
                return true;
            }

            if (Monstro.singleClickActions){
                _markedTile = tile;
            }

            var targetUnit:MonstroEntity = tile.entity as MonstroEntity;
            if (_markedTile == tile){
                if (targetUnit !== _unit){
                    new MonstroEventUnitHit(_unit, targetUnit, onAttackFinished);
                    _unit.attackOtherUnit(targetUnit);
                }

                _markedTile = null;
                _unit.hasMoved = true;

                clearTiles();

                new MonstroEventDisplayAttackStats(false);
                return false;

            } else {
                if (_markedTile){
                    _renderer.markTile(_markedTile, Monstro.MARK_ATTACKABLE);
                }

                _markedTile = tile;
                _renderer.markTile(tile, Monstro.MARK_ATTACK_AT);

                if (_markedTile.entity != _unit){
                    new MonstroEventDisplayAttackStats(
                            true,
                            false,
                            _unit,
                            _markedTile.entity as MonstroEntity
                    );
                } else {
                    new MonstroEventDisplayAttackStats(false);
                }
            }
            
            return false;
        }

        private function fetchAndMarkTiles():void{
            _approachableTiles = _unit.getMovableTiles();
            _attackableTiles = _unit.getAttackableTiles();
            _potentiallyAttackableTiles = _unit.getExpandedAttackableTiles(_approachableTiles);

            _renderer.markTiles(_potentiallyAttackableTiles, Monstro.MARK_ATTACKABLE_WEAK);
            _renderer.markTiles(_attackableTiles, Monstro.MARK_ATTACKABLE);
            _renderer.markTiles(_approachableTiles, Monstro.MARK_MOVABLE);
        }
        
        private function onMovementFinished():void{
            fetchAndMarkTiles();
        }

        private function onAttackFinished():void{
            _isFinished = true;
        }

        private function clearTiles():void{
            if (_approachableTiles){
                _renderer.markTiles(_approachableTiles, Monstro.MARK_RESET);
            }

            if (_potentiallyAttackableTiles){
                _renderer.markTiles(_potentiallyAttackableTiles, Monstro.MARK_RESET);
            }

            if (_attackableTiles){
                _renderer.markTiles(_attackableTiles, Monstro.MARK_RESET);
            }
        }

        private function onEndUnitMove():void{
            if (_unit){
                UndoManager.instance.addBit(new UndoBitUnit(_unit));
                _unit.hasMoved = true;
                _isFinished = true;
            }
        }

		public function destruct():void{
            UndoManager.instance.commitStep();

            new MonstroEventDisplayUnitStats(null);
            new MonstroEventUnitSelected(null);

            clearTiles();

            _approachableTiles = null;
            _potentiallyAttackableTiles = null;
            _attackableTiles = null;

			_unit = null;
			_field = null;
			_renderer = null;
		}
	}
}