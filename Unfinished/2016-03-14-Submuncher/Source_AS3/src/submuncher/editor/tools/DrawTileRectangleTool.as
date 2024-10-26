package submuncher.editor.tools {
    import net.retrocade.functions.printf;
    import net.retrocade.retrocamel.display.layers.RetrocamelLayerStarling;

    import starling.display.Quad;

    import submuncher.editor.core.Editor;
    import submuncher.editor.core.EditorTile;
    import submuncher.editor.core.EditorTilesArray;

    public class DrawTileRectangleTool extends DrawTileBaseTool {
        private static const NW:int = 0;
        private static const N:int = 1;
        private static const NE:int = 2;
        private static const W:int = 3;
        private static const E:int = 4;
        private static const SW:int = 5;
        private static const S:int = 6;
        private static const SE:int = 7;

        private var _drawAreaPreview:Quad;
        private var _startX:int;
        private var _startY:int;
        private var _isDrawing:Boolean;

        public function DrawTileRectangleTool(tile:int, drawTileArray:EditorTilesArray, extEditor:Editor, extToolLayer:RetrocamelLayerStarling, tileFeedFunction:Function) {
            super(tile, drawTileArray, extEditor, extToolLayer, tileFeedFunction);

            _drawAreaPreview = new Quad(16, 16);
            extToolLayer.add(_drawAreaPreview);
            _drawAreaPreview.alpha = 0.5;
            _drawAreaPreview.visible = false;

            _isDrawing = false;
        }

        override public function dispose():void {
            toolLayer.remove(_drawAreaPreview);
            _drawAreaPreview.dispose();
            _drawAreaPreview = null;

            super.dispose();
        }

        override protected function updateMouseDown():void {
            if (!_isDrawing){
                _isDrawing = true;
                _startX = mouseX;
                _startY = mouseY;
            }

            _drawAreaPreview.visible = true;
            _drawAreaPreview.x = drawLeft * 16;
            _drawAreaPreview.y = drawTop * 16;
            _drawAreaPreview.width = (drawRight - drawLeft + 1) * 16;
            _drawAreaPreview.height = (drawBottom - drawTop + 1) * 16;
        }

        override protected function updateNothingDown():void {
            if (_isDrawing){
                _isDrawing = false;
                draw();
            }
            _drawAreaPreview.visible = false;
        }

        private function draw():void {
            var tile:EditorTile;
            var x:int;
            var y:int;
            var fromX:int = drawLeft;
            var fromY:int = drawTop;
            var toX:int = drawRight;
            var toY:int = drawBottom;

            for (x = fromX; x <= toX; x++){
                for (y = fromY; y <= toY; y++){
                    tile = tileArray.getTile(x, y);
                    tile.draw(drawTile);

                    if (x > fromX){
                        tile.setConnect(W, true);
                    }
                    if (x < toX){
                        tile.setConnect(E, true);
                    }
                    if (y > fromY){
                        tile.setConnect(N, true);
                    }
                    if (y < toY){
                        tile.setConnect(S, true);
                    }
                    if (x > fromX && y > fromY){
                        tile.setConnect(NW, true);
                    }
                    if (x < toX && y > fromY){
                        tile.setConnect(NE, true);
                    }
                    if (x > fromX && y < toY){
                        tile.setConnect(SW, true);
                    }
                    if (x < toX && y < toY){
                        tile.setConnect(SE, true);
                    }

                    editor.refreshTile(x, y);
                }
            }
        }

        override public function get name():String {
            return printf("Paint rect, %%", tileArray.name);
        }

        public function get drawLeft():int {
            return Math.max(0, Math.min(_startX, mouseX));
        }

        public function get drawTop():int {
            return Math.max(0, Math.min(_startY, mouseY));
        }

        public function get drawRight():int {
            return Math.min(editor.editorLevel.tileWidth - 1, Math.max(_startX, mouseX));
        }

        public function get drawBottom():int {
            return Math.min(editor.editorLevel.tileHeight - 1, Math.max(_startY, mouseY));
        }
    }
}
