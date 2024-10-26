package game.objects{
    import flash.events.MouseEvent;
    import flash.events.TouchEvent;
    import flash.utils.getTimer;

    import game.data.TBase;
    import game.data.TConnectorManager;
    import game.data.TPath;
    import game.global.Game;
    import game.global.Level;
    import game.global.Permit;
    import game.global.Score;
    import game.global.Sfx;
    import game.tiles.TTilePit;

    import net.retrocade.camel.global.rEvents;
    import net.retrocade.camel.objects.rObject;
    import net.retrocade.utils.Key;
    import net.retrocade.utils.UNumber;

    public class TCursor extends rObject{
        public static var self:TCursor

        private var _tileX:int;
        private var _tileY:int;

        private var _pathPlaced:Number = 0;

        private var _overPlayfield:Boolean = false;

        private var _isOverBase:Boolean = false;

        private var _isOverPit:Boolean  = false;

        public var isEraser:Boolean = false;
        public var isDrawing:Boolean = false;

        private var _isMouseDown  :Boolean = false;
        private var _lastMouseDown:Boolean = false;
        private var _tapClearMode :Boolean = false;

        private var _lastMouseX:Number = -1;
        private var _lastMouseY:Number = -1;

        private var _startMouseX:Number = -1;
        private var _startMouseY:Number = -1;

        public static var _undoHistory:Array = [];
        private var _currentUndo:UndoStep;

        private var _lastTouchedColor:int = -1;
        private var _movedFinger:Boolean = true;
        private var _lastClickTime:Number;

        private var _isTap:Boolean = false;

        public function get mouseX():Number{
            return SmartTouch.singleTouchX;
        }

        public function get mouseY():Number{
            return SmartTouch.singleTouchY;
        }

        public function getMouseDown():Boolean{
            return SmartTouch.isSingleTouchDown;
        }

        public function TCursor(){
            _undoHistory = [];

            Game.gAll.add(this);

            self = this;
        }

        public function undo():void{
            if (_undoHistory.length)
                UndoStep(_undoHistory.pop()).undo();
        }

        public function undoCount():uint{
            return _undoHistory.length;
        }

        public function touchBegin():void{
            _isMouseDown = true;
            _startMouseX = _lastMouseX = SmartTouch.singleTouchX;
            _startMouseY = _lastMouseY = SmartTouch.singleTouchY;

            _currentUndo = new UndoStep();

            _movedFinger = false;

            _lastClickTime    = getTimer();
            _lastTouchedColor = -1;

            _isTap = true;
        }

        public function touchEnd(noTap:Boolean):void{

            if (!noTap && _isTap)
                doDraw();

            _isMouseDown = false;
            isEraser = false;

            if (isDrawing)
                Level.redraw();

            isDrawing = false;

            if (_currentUndo && _currentUndo.countChanges())
                _undoHistory.push(_currentUndo);
        }

        override public function update():void{
            TConnectorManager.checkCompletion();

            var startX:int = Math.floor((_lastMouseX - Game.lStarling.starlingSprite.x) / S().realTileWidth);
            var startY:int = Math.floor((_lastMouseY - Game.lStarling.starlingSprite.y) / S().realTileHeight);

            var endX:int = Math.floor((mouseX - Game.lStarling.starlingSprite.x) / S().realTileWidth);
            var endY:int = Math.floor((mouseY - Game.lStarling.starlingSprite.y) / S().realTileHeight);

            if (!_movedFinger){
                var startTileX:int = Math.floor((_startMouseX - Game.lStarling.starlingSprite.x) / S().realTileWidth);
                var startTileY:int = Math.floor((_startMouseY - Game.lStarling.starlingSprite.y) / S().realTileHeight);

                if (startTileX != startX || startTileY != startY || startTileX != endX || startTileY != endY){
                    _movedFinger = true;
                    _isTap = false;
                }
            }

            _tileX = startX;
            _tileY = startY;

            if (Permit.canClearColor() && !_movedFinger && getMouseDown() && _lastClickTime + 500 < getTimer()){
                var tileUnder:TConnector = Level.level.getTile(_tileX, _tileY) as TConnector;

                if (!tileUnder || !(tileUnder is TPath))
                    return;

                for each(var tile:TConnector in Level.getAllByColor(tileUnder.tileColor)){
                    if (tile is TPath){
                        _currentUndo.remove(tile.tileX, tile.tileY, TPath(tile).tileColor);
                        TPath(tile).removePath();
                    }
                }

                rEvents.add(C.eventClearedColor);

                clearPathEffect();

                SmartTouch.forceSingleTouchRelease();

                if (Score.pathsPlaced.get() == 0)
                    rEvents.add(C.eventRemovedAllPaths);

                return;
            }

            if (!getMouseDown()){
                _tapClearMode  = false;
                _lastMouseDown = false;
                return;
            }

            if (!_movedFinger)
                return;

            do{
                if (getMouseDown() && !Level.levelLocked)
                    doDraw();

                if (_tileX == endX && _tileY == endY)
                    break;

                if (_tileX != endX)
                    _tileX += UNumber.sign(endX - _tileX);
                else if (_tileY != endY)
                    _tileY += UNumber.sign(endY - _tileY);
                else
                    break;

            } while (true);

            _lastMouseX = mouseX;
            _lastMouseY = mouseY;

            _lastMouseDown = _isMouseDown;
        }

        private function doDraw():void{
            checkOverPlayfield();
            checkIsOverBase();
            checkIsOverPit();

            if (!_overPlayfield || _tapClearMode)
                return;

            var item:* = Level.level.getTile(_tileX, _tileY);

            if (Permit.canGetColor() && !isEraser && item is TBase){
                if (Level.selectedColor == TBase(item).tileColor && isDrawing)
                    return;

                Level.selectedColor = TBase(item).tileColor;
                rEvents.add(C.eventDrawColorChanged);

                Level.redrawAsTransparent();

                isDrawing = true;

                rEvents.add(C.eventSelectedColor);

            } else if (item == null){
                if (!isEraser){
                    drawPath();
                }

            } else if (isEraser || (_lastMouseDown == false)){
                if (!_lastMouseDown){
                    isEraser = true;
                }
                onClearDown();

            } else if (Permit.canRemovePath() && item is TPath && TPath(item).tileColor != Level.selectedColor){
                _currentUndo.remove(_tileX, _tileY, TPath(item).tileColor);
                TPath(item).removePath();

                rEvents.add(C.eventRemovedPath, item);
                clearPathEffect();
                drawPath();
            }
        }

        private function onClearDown():void{
            var item:* = Level.level.getTile(_tileX, _tileY);

            if (Permit.canRemovePath() && item is TPath) {
                _currentUndo.remove(_tileX, _tileY, TPath(item).tileColor);
                _lastTouchedColor = TPath(item).tileColor;

                rEvents.add(C.eventRemovedPath, item);

                TPath(item).removePath();
                clearPathEffect();

                if (Score.pathsPlaced.get() == 0)
                    rEvents.add(C.eventRemovedAllPaths);
            }
        }

        private function drawPath():void{
            if (Permit.canDrawPath() && Level.selectedColor >= 0 && _overPlayfield){
                if (Score.pathsMax.get() == Score.pathsPlaced.get()){
                    isDrawing = false;
                    _isMouseDown = false;
                    TInvalid.show(mouseX, mouseY);
                    Sfx.sfxError.play();
                    rEvents.add(C.eventExceededPaths);
                    SmartTouch.forceSingleTouchRelease();
                    return;
                }

                var path:TPath = new TPath(_tileX, _tileY, Level.selectedColor);

                _currentUndo.add(_tileX, _tileY);

                rEvents.add(C.eventDrawnPath, path);

                if (!isDrawing){
                    Level.redrawAsTransparent();
                    isDrawing = true;
                }
            }
        }

        private function clearPathEffect():void {
            Sfx.sfxRemovePath.play();
        }

        private function checkIsOverBase():void{
            var item:* = Level.level.getTile(_tileX, _tileY);
            if (item != null && item is TBase)
                _isOverBase = true;
            else
                _isOverBase = false;
        }

        private function checkIsOverPit():void{
            var item:* = Level.level.getTile(_tileX, _tileY);
            if (item != null && item is TTilePit)
                _isOverPit = true;
            else
                _isOverPit = false;
        }

        private function checkOverPlayfield():void{
            _overPlayfield = !(_tileX < 0 || _tileY < 0 || _tileX >= S().tileGridWidth || _tileY >= S().tileGridHeight);
        }
    }
}