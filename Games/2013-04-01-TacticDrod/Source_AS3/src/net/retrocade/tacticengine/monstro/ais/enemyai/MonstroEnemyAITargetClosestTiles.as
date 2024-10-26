/**
 * Created with IntelliJ IDEA.
 * User: Ryc
 * Date: 20.01.13
 * Time: 13:35
 * To change this template use File | Settings | File Templates.
 */
package net.retrocade.tacticengine.monstro.ais.enemyai {
    import flash.utils.Dictionary;

    import net.retrocade.tacticengine.monstro.ais.*;
    import net.retrocade.tacticengine.core.Field;
    import net.retrocade.tacticengine.core.Tile;
    import net.retrocade.tacticengine.core.Tile;
    import net.retrocade.tacticengine.monstro.entities.MonstroEntity;
    import net.retrocade.tacticengine.monstro.utils.MonstroPathmapper;
    import net.retrocade.utils.UString;

    public class MonstroEnemyAITargetClosestTiles implements IMonstroEnemyStep{
        private var _tilesToTest:Vector.<Tile>;
        private var _foundTiles:Vector.<Tile>;
        private var _unit:MonstroEntity;
        private var _field:Field;

        private var _tilesScores:Dictionary;
        private var _smallestTileScore:int;

        private var _enemies:Vector.<MonstroEntity>;

        public function MonstroEnemyAITargetClosestTiles(){}

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
                distance = Math.min(distance, MonstroPathmapper.getDistance(tile.x, tile.y, enemy.x, enemy.y, _unit, _field));
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

        public function set field(value:Field):void{
            _field = value;
        }

        public function destruct():void{
            _tilesToTest = null;
            _foundTiles = null;
            _unit = null;
            _field = null;
        }
    }
}
