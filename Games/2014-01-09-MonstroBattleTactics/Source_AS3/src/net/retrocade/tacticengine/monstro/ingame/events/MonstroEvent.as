
package net.retrocade.tacticengine.monstro.ingame.events {
    import net.retrocade.tacticengine.core.Eventer;
    import net.retrocade.tacticengine.core.IEvent;

    public class MonstroEvent implements IEvent{
        private var _isPropagationStopped:Boolean = false;
        private var _isDefaultPrevented:Boolean = false;

        final public function get isPropagationStopped():Boolean{
            return _isPropagationStopped;
        }

        final public function get isDefaultPrevented():Boolean{
            return _isDefaultPrevented;
        }

        public function MonstroEvent(){}

        final public function preventDefault():void{
            _isDefaultPrevented = true;
        }

        final public function stopPropagation():void{
            _isPropagationStopped = true;
        }

        final public function dispatch(name:String):void{
            Eventer.dispatch(name, this);
        }

        public function dispose():void{

        }
    }
}
