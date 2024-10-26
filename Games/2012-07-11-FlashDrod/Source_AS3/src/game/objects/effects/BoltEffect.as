package game.objects.effects{
    import flash.display.BitmapData;
    
    import game.global.Gfx;
    import game.managers.effects.VOBitmapSegment;
    import game.managers.effects.VOBoltSegment;
    
    import net.retrocade.camel.core.rGfx;
    import net.retrocade.utils.Rand;
    import net.retrocade.utils.UBitmapData;
    import net.retrocade.utils.UDisplay;

    public class BoltEffect{
        private static const PIECE_LONG_0_180  :VOBitmapSegment = new VOBitmapSegment(1,  55, 30, 4);
        private static const PIECE_LONG_22_202 :VOBitmapSegment = new VOBitmapSegment(40, 5,  28, 14);
        private static const PIECE_LONG_45_225 :VOBitmapSegment = new VOBitmapSegment(15, 5,  24, 23);
        private static const PIECE_LONG_67_247 :VOBitmapSegment = new VOBitmapSegment(1,  12, 13, 26);
        private static const PIECE_LONG_90_270 :VOBitmapSegment = new VOBitmapSegment(71, 22, 4,  29);
        private static const PIECE_LONG_112_292:VOBitmapSegment = new VOBitmapSegment(57, 26, 13, 26);
        private static const PIECE_LONG_135_315:VOBitmapSegment = new VOBitmapSegment(32, 30, 24, 23);
        private static const PIECE_LONG_157_337:VOBitmapSegment = new VOBitmapSegment(3,  40, 28, 14);

        private static const PIECE_SHORT_0_180  :VOBitmapSegment = new VOBitmapSegment(42, 54, 7, 3);
        private static const PIECE_SHORT_22_202 :VOBitmapSegment = new VOBitmapSegment(53, 20, 7, 5);
        private static const PIECE_SHORT_45_225 :VOBitmapSegment = new VOBitmapSegment(45, 20, 7, 6);
        private static const PIECE_SHORT_67_247 :VOBitmapSegment = new VOBitmapSegment(40, 20, 4, 6);
        private static const PIECE_SHORT_90_270 :VOBitmapSegment = new VOBitmapSegment(71, 52, 3, 7);
        private static const PIECE_SHORT_112_292:VOBitmapSegment = new VOBitmapSegment(66, 53, 4, 6);
        private static const PIECE_SHORT_135_315:VOBitmapSegment = new VOBitmapSegment(58, 53, 7, 6);
        private static const PIECE_SHORT_157_337:VOBitmapSegment = new VOBitmapSegment(50, 54, 7, 5);
        
        private static const PIECE_SPARKLE_BIG  :VOBitmapSegment = new VOBitmapSegment(61, 22, 3, 3);
        private static const PIECE_SPARKLE_SMALL:VOBitmapSegment = new VOBitmapSegment(65, 23, 2, 2);
        
        private static const A_0  :uint = 0;
        private static const A_22 :uint = 1;
        private static const A_45 :uint = 2;
        private static const A_67 :uint = 3;
        private static const A_90 :uint = 4;
        private static const A_112:uint = 5;
        private static const A_135:uint = 6;
        private static const A_157:uint = 7;
        private static const A_180:uint = 8;
        private static const A_202:uint = 9;
        private static const A_225:uint = 10;
        private static const A_247:uint = 11;
        private static const A_270:uint = 12;
        private static const A_292:uint = 13;
        private static const A_315:uint = 14;
        private static const A_337:uint = 15;
        
        private static const A_COUNT:uint = 16;
        
        private static const SLOPE_11_25:Number = 0.19891;
        private static const SLOPE_33_75:Number = 0.66818;
        private static const SLOPE_56_25:Number = 1.49661;
        private static const SLOPE_78_75:Number = 5.02737;
        
        private static const LONG_SEGMENTS:Array = [
                new VOBoltSegment(PIECE_LONG_0_180, 1, 1, 27, 0),
                new VOBoltSegment(PIECE_LONG_22_202, 1, 12, 26, -11),
                new VOBoltSegment(PIECE_LONG_45_225, 1, 21, 21, -20),
                new VOBoltSegment(PIECE_LONG_67_247, 1, 24, 10, -23),
                new VOBoltSegment(PIECE_LONG_90_270, 2, 27, 0, -26),
                new VOBoltSegment(PIECE_LONG_112_292, 11, 24, -10, -23),
                new VOBoltSegment(PIECE_LONG_135_315, 22, 21, -22, -21),
                new VOBoltSegment(PIECE_LONG_157_337, 26, 12, -25, -11),
                new VOBoltSegment(PIECE_LONG_0_180, 28, 1, -27, 0),
                new VOBoltSegment(PIECE_LONG_22_202, 26, 1, -25, 11),
                new VOBoltSegment(PIECE_LONG_45_225, 22, 1, -21, 20),
                new VOBoltSegment(PIECE_LONG_67_247, 11, 1, -10, 23),
                new VOBoltSegment(PIECE_LONG_90_270, 2, 1, 0, 26),
                new VOBoltSegment(PIECE_LONG_112_292, 1, 1, 10, 23),
                new VOBoltSegment(PIECE_LONG_135_315, 1, 1, 21, 20),
                new VOBoltSegment(PIECE_LONG_157_337, 1, 1, 25, 11)
            ];
        
        private static const SHORT_SEGMENTS:Array = [
                new VOBoltSegment(PIECE_SHORT_0_180, 0, 1, 5, 0),
                new VOBoltSegment(PIECE_SHORT_22_202, 1, 3, 5, -2),
                new VOBoltSegment(PIECE_SHORT_45_225, 1, 4, 4, -3),
                new VOBoltSegment(PIECE_SHORT_67_247, 1, 4, 1, -4),
                new VOBoltSegment(PIECE_SHORT_90_270, 1, 5, 0, -5),
                new VOBoltSegment(PIECE_SHORT_112_292, 2, 4, -1, -4),
                new VOBoltSegment(PIECE_SHORT_135_315, 5, 4, -4, -3),
                new VOBoltSegment(PIECE_SHORT_157_337, 5, 3, -4, -2),
                new VOBoltSegment(PIECE_SHORT_0_180, 5, 1, -5, 0),
                new VOBoltSegment(PIECE_SHORT_22_202, 5, 1, -4, 2),
                new VOBoltSegment(PIECE_SHORT_45_225, 5, 1, -4, 3),
                new VOBoltSegment(PIECE_SHORT_67_247, 2, 0, -1, 4),
                new VOBoltSegment(PIECE_SHORT_90_270, 1, 0, 0, 5),
                new VOBoltSegment(PIECE_SHORT_112_292, 1, 0, 1, 4),
                new VOBoltSegment(PIECE_SHORT_135_315, 1, 1, 4, 3),
                new VOBoltSegment(PIECE_SHORT_157_337, 1, 1, 4, 2)
            ];
        
        private static const TILE_WIDTH_HALF :Number = S.LEVEL_TILE_WIDTH  / 2;
        private static const TILE_HEIGHT_HALF:Number = S.LEVEL_TILE_HEIGHT / 2;
        
        private static const MAX_POSSIBLE_SIZE:Number = S.LEVEL_WIDTH_PIXELS;
        
        public static function drawBolt(startX:int, startY:int, endX:int, endY:int, targetLayer:BitmapData):void{
            var x:int = startX;
            var y:int = startY;
            
            var sparkleX:int = x + Rand.om * S.LEVEL_TILE_WIDTH  - TILE_WIDTH_HALF;
            var sparkleY:int = y + Rand.om * S.LEVEL_TILE_HEIGHT - TILE_HEIGHT_HALF;
            
            if (Rand.om < 0.5){
                UBitmapData.blitPart(Gfx.BOLTS, targetLayer, sparkleX, sparkleY, 
                    PIECE_SPARKLE_BIG.x, PIECE_SPARKLE_BIG.y, PIECE_SPARKLE_BIG.width, PIECE_SPARKLE_BIG.height);

            } else {
                UBitmapData.blitPart(Gfx.BOLTS, targetLayer, sparkleX, sparkleY, 
                    PIECE_SPARKLE_SMALL.x, PIECE_SPARKLE_SMALL.y, PIECE_SPARKLE_SMALL.width, PIECE_SPARKLE_SMALL.height);

            }
            
            var moveDir          :uint = 0;
            
            var distanceToEnd    :Number = Math.sqrt((x - endX) * (x - endX) + (y - endY) * (y - endY));
            var distanceFromBegin:Number = 0;
            var distanceToClosest:Number = 0;
            
            var moveDirectThreshold:uint;
            var useLongSegment     :Boolean;
            
            var slope              :Number;
            var boltSegment        :VOBoltSegment;
            
            while (distanceToEnd > TILE_WIDTH_HALF){
                distanceFromBegin = Math.sqrt((x - startX) * (x - startX) + (y - startY) * (y - startY));
                distanceToClosest = (distanceFromBegin < distanceToEnd ? distanceFromBegin : distanceToEnd);
                
                if (distanceFromBegin == 0 || distanceToEnd < S.LEVEL_TILE_WIDTH * 3)
                    moveDirectThreshold = 0;
                else
                    moveDirectThreshold = distanceToClosest / MAX_POSSIBLE_SIZE;
                
                if (Rand.om > moveDirectThreshold){ // Move directly
                    if (x - endX == 0){ // Vertical Angle
                        if (y - endY > 0)
                            moveDir = A_90;
                        else {
                            ASSERT(y - endY != 0, "Should not be at the end point");
                            moveDir = A_270;
                        }
                        
                    } else {
                        slope = (y - endY) / (x - endX);
                        if (slope < 0) slope = -slope;
                        
                        if (endY - y < 0){
                            if (endX - x <= 0) {
                                if (slope < SLOPE_11_25)
                                    moveDir = A_180;
                                else if (slope < SLOPE_33_75)
                                    moveDir = A_157;
                                else if (slope < SLOPE_56_25)
                                    moveDir = A_135;
                                else if (slope < SLOPE_78_75)
                                    moveDir = A_112;
                                else
                                    moveDir = A_90;
                            } else {
                                if (slope < SLOPE_11_25)
                                    moveDir = A_0;
                                else if (slope < SLOPE_33_75)
                                    moveDir = A_22;
                                else if (slope < SLOPE_56_25)
                                    moveDir = A_45;
                                else if (slope < SLOPE_78_75)
                                    moveDir = A_67;
                                else
                                    moveDir = A_90;
                            }
                        } else {
                            if (endX - x <= 0) {
                                if (slope < SLOPE_11_25)
                                    moveDir = A_180;
                                else if (slope < SLOPE_33_75)
                                    moveDir = A_202;
                                else if (slope < SLOPE_56_25)
                                    moveDir = A_225;
                                else if (slope < SLOPE_78_75)
                                    moveDir = A_247;
                                else
                                    moveDir = A_270;
                            } else {
                                if (slope < SLOPE_11_25)
                                    moveDir = A_0;
                                else if (slope < SLOPE_33_75)
                                    moveDir = A_337;
                                else if (slope < SLOPE_56_25)
                                    moveDir = A_315;
                                else if (slope < SLOPE_78_75)
                                    moveDir = A_292;
                                else
                                    moveDir = A_270;
                            }
                        }
                    } // end Vertical Angle Else
                    
                    if (distanceToEnd < S.LEVEL_TILE_WIDTH * 3)
                        useLongSegment = false;
                    else
                        useLongSegment = (Rand.om < 0.5);
                } else { // Move Randomly
                    useLongSegment = false;
                    moveDir        = Rand.om * A_COUNT | 0;
                    
                    ASSERT(moveDir >=0 && moveDir < A_COUNT);
                }
                
                
                boltSegment = useLongSegment ? LONG_SEGMENTS[moveDir] : SHORT_SEGMENTS[moveDir];
                
                UBitmapData.blitPart(Gfx.BOLTS, targetLayer,
                    x - boltSegment.xSource,
                    y - boltSegment.ySource,
                    boltSegment.bitmap.x,
                    boltSegment.bitmap.y,
                    boltSegment.bitmap.width,
                    boltSegment.bitmap.height);
                x += boltSegment.xPosition;
                y += boltSegment.yPosition;
                
                sparkleX = x + Rand.om * S.LEVEL_TILE_WIDTH  - TILE_WIDTH_HALF;
                sparkleY = y + Rand.om * S.LEVEL_TILE_HEIGHT - TILE_HEIGHT_HALF;
                
                if (Rand.om < 0.5) {
                    UBitmapData.blitPart(Gfx.BOLTS, targetLayer, sparkleX, sparkleY, 
                        PIECE_SPARKLE_BIG.x, PIECE_SPARKLE_BIG.y, PIECE_SPARKLE_BIG.width, PIECE_SPARKLE_BIG.height);
                } else {
                    UBitmapData.blitPart(Gfx.BOLTS, targetLayer, sparkleX, sparkleY, 
                        PIECE_SPARKLE_SMALL.x, PIECE_SPARKLE_SMALL.y, PIECE_SPARKLE_SMALL.width, PIECE_SPARKLE_SMALL.height);
                }
                
                distanceToEnd = Math.sqrt((x - endX) * (x - endX) + (y - endY) * (y - endY));
            }
        }
    }
}