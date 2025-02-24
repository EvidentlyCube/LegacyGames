
package net.retrocade.tacticengine.monstro.ingame.undo {
	import net.retrocade.tacticengine.core.MonstroField;
	import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventUndidTrap;
	import net.retrocade.tacticengine.monstro.ingame.traps.IMonstroTrap;

	public class UndoBitTrap implements IUndoBit {
		private var _x:uint;
		private var _y:uint;
		private var _isEnabled:Boolean;

		public function UndoBitTrap(trap:IMonstroTrap) {
			if (trap){
				_x = trap.x;
				_y = trap.y;
				_isEnabled = trap.isEnabled;
			}
		}

		public function undo(field:MonstroField):void {
			field.getTileAt(_x, _y).floor.trap.isEnabled = _isEnabled;

			new MonstroEventUndidTrap(field.getTileAt(_x, _y).floor.trap);
		}

		public function dispose():void {}

		public function makeDump():Object{
			return {
				"type": UndoStep.UNDO_BIT_TRAP,
				x: _x,
				y: _y,
				isEnabled: _isEnabled
			}
		}

		public function loadFromDump(dump:Object):void{
			_x = dump.x;
			_y = dump.y;
			_isEnabled = dump.isEnabled;
		}
	}
}
