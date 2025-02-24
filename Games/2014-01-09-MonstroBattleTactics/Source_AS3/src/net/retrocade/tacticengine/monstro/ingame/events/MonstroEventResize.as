
package net.retrocade.tacticengine.monstro.ingame.events {
    public class MonstroEventResize extends MonstroEvent{
        public static const NAME:String = "stage_resize";

        public function MonstroEventResize(){
            dispatch(NAME);
        }
    }
}
