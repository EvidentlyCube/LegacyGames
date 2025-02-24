
package net.retrocade.tacticengine.monstro.ingame.events {
    import net.retrocade.tacticengine.monstro.ingame.ais.common.IMonstroTurnProcess;

    public class MonstroEventTurnProcessIsChanging extends MonstroEvent{
        public static const NAME:String = "turn_process_is_changing";

        public var currentProcess:IMonstroTurnProcess;
        public var newProcess    :IMonstroTurnProcess;

        public function MonstroEventTurnProcessIsChanging(currentProcess:IMonstroTurnProcess,
                                                      newProcess:IMonstroTurnProcess)
        {
            this.currentProcess = currentProcess;
            this.newProcess = newProcess;

            dispatch(NAME);
        }
    }
}
