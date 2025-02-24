
package net.retrocade.tacticengine.monstro.ingame.entities {
    import net.retrocade.tacticengine.core.MonstroField;
    import net.retrocade.tacticengine.core.FieldObject;
    import net.retrocade.tacticengine.core.Tile;
    import net.retrocade.tacticengine.monstro.global.enum.EnumUnitController;
    import net.retrocade.tacticengine.monstro.ingame.floors.MonstroTileFloor;
    import net.retrocade.tacticengine.monstro.ingame.utils.MonstroPathmapper;
    import net.retrocade.utils.UtilsNumber;

    public class MonstroEntityWithAiControl extends MonstroEntityWithStatistics {
        public var controlledBy:EnumUnitController;
        public var attackable:Boolean = true;
        public var hasToBeKilled:Boolean = true;
        public var scoreMultiplier:Number = 1.0;

        public function MonstroEntityWithAiControl(stats:MonstroEntityStatistics, field:MonstroField) {
            super(stats, field);
        }

        override public function canMoveTo(dx:int, dy:int, entity:MonstroEntity):Boolean {
            return entity && (entity.controlledBy === controlledBy || entity == this);
        }

        override public function makeDump():Object {
            var dump:Object = super.makeDump();
            dump.controlledBy = controlledBy.name;
            dump.attackable = attackable;
            dump.hasToBeKilled = hasToBeKilled;
            dump.scoreMultiplier = scoreMultiplier;

            return dump;
        }

        override public function loadFromDump(dump:Object):void {
            super.loadFromDump(dump);

            controlledBy = EnumUnitController.byName(dump.controlledBy);
            attackable = dump.attackable;
            hasToBeKilled = dump.hasToBeKilled;
            scoreMultiplier = dump.scoreMultiplier;
        }

        public function getMovableTiles():Vector.<Tile> {
            return MonstroPathmapper.getMovableTiles(x, y, statistics.movesLeft, this as MonstroEntity, field);
        }

        public function getExpandedAttackableTiles(tiles:Vector.<Tile>):Vector.<Tile> {
            var vector:Vector.<Tile> = MonstroPathmapper.getExpandedTilesInDistance(
                    tiles,
                    statistics.attackRangeMin,
                    statistics.attackRangeMax,
                    field
            );

            vector = vector.filter(function (tile:Tile, index:int, vector:Vector.<Tile>):Boolean {
                return (!tile.entity || (tile.entity.controlledBy !== controlledBy && tile.entity.attackable))
                        && !MonstroTileFloor(tile.floor).isObstacle;
            });

            return vector;
        }

        public function getAttackableTilesWithTargets():Vector.<Tile> {
            var vector:Vector.<Tile> = getAttackableTilesFrom(x, y);

            vector = vector.filter(function (tile:Tile, index:int, vector:Vector.<Tile>):Boolean {
                return (tile.entity && tile.entity.controlledBy !== controlledBy && tile.entity.attackable);
            });

            return vector;
        }

        public function getAttackableTilesFrom(x:int, y:int):Vector.<Tile> {
            return MonstroPathmapper.getTilesInDistance(
                    x,
                    y,
                    getAttackDistanceMin(),
                    getAttackDistanceMax(),
                    field
            );
        }

        public function canAttack(unit:MonstroEntity):Boolean {
            var gridDistance:int = UtilsNumber.distanceManhattan(x, y, unit.x, unit.y);

            return gridDistance >= getAttackDistanceMin() && gridDistance <= getAttackDistanceMax();
        }

        public function canAttackFromTile(tile:Tile, unit:MonstroEntity):Boolean {
            var gridDistance:int = UtilsNumber.distanceManhattan(tile.x, tile.y, unit.x, unit.y);

            return gridDistance >= getAttackDistanceMin() && gridDistance <= getAttackDistanceMax();
        }

        public function canReachToAttack(target:FieldObject):Boolean {
            var gridDistance:int = UtilsNumber.distanceManhattan(x, y, target.x, target.y);
            var maxAttackDistance:int = statistics.movesMax + statistics.attackRangeMax;

            if (maxAttackDistance < gridDistance) {
                return false;
            }

            if (gridDistance >= getAttackDistanceMin() && gridDistance <= getAttackDistanceMax()) {
                return true;
            }

            var attackableTiles:Vector.<Tile> = getAttackableTilesFrom(target.x, target.y);
            for each(var tile:Tile in attackableTiles) {
                if (!tile.canStandOn(this as MonstroEntity)){
                    continue;
                }

                var distance:int = MonstroPathmapper.getDistance(tile.x, tile.y, x, y, this as MonstroEntity, field);

                if (distance <= statistics.movesMax) {
                    return true;
                }
            }

            return false;
        }

        public function canReach(tile:Tile):Boolean {
            var gridDistance:int = UtilsNumber.distanceManhattan(x, y, tile.x, tile.y);

            if (statistics.movesMax < gridDistance) {
                return false;
            }

            if (gridDistance < 2) {
                return tile.canStandOn(this as MonstroEntity);
            }

            return MonstroPathmapper.getDistance(x, y, tile.x, tile.y, this as MonstroEntity, field) <= statistics.movesMax && tile.canStandOn(this as MonstroEntity);
        }

        public function canReachToAttackAnything():Boolean{
            for each(var entity:MonstroEntity in field.getLivingEntities()){
                if (entity && entity.controlledBy === EnumUnitController.ENEMY && canReachToAttack(entity)){
                    return true;
                }
            }

            return false;
        }

        override public function dispose():void{
            controlledBy = null;

            super.dispose();
        }
    }
}
