package game.objects{
    import flash.display.BitmapData;

    import game.data.TBase;
    import game.data.TConnectorData;
    import game.data.TPath;
    import game.functions.colorFromColor;
    import game.global.Game;
    import game.global.Level;
    import game.global.Score;
    import game.global.Sfx;
    import game.states.TStateGame;
    import game.tiles.TTilePit;

    import net.retrocade.camel.core.rDisplay;
    import net.retrocade.camel.core.rGfx;
    import net.retrocade.camel.core.rInput;
    import net.retrocade.camel.effects.rEffQuake;
    import net.retrocade.camel.objects.rObject;
    import net.retrocade.utils.UNumber;

    public class TCursor extends rObject{
        [Embed(source="/../assets/gfx/by_cage/cursors/cursor_cross.png")]       public static var _gfx_cross  :Class;
        [Embed(source="/../assets/gfx/by_cage/cursors/cursor_eyedropper2.png")] public static var _gfx_eyedrop:Class;
        [Embed(source="/../assets/gfx/by_cage/cursors/cursor_eraser2.png")] public static var _gfx_eraser:Class;

        public static var self:TCursor

        private var _iconColor:uint = 0;

        private var _x:int;
        private var _y:int;

        private var _tileX:int;
        private var _tileY:int;

        private var _pathPlaced:Number = 0;

        private var _overPlayfield:Boolean = false;

        private var _isOverBase:Boolean = false;

        private var _isOverPit:Boolean  = false;

        public var isEraser:Boolean = false;

        public function TCursor(){
            Game.gAll.add(this);

            self = this;
        }

        override public function update():void{
            TConnectorData.checkCompletion();

            _tileX = Math.floor((rInput.mouseX - S().playfieldOffsetX * 2) / 32);
            _tileY = Math.floor((rInput.mouseY - S().playfieldOffsetY * 2) / 32);

            _x = _tileX * 16 + S().playfieldOffsetX;
            _y = _tileY * 16 + S().playfieldOffsetY;

            _overPlayfield = !(_tileX < 0 || _tileY < 0 || _tileX >= S().TILE_GRID_WIDTH || _tileY >= S().TILE_GRID_HEIGHT);

            checkIsOverBase();
            checkIsOverPit();

            if (rInput.isMouseDown() && !Level.levelLocked)
                onMouseDown();

            if (rInput.isKeyDown(Game.keyClear) && !Level.levelLocked)
                onClearDown();

            if (_overPlayfield && !_isOverPit){
                if (_isOverBase)
                    Game.lGame.draw(rGfx.getBD(_gfx_eyedrop), _x, _y);
                else if (isEraser)
                    Game.lGame.draw(rGfx.getBD(_gfx_eraser), _x, _y);
                else
                    Game.lGame.draw(rGfx.getBD(_gfx_cross), _x, _y);

                if (_iconColor && !_isOverBase && !isEraser) {
                    Game.lGame.drawRect(_x + 12, _y + 12, 7, 7);
                    Game.lGame.drawRect(_x + 13, _y + 13, 5, 5, _iconColor);
                }
            }
        }

        private function onMouseDown():void{
            if (!_overPlayfield)
                return;
            var item:* = Level.level.get(_tileX * 16, _tileY * 16);

            if (item is TBase){
                Level.selectedColor = TBase(item).color;
                _iconColor = colorFromColor(TBase(item).color);
                isEraser = false;

            } else if (item == null){
                if (!isEraser){
                    drawPath();
                }

            } else if (isEraser)
                onClearDown();

            else if (item is TPath && TPath(item).color != Level.selectedColor){
                TPath(item).clear();
                clearPathEffect();
                drawPath();
            }
        }

        private function onClearDown():void{
            var item:* = Level.level.get(_tileX * 16, _tileY * 16);

            if (item is TPath) {
                TPath(item).clear();
                clearPathEffect();
            }
        }

        private function drawPath():void{
            if (Level.selectedColor >= 0 && _overPlayfield && Score.pathsMax.get() > Score.pathsPlaced.get()){
                new TPath(_tileX * 16, _tileY * 16, Level.selectedColor);
            }
        }

        private function clearPathEffect():void {
            Sfx.sfxRemovePathPlay();
            new rEffQuake(100, 3, 3);
        }

        private function checkIsOverBase():void{
            var item:* = Level.level.get(_tileX * 16, _tileY * 16);
            if (item != null && item is TBase)
                _isOverBase = true;
            else
                _isOverBase = false;
        }

        private function checkIsOverPit():void{
            var item:* = Level.level.get(_tileX * 16, _tileY * 16);
            if (item != null && item is TTilePit)
                _isOverPit = true;
            else
                _isOverPit = false;
        }
    }
}