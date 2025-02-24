
package net.retrocade.tacticengine.monstro.ingame.events {
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
