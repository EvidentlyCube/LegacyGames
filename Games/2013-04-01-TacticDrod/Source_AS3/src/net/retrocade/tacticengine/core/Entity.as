package net.retrocade.tacticengine.core{
    public class Entity extends FieldObject{
        private var _tile:Tile;
		
        private var _virtualProperties:Array = [];
        
        public function Entity(field:Field){
            super(field);
        }
		
		public function move(x:int, y:int):Boolean{
			var tile:Tile = field.getTileAt(x, y);
			
			if (!tile || tile.entity){
				return false;
			}
			
			_x = x;
			_y = y;
			
			this.tile = tile;
			
			return true;
		}

        public function get(name:String):*{
            if (hasOwnProperty(name)){
                return this[name]
            } else {
                return _virtualProperties[name];
            }
        }
        
        public function set(name:String, value:*):void{
            if (hasOwnProperty(name)){
                this[name] = value;
            } else {
                _virtualProperties[name] = value;
            }
        }
        
        public function canMoveTo(dx:int, dy:int, entity:Entity):Boolean{
            return entity === this;
        }

        override public function destruct():void{
            tile = null;

            super.destruct();
        }

        public function get tile():Tile {
            return _tile;
        }

        public function set tile(value:Tile):void {
            if (_tile){
                _tile.entity = null;
            }

            _tile = value;

            if (_tile){
                _tile.entity = this;

                _x = _tile.x;
                _y = _tile.y;
            }
        }
    }
}