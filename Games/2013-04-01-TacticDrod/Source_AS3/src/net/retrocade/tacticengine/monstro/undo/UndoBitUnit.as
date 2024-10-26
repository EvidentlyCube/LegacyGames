/**
 * Created with IntelliJ IDEA.
 * User: Ryc
 * Date: 06.04.13
 * Time: 19:12
 * To change this template use File | Settings | File Templates.
 */
package net.retrocade.tacticengine.monstro.undo {
    import net.retrocade.tacticengine.core.Tile;
    import net.retrocade.tacticengine.monstro.entities.MonstroEntity;

    public class UndoBitUnit implements IUndoBit{
        private var _unit:MonstroEntity;

        private var _x:int;
        private var _y:int;
        private var _hp:int;
        private var _hasMoved:Boolean;

        private var _movesLeft:int;

        public function UndoBitUnit(unit:MonstroEntity){
            _unit = unit;

            _x = _unit.x;
            _y = _unit.y;
            _hp = _unit.hp;
            _hasMoved = _unit.hasMoved;
            _movesLeft = _unit.movesLeft;
        }

        public function undo():void {
            CF::debug{ASSERT(_unit.field);}

            var targetTile:Tile = _unit.field.getTileAt(_x, _y);

            CF::debug{ASSERT(targetTile);}
            CF::debug{ASSERT(!targetTile.entity || targetTile.entity == _unit);}

            _unit.tile = targetTile;
            _unit.hp = _hp;
            _unit.hasMoved = _hasMoved;
            _unit.movesLeft = _movesLeft;
        }

        public function destruct():void {
            _unit = null;
        }
    }
}
