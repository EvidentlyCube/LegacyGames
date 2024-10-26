package net.retrocade.camel.engines.stackgrid{
    import net.retrocade.camel.global.rCore;
    import net.retrocade.camel.global.retrocamel_int;

    use namespace retrocamel_int
    public class rStackGrid{
        private var _tileWidth :uint;
        private var _tileHeight:uint;
        
        private var _width:uint;
        private var _height:uint;
        
        private var _array:Array;
        
        public function rStackGrid(tileWidth:uint, tileHeight:uint){
            _tileWidth = tileWidth;
            _tileHeight = tileHeight;
        }
        
        public function init(width:uint, height:uint):void{
            _width  = width;
            _height = height;
            
            _array = [];
        }
        
        public function add(item:*, cx:int, cy:int):void{
            const key:uint = (cx / _tileWidth  | 0) + 
                (cy / _tileHeight | 0) * _width;
            var bucket:Array = _array[key];
            if (bucket == null){
                _array[key] = [ item ]
                return;
            }
            
            bucket[bucket.length] = item;
        }
        
        public function remove(item:*, cx:int, cy:int):void{
            const key:uint     = (cx / _tileWidth  | 0) + 
                                 (cy / _tileHeight | 0) * _width;
            const bucket:Array = _array[key];
            
            if (bucket == null) return;
            
            const size:int = bucket.length;
            for (var i:int = 0; i < size; ++i){
                if (bucket[i] != item) continue;
                
                if (i != size - 1)
                    bucket[i] = bucket[size - 1];
                
                bucket.length--;
                
                break;
            }
        }
        
        public function get(cx:int, cy:int):Array{
            return _array[(cx / _tileWidth  | 0) + 
                          (cy / _tileHeight | 0) * _width];
        }
        
        public function contains(item:*, cx:int, cy:int):Boolean{
            return _array[(cx / _tileWidth  | 0) + 
                          (cy / _tileHeight | 0) * _width]
                          .indexOf(item) != -1;
        }
    }
}