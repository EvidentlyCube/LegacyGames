
package net.retrocade.tacticengine.monstro.ingame.undo {
    import net.retrocade.tacticengine.core.IDisposable;
	import net.retrocade.tacticengine.core.MonstroField;
	import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventUndidCurrentTurn;

	public class UndoStep implements IDisposable{
		public static const UNDO_BIT_UNIT:String = "undoUnit";
		public static const UNDO_BIT_TRAP:String = "undoTrap";

        private var _undoBits:Vector.<IUndoBit>;
		private var _currentTurn:uint;

        public function UndoStep(currentTurn:uint) {
            _undoBits = new Vector.<IUndoBit>();
			_currentTurn = currentTurn;
        }

        public function addBit(bit:IUndoBit):void{
            _undoBits.push(bit);
        }

        public function undo(field:MonstroField):void{
            for(var i:int = _undoBits.length - 1; i >= 0; i--){
                _undoBits[i].undo(field);
            }

			new MonstroEventUndidCurrentTurn(_currentTurn);
        }

        public function dispose():void {
            for each(var bit:IUndoBit in _undoBits){
                bit.dispose();
            }

            _undoBits = null;
        }

        public function get numberOfBits():uint{
            return _undoBits.length;
        }

		public function makeDump():Object{
			var bits:Array = [];
			for each(var bit:IUndoBit in _undoBits){
				bits.push(bit.makeDump());
			}

			return {
				bits: bits,
				currentTurn: _currentTurn
			};
		}

		public function loadFromDump(dump:Object):void{
			_currentTurn = dump.currentTurn;
			for each(var bitDump:Object in dump.bits){
				var bit:IUndoBit;
				if (bitDump.type === UNDO_BIT_TRAP){
					bit = new UndoBitTrap(null);
				} else if (bitDump.type === UNDO_BIT_UNIT){
					bit = new UndoBitUnit(null);
				}

				bit.loadFromDump(bitDump);
				_undoBits.push(bit);
			}
		}

		public function get currentTurn():uint {
			return _currentTurn;
		}
	}
}
