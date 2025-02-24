
package net.retrocade.tacticengine.monstro.ingame.traps {
    import net.retrocade.tacticengine.monstro.ingame.entities.MonstroEntity;
    import net.retrocade.tacticengine.monstro.global.enum.EnumTrapType;
    import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventTrapActivated;
    import net.retrocade.tacticengine.monstro.ingame.statuses.MonstroStatusStun;
    import net.retrocade.tacticengine.monstro.ingame.undo.UndoBitTrap;
    import net.retrocade.tacticengine.monstro.ingame.undo.UndoManager;

    public class MonstroTrapWeb implements IMonstroTrap {
        private var _isEnabled:Boolean = true;
        private var _x:int;
        private var _y:int;

        public function MonstroTrapWeb(){}

        public function unitStands(unit:MonstroEntity):void {
            if (_isEnabled) {
                new MonstroEventTrapActivated(this, unit);
                unit.statusAdd(new MonstroStatusStun());

                _isEnabled = false;
            }
        }

        public function dispose():void {
        }

        public function get type():EnumTrapType {
            return EnumTrapType.WEB;
        }

        public function get name():String {
            return EnumTrapType.WEB.name;
        }

        public function get isEnabled():Boolean {
            return _isEnabled;
        }

        public function set isEnabled(value:Boolean):void {
            _isEnabled = value;
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

        public function makeDump():Object {
            var dump:Object = {};

            dump.x = _x;
            dump.y = _y;
            dump.isEnabled = _isEnabled;
            dump.name = name;

            return dump;
        }

        public function loadFromDump(dump:Object):void {
            _x = dump.x;
            _y = dump.y;
            _isEnabled = dump.isEnabled;
        }

        public function set y(value:int):void {
            _y = value;
        }
    }
}
