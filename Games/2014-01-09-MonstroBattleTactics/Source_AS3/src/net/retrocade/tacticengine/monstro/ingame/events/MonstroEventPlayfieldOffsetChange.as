
package net.retrocade.tacticengine.monstro.ingame.events {
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
