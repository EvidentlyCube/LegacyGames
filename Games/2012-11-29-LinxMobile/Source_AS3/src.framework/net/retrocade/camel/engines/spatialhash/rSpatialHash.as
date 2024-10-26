package net.retrocade.camel.engines.spatialhash{
    import flash.utils.Dictionary;
    
    import net.retrocade.camel.global.rCore;
    import net.retrocade.camel.global.retrocamel_int;

    use namespace retrocamel_int;
    
    public class rSpatialHash{
        private var _cellSize   :Number = 0;
        private var _maxBuckets :uint   = 0;
        private var _timeStamp  :uint   = 1;
        
        private var _dict:Dictionary = new Dictionary(true);
        
        private var _cx1:Number;
        private var _cx2:Number;
        private var _cy1:Number;
        private var _cy2:Number;
        
        public function rSpatialHash(cellSize:Number, maxBuckets:uint){
            _cellSize   = cellSize;
            _maxBuckets = maxBuckets;
        }
        
        public function clear():void{
            for(var key:* in _dict){
                delete _dict[key];
            }
        }
        
        public function add(shv:rIHashItem):void{
            const cx1:int = shv.hashLeft   / _cellSize | 0;
            const cy1:int = shv.hashTop    / _cellSize | 0;
            const cx2:int = shv.hashRight  / _cellSize | 0;
            const cy2:int = shv.hashBottom / _cellSize | 0;
            
            for (var cy:int = cy1; cy <= cy2; ++cy)
                for (var cx:int = cx1; cx <= cx2; ++cx)
                    _addToBucket(shv, cx, cy);
        }
        
        public function remove(shv:rIHashItem):void{
            const cx1:int = shv.hashLeft   / _cellSize | 0;
            const cy1:int = shv.hashTop    / _cellSize | 0;
            const cx2:int = shv.hashRight  / _cellSize | 0;
            const cy2:int = shv.hashBottom / _cellSize | 0;
            
            for (var cy:int = cy1; cy <= cy2; ++cy)
                for (var cx:int = cx1; cx <= cx2; ++cx)
                    _removeFromBucket(shv, cx, cy);
        }
        
        public function removeFromAll(shv:rIHashItem):void{
            for each(var i:Array in _dict){
                _removeFromBucketGiven(shv, i);
            }
        }
        
        public function move(shv:rIHashItem, x:int, y:int):void{
            const cx1   :int =  shv.hashLeft        / _cellSize | 0;
            const cy1   :int =  shv.hashTop         / _cellSize | 0;
            const cx2   :int =  shv.hashRight       / _cellSize | 0;
            const cy2   :int =  shv.hashBottom      / _cellSize | 0;
            const newcx1:int = (shv.hashLeft   + x) / _cellSize | 0;
            const newcy1:int = (shv.hashTop    + y) / _cellSize | 0;
            const newcx2:int = (shv.hashRight  + x) / _cellSize | 0;
            const newcy2:int = (shv.hashBottom + y) / _cellSize | 0;
            
            // add new
            for (var cy:int = newcy1; cy <= newcy2; ++cy)
                for (var cx:int = newcx1; cx <= newcx2; ++cx)
                    if (cx < cx1 || cx > cx2 || cy < cy1 || cy > cy2)
                        _addToBucket(shv, cx, cy);
            
            // remove old
            for (cy = cy1; cy <= cy2; ++cy)
                for (cx = cx1; cx <= cx2; ++cx)
                    if (cx < newcx1 || cx > newcx2 || cy < newcy1 || cy > newcy2)
                        _removeFromBucket(shv, cx, cy);
        }
        
        public function getOverlapping(shv:rIHashItem):Array{
            const result:Array = new Array();
            
            const cx1   :int =  shv.hashLeft        / _cellSize | 0;
            const cy1   :int =  shv.hashTop         / _cellSize | 0;
            const cx2   :int =  shv.hashRight       / _cellSize | 0;
            const cy2   :int =  shv.hashBottom      / _cellSize | 0;
            
            var count:uint = 0;
            
            var bucket:Array;
            
            for (var cy:int = cy1; cy <= cy2; ++cy){
                for (var cx:int = cx1; cx <= cx2; ++cx){
                    bucket = _dict[_getKey(cx, cy)];
                    if (bucket == null) continue;
                    
                    for each (var b:rIHashItem in bucket){
                        /*if (cx1 <= (b.hashLeft   / _cellSize | 0) &&
                            cx2 >= (b.hashRight  / _cellSize | 0) &&
                            cy1 <= (b.hashTop    / _cellSize | 0) &&
                            cy2 >= (b.hashBottom / _cellSize | 0))*/
                            result[count++] = b;
                    }
                }
            }

            return result;
        }
        
        public function getOverlappingRect(x:int, y:int, width:int, height:int):Array{
            const result:Array = new Array();
            
            const cx1   :int =  x            / _cellSize | 0;
            const cy1   :int =  y            / _cellSize | 0;
            const cx2   :int =  (x + width)  / _cellSize | 0;
            const cy2   :int =  (y + height) / _cellSize | 0;
            
            var count:uint = 0;
            
            var bucket:Array;
            
            for (var cy:int = cy1; cy <= cy2; ++cy){
                for (var cx:int = cx1; cx <= cx2; ++cx){
                    bucket = _dict[_getKey(cx, cy)];
                    if (bucket == null) continue;
                    
                    for each (var b:rIHashItem in bucket){
                        result[count++] = b;
                    }
                }
            }
            
            return result;
        }
        
        private function _addToBucket(shv:rIHashItem, cx:int, cy:int):void{
            const key:uint = _getKey(cx, cy);
            var bucket:Array = _dict[key];
            if (bucket == null){
                _dict[key] = [ shv ]
                return;
            }
            
            bucket[bucket.length] = shv;
        }
        
        private function _removeFromBucket(shv:rIHashItem, cx:int, cy:int):void{
            const key:uint     = _getKey(cx, cy);
            const bucket:Array = _dict[key];
            
            if (bucket == null) return;
            
            const size:int = bucket.length;
            for (var i:int = 0; i < size; ++i){
                const hashValue:rIHashItem = bucket[i];
                if (hashValue != shv) continue;
                if (i == size - 1)
                    --bucket.length;
                else
                    bucket[i] = bucket.pop();
                break;
            }
            
            if (bucket.length == 0)
                delete _dict[key];
        }
        
        private function _removeFromBucketGiven(shv:rIHashItem, bucket:Array):void{
            if (bucket == null) return;
            
            const size:int = bucket.length;
            for (var i:int = 0; i < size; ++i){
                const hashValue:rIHashItem = bucket[i];
                if (hashValue != shv) continue;
                if (i == size - 1)
                    --bucket.length;
                else
                    bucket[i] = bucket.pop();
                break;
            }
        }
        
        private function _getKey(cx:int, cy:int):uint{
            // prime numbers from http://code.google.com/p/chipmunk-physics/source/browse/trunk/src/cpSpaceHash.c
            return (cx * 1640531513 ^ cy * 2654435789) % _maxBuckets;
        }
    }
}