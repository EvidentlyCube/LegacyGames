package submuncher.editor.tools {
    import net.retrocade.functions.printf;
    import net.retrocade.retrocamel.display.layers.RetrocamelLayerStarling;

    import starling.display.Image;

    import submuncher.core.constants.Gfx;
    import submuncher.editor.core.Editor;
    import submuncher.editor.core.EditorTile;
    import submuncher.editor.core.EditorTilesArray;

    public class DrawTileBaseTool extends BaseTool {
        private var _drawTile:int;
        private var _tileImage:Image;
        private var _extTileArray:EditorTilesArray;
        private var _tileFeedFunction:Function;

        public function DrawTileBaseTool(tile:int, drawTileArray:EditorTilesArray, extEditor:Editor, extToolLayer:RetrocamelLayerStarling, tileFeedFunction:Function) {
            super(extEditor, extToolLayer);

            _tileFeedFunction = tileFeedFunction;
            _extTileArray = drawTileArray;
            _tileImage = new Image(_tileFeedFunction(0));

            addChild(_tileImage);

            drawTile = tile;
            alpha = 0.4;
        }

        override public function dispose():void {
            _tileImage.dispose();
            _tileImage = null;
            _extTileArray = null;

            super.dispose();
        }

        public function set tileFeedFunction(value:Function):void {
            _tileFeedFunction = value;
            drawTile = _drawTile;
        }

        public function set drawTile(value:int):void {
            _drawTile = value;
            _tileImage.texture = _tileFeedFunction(_drawTile);
        }

        override public function update():void {
            super.update();

            if (isMouseDown){
                updateMouseDown();
            } else if (isRightMouseDown){
                updateMouseRightDown();
            } else {
                updateNothingDown();
            }
        }

        protected function updateMouseDown():void{

        }

        protected function updateMouseRightDown():void{
            var tile:EditorTile = tileArray.getTile(mouseX, mouseY);
            tile.drawAndCut(0);
            editor.refreshTile(mouseX, mouseY);

            cutTilesAround(mouseX, mouseY);
        }

        protected function updateNothingDown():void{

        }

        protected function cutTilesAround(tileX:int, tileY:int):void{
            for (var dx:int = -1; dx <= 1; dx++) {
                for (var dy:int = -1; dy <= 1; dy++) {
                    var x:int = tileX + dx;
                    var y:int = tileY + dy;
                    var tile:EditorTile = _extTileArray.getTile(x, y);
                    if (tile){
                        tile.cutConnections();
                        editor.refreshTile(x, y);
                    }
                }
            }
        }

        protected function connectTilesAround(tileX:int, tileY:int):void {
            for (var i:int = -1; i <= 1; i++) {
                for (var j:int = -1; j <= 1; j++) {
                    var x:int = tileX + i;
                    var y:int = tileY + j;

                    if (x < 0 || y < 0 || x >= editor.editorLevel.tileWidth || y >= editor.editorLevel.tileHeight) {
                        continue;
                    } else if (i === 0 && j === 0) {
                        continue;
                    }

                    var tile:EditorTile = tileArray.getTile(x, y);
                    tile.connectToIfSame(x - i, y - j);
                    tile.connectToIfSame(x - i, y);
                    tile.connectToIfSame(x, y - j);

                    if (i === 0) {
                        tile.connectToIfSame(x - 1, y);
                        tile.connectToIfSame(x + 1, y);
                        tile.connectToIfSame(x - 1, y - j);
                        tile.connectToIfSame(x + 1, y - j);
                    }

                    if (j === 0) {
                        tile.connectToIfSame(x, y - 1);
                        tile.connectToIfSame(x, y + 1);
                        tile.connectToIfSame(x - i, y - 1);
                        tile.connectToIfSame(x - i, y + 1);
                    }

                    editor.refreshTile(x, y);
                }
            }
        }

        override public function get name():String {
            return printf("Paint group, %%", _extTileArray.name);
        }

        override public function set index(index:int):void {
            drawTile = index;
        }

        override public function get index():int {
            return drawTile;
        }

        public function get tileArray():EditorTilesArray {
            return _extTileArray;
        }

        public function set tileArray(value:EditorTilesArray):void {
            _extTileArray = value;
        }

        public function get drawTile():int {
            return _drawTile;
        }
    }
}
