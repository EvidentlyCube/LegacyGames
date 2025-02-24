package net.retrocade.tacticengine.monstro.global.core {

    import flash.events.MouseEvent;
    import flash.geom.Point;

    import net.retrocade.retrocamel.core.RetrocamelCore;
    import net.retrocade.retrocamel.core.RetrocamelDisplayManager;
    import net.retrocade.retrocamel.core.RetrocamelWindowsManager;
    import net.retrocade.retrocamel.core.RetrocamelStarlingCore;
    import net.retrocade.tacticengine.core.Eventer;
    import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventLockHud;
    import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventPlayfieldOffsetChange;
    import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventTap;
    import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventZoomChange;
    import net.retrocade.utils.UtilsNumber;

    import starling.display.DisplayObject;
    import starling.events.Touch;
    import starling.events.TouchEvent;
    import starling.events.TouchPhase;

    public class SmartTouch {
        public static var isSingleTouchDown:Boolean = false;
        public static var isRightButtonDown:Boolean = false;
        public static var singleTouchX:Number = 0;
        public static var singleTouchY:Number = 0;
        public static var isFastforwardTouch:Boolean = false;
        public static var hoverX:Number = 0;
        public static var hoverY:Number = 0;
        public static var scrollingEnabled:Boolean = true;
        public static var isCtrlDown: Boolean = false;
        private static var _initialSlidingX:int = 0;
        private static var _initialSlidingY:int = 0;
        private static var _isSliding:Boolean = false;
        private static var _boards:Vector.<DisplayObject>;
        private static var _isScrollLocked:Boolean = false;
        private static var _isZoomLocked:Boolean = false;
        private static var _lastMouseDelta:int = 0;

        public static function hook(boards:Vector.<DisplayObject>):void {
            if (_boards) {
                unhook();
            }

            _boards = boards;
            RetrocamelStarlingCore.starlingRoot.addEventListener(TouchEvent.TOUCH, onTouch);
            RetrocamelDisplayManager.flashStage.addEventListener(MouseEvent.RIGHT_MOUSE_DOWN, onRightMouse);
            RetrocamelDisplayManager.flashStage.addEventListener(MouseEvent.RIGHT_MOUSE_UP, onRightMouse);
            RetrocamelDisplayManager.flashStage.addEventListener(MouseEvent.MOUSE_WHEEL, onWheelChanged);

            Eventer.listen(MonstroEventLockHud.NAME, onLock, SmartTouch);
        }

        public static function unhook():void {
            _boards = null;
            RetrocamelStarlingCore.starlingRoot.removeEventListener(TouchEvent.TOUCH, onTouch);
            RetrocamelDisplayManager.flashStage.removeEventListener(MouseEvent.RIGHT_MOUSE_DOWN, onRightMouse);
            RetrocamelDisplayManager.flashStage.removeEventListener(MouseEvent.RIGHT_MOUSE_UP, onRightMouse);
            RetrocamelDisplayManager.flashStage.removeEventListener(MouseEvent.MOUSE_WHEEL, onWheelChanged);

			Eventer.releaseContext(SmartTouch);
        }

        public static function forceBoardToFitInConstraints():void {
            var firstBoard:DisplayObject = _boards[0];
            var forcedX:Number;
            var forcedY:Number;

            if (firstBoard.width < S().playfieldWidth) {
                forcedX = Math.max(-S().playfieldWidth / 4, Math.min(S().playfieldWidth * 4 / 3 - firstBoard.width, firstBoard.x));
            } else {
                forcedX = Math.min(S().playfieldWidth / 4, Math.max(S().playfieldWidth * 3 / 4 - firstBoard.width, firstBoard.x));
            }

            if (firstBoard.height < S().playfieldHeight) {
                forcedY = Math.max(-S().playfieldHeight, Math.min(S().playfieldHeight * 4 / 3 - firstBoard.height, firstBoard.y));
            } else {
                forcedY = Math.min(S().playfieldHeight / 4, Math.max(S().playfieldHeight - firstBoard.height, firstBoard.y));
            }

            setBoardsPosition(forcedX, forcedY);
        }

        public static function flushSingleTouch():void{
            isSingleTouchDown = false;
        }

        private static function onWheelChanged(event:MouseEvent):void{
            if (_isZoomLocked || !scrollingEnabled || RetrocamelWindowsManager.numWindows > 0){
                return;
            }

            if (event.delta > 0){
                new MonstroEventZoomChange(true);
            } else if (event.delta < 0) {
                new MonstroEventZoomChange(false);
            }
        }

        private static function onLock(event:MonstroEventLockHud):void {
            _isScrollLocked = event.lockHud;
            _isZoomLocked = event.lockHud;
        }

        private static function onTouch(e:TouchEvent):void {
            var firstBoard:DisplayObject = _boards[0];
            isCtrlDown = e.ctrlKey;

            var touches:Vector.<Touch> = e.getTouches(RetrocamelStarlingCore.starlingRoot);

            if (touches.length == 1) {
                var touch:Touch = e.getTouch(RetrocamelStarlingCore.starlingRoot);

                hoverX = touch.globalX;
                hoverY = touch.globalY;

                if (touch.phase == TouchPhase.HOVER) {
                    // Do nothing

                } else if (touch.phase == TouchPhase.BEGAN) {
                    singleTouchX = touch.globalX;
                    singleTouchY = touch.globalY;

                    _initialSlidingX = touch.globalX;
                    _initialSlidingY = touch.globalY;

                    if (!isSingleTouchDown) {
                        isSingleTouchDown = true;
                        isFastforwardTouch = true;
                    }
                } else if (touch.phase == TouchPhase.ENDED) {
                    if (isSingleTouchDown && !_isSliding && !RetrocamelCore.paused && !RetrocamelWindowsManager.isBlocking) {
                        new MonstroEventTap(singleTouchX, singleTouchY);
                    }

                    isSingleTouchDown = false;
                    isFastforwardTouch = false;

                    resetSingleTouch();
                } else if (isSingleTouchDown) {
                    singleTouchX = touch.globalX;
                    singleTouchY = touch.globalY;

                    if (_isSliding && !RetrocamelCore.paused && RetrocamelWindowsManager.numWindows === 0) {
                        if (scrollingEnabled && !_isScrollLocked) {
                            new MonstroEventPlayfieldOffsetChange(touch.globalX - touch.previousGlobalX,
                                    touch.globalY - touch.previousGlobalY);
                        }

                    } else if (UtilsNumber.distance(_initialSlidingX, _initialSlidingY, touch.globalX, touch.globalY) > 100) {
                        _isSliding = true;
                    }
                }

            } else if (touches.length == 2 && MonstroConsts.enableZoomPinch) {
                if (isSingleTouchDown) {
                    isSingleTouchDown = false;
                    isFastforwardTouch = false;
                    resetSingleTouch();
                }

                var touchA:Touch = touches[0];
                var touchB:Touch = touches[1];

                if ((touchA.phase != TouchPhase.MOVED && touchA.phase != TouchPhase.STATIONARY) || (touchB.phase != TouchPhase.MOVED && touchB.phase != TouchPhase.STATIONARY)) {
                    return;
                }

                var currentPosA:Point = touchA.getLocation(RetrocamelStarlingCore.starlingRoot);
                var previousPosA:Point = touchA.getPreviousLocation(RetrocamelStarlingCore.starlingRoot);
                var currentPosB:Point = touchB.getLocation(RetrocamelStarlingCore.starlingRoot);
                var previousPosB:Point = touchB.getPreviousLocation(RetrocamelStarlingCore.starlingRoot);

                var midPoint:Point = currentPosA.add(currentPosB);
                midPoint.x /= 2;
                midPoint.y /= 2;

                var currentVector:Point = currentPosA.subtract(currentPosB);
                var previousVector:Point = previousPosA.subtract(previousPosB);

                var sizeDiff:Number = currentVector.length / previousVector.length;
                var gameScale:Number = firstBoard.scaleX;
                gameScale = Math.min(5, Math.max(0.25, gameScale * sizeDiff));

                var midOnLocal:Point = firstBoard.globalToLocal(midPoint);

                setBoardsScale(gameScale);

                var midAfterScale:Point = firstBoard.localToGlobal(midOnLocal);

                setBoardsPosition(firstBoard.x + midPoint.x - midAfterScale.x, firstBoard.y + midPoint.y - midAfterScale.y);

                forceBoardToFitInConstraints();
            }
        }

        private static function setBoardsPosition(x:Number, y:Number):void {
            for each(var board:DisplayObject in _boards) {
                board.x = x;
                board.y = y;
            }
        }

        private static function setBoardsScale(scale:Number):void {
            for each(var board:DisplayObject in _boards) {
                board.scaleX = scale;
                board.scaleY = scale;
            }
        }

        private static function resetSingleTouch():void {
            _initialSlidingX = 0;
            _initialSlidingY = 0;
            _isSliding = false;
        }

        private static function onRightMouse(e:MouseEvent):void {
            e.preventDefault();
            if (e.type == MouseEvent.RIGHT_MOUSE_DOWN) {
                isRightButtonDown = true;
            } else if (e.type == MouseEvent.RIGHT_MOUSE_UP) {
                isRightButtonDown = false;
            }
        }
    }
}