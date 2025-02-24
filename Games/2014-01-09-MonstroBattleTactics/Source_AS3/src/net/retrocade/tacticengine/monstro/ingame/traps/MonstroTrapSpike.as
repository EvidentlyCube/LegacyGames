
package net.retrocade.tacticengine.monstro.ingame.traps {
    import net.retrocade.tacticengine.monstro.ingame.entities.MonstroEntity;
    import net.retrocade.tacticengine.monstro.global.enum.EnumTrapType;
    import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventTrapActivated;
    import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventUnitHit;

    public class MonstroTrapSpike implements IMonstroTrap {
        private var _isEnabled:Boolean = true;
        private var _damage:uint;
        private var _trapType:EnumTrapType;
        private var _x:int;
        private var _y:int;

        public function MonstroTrapSpike(trapType:EnumTrapType, damage:int) {
            _trapType = trapType;
            _damage = damage;
        }

        public function unitStands(unit:MonstroEntity):void {
            if (_isEnabled) {
                new MonstroEventTrapActivated(this, unit);
                new MonstroEventUnitHit(null, unit);
                unit.receiveDamage(_damage);
                unit.hasMoved = true;
            }
        }

        public function dispose():void {
            _trapType = null;
        }

        public function get isEnabled():Boolean {
            return true;
        }

        public function set isEnabled(value:Boolean):void {
        }

        public function get x():int {
            return _x;
        }

        public function set x(value:int):void {
            _x = value;
        }

        public function get y():int {
            return _y;
        }

        public function set y(value:int):void {
            _y = value;
        }

        public function makeDump():Object {
            var dump:Object = {};
            dump.x = _x;
            dump.y = _y;
            dump.name = _trapType.name;
            dump.isEnabled = _isEnabled;
            dump.damage = _damage;

            return dump;
        }

        public function loadFromDump(dump:Object):void {
            _x = dump.x;
            _y = dump.y;
            _trapType = EnumTrapType.byName(dump.name);
            _isEnabled = dump.isEnabled;
            _damage = dump.damage;
        }

        public function get name():String {
            return _trapType.name;
        }

        public function get type():EnumTrapType {
            return _trapType;
        }

		public function get damage():uint {
			return _damage;
		}
	}
}
