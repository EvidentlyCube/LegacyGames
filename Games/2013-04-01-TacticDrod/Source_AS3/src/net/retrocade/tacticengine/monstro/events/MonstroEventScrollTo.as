/**
 * Created with IntelliJ IDEA.
 * User: mzarzycki
 * Date: 17.01.13
 * Time: 10:16
 * To change this template use File | Settings | File Templates.
 */
package net.retrocade.tacticengine.monstro.events {
    public class MonstroEventScrollTo extends MonstroEvent{
        public static const NAME:String = "scroll_to";

        public var x:int;
        public var y:int;
        public var factor:Number;

        public function MonstroEventScrollTo(x:int, y:int, factor:Number){
            this.x = x;
            this.y = y;
            this.factor = factor;

            dispatch(NAME);
        }
    }
}
