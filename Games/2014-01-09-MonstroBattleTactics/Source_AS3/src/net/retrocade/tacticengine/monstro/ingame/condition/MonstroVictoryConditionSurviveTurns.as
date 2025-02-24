
package net.retrocade.tacticengine.monstro.ingame.condition {
	import net.retrocade.tacticengine.core.MonstroField;

    public class MonstroVictoryConditionSurviveTurns implements IMonstroCondition {
        private var _turnCount:int;
		private var _field:MonstroField;


		public function MonstroVictoryConditionSurviveTurns(field:MonstroField, turnCount:int) {
            _turnCount = turnCount;
			_field = field;

            if (_turnCount < 1) {
                throw new Error("Can't wait less than one turn");
            }

        }

        public function check():Boolean {
            return _field.currentTurn === _turnCount;
        }

        public function get type():String {
            return MonstroConditionFactory.SURVIVE_TURNS;
        }

        public function dispose():void {
        }

        public function get turnCount():int {
            return _turnCount;
        }

        public function makeDump():Object {
            var dump:Object = {};
            dump.type = type;
            dump.turnCount = _turnCount;

            return dump;
        }

        public function loadFromDump(dump:Object):void {
            _turnCount = dump.turnCount;
        }
    }
}
