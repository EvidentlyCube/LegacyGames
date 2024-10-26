/**
 * Created with IntelliJ IDEA.
 * User: Ryc
 * Date: 16.02.13
 * Time: 22:28
 * To change this template use File | Settings | File Templates.
 */
package net.retrocade.tacticengine.monstro.actions {
    import net.retrocade.camel.layers.rLayerStarling;
    import net.retrocade.tacticengine.core.Eventer;
    import net.retrocade.tacticengine.monstro.core.Monstro;
    import net.retrocade.tacticengine.monstro.core.MonstroGfx;
    import net.retrocade.tacticengine.monstro.events.MonstroEventTap;
    import net.retrocade.tacticengine.monstro.windows.MonstroWindowMissionFinished;
    import net.retrocade.tacticengine.monstro.windows.MonstroWindowMissionFinished;
    import net.retrocade.utils.UNumber;

    import starling.display.Image;

    public class MonstroActionMissionEnded extends MonstroAction{
        private var _waiter:int = 120;

        public function MonstroActionMissionEnded() {
            super(null);
        }

        override public function update():Boolean{
            if (_waiter > 0){
                _waiter--;
            }
            return _waiter == 0;
        }
    }
}
