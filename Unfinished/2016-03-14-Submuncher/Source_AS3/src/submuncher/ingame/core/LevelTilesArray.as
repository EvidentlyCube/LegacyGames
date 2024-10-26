package submuncher.ingame.core {
    public class LevelTilesArray {
        private var _tiles:Vector.<uint>;
        private var _levelWidth:uint;
        private var _levelHeight:uint;

        public function LevelTilesArray(levelWidth:uint, levelHeight:uint) {
            _levelWidth = levelWidth;
            _levelHeight = levelHeight;
            _tiles = new Vector.<uint>(_levelWidth * _levelHeight);

            for (var i:int = 0; i < _tiles.length; i++) {
                _tiles[i] = Tiles.EMPTY;
            }
        }

        public function setAll(value:uint):void {
            for (var i:int = 0; i < _tiles.length; i++) {
                _tiles[i] = value;
            }
        }

        public function setTile(x:uint, y:uint, value:uint):void {
            if (x >= _levelWidth || y >= _levelHeight){
                return;
            }

            _tiles[x + y *_levelWidth] = value;
        }

        public function resetTile(x:uint, y:uint):void {
            setTile(x, y, Tiles.EMPTY);
        }

        public function getTile(x:uint, y:uint):uint {
            if (x >= _levelWidth || y >= _levelHeight){
                return Tiles.EMPTY;
            }

            return _tiles[x + y *_levelWidth];
        }

        public function get originalArray():Vector.<uint> {
            return _tiles;
        }

        public function createArrayCopy():Vector.<uint> {
            return _tiles.concat();
        }

        public function dispose():void {
            _tiles = null;
        }
    }
}
