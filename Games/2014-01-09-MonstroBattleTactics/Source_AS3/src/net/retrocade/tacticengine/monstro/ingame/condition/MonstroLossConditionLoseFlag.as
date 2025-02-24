
package net.retrocade.tacticengine.monstro.ingame.condition {
    import net.retrocade.tacticengine.core.MonstroField;
    import net.retrocade.tacticengine.monstro.ingame.entities.MonstroEntity;
    import net.retrocade.tacticengine.monstro.ingame.entities.MonstroEntityFactory;

    public class MonstroLossConditionLoseFlag implements IMonstroCondition {
        private var _flag:MonstroEntity;

        public function MonstroLossConditionLoseFlag(field:MonstroField) {
            var allEntities:Vector.<MonstroEntity> = field.getAllEntities();

            for each(var entity:MonstroEntity in allEntities) {
                if (entity.controlledBy.isPlayer() && entity.unitType.isFlag()) {
                    _flag = entity;
                }
            }

            if (!_flag) {
                throw new Error("Player flag not found!");
            }
        }

        public function check():Boolean {
            return !_flag.isAlive;
        }

        public function dispose():void {
            _flag = null;
        }

        public function makeDump():Object {
            var dump:Object = {};
            dump.type = type;

            return dump;
        }

        public function loadFromDump(dump:Object):void {
        }

        public function get type():String {
            return MonstroConditionFactory.LOSE_FLAG;
        }
    }
}
