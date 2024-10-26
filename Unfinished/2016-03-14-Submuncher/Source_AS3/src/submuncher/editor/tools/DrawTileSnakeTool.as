package submuncher.editor.tools {
    import net.retrocade.functions.printf;
    import net.retrocade.retrocamel.display.layers.RetrocamelLayerStarling;

    import submuncher.editor.core.Editor;
    import submuncher.editor.core.EditorTile;
    import submuncher.editor.core.EditorTilesArray;

    public class DrawTileSnakeTool extends DrawTileBaseTool {
        private var _lastTileX:int;
        private var _lastTileY:int;

        public function DrawTileSnakeTool(tile:int, drawTileArray:EditorTilesArray, extEditor:Editor, extToolLayer:RetrocamelLayerStarling, tileFeedFunction:Function) {
            super(tile, drawTileArray, extEditor, extToolLayer, tileFeedFunction);
        }


        override protected function updateMouseDown():void {
            var tile:EditorTile = tileArray.getTile(mouseX, mouseY);

            if (!tile){
                return;
            }

            tile.drawAndConnectTo(drawTile, _lastTileX, _lastTileY);
            editor.refreshTile(mouseX, mouseY);

            cutTilesAround(mouseX, mouseY);

            tile = tileArray.getTile(_lastTileX, _lastTileY);
            if (tile){
                tile.connectTo(mouseX, mouseY);
                editor.refreshTile(_lastTileX, _lastTileY);
            }

            _lastTileX = mouseX;
            _lastTileY = mouseY;
        }

        override protected function updateNothingDown():void {
            _lastTileX = -1;
            _lastTileY = -1;
        }

        override public function get name():String {
            return printf("Paint separate, %%", tileArray.name);
        }
    }
}
