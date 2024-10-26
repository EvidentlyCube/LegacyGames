/**
 * Created with IntelliJ IDEA.
 * User: mzarzycki
 * Date: 17.01.13
 * Time: 10:16
 * To change this template use File | Settings | File Templates.
 */
package net.retrocade.tacticengine.monstro.events {
    import net.retrocade.tacticengine.monstro.ais.IMonstroTurnProcess;

    public class MonstroEventPlayfieldOffsetChange extends MonstroEvent{
        public static const NAME:String = "playfield_offset_change";

        public var deltaX:Number;
        public var deltaY:Number;

        public function MonstroEventPlayfieldOffsetChange(deltaX:Number, deltaY:Number){
            this.deltaX = deltaX;
            this.deltaY = deltaY;

            dispatch(NAME);
        }
    }
}
