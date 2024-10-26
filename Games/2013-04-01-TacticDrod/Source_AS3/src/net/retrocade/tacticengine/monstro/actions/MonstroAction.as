/**
 * Created with IntelliJ IDEA.
 * User: Ryc
 * Date: 13.01.13
 * Time: 10:00
 * To change this template use File | Settings | File Templates.
 */
package net.retrocade.tacticengine.monstro.actions {
    import net.retrocade.tacticengine.core.Field;

    public class MonstroAction implements IMonstroAction{
        private var _callback:Function;
        private var _field:Field;

        public function MonstroAction(callback:Function) {
            _callback = callback;
        }

        final public function set field(value:Field):void{
            _field = value;
        }

        final public function get field():Field{
            return _field;
        }

        public function update():Boolean{
            return true;
        }

        public function get isStoppingAction():Boolean{
            return true;
        }

        public function destruct():void{
            if (_callback != null){
                if (_callback.length == 0){
                    _callback();
                } else {
                    _callback(this);
                }
            }

            _callback = null;
        }
    }
}
