package submuncher.editor.core {
    public class EditorTilesArray {
        private var _tiles:Vector.<EditorTile>;
        private var _levelWidth:uint;
        private var _levelHeight:uint;
        private var _name:String;

        public function EditorTilesArray(name:String, levelWidth:uint, levelHeight:uint, editedLevel:EditorLevel, relatedLayer:EditorTilesArray, isVariation:Boolean) {
            _name = name;
            _levelWidth = levelWidth;
            _levelHeight = levelHeight;
            _tiles = new Vector.<EditorTile>(_levelWidth * _levelHeight);

            for (var x:int = 0; x < _levelWidth; x++){
                for (var y:int = 0; y < _levelHeight; y++) {
                    _tiles[x + y * _levelWidth] = new EditorTile(x, y, editedLevel, this, relatedLayer, isVariation);
                }
            }
        }

        public function getTile(x:uint, y:uint):EditorTile {
            if (x >= _levelWidth || y >= _levelHeight){
                return null;
            }

            return _tiles[x + y *_levelWidth];
        }

        public function dispose():void {
            _tiles = null;
        }

        public function get name():String {
            return _name;
        }
    }
}
