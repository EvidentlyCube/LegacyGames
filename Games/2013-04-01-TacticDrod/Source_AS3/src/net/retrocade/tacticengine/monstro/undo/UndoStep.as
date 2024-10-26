/**
 * Created with IntelliJ IDEA.
 * User: Ryc
 * Date: 06.04.13
 * Time: 19:10
 * To change this template use File | Settings | File Templates.
 */
package net.retrocade.tacticengine.monstro.undo {
    import net.retrocade.tacticengine.core.IDestruct;

    public class UndoStep implements IDestruct{
        private var _undoBits:Vector.<IUndoBit>;

        public function UndoStep() {
            _undoBits = new Vector.<IUndoBit>();
        }

        public function addBit(bit:IUndoBit):void{
            _undoBits.push(bit);
        }

        public function undo():void{
            for(var i:int = _undoBits.length - 1; i >= 0; i--){
                _undoBits[i].undo();
            }
        }

        public function destruct():void {
            for each(var bit:IUndoBit in _undoBits){
                bit.destruct();
            }

            _undoBits = null;
        }

        public function get numberOfBits():uint{
            return _undoBits.length;
        }
    }
}
