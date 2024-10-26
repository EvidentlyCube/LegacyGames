package submuncher.editor.core {

    import flash.events.MouseEvent;

    import net.retrocade.retrocamel.core.RetrocamelDisplayManager;
    import net.retrocade.retrocamel.core.RetrocamelStarlingCore;
    import net.retrocade.retrocamel.core.RetrocamelWindowsManager;

    import starling.events.Touch;
    import starling.events.TouchEvent;
    import starling.events.TouchPhase;

    public class EditorTouch {
        public var isSingleTouchDown:Boolean = false;
        public var isRightButtonDown:Boolean = false;
        public var singleTouchX:Number = 0;
        public var singleTouchY:Number = 0;
        public var isFastforwardTouch:Boolean = false;
        public var hoverX:Number = 0;
        public var hoverY:Number = 0;
        public var scrollingEnabled:Boolean = true;


        public function EditorTouch() {
            RetrocamelStarlingCore.starlingRoot.addEventListener(TouchEvent.TOUCH, onTouch);
            // RetrocamelDisplayManager.flashStage.addEventListener(MouseEvent.RIGHT_MOUSE_DOWN, onRightMouse);
            // RetrocamelDisplayManager.flashStage.addEventListener(MouseEvent.RIGHT_MOUSE_UP, onRightMouse);
            RetrocamelDisplayManager.flashStage.addEventListener(MouseEvent.MOUSE_WHEEL, onWheelChanged);
        }

        public function dispose():void {
            RetrocamelStarlingCore.starlingRoot.removeEventListener(TouchEvent.TOUCH, onTouch);
            // RetrocamelDisplayManager.flashStage.removeEventListener(MouseEvent.RIGHT_MOUSE_DOWN, onRightMouse);
            // RetrocamelDisplayManager.flashStage.removeEventListener(MouseEvent.RIGHT_MOUSE_UP, onRightMouse);
            RetrocamelDisplayManager.flashStage.removeEventListener(MouseEvent.MOUSE_WHEEL, onWheelChanged);
        }


        public function flushSingleTouch():void {
            isSingleTouchDown = false;
        }

        private function onWheelChanged(event:MouseEvent):void {
            if (!scrollingEnabled || RetrocamelWindowsManager.numWindows > 0) {
                return;
            }

            if (event.delta > 0) {
            } else if (event.delta < 0) {
            }
        }

        private function onTouch(e:TouchEvent):void {
            var touch:Touch = e.getTouch(RetrocamelStarlingCore.starlingRoot);
            if (touch) {
                hoverX = touch.globalX;
                hoverY = touch.globalY;

                if (touch.phase == TouchPhase.HOVER) {
                    // Do nothing

                } else if (touch.phase == TouchPhase.BEGAN) {
                    singleTouchX = touch.globalX;
                    singleTouchY = touch.globalY;

                    if (!isSingleTouchDown) {
                        isSingleTouchDown = true;
                        isFastforwardTouch = true;
                    }
                } else if (touch.phase == TouchPhase.ENDED) {
                    isSingleTouchDown = false;
                    isFastforwardTouch = false;

                } else if (isSingleTouchDown) {
                    singleTouchX = touch.globalX;
                    singleTouchY = touch.globalY;
                }

            }
        }

        private function onRightMouse(e:MouseEvent):void {
            // if (e.type == MouseEvent.RIGHT_MOUSE_DOWN) {
            //     isRightButtonDown = true;
            // } else if (e.type == MouseEvent.RIGHT_MOUSE_UP) {
            //     isRightButtonDown = false;
            // }
        }
    }
}