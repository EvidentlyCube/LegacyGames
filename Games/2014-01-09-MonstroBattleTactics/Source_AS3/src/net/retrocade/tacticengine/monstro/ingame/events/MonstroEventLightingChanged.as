
package net.retrocade.tacticengine.monstro.ingame.events {
    public class MonstroEventLightingChanged extends MonstroEvent{
        public static const NAME:String = "MonstroEventLightingChanged";

        public function MonstroEventLightingChanged(){
            dispatch(NAME);
        }
    }
}
