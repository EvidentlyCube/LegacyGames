package net.retrocade.tacticengine.monstro.ingame.floors{
    import flash.geom.Point;

    import net.retrocade.tacticengine.core.MonstroField;
    import net.retrocade.tacticengine.core.Floor;
    import net.retrocade.tacticengine.monstro.ingame.entities.MonstroEntity;
    import net.retrocade.tacticengine.monstro.ingame.traps.IMonstroTrap;

    public class MonstroTileFloor extends Floor{
        public var isObstacle:Boolean = false;
        public var isWater:Boolean = false;

        public var isGrass:Boolean = false;
        public var isGround:Boolean = false;
        public var isSidewalk:Boolean = false;

        public var layers:Vector.<Point>;
        private var _trap:IMonstroTrap;

        public function MonstroTileFloor(field:MonstroField){
            super(field);

            layers = new Vector.<Point>();
		}

        public function activateTraps(unit:MonstroEntity):void{
			if (_trap){
				_trap.unitStands(unit);
			}
        }

		public function set trap(value:IMonstroTrap):void {
			_trap = value;
		}

		public function get trap():IMonstroTrap{
			return _trap;
		}

        public function addLayerItem(tx:int, ty:int):void{
            layers.push(new Point(tx, ty));
        }

        public function addLayerItemGrid(tx:int, ty:int):void{
            layers.push(new Point(tx * 32, ty * 32));
        }

        override public function canMoveTo(dx:int, dy:int, entity:MonstroEntity):Boolean{
            return (entity && isWater && !isObstacle && entity.canFly) || (!isWater && !isObstacle);
        }

        override public function canStandOn(entity:MonstroEntity):Boolean{
            return (entity && isWater && !isObstacle && entity.canFly) || (!isWater && !isObstacle);
        }


        override public function dispose():void{
            layers = null;
			if (_trap){
				_trap.dispose();
			}
			_trap = null;

            super.dispose();
        }
    }
}