
package net.retrocade.tacticengine.monstro.ingame.condition {
    import net.retrocade.tacticengine.core.MonstroField;
    import net.retrocade.tacticengine.monstro.ingame.entities.MonstroEntity;
    import net.retrocade.tacticengine.monstro.ingame.entities.MonstroEntityFactory;

    public class MonstroVictoryConditionDefeatAll implements IMonstroCondition {
        private var _targets:Vector.<MonstroEntity>;

        public function MonstroVictoryConditionDefeatAll(field:MonstroField) {
            _targets = new Vector.<MonstroEntity>();

            var allEntities:Vector.<MonstroEntity> = field.getAllEntities();

            for each(var entity:MonstroEntity in allEntities) {
                if (entity.controlledBy.isEnemy() && entity.hasToBeKilled) {
                    _targets.push(entity);
                }
            }

            if (_targets.length == 0) {
                throw new Error("No enemy units found!");
            }
        }

        public function check():Boolean {
            for each(var entity:MonstroEntity in _targets) {
                if (entity.isAlive) {
                    return false;
                }
            }

            return true;
        }

        public function dispose():void {
            _targets = null;
        }

        public function makeDump():Object {
            var dump:Object = {};
            dump.type = type;

            return dump;
        }

        public function loadFromDump(dump:Object):void {
        }

        public function get type():String {
            return MonstroConditionFactory.DESTROY_ALL;
        }
    }
}
