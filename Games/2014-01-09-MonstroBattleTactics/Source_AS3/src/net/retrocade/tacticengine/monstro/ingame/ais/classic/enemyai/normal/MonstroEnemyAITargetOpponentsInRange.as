
package net.retrocade.tacticengine.monstro.ingame.ais.classic.enemyai.normal {
    import net.retrocade.tacticengine.monstro.ingame.ais.*;
    import net.retrocade.tacticengine.core.MonstroField;
    import net.retrocade.tacticengine.core.Tile;
	import net.retrocade.tacticengine.monstro.ingame.ais.classic.IMonstroEnemyStep;
	import net.retrocade.tacticengine.monstro.ingame.utils.MonstroAttackSimulation;
    import net.retrocade.tacticengine.monstro.ingame.entities.MonstroEntity;
    import net.retrocade.tacticengine.monstro.ingame.utils.MonstroPathmapper;

    public class MonstroEnemyAITargetOpponentsInRange implements IMonstroEnemyStep{
        private var _tilesToTest:Vector.<Tile>;
        private var _foundTiles:Vector.<Tile>;
        private var _unit:MonstroEntity;
        private var _field:MonstroField;

        private var _hostileUnits:Vector.<MonstroEntity>;

        private var _approachableTiles:Vector.<Tile>;

        public function  MonstroEnemyAITargetOpponentsInRange(){}

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

            for each(unit in _hostileUnits){
                if (!unit.attackable){
                    continue;
                }

                for each(tile in _unit.getAttackableTilesFrom(unit.x, unit.y)){
                    if (_unit.canReach(tile)){
                        _tilesToTest.push(tile);
                    }
                }
            }
        }

        public function getResult():Vector.<Tile>{
            return _foundTiles;
        }

        public function set field(value:MonstroField):void{
            _field = value;
        }

        public function dispose():void{
            _tilesToTest = null;
            _foundTiles = null;
            _unit = null;
            _field = null;
            _approachableTiles = null;
        }

        public function toString():String {
            return "Target opponents in range";
        }
    }
}

import net.retrocade.tacticengine.monstro.ingame.entities.MonstroEntity;
import net.retrocade.utils.UtilsNumber;


class ScoredUnit{
    public static var id:int = 0;

    public var unit:MonstroEntity;
    public var id:int = 0;

    public function ScoredUnit(unit:MonstroEntity){
        this.unit = unit;
        this.id = ScoredUnit.id++;
    }
}