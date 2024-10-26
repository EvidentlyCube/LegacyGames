package game.objects {
    import flash.display.Bitmap;
    import flash.display.Shape;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.events.TouchEvent;

    import game.mobiles.MobileButton;

    import net.retrocade.camel.global.rDisplay;
    import net.retrocade.camel.global.rGfx;
    import net.retrocade.camel.objects.rSprite;
    import net.retrocade.utils.UGraphic;

    /**
     * ...
     * @author Maurycy Zarzycki
     */
    public class TDragButton extends rSprite {
        [Embed(source="/../assets/gfx/by_cage/ui/slider_line.png")]  private static var _slider_bg:Class;
        [Embed(source="/../assets/gfx/by_cage/ui/slider_slide.png")] private static var _slider_thumb:Class;

        private static const WIDTH:uint = 414;

        private var _button    :MobileButton;
        private var _clickArea :Shape;
        private var _middleLine:Bitmap;
        private var _thumb     :Bitmap;

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

            _button.x = (WIDTH * S().sizeScaler - _button.width) * _value;

            dispatchEvent(new Event(Event.CHANGE));
        }



        /******************************************************************************************************/
        /**                                                                                        FUNCTIONS  */
        /******************************************************************************************************/

        public function TDragButton() {
            _button     = new MobileButton(null);
            _clickArea  = new Shape();
            _middleLine = rGfx.getB(_slider_bg);

            addChild(_clickArea);
            addChild(_middleLine);
            addChild(_button);


            _middleLine.smoothing = true;

            _button.alpha = 1;

            _thumb = rGfx.getB(_slider_thumb);
            _thumb.smoothing = true;

            _button.addChild(_thumb);

            buttonMode = true;

            addEventListener(TouchEvent.TOUCH_TAP, onTapped);
            addEventListener(MouseEvent.CLICK, onTapped);
            _button.addEventListener(TouchEvent.TOUCH_BEGIN, onButtonTouchBegin);
            _button.addEventListener(MouseEvent.MOUSE_DOWN, onButtonTouchBegin);

            resize();
        }

        public function resize():void{
            _middleLine.x = 18 * S().sizeScaler;
            _middleLine.y = 12 * S().sizeScaler;

            _middleLine.scaleX = S().sizeScaler;
            _middleLine.scaleY = S().sizeScaler;

            _thumb.scaleX = _thumb.scaleY = S().sizeScaler;

            UGraphic.clear(_clickArea).rectFill(0, 0, WIDTH * S().sizeScaler, 36 * S().sizeScaler, 0xFF0000, 0);

            value = value;
        }

        private function onButtonTouchBegin(e:Event):void {
            rDisplay.stage.addEventListener(TouchEvent.TOUCH_END, onStageTouchEnd);
            rDisplay.stage.addEventListener(MouseEvent.MOUSE_UP, onStageTouchEnd);
            addEventListener(Event.ENTER_FRAME, onDragStep);

            e.stopPropagation();
        }

        private function onTapped(e:*):void {
            if (e.target == _button)
                return;

            if (e.localX > _button.center) {
                value += 0.1;

            } else {
                value -= 0.1;
            }

            dispatchEvent(new Event(Event.SELECT));
        }

        private function onStageTouchEnd(e:*):void {
            rDisplay.stage.removeEventListener(TouchEvent.TOUCH_END, onStageTouchEnd);
            rDisplay.stage.removeEventListener(MouseEvent.MOUSE_UP, onStageTouchEnd);
            removeEventListener(Event.ENTER_FRAME, onDragStep);

            dispatchEvent(new Event(Event.SELECT));
        }

        private function onDragStep(e:Event):void {
            var position:Number = mouseX;

            value = (position - _button.width / 2) / (WIDTH * S().sizeScaler - _button.width);
        }
    }
}