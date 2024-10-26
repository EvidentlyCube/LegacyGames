package net.retrocade.camel.engines.tilegrid{
    import net.retrocade.camel.global.rCore;
    import net.retrocade.camel.global.retrocamel_int;
    
    use namespace retrocamel_int;

    public class rTileGrid {
        private var _width:uint;
        private var _height:uint;
        
        private var _tileWidth :uint;
        private var _tileHeight:uint;
        
        private var _array:Array = [];
		
		private var _populateClass:Class;
        
        public function init(width:uint, height:uint, populate:Class = null):void{
            _width  = width;
            _height = height;
            
			_populateClass = populate;
			
            _array = [];
			
			if (_populateClass){
				var l:uint = _width * _height;
				for (var i:uint = 0; i < l; i++){
					_array[i] = new this._populateClass;
				}
			}
        }
        
        public function rTileGrid(width:uint, height:uint, tileWidth:uint, tileHeight:uint, populate:Class = null) {
            _tileWidth = tileWidth;
            _tileHeight = tileHeight;
			
			init(width, height, populate);
        }
        
        public function clear():void{
            _array.splice(0);
        }
        
        public function getArray():Array{
            return _array;
        }
        
        public function set(x:Number, y:Number, item:*):void{
            x = x / _tileWidth  | 0;
            y = y / _tileHeight | 0;
            
            if (x < 0 || y < 0 || x >= _width || y >= _height)
                return;
            
            _array[x + y * _width] = item;
        }
        
        public function get(x:Number, y:Number):*{
            x = x / _tileWidth  | 0;
            y = y / _tileHeight | 0;
            
            if (x < 0 || y < 0 || x >= _width || y >= _height)
                return null;
            
            return _array[x + y * _width];
        }
        
        public function setTile(x:Number, y:Number, item:*):void{
            if (x < 0 || y < 0 || x >= _width || y >= _height)
                return;
            
            _array[x + y * _width] = item;
        }
        
        public function getTile(x:Number, y:Number):*{
            if (x < 0 || y < 0 || x >= _width || y >= _height){
                return null;
            }
            
            return _array[x + y * _width];
        }
    }
}