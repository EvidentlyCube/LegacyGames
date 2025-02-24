
package net.retrocade.tacticengine.monstro.ingame.ais.classic.enemyai.normal {
	import net.retrocade.tacticengine.monstro.ingame.ais.classic.IMonstroEnemyStep;
	import net.retrocade.tacticengine.monstro.ingame.utils.MonstroAttackSimulation;
    import net.retrocade.tacticengine.monstro.ingame.ais.*;
    import flash.utils.Dictionary;

    import net.retrocade.tacticengine.core.MonstroField;
    import net.retrocade.tacticengine.core.Tile;
    import net.retrocade.tacticengine.monstro.ingame.entities.MonstroEntity;
    import net.retrocade.tacticengine.monstro.ingame.utils.MonstroPathmapper;
    import net.retrocade.utils.UtilsNumber;

    public class MonstroEnemyAIFilterMostDamage implements IMonstroEnemyStep{
        private var _tilesToTest:Vector.<Tile>;
        private var _unit:MonstroEntity;
        private var _field:MonstroField;

        private var _testedTiles:Vector.<Tile>;
        private var _tilesScores:Dictionary;
        private var _bestDamageScore:int;

        private var _hostileUnits:Vector.<MonstroEntity>;

        public function MonstroEnemyAIFilterMostDamage(){}

        public function init(entity:MonstroEntity, tiles:Vector.<Tile>, friendlyUnits:Vector.<MonstroEntity>, hostileUnits:Vector.<MonstroEntity>):void{
            _unit = entity;
            _tilesToTest = tiles;

            _testedTiles = new Vector.<Tile>();
            _tilesScores = new Dictionary(true);

            _hostileUnits = hostileUnits;

            _bestDamageScore = int.MIN_VALUE;
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
            var bestDamageScore:int = 0;
            var simulation:MonstroAttackSimulation;

            for each(var enemy:MonstroEntity in _hostileUnits){
                if (!enemy.attackable || !isInAttackRange(enemy, tile.x, tile.y)){
                    continue;
                }

                simulation = new MonstroAttackSimulation(_unit, enemy);

                bestDamageScore = Math.max(simulation.score, bestDamageScore);
            }

            _bestDamageScore = Math.max(_bestDamageScore, bestDamageScore);
            _tilesScores[tile] = bestDamageScore;
        }

        public function getResult():Vector.<Tile>{
            var result:Vector.<Tile> = new Vector.<Tile>();

            for (var tile:Object in _tilesScores){
                var score:int = _tilesScores[tile];
                if (score == _bestDamageScore){
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

        protected function isInAttackRange(target:MonstroEntity, fromX:int, fromY:int):Boolean{
            var distance:int = UtilsNumber.distanceManhattan(target.x, target.y, fromX, fromY);

            return distance >= _unit.getAttackDistanceMin() && distance <= _unit.getAttackDistanceMax();
        }

        public function toString():String {
            return "Filter most damage done";
        }
    }
}
