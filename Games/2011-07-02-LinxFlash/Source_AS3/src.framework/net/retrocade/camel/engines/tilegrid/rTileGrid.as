package net.retrocade.camel.engines.tilegrid{
    import net.retrocade.camel.core.rCore;
    import net.retrocade.camel.core.retrocamel_int;
    
    use namespace retrocamel_int;

    public class rTileGrid {
        private var _width:uint;
        private var _height:uint;
        
        private var _tileWidth :uint;
        private var _tileHeight:uint;
        
        private var _array:Array = [];
        
        public function init(width:uint, height:uint):void{
            _width  = width;
            _height = height;
            
            _array = [];
        }
        
        public function rTileGrid(width:uint, height:uint, tileWidth:uint, tileHeight:uint) {
            _width  = width;
            _height = height;
            _tileWidth = tileWidth;
            _tileHeight = tileHeight;
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
    }
}