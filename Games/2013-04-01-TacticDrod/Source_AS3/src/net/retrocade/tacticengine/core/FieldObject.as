package net.retrocade.tacticengine.core{
    public class FieldObject implements IDestruct{
        private var _field:Field;
		
		protected var _x:int;
		protected var _y:int;
		
		public function get x():int{
			return _x;
		}
		
		public function get y():int{
			return _y;
		}
        
        public function get field():Field{
            return _field;
        }
        
        public function FieldObject(field:Field){
            _field = field;
            
            if (!field){
                throw new ArgumentError("Must pass a valid Field instance");
            }
        }

        public function destruct():void{
            _field = null;
        }
    }
}