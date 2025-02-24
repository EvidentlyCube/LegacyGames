package net.retrocade.tacticengine.core{
    public class FieldObject implements IDisposable, IDumpable{
        private var _field:MonstroField;
		
		protected var _x:int;
		protected var _y:int;
		
		final public function get x():int{
			return _x;
		}

        final public function get y():int{
			return _y;
		}

        final public function get field():MonstroField{
            return _field;
        }
        
        public function FieldObject(field:MonstroField){
            _field = field;
            
            if (!field){
                throw new ArgumentError("Must pass a valid Field instance");
            }
        }

        public function dispose():void{
            _field = null;
        }

        public function makeDump():Object{
            var dump:Object = {};
            dump.x = _x;
            dump.y = _y;

            return dump;
        }

        public function loadFromDump(dump:Object):void{
            _x = dump.x;
            _y = dump.y;
        }
    }
}