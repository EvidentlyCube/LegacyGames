package game.interfaces {
    import flash.display.Shape;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import game.global.Sfx;
    import net.retrocade.camel.core.rDisplay;
	import net.retrocade.camel.core.rSprite;
	
	/**
     * ...
     * @author Maurycy Zarzycki
     */
    public class TDragButton extends rSprite {

        private var _button    :TDrodButton;
        private var _clickArea :Shape;
        private var _middleLine:Shape;

        private var _isDragging:Boolean = false;


        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Slider's value
        // ::::::::::::::::::::::::::::::::::::::::::::::

        private var _value     :Number = 0;

        public function get value():Number {
            return _value;
        }

        public function set value(value:Number):void {
            _value = Math.max(0, Math.min(1, value));

            _button.x = (width - _button.width) * _value;

            dispatchEvent(new Event(Event.CHANGE));
        }



        /******************************************************************************************************/
        /**                                                                                        FUNCTIONS  */
        /******************************************************************************************************/

        public function TDragButton() {
            _button     = new TDrodButton(null, "");
            _clickArea  = new Shape();
            _middleLine = new Shape();

            addChild(_clickArea);
            addChild(_middleLine);
            addChild(_button);

            _button.muteSounds       = true;
            _button.releaseOnRollOut = false;

            width  = 100;
            height = 20;

            buttonMode = true;

            addEventListener(MouseEvent.MOUSE_DOWN, onClicked);
            _button.addEventListener(MouseEvent.MOUSE_DOWN, onButtonDown);
        }

        private function onButtonDown(e:MouseEvent):void {
            rDisplay.stage.addEventListener(MouseEvent.MOUSE_UP, onStageUp);
            addEventListener(Event.ENTER_FRAME, onDragStep);

            e.stopPropagation();
        }

        private function onClicked(e:MouseEvent):void {
            if (e.localX > _button.center) {
                value += 0.1;

            } else {
                value -= 0.1;
            }
        }

        private function onStageUp(e:MouseEvent):void {
            rDisplay.stage.removeEventListener(MouseEvent.MOUSE_UP, onStageUp);
            removeEventListener(Event.ENTER_FRAME, onDragStep);

            dispatchEvent(new MouseEvent(MouseEvent.MOUSE_UP, false));
        }

        private function onDragStep(e:Event):void {
            var position:Number = mouseX;

            value = (position - _button.width / 2) / (width - _button.width);
        }

        override public function set width(value:Number):void {
            _clickArea.graphics.clear();
            _clickArea.graphics.beginFill(0, 0);
            _clickArea.graphics.drawRect(0, 0, value, height);

            _button.width = height * 0.70 | 0;

            drawLine();
        }

        override public function set height(value:Number):void {
            _clickArea.graphics.clear();
            _clickArea.graphics.beginFill(0, 0);
            _clickArea.graphics.drawRect(0, 0, width, value);

            _button.height = value;
	
			drawLine();
        }
		
		private function drawLine():void {
			_middleLine.graphics.clear();
            _middleLine.graphics.lineStyle(1, 0, 0.5);
			
			// Middle line
            _middleLine.graphics.moveTo(0, height / 2);
            _middleLine.graphics.lineTo(width + 1, height / 2);
			
			// Left column
			_middleLine.graphics.moveTo(0, 0);
			_middleLine.graphics.lineTo(0, height);
			
			// Right column
			_middleLine.graphics.moveTo(width, 0);
			_middleLine.graphics.lineTo(width, height);
		}
    }
}