package net.retrocade.tacticengine.monstro.entities{
    import net.retrocade.tacticengine.core.Entity;
    import net.retrocade.tacticengine.core.Eventer;
    import net.retrocade.tacticengine.core.Field;
    import net.retrocade.tacticengine.core.Tile;
    import net.retrocade.tacticengine.monstro.core.Monstro;
    import net.retrocade.tacticengine.monstro.core.MonstroData;
    import net.retrocade.tacticengine.monstro.data.MonstroAttackSimulation;
    import net.retrocade.tacticengine.monstro.entities.MonstroEntityFactory;
    import net.retrocade.tacticengine.monstro.events.MonstroEventUnitDisable;
    import net.retrocade.tacticengine.monstro.events.MonstroEventUnitEnable;
    import net.retrocade.tacticengine.monstro.events.MonstroEventUnitKilled;
    import net.retrocade.tacticengine.monstro.floors.MonstroTileFloor;
    import net.retrocade.tacticengine.monstro.undo.UndoBitUnit;
    import net.retrocade.tacticengine.monstro.undo.UndoManager;
    import net.retrocade.tacticengine.monstro.utils.MonstroPathmapper;
    import net.retrocade.utils.UNumber;

    public class MonstroEntity extends Entity{
        private var _hasMoved:Boolean = false;

        public var isPlayer:Boolean;

        public var movesLeft:int;
        public var movesMax:int;

        public var hp:int;
        public var attack:int;
        public var movementOrder:int;

        public var name:String;
        public var prettyName:String;

		public function MonstroEntity(field:Field){
			super(field);
		}

        public function getMovableTiles():Vector.<Tile>{
            return MonstroPathmapper.getMovableTiles(x, y, this, field);
        }

        public function getExpandedAttackableTiles(tiles:Vector.<Tile>):Vector.<Tile>{
            var vector:Vector.<Tile> =  MonstroPathmapper.getExpandedTilesInDistance(tiles, 0, getAttackDistance(), field);

            vector = vector.filter(function(tile:Tile, index:int, vector:Vector.<Tile>):Boolean{
                return (!tile.entity || tile.entity.get(Monstro.PROP_isPlayerControlled) != isPlayer)
                        && !MonstroTileFloor(tile.floor).isObstacle;
            });

            return vector;
        }

        public function getAttackDistance():int{
            return 1;
        }

        public function isHuman():Boolean{
            return (name == MonstroEntityFactory.NAME_BEETHRO ||
                    name == MonstroEntityFactory.NAME_CITIZEN ||
                    name == MonstroEntityFactory.NAME_STALWART);
        }

        public function getAttackableTiles():Vector.<Tile>{
            var vector:Vector.<Tile> = MonstroPathmapper.getTilesInDistance(x, y, 0, getAttackDistance(), field);

            vector = vector.filter(function(tile:Tile, index:int, vector:Vector.<Tile>):Boolean{
                return (tile.entity && tile.entity.get(Monstro.PROP_isPlayerControlled) != isPlayer);
            });

            return vector;
        }

        public function attackOtherUnit(attacked:MonstroEntity):void{
            attacked.receiveDamage(attack);
        }

        public function receiveDamage(attack:int):void{
            UndoManager.instance.addBit(new UndoBitUnit(this));

            hp = Math.max(0, hp - attack);

            if (hp == 0){
                if (isPlayer){
                    MonstroData.lostUnits.add(1);
                }

                killUnit();
            }
        }

        public function killUnit():void{
            tile = null;
            new MonstroEventUnitKilled(this);
        }

        public function get hasMoved():Boolean {
            return _hasMoved;
        }

        public function set hasMoved(value:Boolean):void {
            if (value != _hasMoved){
                _hasMoved = value;
                if (value == true){
                    new MonstroEventUnitDisable(this);
                } else {
                    new MonstroEventUnitEnable(this);
                }
            }
        }

        public function canReach(tile:Tile):Boolean{
            return MonstroPathmapper.getDistance(x, y, tile.x, tile.y, this, field) <= movesLeft && tile.canStandOn(this);
        }

        public function canAttack(entity:MonstroEntity):Boolean{
            return UNumber.distanceGrid(x, y, entity.x, entity.y) <= getAttackDistance();
        }

        override public function canMoveTo(dx:int, dy:int, entity:Entity):Boolean{
            return false;
        }
    }
}