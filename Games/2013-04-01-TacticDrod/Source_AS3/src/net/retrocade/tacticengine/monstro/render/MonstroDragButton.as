package net.retrocade.tacticengine.monstro.render {
    import flash.geom.Point;

    import net.retrocade.camel.global.rDisplay;
    import net.retrocade.tacticengine.monstro.core.MonstroGfx;

    import starling.display.Image;

    import starling.display.Sprite;
    import starling.display.TouchShape;
    import starling.events.Event;
    import starling.events.Touch;
    import starling.events.TouchEvent;
    import starling.events.TouchPhase;

    /**
     * ...
     * @author Maurycy Zarzycki
     */
    public class MonstroDragButton extends Sprite {
        private var _clickArea :TouchShape;
        private var _middleLine:Image;
        private var _thumb     :Image;

        private var _leftEdge  :Number = 0;
        private var _rightEdge :Number = 0;

        private var _isDragging:Boolean = false;

        private var _minValue:Number = 0;
        private var _maxValue:Number = 1;
        private var _step:Number = 0.0001;

        private var _values:Vector.<Number>;

        private var _value     :Number = 0;


        private function getRoundedToClosest(value:Number):Number{
            value = Math.max(_minValue, Math.min(_maxValue, value));

            if (_values){
                var bestDifference:Number = Number.MAX_VALUE;
                var bestValue:Number = value;
                var difference:Number;

                for each(var roundTo:Number in _values){
                    difference = Math.abs(value - roundTo);
                    if (difference < bestDifference){
                        bestDifference = difference;
                        bestValue = roundTo;
                    }
                }

                return bestValue;
            } else {
                var roundedDown:Number = Math.floor((value - _minValue) / _step) * _step;
                var roundedUp  :Number = Math.ceil((value - _minValue) / _step) * _step;

                if (value - roundedDown < roundedUp - value){
                    return roundedDown;
                } else {
                    return roundedUp;
                }
            }
        }



        /******************************************************************************************************/
        /**                                                                                        FUNCTIONS  */
        /******************************************************************************************************/

        public function MonstroDragButton(){
            _clickArea  = new TouchShape(273, 30);
            _middleLine = MonstroGfx.getSliderBackground();
            _thumb = MonstroGfx.getSliderThumb();

            addChild(_middleLine);
            addChild(_thumb);
            addChild(_clickArea);

            _thumb.y = 5;

            _leftEdge = 12;
            _rightEdge = 11;

            _middleLine.touchable = false;
            _thumb.touchable = false;

            useHandCursor = true;

            value = 1;

            addEventListener(TouchEvent.TOUCH, onTouch);
            rDisplay.starlingStage.addEventListener(TouchEvent.TOUCH, onStageTouch);
        }

        private function onTouch(e:TouchEvent):void{
            var touch:Touch = e.getTouch(this);

            if (touch){
                if (touch.phase == TouchPhase.BEGAN){
                    _isDragging = true;
                } else if (_isDragging){
                    if (touch.phase == TouchPhase.MOVED){
                        onMoved(touch.globalX);
                    } else if (touch.phase == TouchPhase.ENDED){
                        onMoved(touch.globalX);
                        _isDragging = false;
                    }
                }
            }
        }

        private function onStageTouch(e:TouchEvent):void{
            if (!_isDragging){
                return;
            }

            var touch:Touch = e.getTouch(this);

            if (touch){
                if (touch.phase == TouchPhase.MOVED){
                    onMoved(touch.globalX);
                } else if (touch.phase == TouchPhase.ENDED){
                    _isDragging = false;
                }
            }
        }

        private function onMoved(globalX:Number):void{
            var point:Point = new Point(globalX);
            globalToLocal(point, point);

            var offsetFraction:Number = (point.x - _leftEdge) / (_middleLine.width - _leftEdge - _rightEdge);
            value = _minValue + offsetFraction * _maxValue;
        }

        public function get minValue():Number {
            return _minValue;
        }

        public function set minValue(value:Number):void {
            _minValue = value;
        }

        public function get maxValue():Number {
            return _maxValue;
        }

        public function set maxValue(value:Number):void {
            _maxValue = value;
        }

        public function get step():Number {
            return _step;
        }

        public function set step(value:Number):void {
            _step = value;
        }

        public function get values():Vector.<Number> {
            return _values;
        }

        public function set values(value:Vector.<Number>):void {
            if (value.length == 0){
                _values = null;
            } else {
                _values = value;

                _minValue = Number.MAX_VALUE;
                _maxValue = Number.MIN_VALUE;

                for each(var number:Number in value){
                    _minValue = Math.min(number, _minValue);
                    _maxValue = Math.max(number, _maxValue);
                }
            }
        }

        public function get value():Number {
            return _value;
        }

        public function set value(value:Number):void {
            _value = getRoundedToClosest(value);

            var thumbOffset:Number = (_value - _minValue) / (_maxValue - _minValue);

            _thumb.center = _leftEdge + (_middleLine.width - _leftEdge - _rightEdge) * thumbOffset;

            dispatchEvent(new Event(Event.CHANGE));
        }
    }
}