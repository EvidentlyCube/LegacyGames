
package net.retrocade.tacticengine.monstro.ingame.events {

    public class MonstroEventClearAllActions extends MonstroEvent{
        public static const NAME:String = "MonstroEventClearAllActions";

        public function MonstroEventClearAllActions()
        {
            dispatch(NAME);
        }
    }
}
