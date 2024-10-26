/*
 * Copyright (C) 2013 Maurycy Zarzycki
 * Unless stated otherwise in the rest of the source file
 *
 * Permission is hereby granted, free of charge, to any person obtaining
 * a copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included
 * in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
 * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 */

/**
 * Created by Skell on 09.11.13.
 */
package net.retrocade.collision {

    import flash.display.BitmapData;
    import flash.display.BlendMode;
    import flash.geom.ColorTransform;
    import flash.geom.Matrix;
    import flash.geom.Point;
    import flash.geom.Rectangle;

    import net.retrocade.utils.UtilsNumber;

    public class CollisionManager {
        [Inline]
        public static function checkCollision(objectLeft:CollisionShapeBase, objectRight:CollisionShapeBase):Boolean {
            if (!objectRight || !objectRight) {
                return false;
            }

            return objectLeft.collide(objectRight);
        }

        [Inline]
        public static function shapesCircleCircle(circleLeft:CollisionShapeCircle, circleRight:CollisionShapeCircle):Boolean {
            return circleCircle(
                circleLeft.x,
                circleLeft.y,
                circleLeft.radius,
                circleRight.x,
                circleRight.y,
                circleRight.radius
            );
        }


        [Inline]
        public static function shapesCircleLine(circle:CollisionShapeCircle, line:CollisionShapeLine):Boolean {
            return circleLine(
                circle.x,
                circle.y,
                circle.radius,
                line.x,
                line.y,
                line.endX,
                line.endY
            );
        }

        [Inline]
        public static function shapesCirclePolygon(circle:CollisionShapeCircle, polygon:CollisionShapePolygon):Boolean{
            return circlePolygon(
                circle.x,
                circle.y,
                circle.radius,
                polygon
            );
        }

        [Inline]
        public static function shapesCircleRectangle(circle:CollisionShapeCircle, rectangle:CollisionShapeRectangle):Boolean {
            return circleRectangle(
                circle.x,
                circle.y,
                circle.radius,
                rectangle.x,
                rectangle.y,
                rectangle.width,
                rectangle.height
            );
        }

        [Inline]
        public static function shapesLineLine(lineLeft:CollisionShapeLine, lineRight:CollisionShapeLine):Boolean {
            return lineLine(
                lineLeft.x,
                lineLeft.y,
                lineLeft.endX,
                lineLeft.endY,
                lineRight.x,
                lineRight.y,
                lineRight.endX,
                lineRight.endY
            );
        }

        [Inline]
        public static function shapesPolygonRectangle(polygon:CollisionShapePolygon, rectangle:CollisionShapeRectangle):Boolean{
            return polygonRectangle(
                rectangle.x,
                rectangle.y,
                rectangle.width,
                rectangle.height,
                polygon
            );
        }

        [Inline]
        public static function shapesRectangleRectangle(rectangleLeft:CollisionShapeRectangle, rectangleRight:CollisionShapeRectangle):Boolean {
            return rectangleRectangle(
                rectangleLeft.x,
                rectangleLeft.y,
                rectangleLeft.width,
                rectangleLeft.height,
                rectangleRight.x,
                rectangleRight.y,
                rectangleRight.width,
                rectangleRight.height
            );
        }

        [Inline]
        public static function circleCircle(aX:Number, aY:Number, aRadius:Number, bX:Number, bY:Number, bRadius:Number):Boolean {
            var radiusSum:Number = aRadius + bRadius;
            var distanceSquared:Number = UtilsNumber.distanceSquared(aX, aY, bX, bY);

            return distanceSquared <= radiusSum * radiusSum;
        }

        [Inline]
        public static function circleLine(circleX:Number, circleY:Number, cRadius:Number, lineX1:Number, lineY1:Number, lineX2:Number, lineY2:Number):Boolean {
            var a:Number = (lineX2 - lineX1) * (lineX2 - lineX1) + (lineY2 - lineY1) * (lineY2 - lineY1);
            var b:Number = 2 * ((lineX2 - lineX1) * (lineX1 - circleX) + (lineY2 - lineY1) * (lineY1 - circleY));
            var c:Number = circleX * circleX + circleY * circleY + lineX1 * lineX1 + lineY1 * lineY1 - 2 * (circleX * lineX1 + circleY * lineY1) - cRadius * cRadius;
            var delta:Number = b * b - 4 * a * c;

            if (delta >= 0) {
                var sqrd:Number = Math.sqrt(delta);
                var u1:Number = (-b - sqrd) / (2 * a);
                var u2:Number = (-b + sqrd) / (2 * a);
                if ((u1 >= 0 && u1 <= 1) || (u2 >= 0 && u2 <= 1)) {
                    return true;
                }
            }

            return false;
        }

        [Inline]
        public static function circlePolygon(cX:Number, cY:Number, cRadius:Number, polygon:CollisionShapePolygon):Boolean {
            var i:uint;
            var l:uint = polygon.linesCount;
            var line:CollisionShapeLine = new CollisionShapeLine(0, 0, 0, 0, 0, 0);

            for (i = 0; i < l; i++) {
                polygon.getLine(i, line);

                if (circleLine(cX, cY, cRadius, line.x, line.y, line.endX, line.endY)) {
                    return true;
                }
            }

            return pointInPolygon(cX, cY, polygon);
        }

        [Inline]
        public static function circleRectangle(cX:Number, cY:Number, cRadius:Number, rX:Number, rY:Number, rWidth:Number, rHeight:Number):Boolean {
            rWidth--;
            rHeight--;

            return circleLine(cX, cY, cRadius, rX, rY, rX + rWidth, rY) ||
                circleLine(cX, cY, cRadius, rX, rY, rX, rY + rHeight) ||
                circleLine(cX, cY, cRadius, rX + rWidth, rY, rX + rWidth, rY + rHeight) ||
                circleLine(cX, cY, cRadius, rX, rY + rHeight, rX + rWidth, rY + rHeight);
        }

        [Inline]
        public static function lineLine(aX1:Number, aY1:Number, aX2:Number, aY2:Number, bX1:Number, bY1:Number, bX2:Number, bY2:Number):Boolean {
            var Ua:Number = ((bX2 - bX1) * (aY1 - bY1) - (bY2 - bY1) * (aX1 - bX1)) / ((bY2 - bY1) * (aX2 - aX1) - (bX2 - bX1) * (aY2 - aY1));
            var Ub:Number = ((aX2 - aX1) * (aY1 - bY1) - (aY2 - aY1) * (aX1 - bX1)) / ((bY2 - bY1) * (aX2 - aX1) - (bX2 - bX1) * (aY2 - aY1));

            return (Ua < 1 && Ua > 0 && Ub < 1 && Ub > 0) || (Ua == 0 && Ub == 0);
        }

        [Inline]
        public static function linePolygon(lX1:Number, lY1:Number, lX2:Number, lY2:Number, polygon:CollisionShapePolygon):Boolean {
            return polygon.lineIntersects(lX1, lY1, lX2, lY2);
        }

        [Inline]
        public static function polygonRectangle(rX:Number, rY:Number, rWidth:Number, rHeight:Number, polygon:CollisionShapePolygon):Boolean {
            return polygon.lineIntersects(rX, rY, rX + rWidth, rY) ||
                polygon.lineIntersects(rX, rY, rX, rY + rHeight) ||
                polygon.lineIntersects(rX + rWidth, rY, rX + rWidth, rY + rHeight) ||
                polygon.lineIntersects(rX, rY + rHeight, rX + rWidth, rY + rHeight);
        }

        [Inline]
        public static function rectangleRectangle(aX:Number, aY:Number, aWidth:Number, aHeight:Number, bX:Number, bY:Number, bWidth:Number, bHeight:Number):Boolean {
            return (aX < bX + bWidth) &&
                (bX < aX + aWidth) &&
                (aY < bY + bHeight) &&
                (bY < aY + aHeight);
        }

        [Inline]
        public static function circlePoint(cX:Number, cY:Number, cRadius:Number, pX:Number, pY:Number):Boolean {
            var distanceSquared:Number = UtilsNumber.distanceSquared(cX, cY, pX, pY);

            return distanceSquared <= cRadius * cRadius;
        }

        [Inline]
        /**
         * Using algorithm from: http://alienryderflex.com/polygon/
         */
        public static function pointInPolygon(pX:Number, pY:Number, polygon:CollisionShapePolygon):Boolean {
            var i:uint;
            var l:uint = polygon.pointsCount;

            var linesTouched:uint = 0;

            for (i = 0; i < l; i++) {
                var pointLeft:Point = polygon.getPoint(i);
                var pointRight:Point = polygon.getPoint(i + 1);

                if (lineLine(pX, pY, pX + polygon.maxPointDistance, pY, pointLeft.x, pointLeft.y, pointRight.x, pointRight.y)) {
                    linesTouched++;
                }
            }

            return (linesTouched & 0x1) === 1;
        }

        [Inline]
        public static function shapesPolygonPolygon(polygonLeft:CollisionShapePolygon, polygonRight:CollisionShapePolygon):Boolean {
            return polygonLeft.hasPointIn(polygonRight) ||
                polygonRight.hasPointIn(polygonLeft) ||
                polygonLeft.anySideIntersectsWith(polygonRight) ||
                polygonRight.anySideIntersectsWith(polygonLeft);
        }

        private static var _bitmapData:BitmapData;
        private static var _rect:Rectangle;

        private static var _ct:ColorTransform;

        private static var _mtx1:Matrix;
        private static var _mtx2:Matrix;

        public static function initBitmapCollision(width:uint, height:uint):void{
            _bitmapData = new BitmapData(width, height);
            _rect = new Rectangle(0, 0, width, height);

            _ct = new ColorTransform(1, 1, 1, 1, 255, -255, -255, 0);

            _mtx1 = new Matrix();
            _mtx2 = new Matrix();
        }


        public static function bitmap(_gfx1:BitmapData, _x1:Number, _y1:Number, scaleX1:Number, scaleY1:Number, rotation1:Number,
                                      _gfx2:BitmapData, _x2:Number, _y2:Number, scaleX2:Number, scaleY2:Number, rotation2:Number):Boolean{

            _bitmapData.fillRect(_rect, 0);

            if (_x1 < _x2){
                _x2 -= _x1;
                _x1 = 0;
            } else {
                _x1 -= _x2;
                _x2 = 0;
            }

            if (_y1 < _y2){
                _y2 -= _y1;
                _y1 = 0;
            } else {
                _y1 -= _y2;
                _y2 = 0;
            }

            _x1 += 15;
            _x2 += 15;
            _y1 += 15;
            _y2 += 15;

            _mtx1.identity();
            _mtx2.identity();

            _mtx1.translate(- _gfx1.width / 2, - _gfx1.height / 2);
            _mtx2.translate(- _gfx2.width / 2, - _gfx2.height / 2);

            _mtx1.scale(scaleX1, scaleY1);
            _mtx2.scale(scaleX2, scaleY2);

            _mtx1.rotate(rotation1 * Math.PI / 180);
            _mtx2.rotate(rotation2 * Math.PI / 180);

            _mtx1.translate(_x1 + _gfx1.width * scaleX1 / 2, _y1 + _gfx1.height * scaleY1 / 2);
            _mtx2.translate(_x2 + _gfx2.width * scaleX2 / 2, _y2 + _gfx2.height * scaleY2 / 2);

            _bitmapData.draw(_gfx1, _mtx1, _ct, BlendMode.NORMAL);
            _bitmapData.draw(_gfx2, _mtx2, _ct, BlendMode.DIFFERENCE);

            return (_bitmapData.getColorBoundsRect(0xFFFFFFFF, 0xFF000000).width) > 0;
        }
    }
}
