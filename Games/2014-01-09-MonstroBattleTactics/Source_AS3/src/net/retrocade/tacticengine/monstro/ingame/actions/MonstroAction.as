
package net.retrocade.tacticengine.monstro.ingame.actions {
    import flash.utils.getQualifiedClassName;

    import net.retrocade.tacticengine.core.MonstroField;

    public class MonstroAction implements IMonstroAction{
        protected var _callback:Function;
        private var _field:MonstroField;


		public function get isProcessManagerBlocked():Boolean
		{
			return true;
		}

		public function get canHaveMultipleInstances():Boolean{
            return true;
        }

		public function get isBlockingOtherActions():Boolean{
			return true;
		}

        public function get canBeCancelled():Boolean {
            return true;
        }

        public function MonstroAction(callback:Function) {
            _callback = callback;
        }

        final public function set field(value:MonstroField):void{
            _field = value;
        }

        final public function get field():MonstroField{
            return _field;
        }

        public function update():Boolean{
            return true;
        }

		public function resize():void {}

        public function get shouldSkipFrameAfterFinished():Boolean{
            return true;
        }

        public function dispose():void{
            _callback = null;
        }


		public function get callback():Function{
			return _callback;
		}

		public function toString():String {
            return getQualifiedClassName(this);
        }
    }
}
