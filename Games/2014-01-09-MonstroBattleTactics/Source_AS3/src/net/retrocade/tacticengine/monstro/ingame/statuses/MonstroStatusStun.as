
package net.retrocade.tacticengine.monstro.ingame.statuses {
    import net.retrocade.tacticengine.core.Eventer;
    import net.retrocade.tacticengine.monstro.ingame.entities.MonstroEntity;
    import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventSaveStateLoaded;
    import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventStatusChanged;

    final public class MonstroStatusStun implements IMonstroStatus {
        private var _unit:MonstroEntity;
        private var _counter:int = 0;

        public function MonstroStatusStun() {
        }

        final public function attachToUnit(unit:MonstroEntity):void {
            _unit = unit;
            _counter = 1;

            _unit.hasMoved = true;

            new MonstroEventStatusChanged(this, _unit, true);
        }

        final public function onTurnStart():void {
            _unit.hasMoved = true;

            _counter--;

            if (_counter == 0) {
                removeStatus();
            }
        }

        final public function onTurnEnd():void {

        }

        final public function onAttack():void {
        }

        final public function onDefense():void {
        }

        final public function dispose():void {
            _unit = null;

			Eventer.releaseContext(this);
        }

        final public function makeDump():Object {
            var descriptor:Object = {};
            descriptor.name = MonstroStatusFactory.STUN;
            descriptor.counter = _counter;

            return descriptor;
        }

        final public function loadFromDump(descriptor:Object):void {
            _counter = descriptor.counter;

            Eventer.listen(MonstroEventSaveStateLoaded.NAME, onSaveLoaded, this);
        }

        final private function removeStatus():void {
            new MonstroEventStatusChanged(this, _unit, false);
            _unit.statusRemove(this);
        }

        final public function get name():String {
            return MonstroStatusFactory.STUN;
        }

        final public function get unit():MonstroEntity {
            return _unit;
        }

        final public function set unit(value:MonstroEntity):void {
            _unit = value;
        }

        final public function onSaveLoaded():void{
            Eventer.release(MonstroEventSaveStateLoaded.NAME, onSaveLoaded);

            new MonstroEventStatusChanged(this, _unit, true);
        }
    }
}
