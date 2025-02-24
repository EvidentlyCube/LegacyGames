
package net.retrocade.tacticengine.monstro.global.core {
    import flash.geom.Point;

    import net.retrocade.retrocamel.interfaces.IRetrocamelUpdatable;
    import net.retrocade.tacticengine.core.Eventer;
    import net.retrocade.tacticengine.core.MonstroField;
    import net.retrocade.tacticengine.core.IDisposable;
    import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventPlayfieldOffsetChange;
    import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventResize;
    import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventScrollTo;
    import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventZoomChange;
    import net.retrocade.utils.UtilsNumber;

    import starling.display.DisplayObject;

    public class ZoomManager implements IDisposable, IRetrocamelUpdatable {
        public var isEnabled:Boolean = true;
        private var _boards:Vector.<DisplayObject>;
        private var _zoomLevels:Vector.<Point>;
        private var _offsetX:Number = 0.5;
        private var _offsetY:Number = 0.5;
        private var _toScaleX:Number;
        private var _toScaleY:Number;
        private var _field:MonstroField;
        private var _zoomLevel:int = 3;

        public function ZoomManager(field:MonstroField) {
            _field = field;

            _zoomLevels = new <Point>[
                new Point(0.25, 0.25),
                new Point(0.5, 0.5),
                new Point(1.0, 1.0),
                new Point(2.0, 2.0),
                new Point(3.0, 3.0),
                new Point(4.0, 4.0)
            ];
        }

        public function hook(boards:Vector.<DisplayObject>):void {
            _boards = boards;

            Eventer.listen(MonstroEventZoomChange.NAME, onZoomChange, this);
            Eventer.listen(MonstroEventResize.NAME, recalculate, this);
            Eventer.listen(MonstroEventPlayfieldOffsetChange.NAME, onOffsetChange, this);
            Eventer.listen(MonstroEventScrollTo.NAME, onScrollTo, this);

            _zoomLevel = MonstroData.getZoomLevel(3);

            recalculate();
            setBoardsProperties(boardX, boardY, _toScaleX, _toScaleY);
        }

        public function dispose():void {
            Eventer.releaseContext(this);

            _zoomLevels.length = 0;
            _zoomLevels = null;

            _boards.length = 0;
            _boards = null;
            _field = null;
        }

        public function update():void {
            if (!_boards || !isEnabled) {
                return;
            }
            setBoardsProperties(
                    boardX,
                    boardY,
                    UtilsNumber.approach(boardScaleX, _toScaleX, 0.4, 0.01, 0.125),
                    UtilsNumber.approach(boardScaleY, _toScaleY, 0.4, 0.01, 0.125)
            );

            setBoardsProperties(
                    MonstroConsts.gameWidth / 2 - boardScaledWidth * _offsetX,
                    MonstroConsts.gameHeight / 2 - boardScaledHeight * _offsetY,
                    boardScaleX,
                    boardScaleY
            );
        }

        private function onZoomChange(event:MonstroEventZoomChange):void {
            if (!isEnabled) {
                return;
            }

            if (event.zoomIn) {
                _zoomLevel = Math.min(_zoomLevel + 1, _zoomLevels.length - 1);
            } else {
                _zoomLevel = Math.max(_zoomLevel - 1, 0);
            }

            MonstroData.setZoomLevel(_zoomLevel);

            recalculate();
        }

        private function recalculate():void {
            _toScaleX = _zoomLevels[_zoomLevel].x;
            _toScaleY = _zoomLevels[_zoomLevel].y;

            update();
        }

        private function setBoardsProperties(x:Number, y:Number, scaleX:Number, scaleY:Number):void {
            for each(var board:DisplayObject in _boards) {
                board.x = x;
                board.y = y;
                board.scaleX = scaleX;
                board.scaleY = scaleY;
            }
        }

        private function onOffsetChange(event:MonstroEventPlayfieldOffsetChange):void {
            if (!isEnabled) {
                return;
            }

            var offsetX:Number = event.deltaX * (1 / boardScaledWidth);
            var offsetY:Number = event.deltaY * (1 / boardScaledHeight);

            _offsetX = Math.max(0, Math.min(1, _offsetX - offsetX));
            _offsetY = Math.max(0, Math.min(1, _offsetY - offsetY));
        }

        private function onScrollTo(event:MonstroEventScrollTo):void {
            if (!isEnabled) {
                return;
            }

            var toX:Number = UtilsNumber.limit(event.x / boardRealWidth, 1, 0);
            var toY:Number = UtilsNumber.limit(event.y / boardRealHeight, 1, 0);

            _offsetX = UtilsNumber.approach(_offsetX, toX, event.factor, event.factor / 100);
            _offsetY = UtilsNumber.approach(_offsetY, toY, event.factor, event.factor / 100);

            if (_offsetX != toX || _offsetY != toY) {
                event.preventDefault();
            }
        }

        public function get zoomLevel():int {
            return _zoomLevel;
        }

        public function get totalZoomLevels():int {
            return _zoomLevels.length;
        }

        public function get board():DisplayObject {
            return _boards[0];
        }

        public function get boardX():Number {
            return board.x;
        }

        public function get boardScaledWidth():Number {
            return boardRealWidth * boardScaleX;
        }

        public function get boardScaledHeight():Number {
            return boardRealHeight * boardScaleY;
        }

        public function get boardY():Number {
            return board.y;
        }

        public function get boardScaleX():Number {
            return board.scaleX;
        }

        public function get boardScaleY():Number {
            return board.scaleY;
        }

        public function get boardRealWidth():Number {
            return _field.width * MonstroConsts.tileWidth;
        }

        public function get boardRealHeight():Number {
            return _field.height * MonstroConsts.tileHeight;
        }
    }
}
