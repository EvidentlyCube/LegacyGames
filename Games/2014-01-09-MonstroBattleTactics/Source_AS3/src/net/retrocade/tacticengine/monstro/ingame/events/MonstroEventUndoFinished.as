
package net.retrocade.tacticengine.monstro.ingame.events {
    public class MonstroEventUndoFinished extends MonstroEvent{
        public static const NAME:String = "MonstroEventUndoFinished";

		public function MonstroEventUndoFinished(){
            dispatch(NAME);
        }
    }
}
