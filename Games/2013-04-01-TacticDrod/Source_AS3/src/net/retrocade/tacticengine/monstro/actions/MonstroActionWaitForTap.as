/**
 * Created with IntelliJ IDEA.
 * User: mzarzycki
 * Date: 17.01.13
 * Time: 10:11
 * To change this template use File | Settings | File Templates.
 */
package net.retrocade.tacticengine.monstro.actions {
    import net.retrocade.tacticengine.core.Eventer;
    import net.retrocade.tacticengine.monstro.events.MonstroEventTap;

    public class MonstroActionWaitForTap extends MonstroAction{
        private var _hasTapped:Boolean = false;

        public function MonstroActionWaitForTap(callback:Function = null) {
            super(callback);

            Eventer.listen(MonstroEventTap.NAME, onTap);
        }

        override public function update():Boolean{
            return _hasTapped;
        }

        private function onTap():void{
            _hasTapped = true;
        }

        override public function destruct():void{
            Eventer.release(MonstroEventTap.NAME, onTap);

            super.destruct();
        }
    }
}
