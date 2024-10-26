/**
 * Created with IntelliJ IDEA.
 * User: mzarzycki
 * Date: 17.01.13
 * Time: 10:16
 * To change this template use File | Settings | File Templates.
 */
package net.retrocade.tacticengine.monstro.events {
    public class MonstroEventResize extends MonstroEvent{
        public static const NAME:String = "stage_resize";

        public function MonstroEventResize(){
            dispatch(NAME);
        }
    }
}
