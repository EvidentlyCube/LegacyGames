package net.retrocade.tacticengine.monstro.core{
    import flash.geom.Point;

    import net.retrocade.camel.global.rCore;
    import net.retrocade.camel.global.rWindows;

    import net.retrocade.starling.rStarling;
    import net.retrocade.tacticengine.monstro.events.MonstroEventPlayfieldOffsetChange;
    import net.retrocade.tacticengine.monstro.events.MonstroEventTap;
    import net.retrocade.tacticengine.monstro.states.MonstroStateIngame;
    import net.retrocade.utils.UNumber;

    import starling.display.DisplayObject;

    import starling.display.Sprite;
    import starling.events.Touch;
    import starling.events.TouchEvent;
    import starling.events.TouchPhase;

    public class SmartTouch{
        public static var isSingleTouchDown:Boolean = false;
        public static var singleTouchX:Number = 0;
        public static var singleTouchY:Number = 0;

        public static var hoverX:Number = 0;
        public static var hoverY:Number = 0;

        private static var _initialSlidingX:int = 0;
        private static var _initialSlidingY:int = 0;
        private static var _isSliding:Boolean = false;
        private static var _boards:Vector.<DisplayObject>;

        public static function hook(boards:Vector.<DisplayObject>):void{
            if (_boards){
                unhook();
            }

            _boards = boards;
            rStarling.starlingRoot.addEventListener(TouchEvent.TOUCH, onTouch);
        }

        public static function unhook():void{
            _boards = null;
            rStarling.starlingRoot.removeEventListener(TouchEvent.TOUCH, onTouch);
        }

        private static function onTouch(e:TouchEvent):void{
            var firstBoard:DisplayObject = _boards[0];

            var touches:Vector.<Touch> = e.getTouches(rStarling.starlingRoot);

            if (touches.length == 1){
                var touch:Touch = e.getTouch(rStarling.starlingRoot);

                hoverX = touch.globalX;
                hoverY = touch.globalY;

                if (touch.phase == TouchPhase.HOVER){
                    // Do nothing

                } else if (touch.phase == TouchPhase.BEGAN){
                    singleTouchX = touch.globalX;
                    singleTouchY = touch.globalY;

                    _initialSlidingX = touch.globalX;
                    _initialSlidingY = touch.globalY;

                    if (!isSingleTouchDown){
                        isSingleTouchDown = true;
                    }
                } else if (touch.phase == TouchPhase.ENDED){
                    if (isSingleTouchDown && !_isSliding && !rCore.paused && !rWindows.isBlocking){
                        new MonstroEventTap(singleTouchX, singleTouchY);
                    }

                    isSingleTouchDown = false;

                    resetSingleTouch();
                } else if (isSingleTouchDown){
                    singleTouchX = touch.globalX;
                    singleTouchY = touch.globalY;

                    if (_isSliding){
                        new MonstroEventPlayfieldOffsetChange(touch.globalX - touch.previousGlobalX, touch.globalY - touch.previousGlobalY);

                    } else if (UNumber.distance(_initialSlidingX, _initialSlidingY, touch.globalX, touch.globalY) > 100){
                        _isSliding = true;
                    }
                }

            } else if (touches.length == 2 && Monstro.enableZoomPinch){
                if (isSingleTouchDown){
                    isSingleTouchDown = false;
                    resetSingleTouch();
                }

                var touchA:Touch = touches[0];
                var touchB:Touch = touches[1];

                if ((touchA.phase != TouchPhase.MOVED && touchA.phase != TouchPhase.STATIONARY) ||
                        (touchB.phase != TouchPhase.MOVED && touchB.phase != TouchPhase.STATIONARY)){
                    return;
                }

                var currentPosA:Point  = touchA.getLocation(rStarling.starlingRoot);
                var previousPosA:Point = touchA.getPreviousLocation(rStarling.starlingRoot);
                var currentPosB:Point  = touchB.getLocation(rStarling.starlingRoot);
                var previousPosB:Point = touchB.getPreviousLocation(rStarling.starlingRoot);

                var midPoint:Point = currentPosA.add(currentPosB);
                midPoint.x /= 2;
                midPoint.y /= 2;

                var currentVector:Point  = currentPosA.subtract(currentPosB);
                var previousVector:Point = previousPosA.subtract(previousPosB);

                var sizeDiff:Number = currentVector.length / previousVector.length;
                var gameScale:Number = firstBoard.scaleX;
                gameScale = Math.min(5, Math.max(0.25, gameScale * sizeDiff));

                var midOnLocal:Point = firstBoard.globalToLocal(midPoint);

                setBoardsScale(gameScale);

                var midAfterScale:Point = firstBoard.localToGlobal(midOnLocal);

                setBoardsPosition(
                        firstBoard.x + midPoint.x - midAfterScale.x,
                        firstBoard.y + midPoint.y - midAfterScale.y
                );

                forceBoardToFitInConstraints();
            }
        }

        private static function setBoardsPosition(x:Number, y:Number):void{
            for each(var board:DisplayObject in _boards){
                board.x = x;
                board.y = y;
            }
        }

        private static function setBoardsScale(scale:Number):void{
            for each(var board:DisplayObject in _boards){
                board.scaleX = scale;
                board.scaleY = scale;
            }
        }

        public static function forceBoardToFitInConstraints():void{
            var firstBoard:DisplayObject = _boards[0];
            var forcedX:Number;
            var forcedY:Number;

            if (firstBoard.width < S().playfieldWidth){
                forcedX = Math.max(-S().playfieldWidth / 4, Math.min(S().playfieldWidth * 4/3 - firstBoard.width, firstBoard.x));
            } else {
                forcedX = Math.min(S().playfieldWidth / 4, Math.max(S().playfieldWidth * 3 / 4 - firstBoard.width, firstBoard.x));
            }

            if (firstBoard.height < S().playfieldHeight){
                forcedY = Math.max(- S().playfieldHeight, Math.min(S().playfieldHeight * 4/3 - firstBoard.height, firstBoard.y));
            } else {
                forcedY = Math.min(S().playfieldHeight / 4, Math.max(S().playfieldHeight - firstBoard.height, firstBoard.y));
            }

            setBoardsPosition(forcedX, forcedY);
        }

        private static function resetSingleTouch():void{
            _initialSlidingX = 0;
            _initialSlidingY = 0;
            _isSliding = false;
        }
    }
}