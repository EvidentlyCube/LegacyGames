/**
 * Created with IntelliJ IDEA.
 * User: mzarzycki
 * Date: 17.01.13
 * Time: 10:16
 * To change this template use File | Settings | File Templates.
 */
package net.retrocade.tacticengine.monstro.events {
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
