/**
 * Created with IntelliJ IDEA.
 * User: mzarzycki
 * Date: 14.02.13
 * Time: 14:45
 * To change this template use File | Settings | File Templates.
 */
package net.retrocade.tacticengine.monstro.core {
    import flash.geom.Point;

    import net.retrocade.camel.global.rInput;
    import net.retrocade.camel.global.rWindows;
    import net.retrocade.camel.interfaces.rIUpdatable;
    import net.retrocade.tacticengine.core.Eventer;
    import net.retrocade.tacticengine.core.Field;

    import net.retrocade.tacticengine.core.IDestruct;
    import net.retrocade.tacticengine.monstro.events.MonstroEventPlayfieldOffsetChange;
    import net.retrocade.tacticengine.monstro.events.MonstroEventResize;
    import net.retrocade.tacticengine.monstro.events.MonstroEventScrollTo;
    import net.retrocade.tacticengine.monstro.events.MonstroEventZoomChange;
    import net.retrocade.utils.UNumber;
    import net.retrocade.utils.UNumber;
    import net.retrocade.utils.UNumber;

    import starling.display.DisplayObject;

    public class ZoomManager implements IDestruct, rIUpdatable{
        private var _boards:Vector.<DisplayObject>;

        private var _zoomedIn:Boolean = false;

        private var _offsetX:Number = 0.5;
        private var _offsetY:Number = 0.5;

        private var _toScaleX:Number;
        private var _toScaleY:Number;

        private var _field:Field;

        public var isEnabled:Boolean = true;

        public function ZoomManager(field:Field){
            _field = field;
        }

        public function hook(boards:Vector.<DisplayObject>):void{
            _boards = boards;

            Eventer.listen(MonstroEventZoomChange.NAME, onZoomChange);
            Eventer.listen(MonstroEventResize.NAME, recalculate);
            Eventer.listen(MonstroEventPlayfieldOffsetChange.NAME, onOffsetChange);
            Eventer.listen(MonstroEventScrollTo.NAME, onScrollTo);

            recalculate();
        }

        public function destruct():void{
            Eventer.release(MonstroEventZoomChange.NAME, onZoomChange);
            Eventer.release(MonstroEventResize.NAME, recalculate);
            Eventer.release(MonstroEventPlayfieldOffsetChange.NAME, onOffsetChange);
            Eventer.release(MonstroEventScrollTo.NAME, onScrollTo);
            _boards.length = 0;
            _boards = null;
            _field = null;
        }

        public function get board():DisplayObject{
            return _boards[0];
        }

        public function get boardX():Number{
            return board.x;
        }

        public function get boardScaledWidth():Number{
            return boardRealWidth * boardScaleX;
        }

        public function get boardScaledHeight():Number{
            return boardRealHeight * boardScaleY;
        }

        public function get boardY():Number{
            return board.y;
        }

        public function get boardScaleX():Number{
            return board.scaleX;
        }

        public function get boardScaleY():Number{
            return board.scaleY;
        }

        public function get boardRealWidth():Number{
            return _field.width * Monstro.tileWidth;
        }

        public function get boardRealHeight():Number{
            return _field.height * Monstro.tileHeight;
        }

        public function update():void{
            if (!_boards || !isEnabled){
                return;
            }

            setBoardsProperties(
                    boardX,
                    boardY,
                    UNumber.approach(boardScaleX, _toScaleX, 0.4, 0.01, 0.125),
                    UNumber.approach(boardScaleY, _toScaleY, 0.4, 0.01, 0.125)
            );

            setBoardsProperties(
                    Monstro.gameWidth / 2 - boardScaledWidth * _offsetX,
                    Monstro.gameHeight / 2 - boardScaledHeight * _offsetY,
                    boardScaleX,
                    boardScaleY
            );
        }

        private function onZoomChange(event:MonstroEventZoomChange):void{
            if (!isEnabled || rWindows.isBlocking){
                return;
            }

            _zoomedIn = event.zoomIn;
            recalculate();
        }

        private function recalculate():void{
            if (_zoomedIn){
                recalculateZoomIn();
            } else {
                recalculateZoomOut();
            }
        }

        private function recalculateZoomIn():void{
            _toScaleX = 2;
            _toScaleY = 2;
        }

        private function recalculateZoomOut():void{
            _toScaleX = 1;
            _toScaleY = 1;
        }

        private function setBoardsProperties(x:Number, y:Number, scaleX:Number, scaleY:Number):void{
            for each(var board:DisplayObject in _boards){
                board.x = x;
                board.y = y;
                board.scaleX = scaleX;
                board.scaleY = scaleY;
            }
        }

        private function onOffsetChange(event:MonstroEventPlayfieldOffsetChange):void{
            if (!isEnabled || rWindows.isBlocking){
                return;
            }

            var offsetX:Number = event.deltaX * (1 / boardScaledWidth);
            var offsetY:Number = event.deltaY * (1 / boardScaledHeight);

            _offsetX = Math.max(0, Math.min(1, _offsetX - offsetX));
            _offsetY = Math.max(0, Math.min(1, _offsetY - offsetY));
        }

        private function onScrollTo(event:MonstroEventScrollTo):void{
            if (!isEnabled || rWindows.isBlocking){
                return;
            }

            var toX:Number = UNumber.limit(event.x / boardRealWidth, 1, 0);
            var toY:Number = UNumber.limit(event.y / boardRealHeight, 1, 0);

            _offsetX = UNumber.approach(_offsetX, toX, event.factor, event.factor / 100);
            _offsetY = UNumber.approach(_offsetY, toY, event.factor, event.factor / 100);

            if (_offsetX != toX || _offsetY != toY)
            {
                event.preventDefault();
            }
        }
    }
}
