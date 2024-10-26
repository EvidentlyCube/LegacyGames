package submuncher.editor.core {
    import net.retrocade.retrocamel.display.layers.RetrocamelLayerStarling;

    import submuncher.core.constants.Gfx;
    import submuncher.editor.layers.EditorInfoBox;
    import submuncher.editor.layers.EditorPalette;

    import submuncher.editor.tools.BaseTool;
    import submuncher.editor.tools.DrawTileRectangleTool;
    import submuncher.editor.tools.DrawTileSnakeTool;
    import submuncher.editor.tools.DrawTileTool;
    import submuncher.ingame.core.Game;
    import submuncher.ingame.core.Level;

    public class Editor {
        private var _displayOffsetX:Number;
        private var _displayOffsetY:Number;
        private var _extGame:Game;
        private var _extLevel:Level;

        private var _toolLayer:RetrocamelLayerStarling;
        private var _infoLayer:EditorInfoBox;
        private var _paletteLayer:EditorPalette;

        private var _controller:EditorController;
        private var _editorLevel:EditorLevel;
        private var _tool:BaseTool;

        private var _mouseX:int;
        private var _mouseY:int;
        private var _touch:EditorTouch;

        public function Editor(game:Game, level:Level) {
            _extGame = game;
            _extLevel = level;
            _displayOffsetX = 0;
            _displayOffsetY = 0;

            _toolLayer = new RetrocamelLayerStarling();
            _infoLayer = new EditorInfoBox(this);
            _paletteLayer = new EditorPalette(this);

            _editorLevel = new EditorLevel(level);
            _touch = new EditorTouch();
            _controller = new EditorController(this, _toolLayer);

            _controller.switchToTool(0);
            _paletteLayer.setTileset(Gfx.getEditorBaseForegroundTile, 16);
        }

        public function update():void {
            _mouseX = (_touch.hoverX - _displayOffsetX) / S.tileEdge | 0;
            _mouseY = (_touch.hoverY - _displayOffsetY) / S.tileEdge | 0;
            _controller.update();
            _tool.update();
            _infoLayer.update();
            _paletteLayer.update();
        }

        public function refreshTile(x:int, y:int):void{
            _extGame.currentLevel.tilesForeground.setTile(x, y, _editorLevel.foregroundLayer.getTile(x, y).computedTile);
            _extGame.currentLevel.tilesForegroundVariant.setTile(x, y, _editorLevel.foregroundVariantLayer.getTile(x, y).computedTile);
            _extGame.gameCommunication.onTileChanged.call(x, y);
        }

        public function get mouseX():Number {
            return _mouseX;
        }

        public function get mouseY():Number {
            return _mouseY;
        }

        public function get globalMouseX():Number {
            return _touch.hoverX;
        }

        public function get globalMouseY():Number {
            return _touch.hoverY;
        }

        public function get isMouseDown():Boolean {
            return _touch.isSingleTouchDown;
        }

        public function get isRightMouseDown():Boolean {
            return _touch.isRightButtonDown;
        }

        public function get editorLevel():EditorLevel {
            return _editorLevel;
        }

        public function get tool():BaseTool {
            return _tool;
        }

        public function set tool(value:BaseTool):void {
            _tool = value;
        }

        public function get displayOffsetX():Number {
            return _displayOffsetX;
        }

        public function set displayOffsetX(value:Number):void {
            _displayOffsetX = value;
            resetOffset();
        }

        public function get displayOffsetY():Number {
            return _displayOffsetY;
        }

        public function set displayOffsetY(value:Number):void {
            _displayOffsetY = value;
            resetOffset();
        }

        public function get paletteLayer():EditorPalette {
            return _paletteLayer;
        }

        private function resetOffset():void {
            if (_displayOffsetX > S.gameWidth / 2){
                _displayOffsetX = S.gameWidth / 2;
            } else if (_displayOffsetX < -_extLevel.tileWidth * S.tileEdge - S.gameWidth / 2){
                _displayOffsetX = -_extLevel.tileWidth * S.tileEdge - S.gameWidth / 2;
            }
            if (_displayOffsetY > S.gameHeight / 2){
                _displayOffsetY = S.gameHeight / 2;
            } else if (_displayOffsetY < -_extLevel.tileHeight * S.tileEdge - S.gameHeight / 2){
                _displayOffsetY = -_extLevel.tileHeight * S.tileEdge - S.gameHeight / 2;
            }
            _extGame.frontend.setOffset(_displayOffsetX, _displayOffsetY);
            _toolLayer.layer.x = _displayOffsetX;
            _toolLayer.layer.y = _displayOffsetY;
        }
    }
}
