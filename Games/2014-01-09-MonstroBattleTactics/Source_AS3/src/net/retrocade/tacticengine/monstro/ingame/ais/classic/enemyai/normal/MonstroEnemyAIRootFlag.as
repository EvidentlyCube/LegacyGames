
package net.retrocade.tacticengine.monstro.ingame.ais.classic.enemyai.normal {
    import net.retrocade.tacticengine.core.MonstroField;
    import net.retrocade.tacticengine.core.Tile;
	import net.retrocade.tacticengine.monstro.global.enum.EnumUnitType;
	import net.retrocade.tacticengine.monstro.ingame.ais.classic.IMonstroEnemyStep;
    import net.retrocade.tacticengine.monstro.ingame.entities.MonstroEntity;
    import net.retrocade.tacticengine.monstro.ingame.entities.MonstroEntityFactory;

    public class MonstroEnemyAIRootFlag implements IMonstroEnemyStep {
        protected var _field:MonstroField;
        protected var _unit:MonstroEntity;
        protected var _friendlyUnits:Vector.<MonstroEntity>;
        protected var _hostileUnits:Vector.<MonstroEntity>;
        protected var _possibleTiles:Vector.<Tile>;
        private var _flag:MonstroEntity;
        private var _lookedForFlag:Boolean = false;

        public function dispose():void {
            _field = null;
            _unit = null;
            _friendlyUnits = null;
            _hostileUnits = null;
            _possibleTiles = null;
            _flag = null;
        }

        public function init(entity:MonstroEntity, tiles:Vector.<Tile>, friendlyUnits:Vector.<MonstroEntity>, hostileUnits:Vector.<MonstroEntity>):void {
            _unit = entity;
            _possibleTiles = tiles;
            _friendlyUnits = friendlyUnits;
            _hostileUnits = hostileUnits;
        }

        public function update():Boolean {
            return true;
        }

        public function getResult():Vector.<Tile> {
            return _possibleTiles;
        }

        public function set field(value:MonstroField):void {
            _field = value;
        }

        public function get flag():MonstroEntity {
            if (!_lookedForFlag) {
                for each(var unit:MonstroEntity in _hostileUnits) {
                    if (unit.unitType == EnumUnitType.FLAG_KING || unit.unitType == EnumUnitType.FLAG_BRAIN) {
                        _flag = unit;
                        break;
                    }
                }

                _lookedForFlag = true;
            }

            return _flag;
        }

        public function toString():String{
            throw new Error("Abstract implementation");
        }
    }
}
