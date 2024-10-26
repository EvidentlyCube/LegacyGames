package submuncher.editor.tools {
    import net.retrocade.functions.printf;
    import net.retrocade.retrocamel.display.layers.RetrocamelLayerStarling;

    import submuncher.editor.core.Editor;
    import submuncher.editor.core.EditorTile;
    import submuncher.editor.core.EditorTilesArray;

    public class DrawTileTool extends DrawTileBaseTool {
        public function DrawTileTool(tile:int, drawTileArray:EditorTilesArray, extEditor:Editor, extToolLayer:RetrocamelLayerStarling, tileFeedFunction:Function) {
            super(tile, drawTileArray, extEditor, extToolLayer, tileFeedFunction);
        }

        override protected function updateMouseDown():void {
            var tile:EditorTile = tileArray.getTile(mouseX, mouseY);
            tile.drawAndConnect(drawTile);
            editor.refreshTile(mouseX, mouseY);

            connectTilesAround(mouseX, mouseY);
            refreshTilesAround();
        }

        private function refreshTilesAround():void {
            for (var i:int = -1; i <= 1; i++) {
                for (var j:int = -1; j <= 1; j++) {
                    var x:int = mouseX + i;
                    var y:int = mouseY + j;

                    if (x < 0 || y < 0 || x >= editor.editorLevel.tileWidth || y >= editor.editorLevel.tileHeight) {
                        continue;
                    } else if (i === 0 && j === 0) {
                        continue;
                    }

                    editor.refreshTile(x, y);
                }
            }
        }

        override public function get name():String {
            return printf("Paint group, %%", tileArray.name);
        }
    }
}
