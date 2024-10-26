package net.retrocade.tacticengine.monstro.floors{
    import flash.geom.Point;

    import net.retrocade.tacticengine.core.Entity;

    import net.retrocade.tacticengine.core.Field;
    import net.retrocade.tacticengine.core.Floor;
    import net.retrocade.tacticengine.monstro.core.Monstro;

    public class MonstroTileFloor extends Floor{
        public var isObstacle:Boolean = false;
        public var isWall:Boolean = false;
        public var isFloor:Boolean = false;
        public var tx:int;
        public var ty:int;

        public var layers:Vector.<Point>;

        public function MonstroTileFloor(field:Field){
            super(field);

            layers = new Vector.<Point>();
        }

        public function addLayerItem(tx:int, ty:int):void{
            layers.push(new Point(tx, ty));
        }

        public function addLayerItemIndex(index:int):void{
            layers.push(new Point(index % 23, index / 23 | 0));
        }
        override public function canMoveTo(dx:int, dy:int, entity:Entity):Boolean{
            return !isObstacle;
        }
    }
}