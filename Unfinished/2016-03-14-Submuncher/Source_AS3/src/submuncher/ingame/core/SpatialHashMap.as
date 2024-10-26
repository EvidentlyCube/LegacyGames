package submuncher.ingame.core {
    import flash.utils.Dictionary;

    import submuncher.ingame.gameObjects.GameObject;

    public class SpatialHashMap {
        private var _cellSize:Number;
        private var _maxBuckets:uint;
        private var _levelWidth:uint;

        private var _dict:Dictionary;

        public function SpatialHashMap(cellSize:Number, maxBuckets:uint, levelWidth:uint) {
            _dict = new Dictionary(true);
            _cellSize = cellSize;
            _maxBuckets = maxBuckets;
            _levelWidth = levelWidth;
        }

        public function clear():void {
            for (var key:* in _dict) {
                delete _dict[key];
            }
        }

        public function addSingle(gameObject:GameObject):void {
            _addToBucket(gameObject, gameObject.x / _cellSize, gameObject.y / _cellSize);
        }

        public function addSingleAt(gameObject:GameObject, x:uint, y:uint):void {
            _addToBucket(gameObject, x / _cellSize, y / _cellSize);
        }

        public function removeSingle(gameObject:GameObject):void {
            _removeFromBucket(gameObject, gameObject.x / _cellSize, gameObject.y / _cellSize);
        }

        public function removeSingleAt(gameObject:GameObject, x:uint, y:uint):void {
            _removeFromBucket(gameObject, x / _cellSize, y / _cellSize);
        }

        public function addMultiTile(gameObject:GameObject):void {
            const cx1:int = gameObject.x / _cellSize | 0;
            const cy1:int = gameObject.y / _cellSize | 0;
            const cx2:int = gameObject.right / _cellSize | 0;
            const cy2:int = gameObject.bottom / _cellSize | 0;

            for (var cy:int = cy1; cy < cy2; ++cy) {
                for (var cx:int = cx1; cx < cx2; ++cx) {
                    _addToBucket(gameObject, cx, cy);
                }
            }
        }

        public function removeMultiTileAt(gameObject:GameObject, x:int, y:int):void {
            const cx1:int = x / _cellSize | 0;
            const cy1:int = x / _cellSize | 0;
            const cx2:int = (x + gameObject.width) / _cellSize | 0;
            const cy2:int = (y + gameObject.height) / _cellSize | 0;

            for (var cy:int = cy1; cy < cy2; ++cy) {
                for (var cx:int = cx1; cx < cx2; ++cx) {
                    _removeFromBucket(gameObject, cx, cy);
                }
            }
        }

        public function removeMultiTile(gameObject:GameObject):void {
            const cx1:int = gameObject.x / _cellSize | 0;
            const cy1:int = gameObject.y / _cellSize | 0;
            const cx2:int = gameObject.right / _cellSize | 0;
            const cy2:int = gameObject.bottom / _cellSize | 0;

            for (var cy:int = cy1; cy < cy2; ++cy) {
                for (var cx:int = cx1; cx < cx2; ++cx) {
                    _removeFromBucket(gameObject, cx, cy);
                }
            }
        }

        public function getAllAt(x:int, y:int):Vector.<GameObject> {
            const result:Vector.<GameObject> = new Vector.<GameObject>();

            var bucket:Array = _dict[_getKey(x / _cellSize, y / _cellSize)];
            if (bucket != null) {
                for each (var gameObject:GameObject in bucket) {
                    result.push(gameObject);
                }
            }

            return result;
        }

        public function getAllAtStrict(x:int, y:int):Vector.<GameObject> {
            const result:Vector.<GameObject> = new Vector.<GameObject>();

            var bucket:Array = _dict[_getKey(x / _cellSize, y / _cellSize)];
            if (bucket != null) {
                for each (var gameObject:GameObject in bucket) {
                    if (gameObject.x === x && gameObject.y === y) {
                        result.push(gameObject);
                    }
                }
            }

            return result;
        }


        public function getAllAtRectangle(x:int, y:int, width:int, height:int):Vector.<GameObject> {
            const result:Vector.<GameObject> = new Vector.<GameObject>();

            const cx1:int = x / _cellSize | 0;
            const cy1:int = y / _cellSize | 0;
            const cx2:int = (x + width - 1) / _cellSize | 0;
            const cy2:int = (y + height - 1) / _cellSize | 0;

            var bucket:Array;

            for (var cy:int = cy1; cy <= cy2; ++cy) {
                for (var cx:int = cx1; cx <= cx2; ++cx) {
                    bucket = _dict[_getKey(cx, cy)];
                    if (bucket == null) {
                        continue;
                    }

                    for each (var gameObject:GameObject in bucket) {
                        result.push(gameObject);
                    }
                }
            }
            return result;
        }

        private function _addToBucket(gameObject:GameObject, cx:int, cy:int):void {
            const key:uint = _getKey(cx, cy);

            var bucket:Array = _dict[key];
            if (bucket == null) {
                _dict[key] = [ gameObject ];
            } else {
                bucket[bucket.length] = gameObject;
            }
        }

        private function _removeFromBucket(gameObject:GameObject, cx:int, cy:int):void {
            const key:uint = _getKey(cx, cy);
            const bucket:Array = _dict[key];

            if (bucket == null) {
                return;
            }

            const size:int = bucket.length;
            for (var i:int = 0; i < size; ++i) {
                const hashValue:GameObject = bucket[i];
                if (hashValue != gameObject) {
                    continue;
                }
                if (i == size - 1) {
                    --bucket.length;
                } else {
                    bucket[i] = bucket.pop();
                }
                break;
            }

            if (bucket.length == 0) {
                delete _dict[key];
            }
        }

        private function _getKey(cx:int, cy:int):uint {
            return cx + cy * _levelWidth % _maxBuckets;
        }

        public function dispose():void {
            _dict = null;
        }
    }
}
