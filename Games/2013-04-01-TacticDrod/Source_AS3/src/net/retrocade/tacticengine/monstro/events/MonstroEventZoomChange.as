/**
 * Created with IntelliJ IDEA.
 * User: mzarzycki
 * Date: 17.01.13
 * Time: 10:16
 * To change this template use File | Settings | File Templates.
 */
package net.retrocade.tacticengine.monstro.events {
    import net.retrocade.tacticengine.monstro.ais.IMonstroTurnProcess;

    public class MonstroEventZoomChange extends MonstroEvent{
        public static const NAME:String = "zoom_change";

        public var zoomIn:Boolean;

        public function MonstroEventZoomChange(zoomIn:Boolean){
            this.zoomIn = zoomIn;

            dispatch(NAME);
        }
    }
}
