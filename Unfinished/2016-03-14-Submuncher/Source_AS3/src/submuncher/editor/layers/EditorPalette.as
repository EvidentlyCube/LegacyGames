package submuncher.editor.layers {
    import submuncher.editor.core.*;
    import net.retrocade.constants.KeyConst;
    import net.retrocade.retrocamel.core.RetrocamelInputManager;
    import net.retrocade.retrocamel.display.layers.RetrocamelLayerStarling;

    import starling.display.Image;

    import submuncher.core.constants.Gfx;

    public class EditorPalette extends RetrocamelLayerStarling{
        private static const OFFSET_X:int = 5;
        private static const OFFSET_Y:int = 15;
        private var _extEditor:Editor;
        private var _images:Vector.<Image>;

        private var _totalTiles:int;
        private var _tilesetEdge:int;
        private var _imageFeedFunction:Function;

        private var _selectedTileIndex:int;

        public function EditorPalette(editor:Editor) {
            _extEditor = editor;
            _images = new Vector.<Image>(9, true);
            _selectedTileIndex = 0;

            for(var i:int = 0; i < 9; i++){
                var image:Image = new Image(Gfx.getEditorBaseForegroundTile(0));
                image.x = (i % 3) * S.tileEdge + OFFSET_X;
                image.y = (i / 3 | 0) * S.tileEdge + OFFSET_Y;
                add(image);
                _images[i] = image;

                if (i !== 4){
                    image.alpha = 0.6;
                }
            }
        }

        public function setTileset(imageFeedFunction:Function, tilesetEdge:int = 16):void {
            _tilesetEdge = tilesetEdge;
            _totalTiles = tilesetEdge * tilesetEdge;
            _imageFeedFunction = imageFeedFunction;

            refreshImages();
        }

        public function update():void {
            if (RetrocamelInputManager.isCtrlDown){
                return;
            }

            var x:int = selectedTileX;
            var y:int = selectedTileY;
            var wasChanged:Boolean = false;

            if (RetrocamelInputManager.isKeyHit(KeyConst.A)){
                x--;
                wasChanged = true;
            }
            if (RetrocamelInputManager.isKeyHit(KeyConst.D)){
                x++;
                wasChanged = true;
            }
            if (RetrocamelInputManager.isKeyHit(KeyConst.W)){
                y--;
                wasChanged = true;
            }
            if (RetrocamelInputManager.isKeyHit(KeyConst.S)){
                y++;
                wasChanged = true;
            }

            if (!wasChanged){
                return;
            }

            if (x < 0){
                x += _tilesetEdge;
            } else if (x >= _tilesetEdge){
                x -= _tilesetEdge;
            }

            if (y < 0){
                y += _tilesetEdge;
            } else if (y >= _tilesetEdge){
                y -= _tilesetEdge;
            }

            _selectedTileIndex = x + y * _tilesetEdge;
            _extEditor.tool.index = _selectedTileIndex;
            refreshImages();
        }

        private function refreshImages():void {
            for (var dx:int = -1; dx <= 1; dx++){
                for (var dy:int = -1; dy <= 1; dy++){
                    var x:int = wrapCoordinate(selectedTileX + dx);
                    var y:int = wrapCoordinate(selectedTileY + dy);

                    _images[dx + 1 + (dy + 1) * 3].texture = _imageFeedFunction(x + y * _tilesetEdge);
                }
            }
        }

        private function wrapCoordinate(coord:int):int{
            while (coord < 0){
                coord += _tilesetEdge;
            }
            while (coord >= _tilesetEdge){
                coord -= _tilesetEdge;
            }

            return coord;
        }

        private function get selectedTileX():int{
            return _selectedTileIndex % _tilesetEdge;
        }

        private function get selectedTileY():int{
            return _selectedTileIndex / _tilesetEdge | 0;
        }
    }
}
