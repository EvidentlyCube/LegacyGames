/**
 * Created with IntelliJ IDEA.
 * User: Ryc
 * Date: 13.01.13
 * Time: 14:31
 * To change this template use File | Settings | File Templates.
 */
package net.retrocade.tacticengine.monstro.actions {
    import net.retrocade.tacticengine.monstro.render.MonstroUnitClip;

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
            _unit.showUnitRect = false;

            return true;
        }

        override public function destruct():void{
            _unit = null;
        }

        override public function get isStoppingAction():Boolean {
            return false;
        }
    }
}
