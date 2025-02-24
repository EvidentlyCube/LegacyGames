
package net.retrocade.tacticengine.monstro.ingame.ais.classic.enemyai.normal {
    import net.retrocade.tacticengine.monstro.ingame.ais.*;
    import flash.utils.Dictionary;

    import net.retrocade.tacticengine.core.MonstroField;
    import net.retrocade.tacticengine.core.Tile;
	import net.retrocade.tacticengine.monstro.ingame.ais.classic.IMonstroEnemyStep;
	import net.retrocade.tacticengine.monstro.ingame.entities.MonstroEntity;
    import net.retrocade.tacticengine.monstro.ingame.utils.MonstroPathmapper;

    public class MonstroEnemyAIFilterLeastAttackers implements IMonstroEnemyStep{
        private var _tilesToTest:Vector.<Tile>;
        private var _unit:MonstroEntity;
        private var _field:MonstroField;

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
                if (enemy.canReachToAttack(tile)){
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

        public function set field(value:MonstroField):void{
            _field = value;
        }

        public function dispose():void{

        }

        public function toString():String {
            return "Filter least attackers";
        }
    }
}
