/**
 * Created with IntelliJ IDEA.
 * User: Ryc
 * Date: 28.03.13
 * Time: 19:40
 * To change this template use File | Settings | File Templates.
 */
package net.retrocade.tacticengine.monstro.actions {
    import net.retrocade.tacticengine.core.Tile;
    import net.retrocade.tacticengine.monstro.core.MonstroConst;

    public class MonstroUnitStepData {
        public var toX:int;
        public var toY:int;
        public var direction:int;

        public function MonstroUnitStepData(toX:int, toY:int, direction:int){
            this.toX = toX;
            this.toY = toY;
            this.direction = direction;
        }

        public static function fromTile(tile:Tile):MonstroUnitStepData{
            return new MonstroUnitStepData(tile.x, tile.y, MonstroConst.NO_ORIENTATION);
        }

        public static function fromTileAsVector(tile:Tile):Vector.<MonstroUnitStepData>{
            return new <MonstroUnitStepData>[new MonstroUnitStepData(tile.x, tile.y, MonstroConst.NO_ORIENTATION)];
        }


    }
}
