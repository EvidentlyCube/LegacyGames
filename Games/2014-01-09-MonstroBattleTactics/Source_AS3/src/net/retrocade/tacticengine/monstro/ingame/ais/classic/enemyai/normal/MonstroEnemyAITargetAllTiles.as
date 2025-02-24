
package net.retrocade.tacticengine.monstro.ingame.ais.classic.enemyai.normal {
    import net.retrocade.tacticengine.core.MonstroField;
    import net.retrocade.tacticengine.core.Tile;
    import net.retrocade.tacticengine.monstro.ingame.ais.*;
	import net.retrocade.tacticengine.monstro.ingame.ais.classic.IMonstroEnemyStep;
	import net.retrocade.tacticengine.monstro.ingame.entities.MonstroEntity;

    public class MonstroEnemyAITargetAllTiles implements IMonstroEnemyStep {
        private var _unit:MonstroEntity;
        private var _field:MonstroField;

        public function MonstroEnemyAITargetAllTiles() {
        }

        public function init(entity:MonstroEntity, tiles:Vector.<Tile>, friendlyUnits:Vector.<MonstroEntity>, hostileUnits:Vector.<MonstroEntity>):void {
            _unit = entity;
        }

        public function update():Boolean {
            return true;
        }

        public function getResult():Vector.<Tile> {
            return _unit.getMovableTiles();
        }

        public function dispose():void {
            _unit = null;
            _field = null;
        }

        public function set field(value:MonstroField):void {
            _field = value;
        }

        public function toString():String {
            return "Target all tiles";
        }
    }
}
