
package net.retrocade.tacticengine.monstro.ingame.ais.classic.enemyai.normal {
    import flash.utils.Dictionary;

    import net.retrocade.tacticengine.monstro.ingame.ais.*;
    import net.retrocade.tacticengine.core.MonstroField;
    import net.retrocade.tacticengine.core.Tile;
    import net.retrocade.tacticengine.core.Tile;
	import net.retrocade.tacticengine.monstro.ingame.ais.classic.IMonstroEnemyStep;
	import net.retrocade.tacticengine.monstro.ingame.entities.MonstroEntity;
    import net.retrocade.tacticengine.monstro.ingame.utils.MonstroPathmapper;
    import net.retrocade.utils.UtilsString;

    public class MonstroEnemyAITargetClosestToPlayerTiles implements IMonstroEnemyStep{
        private var _tilesToTest:Vector.<Tile>;
        private var _foundTiles:Vector.<Tile>;
        private var _unit:MonstroEntity;
        private var _field:MonstroField;

        private var _tilesScores:Dictionary;
        private var _smallestTileScore:int;

        private var _enemies:Vector.<MonstroEntity>;

        public function MonstroEnemyAITargetClosestToPlayerTiles(){}

        public function init(entity:MonstroEntity, tiles:Vector.<Tile>, friendlyUnits:Vector.<MonstroEntity>, hostileUnits:Vector.<MonstroEntity>):void{
            _unit = entity;

            _foundTiles = new Vector.<Tile>();
            _tilesToTest = _unit.getMovableTiles();
            _tilesScores = new Dictionary(true);

            _enemies = hostileUnits;

            _smallestTileScore = int.MAX_VALUE;
        }

        public function update():Boolean{
            if (_tilesToTest.length == 0){
                return true;
            }

            var tile:Tile = _tilesToTest.pop();
            parseTile(tile);

            return _tilesToTest.length == 0;
        }

        private function parseTile(tile:Tile):void{
            var distance:int = int.MAX_VALUE;
            for each(var enemy:MonstroEntity in _enemies){
                if (!enemy.attackable){
                    continue;
                }

				var tempDistance:Number = MonstroPathmapper.getDistance(tile.x, tile.y, enemy.x, enemy.y, _unit, _field);

				tempDistance *= 100;
				tempDistance -= Math.abs(_unit.y - tile.y) * 10;
				tempDistance -= Math.abs(_unit.x - tile.x);

				distance = Math.min(tempDistance, distance);
			}

            _smallestTileScore = Math.min(_smallestTileScore, distance);
            _tilesScores[tile] = distance;
        }

        public function getResult():Vector.<Tile>{
            var result:Vector.<Tile> = new Vector.<Tile>();

            for (var tile:Object in _tilesScores){
                var score:int = _tilesScores[tile];
                if (score == _smallestTileScore){
                    result.push(tile as Tile);
                }
            }

            return result;
        }

        public function set field(value:MonstroField):void{
            _field = value;
        }

        public function dispose():void{
            _tilesToTest = null;
            _foundTiles = null;
            _unit = null;
            _field = null;
        }

        public function toString():String {
            return "Target closest tiles";
        }
    }
}
