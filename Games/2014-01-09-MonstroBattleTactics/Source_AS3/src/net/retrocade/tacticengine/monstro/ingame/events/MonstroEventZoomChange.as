
package net.retrocade.tacticengine.monstro.ingame.events {
    public class MonstroEventZoomChange extends MonstroEvent{
        public static const NAME:String = "zoom_change";

        public var zoomIn:Boolean;

        public function MonstroEventZoomChange(zoomIn:Boolean){
            this.zoomIn = zoomIn;

            dispatch(NAME);
        }
    }
}
