/**
 * Created with IntelliJ IDEA.
 * User: mzarzycki
 * Date: 17.01.13
 * Time: 10:16
 * To change this template use File | Settings | File Templates.
 */
package net.retrocade.tacticengine.monstro.events {
    import net.retrocade.tacticengine.monstro.ais.IMonstroTurnProcess;

    public class MonstroEventTurnProcessChange extends MonstroEvent{
        public static const NAME:String = "turn_process_change";

        public var currentProcess:IMonstroTurnProcess;
        public var newProcess    :IMonstroTurnProcess;

        public function MonstroEventTurnProcessChange(currentProcess:IMonstroTurnProcess,
                                                      newProcess:IMonstroTurnProcess)
        {
            this.currentProcess = currentProcess;
            this.newProcess = newProcess;

            dispatch(NAME);
        }
    }
}
