
package net.retrocade.tacticengine.monstro.ingame.events {
    public class MonstroEventSaveStateLoaded extends MonstroEvent{
        public static const NAME:String = "save_state_loaded";

        public function MonstroEventSaveStateLoaded(){
            dispatch(NAME);
        }
    }
}
