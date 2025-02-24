
package net.retrocade.tacticengine.monstro.ingame.events {
	import net.retrocade.tacticengine.monstro.ingame.traps.IMonstroTrap;

	public class MonstroEventUndidTrap extends MonstroEvent{
        public static const NAME:String = "MonstroEventUndidTrap";

		private var _trap:IMonstroTrap;

		public function get trap():IMonstroTrap {
			return _trap;
		}

		public function MonstroEventUndidTrap(trap:IMonstroTrap){
			_trap = trap;
            dispatch(NAME);
        }
    }
}
