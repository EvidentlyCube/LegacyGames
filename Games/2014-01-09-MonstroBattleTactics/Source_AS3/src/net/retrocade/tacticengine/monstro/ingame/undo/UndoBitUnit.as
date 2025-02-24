
package net.retrocade.tacticengine.monstro.ingame.undo {
	import net.retrocade.tacticengine.core.MonstroField;
	import net.retrocade.tacticengine.core.Tile;
    import net.retrocade.tacticengine.monstro.ingame.entities.MonstroEntity;
    import net.retrocade.tacticengine.monstro.ingame.entities.MonstroEntityStatistics;
	import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventUndidUnit;

	public class UndoBitUnit implements IUndoBit{
		private var _id:int;
        private var _x:int;
        private var _y:int;
        private var _hp:int;
        private var _defense:int;
        private var _hasMoved:Boolean;
        private var _damageDealt:int;
        private var _damageReceived:int;
        private var _tilesMoved:int;

        private var _movesLeft:int;

        private var _statusDescriptors:Vector.<Object>;

        public function UndoBitUnit(unit:MonstroEntity){
			if (unit) {
				_id = unit.id;
				_x = unit.x;
				_y = unit.y;
				_hp = unit.getStatistics().hp;
				_defense = unit.getStatistics().defense;
				_hasMoved = unit.hasMoved;
				_movesLeft = unit.getStatistics().movesLeft;
				_statusDescriptors = unit.statusGenerateDescriptors();
				_damageDealt = unit.damageDealt;
				_damageReceived = unit.damageReceived;
				_tilesMoved = unit.tilesMoved;
			}
        }

        public function undo(field:MonstroField):void {
			var unit:MonstroEntity = field.getEntityById(_id);
            var targetTile:Tile = field.getTileAt(_x, _y);

            CF::debug{ASSERT(targetTile);}
//            CF::debug{ASSERT(!targetTile.entity || targetTile.entity == unit);}

			if (targetTile.entity && targetTile.entity != unit){
				targetTile.entity.tile = null;
			}


            var statistics:MonstroEntityStatistics = unit.getStatistics();
            statistics.hp = _hp;
            statistics.defense = _defense;
            statistics.movesLeft = _movesLeft;

            unit.tile = targetTile;
            unit.hasMoved = _hasMoved;
            unit.setStatistics(statistics);
            unit.statusLoadFromDescriptors(_statusDescriptors);
            unit.damageDealt = _damageDealt;
			unit.damageReceived = _damageReceived;
			unit.tilesMoved = _tilesMoved;

			new MonstroEventUndidUnit(unit);
        }

        public function dispose():void {
			_statusDescriptors = null;
        }

		public function makeDump():Object{
			var statusDescriptors:Array = [];
			for each(var statusDescriptor:Object in _statusDescriptors){
				statusDescriptors.push(statusDescriptor);
			}

			return {
				"type": UndoStep.UNDO_BIT_UNIT,
				id: _id,
				x: _x,
				y: _y,
				hp: _hp,
				defense: _defense,
				hasMoved: _hasMoved,
				damageDealt: _damageDealt,
				damageReceived: _damageReceived,
				tilesMoved: _tilesMoved,
				movesLeft: _movesLeft,
				"statusDescriptors": statusDescriptors
			}
		}

		public function loadFromDump(dump:Object):void{
			_id = dump.id;
			_x = dump.x;
			_y = dump.y;
			_hp = dump.hp;
			_defense = dump.defense;
			_hasMoved = dump.hasMoved;
			_damageDealt = dump.damageDealt;
			_damageReceived = dump.damageReceived;
			_tilesMoved = dump.tilesMoved;
			_movesLeft = dump.movesLeft;

			_statusDescriptors = new Vector.<Object>();
			for each(var descriptor:Object in dump.statusDescriptors){
				_statusDescriptors.push(descriptor);
			}
		}
    }
}
