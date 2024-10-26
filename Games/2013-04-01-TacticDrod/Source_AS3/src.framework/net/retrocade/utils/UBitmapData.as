package net.retrocade.utils{
    import flash.display.BitmapData;
    import flash.display.IBitmapDrawable;
    import flash.geom.ColorTransform;
    import flash.geom.Matrix;
    import flash.geom.Point;
    import flash.geom.Rectangle;

    public class UBitmapData{
        private static var POINT         :Point          = new Point();
        private static var MATRIX        :Matrix         = new Matrix();
        private static var RECT          :Rectangle      = new Rectangle();
        private static var COLORTRANSFORM:ColorTransform = new ColorTransform();

        /**
         * Returns a mirrored BitmapData, the original is unmodified
         * @param data BitmapData to be mirrored
         * @return New, mirrored BitmapData
         */
        public static function mirror(data:BitmapData):BitmapData{
            var m:Matrix = new Matrix();
            m.scale(-1, 1);
            m.translate(data.width, 0);

            var bitmapData:BitmapData = new BitmapData(data.width, data.height, true, 0);
            bitmapData.draw(data, m);

            return bitmapData;
        }

        public static function blit(source:BitmapData, target:BitmapData, x:uint, y:uint):void{
            POINT.x     = x;
            POINT.y     = y;

            target.copyPixels(source, source.rect, POINT, null, null, true);
        }

        /**
         * Blits a designated BitmapData's region to another BitmapData
         * @param source Source BitmapData
         * @param target Target BitmapData
         * @param x Target draw position
         * @param y Target draw position
         * @param sourceX X of the top-left corner of the source rectangle
         * @param sourceY Y of the top-left corner of the source rectangle
         * @param sourceWidth Width of the source rectangle
         * @param sourceHeight Height of the source rectangle
         */
        public static function blitPart(source:BitmapData, target:BitmapData, x:int, y:int, sourceX:uint, sourceY:uint,
                                        sourceWidth:uint, sourceHeight:uint):void{
            RECT.x      = sourceX;
            RECT.y      = sourceY;
            RECT.width  = sourceWidth;
            RECT.height = sourceHeight;

            POINT.x     = x;
            POINT.y     = y;

            target.copyPixels(source, RECT, POINT, null, null, true);
        }

        /**
         * Applies a ColorTransform to a given BitmapData
         * @param data BitmapData to be colorized
         * @param redMulti
         * @param greenMulti
         * @param blueMulti
         * @param redOffset
         * @param greenOffset
         * @param blueOffset
         */
        public static function colorize(data:BitmapData, redMulti:Number, greenMulti:Number, blueMulti:Number, redOffset:int, greenOffset:int, blueOffset:int):void{
            COLORTRANSFORM = new ColorTransform(redMulti, greenMulti, blueMulti, 1, redOffset, greenOffset, blueOffset, 0);
            data.colorTransform(data.rect, COLORTRANSFORM);
        }

        public static function draw(source:IBitmapDrawable, target:BitmapData, x:int, y:int):void {
            MATRIX.identity();
            MATRIX.translate(x, y);
            target.draw(source, MATRIX);
        }

        public static function drawPart(source:IBitmapDrawable, target:BitmapData, x:int, y:int, sourceX:uint,
                                          sourceY:uint, sourceWidth:uint, sourceHeight:uint):void{

            MATRIX.identity();
            MATRIX.translate(x - sourceX, y - sourceY);

            RECT.x      = x;
            RECT.y      = y;
            RECT.width  = sourceWidth;
            RECT.height = sourceHeight;

            target.draw(source, MATRIX, null, null, RECT);
        }

        public static function shapeRectangle(data:BitmapData, x:uint, y:uint, w:uint, h:uint, color:uint, alpha:Number):void {
            RECT.x      = x;
            RECT.y      = y;
            RECT.width  = w;
            RECT.height = h;

                 if (alpha < 0) alpha = 0;
            else if (alpha > 1) alpha = 1;

            alpha = alpha * 255 | 0;

            color = (color & 0xFFFFFF) | (alpha << 24);

            data.fillRect(RECT, color);
        }
    }
}