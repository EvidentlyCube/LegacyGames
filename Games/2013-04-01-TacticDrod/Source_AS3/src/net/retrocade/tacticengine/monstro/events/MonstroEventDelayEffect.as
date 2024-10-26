/**
 * Created with IntelliJ IDEA.
 * User: Ryc
 * Date: 14.01.13
 * Time: 19:42
 * To change this template use File | Settings | File Templates.
 */
package net.retrocade.tacticengine.monstro.events {
    import net.retrocade.tacticengine.core.IEvent;

    public class MonstroEventDelayEffect extends MonstroEvent{
        public static const NAME:String = "delay";

        public var delay:int;

        public function MonstroEventDelayEffect(delay:int) {
            this.delay = delay;

            dispatch(NAME);
        }
    }
}
