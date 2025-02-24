
package net.retrocade.tacticengine.monstro.ingame.events {
    public class MonstroEventEndTurn extends MonstroEvent{
        public static const NAME:String = "end_turn";

        public function MonstroEventEndTurn(){
            dispatch(NAME);
        }
    }
}
