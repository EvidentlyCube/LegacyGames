
package net.retrocade.tacticengine.monstro.ingame.events {
    public class MonstroEventTap extends MonstroEvent{
        public static const NAME:String = "tap";

        public var x:int;
        public var y:int;

        public function MonstroEventTap(x:int,  y:int){
            this.x = x;
            this.y = y;

            dispatch(NAME);
        }
    }
}
