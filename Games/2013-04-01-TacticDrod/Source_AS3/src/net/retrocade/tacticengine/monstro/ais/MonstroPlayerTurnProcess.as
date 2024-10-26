package net.retrocade.tacticengine.monstro.ais{
    import flash.geom.Point;

    import net.retrocade.tacticengine.core.Entity;
    import net.retrocade.tacticengine.core.Eventer;

    import net.retrocade.tacticengine.core.Field;
    import net.retrocade.tacticengine.core.Tile;
    import net.retrocade.tacticengine.monstro.ais.player.MonstroPlayerThreadFactory;
    import net.retrocade.tacticengine.monstro.ais.player.IMonsroPlayerTurnProcessThread;
    import net.retrocade.tacticengine.monstro.ais.player.MonstroPlayerThreadPlayerUnit;
    import net.retrocade.tacticengine.monstro.core.Monstro;
    import net.retrocade.tacticengine.monstro.entities.MonstroEntity;
    import net.retrocade.tacticengine.monstro.events.MonstroEventEndTurn;
    import net.retrocade.tacticengine.monstro.events.MonstroEventMissionFinished;
    import net.retrocade.tacticengine.monstro.events.MonstroEventTap;
    import net.retrocade.tacticengine.monstro.events.MonstroEventUndo;
    import net.retrocade.tacticengine.monstro.events.MonstroEventUnitKilled;
    import net.retrocade.tacticengine.monstro.render.MonstroFieldRenderer;
    import net.retrocade.tacticengine.monstro.undo.UndoBitUnit;
    import net.retrocade.tacticengine.monstro.undo.UndoManager;

    public class MonstroPlayerTurnProcess implements IMonstroTurnProcess{
        private var _fieldRenderer:MonstroFieldRenderer;
        private var _field:Field;
		
		private var _currentThread:IMonsroPlayerTurnProcessThread;
		private var _enabled:Boolean = true;

        private var _units:Vector.<MonstroEntity>;

        private var _isTurnFinished:Boolean = false;
        
        public function MonstroPlayerTurnProcess(field:Field, fieldRenderer:MonstroFieldRenderer){
            _field = field;
            _fieldRenderer = fieldRenderer;

            Eventer.listen(MonstroEventTap.NAME, onTap);
            Eventer.listen(MonstroEventUnitKilled.NAME, resetUnitsList);
            Eventer.listen(MonstroEventUndo.NAME, onUndo);

            resetUnitsList();
        }

        public function start():void{
            Eventer.listen(MonstroEventEndTurn.NAME, onEndTurn);
            _isTurnFinished = false;

            for each(var unit:MonstroEntity in _units){
                unit.movesLeft = unit.movesMax;
            }

            UndoManager.instance.clear();
        }

        public function stop():void{
            if (_currentThread){
                _currentThread.destruct();
            }

            _currentThread = null;

            Eventer.release(MonstroEventEndTurn.NAME, onEndTurn);

            enabled = false;
            for each(var unit:MonstroEntity in _units){
                unit.hasMoved = false;
            }
        }

		public function update():Boolean{
            while (_currentThread && _currentThread.update()){
                _currentThread.destruct();
                _currentThread = null;
            }

			return _isTurnFinished;
		}
		
		public function set enabled(value:Boolean):void{
			_enabled = value;
		}
		
		public function get enabled():Boolean{
			return _enabled;
		}

        private function onEndTurn():void{
            UndoManager.instance.startNewStep();
            for each(var unit:MonstroEntity in _units){
                if (!unit.hasMoved){
                    unit.hasMoved = true;
                    UndoManager.instance.addBit(new UndoBitUnit(unit));
                }
            }

            _isTurnFinished = true;
        }

        private function resetUnitsList():void{
            _units = new Vector.<MonstroEntity>();

            var entities:Vector.<Entity> = _field.getAllEntities();
            for each(var entity:Entity in entities){
                if (entity.get(Monstro.PROP_isPlayerControlled)){
                    _units.push(entity as MonstroEntity);
                }
            }
        }

        private function onTap(e:MonstroEventTap):void{
            if (!enabled){
                return;
            }

            var newPosition:Point = _fieldRenderer.layerFloor.layer.globalToLocal(new Point(e.x, e.y));

            var tileX:int = newPosition.x / Monstro.tileWidth;
            var tileY:int = newPosition.y / Monstro.tileHeight;

            onClick(tileX, tileY);
        }

        public function onUndo():void{
            if (_currentThread){
                _currentThread.destruct();
                _currentThread = null;
            }
        }
        
        private function onClick(tileX:int, tileY:int):void{
			if (!_currentThread){
				_currentThread = getThread(_field.getTileAt(tileX, tileY));
			}

            var stop:Boolean = false;
            while (_currentThread && _currentThread.click(tileX, tileY)){
				_currentThread.destruct();
				_currentThread = null;

                if (stop){
                    break;
                }

                _currentThread = getThread(_field.getTileAt(tileX, tileY));
                stop = true;
			}
        }

        private function getThread(tile:Tile):IMonsroPlayerTurnProcessThread{
            var thread:IMonsroPlayerTurnProcessThread = MonstroPlayerThreadFactory.createAction(tile);

            if (thread){
                thread.field = _field;
                thread.fieldRenderer = _fieldRenderer;
            }

            return thread;
        }
		
		public function destruct():void{
			if (_currentThread){
                _currentThread.destruct();
            }

            _currentThread = null;

            Eventer.release(MonstroEventTap.NAME, onTap);
            Eventer.release(MonstroEventUnitKilled.NAME, resetUnitsList);
            Eventer.release(MonstroEventUndo.NAME, onUndo);

            _field = null;
            _fieldRenderer = null;
		}

        public function get controllableUnits():Vector.<MonstroEntity>{
            return _units;
        }

        public function canStopUnitTurn():Boolean{
            return _currentThread && _currentThread is MonstroPlayerThreadPlayerUnit;
        }
    }
}