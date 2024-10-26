package{
    import flash.geom.Point;
    import flash.events.MouseEvent;
    import flash.events.KeyboardEvent;
    import flash.ui.Keyboard;

    import game.global.Game;
    import game.global.Minimap;
    import game.objects.TCursor;
    import game.states.TStateGame;

    import net.retrocade.camel.global.rCore;
    import net.retrocade.camel.global.rWindows;
    import net.retrocade.starling.rStarling;
    import net.retrocade.utils.UNumber;

    import starling.display.Sprite;
    import starling.events.Touch;
    import starling.events.TouchEvent;
    import starling.events.TouchPhase;

    public class SmartTouch{
        private static var boardTouch1Id :int = -1;
        private static var boardTouch2Id :int = -1;

        public static var isSingleTouchDown:Boolean = false;
        public static var singleTouchX:Number = 0;
        public static var singleTouchY:Number = 0;

        private static var initialDistance:Number = NaN;
        private static var isZooming:Boolean = false;
        private static var isSpaceScrolling:Boolean = false;
        private static var lastSpaceScrollMousePosition:Point = null;

        public static function forceSingleTouchRelease():void{
            if (isSingleTouchDown){
                isSingleTouchDown = false;
                TCursor.self.touchEnd(true);
            }
        }

        public static function hook():void{
            rStarling.starlingRoot.addEventListener(TouchEvent.TOUCH, onTouch);

        }

        public static function unhook():void{
            rStarling.starlingRoot.removeEventListener(TouchEvent.TOUCH, onTouch);
        }

        private static function onTouch(e:TouchEvent):void{
            var touches:Vector.<Touch> = e.getTouches(rStarling.starlingRoot);

            if (!(rCore.currentState is TStateGame) || rCore.paused || rWindows.pauseGame){
                forceSingleTouchRelease();
                return;
            }

            if (touches.length != 2){
                initialDistance = NaN;
                isZooming = false;
            }

            if (touches.length == 1){
                var touch:Touch = e.getTouch(rStarling.starlingRoot);

                if (Minimap.instance.isTouchOnMinimap(touch)){
                    if (touch.phase != TouchPhase.HOVER)
                        Minimap.instance.touchedMinimap(touch);

                } else if (touch.phase == TouchPhase.HOVER){
                    return;
                } else if (touch.phase == TouchPhase.BEGAN){
                    singleTouchX = touch.globalX;
                    singleTouchY = touch.globalY;

                    if (isSingleTouchDown){
                        TCursor.self.touchEnd(true);
                        TCursor.self.touchBegin();
                    } else {
                        TCursor.self.touchBegin();
                        isSingleTouchDown = true;
                    }
                } else if (touch.phase == TouchPhase.ENDED){
                    if (isSingleTouchDown){
                        TCursor.self.touchEnd(false);
                        isSingleTouchDown = false;
                    }
                } else if (isSingleTouchDown){
                    singleTouchX = touch.globalX;
                    singleTouchY = touch.globalY;
                }

            } else if (touches.length == 2){
                // Zooming is broken!
                return;
                if (isSingleTouchDown){
                    TCursor.self.touchEnd(true);
                    isSingleTouchDown = false;
                }

                var board:Sprite = Game.lStarling.starlingSprite;

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

                var deltaA:Point = currentPosA.subtract(previousPosA);
                var deltaB:Point = currentPosB.subtract(previousPosB);
                var delta :Point = new Point((deltaA.x + deltaB.x) / 2, (deltaA.y + deltaB.y) / 2);

                var fingerDistance:Number = Math.sqrt(UNumber.distance(currentPosA.x, currentPosA.y, currentPosB.x, currentPosB.y));
                var midPoint:Point = currentPosA.add(currentPosB);
                midPoint.x /= 2;
                midPoint.y /= 2;

                var currentVector:Point  = currentPosA.subtract(currentPosB);
                var previousVector:Point = previousPosA.subtract(previousPosB);

                var deltaCalcPrev:Point = board.localToGlobal(new Point(0, 0));
                var deltaCalcAfter:Point = board.localToGlobal(new Point(delta.x, delta.y));

                board.x += delta.x / 2;
                board.y += delta.y / 2;

                if (isNaN(initialDistance)){
                    initialDistance = fingerDistance;
                } else if (Math.abs(fingerDistance - initialDistance) > S().gameDiameter / 6){
                    isZooming = true;
                }

                // scale
                var sizeDiff:Number = currentVector.length / previousVector.length;
                if (isZooming){
                    S().zoomInFactor = Math.min(3, Math.max(1, S().zoomInFactor * Math.sqrt(sizeDiff)));
                }

                var midOnLocal:Point = board.globalToLocal(midPoint);

                board.scaleX = S().gameScale;
                board.scaleY = S().gameScale;

                var midAfterScale:Point = board.localToGlobal(midOnLocal);

                board.x += midPoint.x - midAfterScale.x;
                board.y += midPoint.y - midAfterScale.y;

                forceBoardToFitInConstraints();

                Minimap.instance.minimapScrolled();
            }
        }

        public static function setXYFactor(xFactor:Number, yFactor:Number):void{
            var board:Sprite = Game.lStarling.starlingSprite;

            var leftEdge:Number = S().playfieldOffsetX;
            var rightEdge:Number = S().gameWidth - board.width;
            var topEdge:Number = S().playfieldOffsetY;
            var bottomEdge:Number = S().gameHeight - board.height;

            var xOffset:Number = rightEdge - leftEdge;
            var yOffset:Number = bottomEdge - topEdge;
            leftEdge -= xOffset / 2;
            rightEdge += xOffset / 2;
            topEdge -= yOffset / 2;
            bottomEdge += yOffset / 2;

            board.x = leftEdge + xFactor * (rightEdge - leftEdge);
            board.y = topEdge + yFactor * (bottomEdge - topEdge);

            forceBoardToFitInConstraints();
            Minimap.instance.minimapScrolled();
        }

        public static function forceBoardToFitInConstraints():void{
            var board:Sprite = Game.lStarling.starlingSprite;

            if (board.width < S().gameWidth - S().playfieldOffsetX)
                board.x = Math.max(-S().gameWidth / 4, Math.min(S().gameWidth * 4/3 - board.width, board.x));
            else
                board.x = Math.min(S().gameWidth / 4, Math.max(S().gameWidth * 3 / 4 - board.width, board.x));

            if (board.height < S().gameHeight - S().playfieldOffsetY)
                board.y = Math.max(- S().gameHeight, Math.min(S().gameHeight * 4/3 - board.height, board.y));
            else
                board.y = Math.min(S().gameHeight / 4, Math.max(S().gameHeight - board.height, board.y));
        }
    }
}