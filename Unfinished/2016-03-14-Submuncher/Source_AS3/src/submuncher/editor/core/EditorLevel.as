package submuncher.editor.core {
    import submuncher.ingame.core.Level;

    public class EditorLevel {
        private var _tileWidth:int;
        private var _tileHeight:int;
        private var _extLevel:Level;

        private var _foregroundLayer:EditorTilesArray;
        private var _foregroundVariantLayer:EditorTilesArray;

        public function EditorLevel(level:Level) {
            _extLevel = level;
            _tileWidth = level.tileWidth;
            _tileHeight = level.tileHeight;

            _foregroundLayer = new EditorTilesArray("FG", level.tileWidth, level.tileHeight, this, null, false);
            _foregroundVariantLayer = new EditorTilesArray("FG (variant)", level.tileWidth, level.tileHeight, this, _foregroundLayer, true);
        }

        public function get tileWidth():int {
            return _tileWidth;
        }

        public function get tileHeight():int {
            return _tileHeight;
        }

        public function get foregroundLayer():EditorTilesArray {
            return _foregroundLayer;
        }

        public function get foregroundVariantLayer():EditorTilesArray {
            return _foregroundVariantLayer;
        }
    }
}
