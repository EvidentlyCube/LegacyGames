package net.retrocade.tacticengine.core{
    import net.retrocade.tacticengine.monstro.ingame.entities.MonstroEntity;

    public class Entity extends FieldObject{
        private var _tile:Tile;

        public function Entity(field:MonstroField){
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

        public function canMoveTo(dx:int, dy:int, entity:MonstroEntity):Boolean{
            return entity === this;
        }

        override public function dispose():void{
            tile = null;

            super.dispose();
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
                _tile.entity = this as MonstroEntity;

                _x = _tile.x;
                _y = _tile.y;
            }
        }


        override public function makeDump():Object {
            return super.makeDump();
        }

        override public function loadFromDump(dump:Object):void {
            super.loadFromDump(dump);
        }
    }
}