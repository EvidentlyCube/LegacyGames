
package net.retrocade.tacticengine.monstro.ingame.events {
    public class MonstroEventStopUnit extends MonstroEvent{
        public static const NAME:String = "stop_unit";

        public function MonstroEventStopUnit(){
            dispatch(NAME);
        }
    }
}
