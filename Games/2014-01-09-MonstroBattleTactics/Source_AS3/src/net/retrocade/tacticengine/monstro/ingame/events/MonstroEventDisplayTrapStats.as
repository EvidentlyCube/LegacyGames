
package net.retrocade.tacticengine.monstro.ingame.events {
    import net.retrocade.tacticengine.monstro.ingame.entities.MonstroEntity;
    import net.retrocade.tacticengine.monstro.ingame.traps.IMonstroTrap;

    public class MonstroEventDisplayTrapStats extends MonstroEvent{
        public static const NAME:String = "MonstroEventDisplayTrapStats";

        public var trap:IMonstroTrap;

        public function MonstroEventDisplayTrapStats(trap:IMonstroTrap){
            this.trap = trap;

            dispatch(NAME);
        }
    }
}
