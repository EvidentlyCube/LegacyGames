/**
 * Created with IntelliJ IDEA.
 * User: Ryc
 * Date: 20.01.13
 * Time: 13:35
 * To change this template use File | Settings | File Templates.
 */
package net.retrocade.tacticengine.monstro.ais.enemyai {
    import net.retrocade.tacticengine.monstro.ais.*;
    import net.retrocade.tacticengine.core.Field;
    import net.retrocade.tacticengine.core.Tile;
    import net.retrocade.tacticengine.monstro.data.MonstroAttackSimulation;
    import net.retrocade.tacticengine.monstro.entities.MonstroEntity;
    import net.retrocade.tacticengine.monstro.entities.MonstroEntityFactory;
    import net.retrocade.tacticengine.monstro.utils.MonstroPathmapper;

    public class MonstroEnemyAITargetOpponentsInRange implements IMonstroEnemyStep{
        private var _tilesToTest:Vector.<Tile>;
        private var _foundTiles:Vector.<Tile>;
        private var _unit:MonstroEntity;
        private var _field:Field;

        private var _hostileUnits:Vector.<MonstroEntity>;

        private var _approachableTiles:Vector.<Tile>;

        public function MonstroEnemyAITargetOpponentsInRange(){}

        public function init(entity:MonstroEntity, tiles:Vector.<Tile>, friendlyUnits:Vector.<MonstroEntity>, hostileUnits:Vector.<MonstroEntity>):void{
            _unit = entity;

            _hostileUnits = hostileUnits;

            _approachableTiles = null;
            _foundTiles = new Vector.<Tile>();
            _tilesToTest = null;
        }

        public function update():Boolean{
            var tile:Tile;

            if (!_approachableTiles){
                setApproachableTiles();
                return false;
            }

            if (_tilesToTest.length == 0){
                return true;
            }

            tile = _tilesToTest.pop();

            if (_approachableTiles.indexOf(tile) !== -1 && _foundTiles.indexOf(tile) === -1){
                _foundTiles.push(tile);
            }

            return _tilesToTest.length == 0;
        }

        private function setApproachableTiles():void {
            var tile:Tile;
            var  unit:MonstroEntity;

            // At first target only those enemies which stand next to the unit
            // If there aren't any enemies next to it, target all of them

            _approachableTiles = _unit.getMovableTiles();
            _approachableTiles.push(_unit.tile);

            _tilesToTest = new Vector.<Tile>();

            var playerUnits:Vector.<MonstroEntity> = _hostileUnits;
            var targetEnemies:Vector.<MonstroEntity> = new Vector.<MonstroEntity>();

            targetEnemies = playerUnits;

            var enemyScores:Vector.<ScoredUnit> = new Vector.<ScoredUnit>();

            for each(unit in targetEnemies) {
                var simulation:MonstroAttackSimulation = new MonstroAttackSimulation(_unit, unit);
                enemyScores.push(new ScoredUnit(unit,  simulation.score));
            }

            enemyScores = enemyScores.sort(ScoredUnit.compare);

            var breakNow:Boolean = false;

            for each(var score:ScoredUnit in enemyScores){
                if (score.unit.name == MonstroEntityFactory.NAME_BEETHRO){
                    _tilesToTest.length == 0;
                    breakNow = true;
                }

                for each(tile in MonstroPathmapper.getTilesInDistance(score.unit.x, score.unit.y, 0, _unit.getAttackDistance(), _field)) {
                    if (_unit.canReach(tile)){
                        _tilesToTest.push(tile);
                    }
                }

                if (breakNow){
                    break;
                }
            }
        }

        public function getResult():Vector.<Tile>{
            return _foundTiles;
        }

        public function set field(value:Field):void{
            _field = value;
        }

        public function destruct():void{
            _tilesToTest = null;
            _foundTiles = null;
            _unit = null;
            _field = null;
            _approachableTiles = null;
        }
    }
}

import net.retrocade.tacticengine.monstro.entities.MonstroEntity;
import net.retrocade.utils.UNumber;


class ScoredUnit{
    public static var id:int = 0;

    public var unit:MonstroEntity;
    public var score:int = 0;
    public var id:int = 0;

    public function ScoredUnit(unit:MonstroEntity, score:int){
        this.unit = unit;
        this.score = score;
        this.id = ScoredUnit.id++;
    }

    public static function compare(objectA:ScoredUnit, objectB:ScoredUnit):int{
        if (objectA.score == objectB.score){
            return UNumber.sign(objectB.id - objectA.id);
        } else {
            return UNumber.sign(objectB.score - objectA.score);
        }
    }
}