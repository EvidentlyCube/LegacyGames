package net.retrocade.tacticengine.monstro.gui.render {
    import flash.geom.Point;

    import net.retrocade.retrocamel.core.RetrocamelDisplayManager;
	import net.retrocade.signal.Signal;
	import net.retrocade.tacticengine.monstro.global.core.MonstroGfx;

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

        private var _value     :Number = 0;

		public var dragStarted:Signal;
		public var dragEnded:Signal;

        private function getRoundedToClosest(value:Number):Number{
            value = Math.max(_minValue, Math.min(_maxValue, value));

			var roundedDown:Number = _minValue + Math.floor((value - _minValue) / _step) * _step;
			var roundedUp  :Number = _minValue + Math.ceil((value - _minValue) / _step) * _step;

			if (value - roundedDown < roundedUp - value){
				return roundedDown;
			} else {
				return roundedUp;
			}
        }



        /******************************************************************************************************/
        /**                                                                                        FUNCTIONS  */
        /******************************************************************************************************/

        public function MonstroDragButton(){
            _middleLine = MonstroGfx.getSliderBackground();
            _thumb = MonstroGfx.getSliderThumb();
            _clickArea  = new TouchShape(347, _middleLine.height);

            addChild(_middleLine);
            addChild(_thumb);
            addChild(_clickArea);

            _thumb.y = 14;

            _leftEdge = 65;
            _rightEdge = 65;

            _middleLine.touchable = false;
            _thumb.touchable = false;

            useHandCursor = true;

            value = 1;

            addEventListener(TouchEvent.TOUCH, onTouch);
            RetrocamelDisplayManager.starlingStage.addEventListener(TouchEvent.TOUCH, onStageTouch);

			dragStarted = new Signal();
			dragEnded = new Signal();
        }

		override public function dispose():void {
			_middleLine.dispose();
			_thumb.dispose();
			_clickArea.dispose();

			removeEventListener(TouchEvent.TOUCH, onTouch);
			RetrocamelDisplayManager.starlingStage.removeEventListener(TouchEvent.TOUCH, onStageTouch);

			dragStarted.clear();
			dragEnded.clear();

			super.dispose();
		}

		private function onTouch(e:TouchEvent):void{
            var touch:Touch = e.getTouch(this);

            if (touch){
                if (touch.phase == TouchPhase.BEGAN){
					dragStarted.call(this);
                    _isDragging = true;
                } else if (_isDragging){
                    if (touch.phase == TouchPhase.MOVED){
                        onMoved(touch.globalX);
                    } else if (touch.phase == TouchPhase.ENDED){
                        onMoved(touch.globalX);
                        _isDragging = false;
						dragEnded.call(this);
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
                if (touch.phase == TouchPhase.MOVED || touch.phase == TouchPhase.BEGAN){
                    onMoved(touch.globalX);
                } else if (touch.phase == TouchPhase.ENDED){
                    _isDragging = false;
					dragEnded.call(this);
                }
            }
        }

        private function onMoved(globalX:Number):void{
            var point:Point = new Point(globalX);
            globalToLocal(point, point);

            var offsetFraction:Number = (point.x - _leftEdge) / (_middleLine.width - _leftEdge - _rightEdge);
            value = _minValue + offsetFraction * (_maxValue - _minValue);
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