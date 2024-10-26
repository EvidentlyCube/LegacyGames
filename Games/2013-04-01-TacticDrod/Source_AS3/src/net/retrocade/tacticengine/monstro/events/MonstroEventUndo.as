/**
 * Created with IntelliJ IDEA.
 * User: mzarzycki
 * Date: 17.01.13
 * Time: 10:16
 * To change this template use File | Settings | File Templates.
 */
package net.retrocade.tacticengine.monstro.events {
    public class MonstroEventUndo extends MonstroEvent{
        public static const NAME:String = "undo_movement";

        public function MonstroEventUndo(){
            dispatch(NAME);
        }
    }
}
