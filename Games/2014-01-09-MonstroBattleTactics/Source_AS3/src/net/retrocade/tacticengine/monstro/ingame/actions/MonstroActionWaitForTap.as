
package net.retrocade.tacticengine.monstro.ingame.actions {
    import net.retrocade.tacticengine.core.Eventer;
    import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventTap;

    public class MonstroActionWaitForTap extends MonstroAction{
        private var _hasTapped:Boolean = false;

        public function MonstroActionWaitForTap(callback:Function = null) {
            super(callback);

            Eventer.listen(MonstroEventTap.NAME, onTap, this);
        }

        override public function update():Boolean{
            return _hasTapped;
        }

        private function onTap():void{
            _hasTapped = true;
        }

        override public function dispose():void{
			Eventer.releaseContext(this);

            super.dispose();
        }
    }
}
