/**
 * Created with IntelliJ IDEA.
 * User: Ryc
 * Date: 20.01.13
 * Time: 14:52
 * To change this template use File | Settings | File Templates.
 */
package net.retrocade.tacticengine.monstro.ais.enemyai {
    import net.retrocade.tacticengine.monstro.ais.*;
    import flash.utils.Dictionary;

    import net.retrocade.tacticengine.core.Field;
    import net.retrocade.tacticengine.core.Tile;
    import net.retrocade.tacticengine.monstro.entities.MonstroEntity;
    import net.retrocade.tacticengine.monstro.utils.MonstroPathmapper;

    public class MonstroEnemyAIFilterLeastAttackers implements IMonstroEnemyStep{
        private var _tilesToTest:Vector.<Tile>;
        private var _unit:MonstroEntity;
        private var _field:Field;

        private var _testedTiles:Vector.<Tile>;
        private var _tilesScores:Dictionary;
        private var _smallestTileScore:int;

        private var _hostileUnits:Vector.<MonstroEntity>;

        public function MonstroEnemyAIFilterLeastAttackers(){}

        public function init(entity:MonstroEntity, tiles:Vector.<Tile>, friendlyUnits:Vector.<MonstroEntity>, hostileUnits:Vector.<MonstroEntity>):void{
            _unit = entity;
            _tilesToTest = tiles;

            _testedTiles = new Vector.<Tile>();
            _tilesScores = new Dictionary(true);

            _hostileUnits = hostileUnits;

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
            var noEnemiesWhichCanAttack:int = 0;
            for each(var enemy:MonstroEntity in _hostileUnits){
                var distance:int = MonstroPathmapper.getDistance(tile.x, tile.y, enemy.x, enemy.y, enemy, _field);

                if (distance <= enemy.movesLeft + enemy.getAttackDistance()){
                    noEnemiesWhichCanAttack++;
                }
            }

            _smallestTileScore = Math.min(_smallestTileScore, noEnemiesWhichCanAttack);
            _tilesScores[tile] = noEnemiesWhichCanAttack;
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

        }
    }
}
