package game.widgets{    
    import flash.display.BitmapData;
    import flash.geom.Point;
    import flash.geom.Rectangle;
    import flash.utils.getTimer;
    
    import game.global.Game;
    import game.global.Gfx;
    import game.global.Room;
    
    import net.retrocade.camel.core.rGfx;
    import net.retrocade.utils.Rand;
    import net.retrocade.utils.UNumber;

    public class TWidgetFace{
        public  static const MOOD_NORMAL    :uint = 0;
        public  static const MOOD_AGGRESSIVE:uint = 1;
        public  static const MOOD_NERVOUS   :uint = 2;
        public  static const MOOD_STRIKE    :uint = 3;
        public  static const MOOD_HAPPY     :uint = 4;
        public  static const MOOD_DYING     :uint = 5;
        public  static const MOOD_TALKING   :uint = 6;
        private static const MOOD_COUNT     :uint = 7;
        
        private static const FACE_BEETHRO_NORMAL            :uint = 0;
        private static const FACE_BEETHRO_NORMAL_BLINK      :uint = 1;
        private static const FACE_BEETHRO_STRIKE            :uint = 2;
        private static const FACE_NEGOTIATOR                :uint = 3;
        private static const FACE_CITIZEN1                  :uint = 4;
        
        private static const FACE_BEETHRO_AGGRESSIVE        :uint = 5;
        private static const FACE_BEETHRO_AGGRESSIVE_BLINK  :uint = 6;
        private static const FACE_BEETHRO_DYING_1           :uint = 7;
        private static const FACE_TAR_TECHNICIAN            :uint = 8;
        private static const FACE_CITIZEN2                  :uint = 9;
        
        private static const FACE_BEETHRO_NERVOUS           :uint = 10;
        private static const FACE_BEETHRO_NERVOUS_BLINK     :uint = 11;
        private static const FACE_BEETHRO_DYING_2           :uint = 12;
        private static const FACE_MUD_COORDINATOR           :uint = 13;
        private static const FACE_CITIZEN3                  :uint = 14;
        
        private static const FACE_BEETHRO_HAPPY             :uint = 15;
        private static const FACE_BEETHRO_HAPPY_BLINK       :uint = 16;
        private static const FACE_BEETHRO_DYING_3           :uint = 17;
        private static const FACE_GOBLIN                    :uint = 18;
        private static const FACE_CITIZEN4                  :uint = 19;
        
        private static const FACE_BEETHRO_TALKING           :uint = 20;
        private static const FACE_BEETHRO_TALKING_BLINK     :uint = 21;
        
        private static const EYE_MASKS:Array = [
            [0, 6,   55, 19],  //Normal
            [0, 24,  55, 19],  //Aggressive
            [0, 43,  55, 19],  //Nervous
            [0, 100, 55, 19],  //Strike
            [0, 62,  55, 19],  //Happy
            [0, 120, 55, 19],  //Dying
            [0, 82,  55, 19]   //Talking
        ];
        
        private static const EYE_MASK_OFFSET:Array = [
            [46, 35],           //Normal
            [46, 35],           //Aggressive
            [46, 35],           //Nervous
            [46, 35],           //Strike
            [46, 35],           //Happy
            [46, 35],           //Dying
            [46, 35]            //Talking
        ];
        
        private static const LEFT_PUPIL_OFFSET:Array = [
            [9, 11], //Normal
            [9, 11], //Aggressive
            [9, 11], //Nervous
            [9, 11], //Strike
            [9, 11], //Happy
            [9, 11], //Dying
            [9, 11]  //Talking
        ];
        
        private static const FACE_POSITIONS:Array = [
            [1,   1],
            [132, 1],
            [263, 1],
            [394, 1],
            [525, 1],
            
            [1,   166],
            [132, 166],
            [263, 166],
            [394, 166],
            [525, 166],
            
            [1,   331],
            [132, 331],
            [263, 331],
            [394, 331],
            [525, 331],
            
            [1,   496],
            [132, 496],
            [263, 496],
            [394, 496],
            [525, 496],
            
            [1,   661],
            [132, 661]
        ];
        
        private static const FACE_X     :uint = 14;
        private static const FACE_Y     :uint = 14;
        private static const FACE_WIDTH :uint = 130;
        private static const FACE_HEIGHT:uint = 164;
        
        private static const X_BETWEEN_PUPILS:uint = 36;
        
        private static const PUPIL_X:uint = 0;
        private static const PUPIL_Y:uint = 0;
        
        private static const PUPIL_WIDTH :uint = 6;
        private static const PUPIL_HEIGHT:uint = 6;
        
        private static const PUPIL_WIDTH_HALF :uint = 3;
        private static const PUPIL_HEIGHT_HALF:uint = 3;
        
        private static var currentMood :uint = MOOD_NORMAL;
        private static var previousMood:uint = MOOD_NORMAL;
        
        private static var isReading :Boolean = false;
        private static var isBlinking:Boolean = false;
        private static var isSleeping:Boolean = false;
        
        private static var pupilX:int = 0;
        private static var pupilY:int = 0;
        
        private static var pupilTargetX:int = 0;
        private static var pupilTargetY:int = 0;
        
        private static var lastFramePaint:Number = 0;
        private static var lastFramePupil:Number = 0;
        
        private static var delayMood     :uint = 0;
        private static var startDelayMood:Number = 0;
        
        public  static var isMoodDrawn    :Boolean = false;
        private static var doBlinkNextTime:Boolean = false;
        private static var isMoodLocked     :Boolean = false;
        
        private static var speaker        :uint = C.SPEAK_Beethro;
        
        private static var _point1:Point = new Point();
        private static var _point2:Point = new Point();
        private static var _rect  :Rectangle = new Rectangle(PUPIL_X, PUPIL_Y, PUPIL_WIDTH, PUPIL_HEIGHT);
        
        private static var currentFaceX:uint = 1;
        private static var currentFaceY:uint = 1;
        
        private static var dyingFaceFrame:uint = 0;
        
        public static function setMood(newMood:uint, moodDelay:uint = 0, overrideLock:Boolean = false):void{
            if (isMoodLocked && !overrideLock) return;
            
            if (previousMood != newMood && !moodDelay)
                previousMood = newMood;
            
            if (currentMood != newMood){
                currentMood = newMood;
                isMoodDrawn = false;
            }
            
            delayMood      = moodDelay;
            startDelayMood = getTimer();
            
            isSleeping     = false;
        }
        
        public static function setSpeaker(newSpeaker:uint, lockMood:Boolean):void{
            speaker      = newSpeaker;
            isMoodLocked = lockMood;
            isMoodDrawn  = false;
        }
        
        public static function getSpeaker():uint{
            return speaker;
        }
        
        public static function isLocked():Boolean{
            return isMoodLocked;
        }
        
        private static function paint():void{
            var wasBlinking:Boolean = isBlinking;
            
            if (!isSleeping){
                if (isBlinking)
                    isBlinking = false;
                else {
                    if (currentMood == MOOD_STRIKE || currentMood == MOOD_DYING)
                        isBlinking = false;
                    else
                        isBlinking = doBlinkNextTime || ((Rand.om * 20 | 0) == 0);
                }
            }
            
            doBlinkNextTime = false;
            
            setFace();
            
            var doDrawPupils:Boolean = (speaker == C.SPEAK_Beethro && !isBlinking);
            
            if (!isMoodDrawn || isBlinking != wasBlinking || currentMood == MOOD_DYING){
                Game.room.layerUnder.blitRectDirect(FACE_X, FACE_Y, FACE_WIDTH, FACE_HEIGHT, 0xFFFF0000);
                Game.room.layerUnder.drawComplexDirect(Gfx.FACES, FACE_X, FACE_Y, 1,
                    currentFaceX, currentFaceY, FACE_WIDTH, FACE_HEIGHT);
                
                isMoodDrawn = true;
                
            } else if (doDrawPupils){
                clearPupils();
                ASSERT(!isBlinking);
            }
            
            if (doDrawPupils){
                if (getTimer() - lastFramePupil > 200){
                    movePupils();
                    lastFramePupil = getTimer();
                }
                
                clearPupils();
                drawPupils();
                
                ASSERT(!isBlinking);
            }
        }
        
        public static function setReading(reading:Boolean):void{
            isReading = reading;
        }
        
        public static function setSleeping():void{
            setMood(MOOD_TALKING);
            isSleeping  = true;
            isBlinking  = true;
            isMoodDrawn = false;
        }
        
        private static function drawPupils():void{
            ASSERT(!isSleeping);
            ASSERT(!isBlinking);
            ASSERT(isMoodDrawn);
            
            var pupilLeftX:uint = LEFT_PUPIL_OFFSET[currentMood][0] - PUPIL_WIDTH_HALF + pupilX;
            var pupilY:uint = LEFT_PUPIL_OFFSET[currentMood][1] - PUPIL_HEIGHT_HALF + pupilY;
            
            drawPupils_drawOnePupil(
                FACE_X + EYE_MASK_OFFSET[currentMood][0] + pupilLeftX,
                FACE_Y + EYE_MASK_OFFSET[currentMood][1] + pupilY,
                
                EYE_MASKS[currentMood][0],
                EYE_MASKS[currentMood][1])
            
            var pupilRightX:uint = pupilLeftX + X_BETWEEN_PUPILS;
            
            drawPupils_drawOnePupil(
                FACE_X + EYE_MASK_OFFSET[currentMood][0] + pupilRightX,
                FACE_Y + EYE_MASK_OFFSET[currentMood][1] + pupilY,
                
                EYE_MASKS[currentMood][0],
                EYE_MASKS[currentMood][1])
        }
        
        private static function drawPupils_drawOnePupil(x:int, y:int, maskX:int, maskY:int):void{
            _point1.x = x;
            _point1.y = y;
            
            _point2.x = -FACE_X + maskX - EYE_MASK_OFFSET[currentMood][0] + _point1.x;
            _point2.y = -FACE_Y + maskY - EYE_MASK_OFFSET[currentMood][1] + _point1.y;
            
            Game.room.layerUnder.bitmapData.copyPixels(Gfx.EYES,
                _rect, _point1, Gfx.EYES, _point2, true);
        }
        
        private static function clearPupils():void{
            Game.room.layerUnder.drawComplexDirect(Gfx.FACES, 
                FACE_X + EYE_MASK_OFFSET[currentMood][0],
                FACE_Y + EYE_MASK_OFFSET[currentMood][1],
                1,
                currentFaceX + EYE_MASK_OFFSET[currentMood][0],
                currentFaceY + EYE_MASK_OFFSET[currentMood][1],
                EYE_MASKS[currentMood][2],
                EYE_MASKS[currentMood][3]);
        }
        
        private static function movePupils():void{
            var rightBound:int = PUPIL_WIDTH - 1;
            var leftBound :int = - rightBound;
            
            var bottomBound:int = (EYE_MASKS[currentMood][3] - PUPIL_HEIGHT - PUPIL_HEIGHT) / 2;
            var topBound   :int = -bottomBound;
            
            if (currentMood == MOOD_NERVOUS)
                topBound += 2;
            else if (currentMood == MOOD_HAPPY)
                topBound += 1;
            
            if (isReading){
                if (--pupilX < leftBound)
                    pupilX = rightBound;
                pupilY = bottomBound;
            } else {
                switch(currentMood){
                    case(MOOD_DYING):
                    case(MOOD_STRIKE):
                        pupilX = pupilY = 0;
                        break;
                    
                    default:
                        var relaxationLevel:uint = 4;
                        switch(currentMood){
                            case(MOOD_HAPPY): case(MOOD_TALKING): relaxationLevel = 6; break;
                            case(MOOD_AGGRESSIVE): case(MOOD_NERVOUS): relaxationLevel = 0; break;
                        }
                        
                        if (pupilTargetX < leftBound)
                            pupilTargetX = leftBound;
                        else if (pupilTargetX > rightBound)
                            pupilTargetX = rightBound;
                        
                        if (pupilTargetY < topBound)
                            pupilTargetY = topBound;
                        else if (pupilTargetY > bottomBound)
                            pupilTargetY = bottomBound;
                        
                        if (pupilX == pupilTargetX && pupilY == pupilTargetY){
                            if (!relaxationLevel || Rand.u(0, relaxationLevel) == 0){
                                pupilTargetX = Rand.u(0, rightBound - leftBound + 1) + leftBound;
                                pupilTargetY = Rand.u(0, bottomBound - topBound + 1) + topBound;
                            }
                        } else {
                            var xDist:int = pupilTargetX - pupilX;
                            var xSpeed:int = 1 + (Math.abs(xDist) > 2 ? 1 : 0) + (Math.abs(xDist) > 4 ? 1 : 0);
                            pupilX += (xDist > 0 ? xSpeed : xDist < 0 ? -xSpeed : 0);
                            
                            xDist = pupilTargetY - pupilY;
                            pupilY += (xDist > 0 ? 1 : xDist < 0 ? -1 : 0);
                        }
                    break;
                } // End of Switch
            } // End of elseif
            
            if (pupilX < leftBound)
                pupilX = leftBound;
            else if (pupilX > rightBound)
                pupilX = rightBound;
            
            if (pupilY < topBound)
                pupilY = topBound;
            else if (pupilY > bottomBound)
                pupilY = bottomBound;
        }
        
        public static function setFace():void{
            var face:uint = uint.MAX_VALUE;
            
            switch(speaker){
                case(C.SPEAK_Beethro):
                case(C.SPEAK_BeethroInDisguise):
                case(C.SPEAK_Clone):
                    switch(currentMood){
                        case(MOOD_NORMAL):
                            face = (isBlinking ? FACE_BEETHRO_NORMAL_BLINK : FACE_BEETHRO_NORMAL);
                        break;
                        case(MOOD_AGGRESSIVE):
                            face = (isBlinking ? FACE_BEETHRO_AGGRESSIVE_BLINK : FACE_BEETHRO_AGGRESSIVE);
                        break;
                        case(MOOD_HAPPY):
                            face = (isBlinking ? FACE_BEETHRO_HAPPY_BLINK : FACE_BEETHRO_HAPPY);
                        break;
                        case(MOOD_NERVOUS):
                            face = (isBlinking ? FACE_BEETHRO_NERVOUS_BLINK : FACE_BEETHRO_NERVOUS);
                        break;
                        case(MOOD_STRIKE):
                            face = FACE_BEETHRO_STRIKE;
                        break;
                        case(MOOD_TALKING):
                            face = (isBlinking ? FACE_BEETHRO_TALKING_BLINK : FACE_BEETHRO_TALKING);
                        break;
                        case(MOOD_DYING):
                            dyingFaceFrame++;
                            
                            isMoodDrawn = false;
                            
                            switch(dyingFaceFrame & 0x03){
                                case(0):
                                    face = FACE_BEETHRO_DYING_1;
                                break;
                                case(1): case(3):
                                    face = FACE_BEETHRO_DYING_2;
                                break;
                                case(2):
                                    face = FACE_BEETHRO_DYING_3;
                                break;
                            }
                        break;
                    }
                break;
                
                case(C.SPEAK_Citizen1): face = FACE_CITIZEN1; break;
                case(C.SPEAK_Citizen2): face = FACE_CITIZEN2; break;
                case(C.SPEAK_Citizen3): face = FACE_CITIZEN3; break;
                case(C.SPEAK_Citizen4): face = FACE_CITIZEN4; break;
                
                case(C.SPEAK_Goblin):         face = FACE_GOBLIN;          break;
                case(C.SPEAK_TarTechnician):  face = FACE_TAR_TECHNICIAN;  break;
                case(C.SPEAK_MudCoordinator): face = FACE_MUD_COORDINATOR; break;
                case(C.SPEAK_Negotiator):     face = FACE_NEGOTIATOR;      break;
            }
            
            if (face == uint.MAX_VALUE)
                return;
            
            var newCurrentFaceX:uint = FACE_POSITIONS[face][0];
            var newCurrentFaceY:uint = FACE_POSITIONS[face][1];
            
            if (newCurrentFaceX != currentFaceX || newCurrentFaceY != currentFaceY){
                isMoodDrawn = false;
                
                currentFaceX = newCurrentFaceX;
                currentFaceY = newCurrentFaceY;
            }
        }
        
        public static function animate():void{
            var timeNow:Number = getTimer();
            
            if (currentMood != previousMood && (delayMood > 0 && timeNow - startDelayMood > delayMood)){
                currentMood = previousMood;
                isMoodDrawn = false;
                delayMood   = 0;
            }
            
            if (!isMoodDrawn || timeNow - lastFramePaint > 200 ||
                (currentMood == MOOD_DYING && timeNow - lastFramePaint > 50)){
                paint();
                lastFramePaint = timeNow;
            }
        }
    }
}