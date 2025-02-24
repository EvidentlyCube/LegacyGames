
package net.retrocade.tacticengine.monstro.ingame.events {
    import net.retrocade.tacticengine.monstro.ingame.ais.common.IMonstroTurnProcess;

    public class MonstroEventTurnProcessHasChanged extends MonstroEvent{
        public static const NAME:String = "turn_process_has_changed";

        public var newProcess    :IMonstroTurnProcess;

        public function MonstroEventTurnProcessHasChanged(newProcess:IMonstroTurnProcess)
        {
            this.newProcess = newProcess;

            dispatch(NAME);
        }
    }
}
