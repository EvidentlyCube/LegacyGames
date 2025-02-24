
package net.retrocade.tacticengine.monstro.ingame.actions {
    import net.retrocade.tacticengine.monstro.gui.render.MonstroUnitClip;

    public class MonstroActionChangeUnitEnabled extends MonstroAction{
        public var _unit:MonstroUnitClip;
        public var _isEnabled:Boolean;

        public function MonstroActionChangeUnitEnabled(unit:MonstroUnitClip, isEnabled:Boolean, onFinished:Function = null) {
            super(onFinished);

            _unit = unit;
            _isEnabled = isEnabled;
        }

        override public function update():Boolean{
            _unit.disabled = !_isEnabled;

            return true;
        }

        override public function dispose():void{
            _unit = null;
        }

        override public function get shouldSkipFrameAfterFinished():Boolean {
            return false;
        }
    }
}
