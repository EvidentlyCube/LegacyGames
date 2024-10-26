package submuncher.editor.core {
    import net.retrocade.constants.KeyConst;
    import net.retrocade.retrocamel.core.RetrocamelInputManager;
    import net.retrocade.retrocamel.display.layers.RetrocamelLayerStarling;
    import net.retrocade.utils.UtilsNumber;

    import submuncher.core.constants.Gfx;

    import submuncher.editor.tools.BaseTool;
    import submuncher.editor.tools.DrawTileBaseTool;
    import submuncher.editor.tools.DrawTileRectangleTool;
    import submuncher.editor.tools.DrawTileSnakeTool;
    import submuncher.editor.tools.DrawTileTool;

    public class EditorController {
        private var _extEditor:Editor;
        private var _mouseGrabX:Number;
        private var _mouseGrabY:Number;

        private var _currentToolIndex:int;
        private var _tools:Vector.<BaseTool>;

        public function EditorController(extEditor:Editor, toolLayer:RetrocamelLayerStarling) {
            _extEditor = extEditor;
            _currentToolIndex = -1;
            
            _tools = new <BaseTool>[
                new DrawTileTool(0, extEditor.editorLevel.foregroundLayer, extEditor, toolLayer, Gfx.getEditorBaseForegroundTile),
                new DrawTileSnakeTool(0, extEditor.editorLevel.foregroundLayer, extEditor, toolLayer, Gfx.getEditorBaseForegroundTile),
                new DrawTileRectangleTool(0, extEditor.editorLevel.foregroundLayer, extEditor, toolLayer, Gfx.getEditorBaseForegroundTile)
            ];

            for each (var tool:BaseTool in _tools) {
                tool.visible = false;
            }
        }

        public function update():void {
            if (RetrocamelInputManager.isCtrlDown) {
                if (RetrocamelInputManager.isKeyHit(KeyConst.A)) {
                    switchToTool(_currentToolIndex+1);

                } else if (RetrocamelInputManager.isKeyHit(KeyConst.D)) {
                    switchToTool(_currentToolIndex-1);

                } else if (RetrocamelInputManager.isKeyHit(KeyConst.S)) {
                    switchLayer();
                }
            } else {
                if (RetrocamelInputManager.isKeyDown(KeyConst.SPACE)) {
                    if (isNaN(_mouseGrabX)) {
                        _mouseGrabX = _extEditor.globalMouseX;
                        _mouseGrabY = _extEditor.globalMouseY;
                    } else {
                        _extEditor.displayOffsetX += _extEditor.globalMouseX - _mouseGrabX;
                        _extEditor.displayOffsetY += _extEditor.globalMouseY - _mouseGrabY;
                        _mouseGrabX = _extEditor.globalMouseX;
                        _mouseGrabY = _extEditor.globalMouseY;
                    }
                } else {
                    _mouseGrabX = NaN;
                    _mouseGrabY = NaN;
                }
            }
        }

        public function switchToTool(newToolIndex:int):void {
            newToolIndex = UtilsNumber.wrapNumber(newToolIndex, 0, _tools.length);
            if (_currentToolIndex === newToolIndex){
                return;
            }

            var oldTool:BaseTool = _extEditor.tool;
            var newTool:BaseTool = _tools[newToolIndex];

            if (oldTool && oldTool is DrawTileBaseTool && newTool is DrawTileBaseTool){
                newTool.index = oldTool.index;
                DrawTileBaseTool(newTool).tileArray = DrawTileBaseTool(oldTool).tileArray;
            }

            if (oldTool){
                oldTool.visible = false;
            }

            newTool.visible = true;
            _extEditor.tool = newTool;
            _currentToolIndex = newToolIndex;
        }

        public function switchLayer():void {
            var drawTool:DrawTileBaseTool = DrawTileBaseTool(_extEditor.tool);
            if (drawTool){
                if (drawTool.tileArray === _extEditor.editorLevel.foregroundLayer){
                    drawTool.tileArray = _extEditor.editorLevel.foregroundVariantLayer;
                    _extEditor.paletteLayer.setTileset(Gfx.getEditorBaseForegroundVariantTile);
                    setToolFeed(Gfx.getEditorBaseForegroundVariantTile);
                } else {
                    drawTool.tileArray = _extEditor.editorLevel.foregroundLayer;
                    _extEditor.paletteLayer.setTileset(Gfx.getEditorBaseForegroundTile);
                    setToolFeed(Gfx.getEditorBaseForegroundTile);
                }
            }
        }

        private function setToolFeed(feedFunction:Function):void{
            for each (var tool:BaseTool in _tools) {
                var drawTool:DrawTileBaseTool = DrawTileBaseTool(tool);
                if (drawTool){
                    drawTool.tileFeedFunction = feedFunction;
                }
            }
        }
    }
}
