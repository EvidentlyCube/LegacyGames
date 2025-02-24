
package net.retrocade.tacticengine.monstro.ingame.events {
    public class MonstroEventWindowClosed extends MonstroEvent{
        public static const NAME:String = "MonstroEventWindowClosed";

		public function MonstroEventWindowClosed(){
            dispatch(NAME);
        }
    }
}
