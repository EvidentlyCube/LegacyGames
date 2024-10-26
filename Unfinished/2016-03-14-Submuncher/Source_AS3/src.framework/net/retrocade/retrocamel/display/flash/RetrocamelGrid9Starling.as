/*
 * Copyright (C) 2013 Maurycy Zarzycki
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING B NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

package net.retrocade.retrocamel.display.flash {
    import flash.geom.Rectangle;

    import starling.display.DisplayObject;
    import starling.display.Image;
    import starling.display.Sprite;
    import starling.textures.Texture;
    import starling.textures.TextureSmoothing;

    /**
     * ...
     * @author Maurycy Zarzycki
     */
    public class RetrocamelGrid9Starling extends Sprite {
        private var _topLeft:Image;
        private var _top:Image;
        private var _topRight:Image;
        private var _left:Image;
        private var _center:Image;
        private var _right:Image;
        private var _bottomLeft:Image;
        private var _bottom:Image;
        private var _bottomRight:Image;

        private var _spaceLeft:int;
        private var _spaceTop:int;
        private var _spaceBottom:int;
        private var _spaceRight:int;

        public function RetrocamelGrid9Starling(texture:Texture, innerRectangle:Rectangle, outerRectangle:Rectangle = null) {
            if (!outerRectangle) {
                outerRectangle = new Rectangle(0, 0, texture.width, texture.height);
            }

            _spaceLeft = innerRectangle.x;
            _spaceTop = innerRectangle.y;
            _spaceRight = outerRectangle.width - innerRectangle.right;
            _spaceBottom = outerRectangle.height - innerRectangle.bottom;

            _topLeft = new Image(Texture.fromTexture(texture, new Rectangle(
                outerRectangle.x,
                outerRectangle.y,
                innerRectangle.x,
                innerRectangle.y
            )));
            _top = new Image(Texture.fromTexture(texture, new Rectangle(
                    outerRectangle.x + innerRectangle.x,
                outerRectangle.y,
                innerRectangle.width,
                innerRectangle.y
            )));
            _topRight = new Image(Texture.fromTexture(texture, new Rectangle(
                    outerRectangle.x + innerRectangle.right,
                outerRectangle.y,
                _spaceRight,
                innerRectangle.y)));
            _left = new Image(Texture.fromTexture(texture, new Rectangle(
                outerRectangle.x,
                    outerRectangle.y + innerRectangle.y,
                innerRectangle.x,
                innerRectangle.height
            )));
            _center = new Image(Texture.fromTexture(texture, new Rectangle(
                    outerRectangle.x + innerRectangle.x,
                    outerRectangle.y + innerRectangle.y,
                innerRectangle.width,
                innerRectangle.height
            )));
            _right = new Image(Texture.fromTexture(texture, new Rectangle(
                    outerRectangle.x + innerRectangle.right,
                    outerRectangle.y + innerRectangle.y,
                _spaceRight,
                innerRectangle.height
            )));
            _bottomLeft = new Image(Texture.fromTexture(texture, new Rectangle(
                outerRectangle.x,
                    outerRectangle.y + innerRectangle.bottom,
                innerRectangle.x,
                _spaceBottom
            )));
            _bottom = new Image(Texture.fromTexture(texture, new Rectangle(
                    outerRectangle.x + innerRectangle.x,
                    outerRectangle.y + innerRectangle.bottom,
                innerRectangle.width,
                _spaceBottom
            )));
            _bottomRight = new Image(Texture.fromTexture(texture, new Rectangle(
                    outerRectangle.x + innerRectangle.right,
                    outerRectangle.y + innerRectangle.bottom,
                _spaceRight,
                _spaceBottom
            )));

            addChild(_center);
            addChild(_left);
            addChild(_right);
            addChild(_top);
            addChild(_bottom);
            addChild(_topLeft);
            addChild(_topRight);
            addChild(_bottomLeft);
            addChild(_bottomRight);

            _top.x = innerRectangle.x;
            _center.x = innerRectangle.x;
            _bottom.x = innerRectangle.x;
            _topRight.x = innerRectangle.right;
            _right.x = innerRectangle.right;
            _bottomRight.x = innerRectangle.right;

            _left.y = innerRectangle.y;
            _center.y = innerRectangle.y;
            _right.y = innerRectangle.y;
            _bottomLeft.y = innerRectangle.bottom;
            _bottom.y = innerRectangle.bottom;
            _bottomRight.y = innerRectangle.bottom;

            width = innerRectangle.width;
            height = innerRectangle.height;
        }

        public function set innerX(value:Number):void {
            this.x = value - _spaceLeft | 0;
        }

        public function set innerY(value:Number):void {
            this.y = value - _spaceTop | 0;
        }

        public function get innerX():Number {
            return this.x + _spaceLeft | 0;
        }

        public function get innerY():Number {
            return this.y + _spaceTop | 0;
        }

        public function set innerWidth(value:Number):void {
            this.width = value + _spaceLeft + _spaceRight + 1 | 0;
        }

        public function set innerHeight(value:Number):void {
            this.height = value + _spaceTop + _spaceBottom + 1 | 0;
        }

        public function get innerWidth():Number {
            return this.width - _spaceLeft - _spaceRight - 1 | 0;
        }

        public function get innerHeight():Number {
            return this.height - _spaceTop - _spaceBottom - 1 | 0;
        }

        override public function set width(value:Number):void {
            if (value < _spaceLeft + _spaceRight + 1) {
                value = _spaceLeft + _spaceRight + 1;
            }

            var midWidth:Number = value - _spaceLeft - _spaceRight;

            _top.width = midWidth;
            _center.width = midWidth;
            _bottom.width = midWidth;
            _topRight.x = value - _spaceRight;
            _right.x = value - _spaceRight;
            _bottomRight.x = value - _spaceRight;
        }

        override public function set height(value:Number):void {
            if (value < _spaceTop + _spaceBottom + 1) {
                value = _spaceTop + _spaceBottom + 1;
            }

            var midHeight:Number = value - _spaceTop - _spaceBottom;

            _left.height = midHeight;
            _center.height = midHeight;
            _right.height = midHeight;
            _bottomLeft.y = value - _spaceBottom;
            _bottom.y = value - _spaceBottom;
            _bottomRight.y = value - _spaceBottom;
        }

        override public function dispose():void {
            removeChildren();

            _topLeft.dispose();
            _top.dispose();
            _topRight.dispose();
            _left.dispose();
            _center.dispose();
            _right.dispose();
            _bottomLeft.dispose();
            _bottom.dispose();
            _bottomRight.dispose();

            _topLeft = null;
            _top = null;
            _topRight = null;
            _left = null;
            _center = null;
            _right = null;
            _bottomLeft = null;
            _bottom = null;
            _bottomRight = null;

            super.dispose();
        }

        public function set smoothing(value:String):void {
            if (!TextureSmoothing.isValid(value)) {
                throw new ArgumentError("Inavlid smoothing type: " + value);
            }

            _topLeft.smoothing = value;
            _top.smoothing = value;
            _topRight.smoothing = value;
            _left.smoothing = value;
            _center.smoothing = value;
            _right.smoothing = value;
            _bottomLeft.smoothing = value;
            _bottom.smoothing = value;
            _bottomRight.smoothing = value;
        }

        public function innerWrapAround(...rest:Array):void {
            var minX:Number = Number.MAX_VALUE;
            var maxX:Number = Number.MIN_VALUE;
            var minY:Number = Number.MAX_VALUE;
            var maxY:Number = Number.MIN_VALUE;

            for each(var displayObject:DisplayObject in rest) {
                minX = Math.min(displayObject.x, minX);
                minY = Math.min(displayObject.y, minY);
                maxX = Math.max(displayObject.right, maxX);
                maxY = Math.max(displayObject.bottom, maxY);
            }

            innerX = minX;
            innerY = minY;
            innerWidth = maxX - minX;
            innerHeight = maxY - minY;
        }


        public function wrapAround(displayObject:DisplayObject):void {
            innerWidth = displayObject.width;
            innerHeight = displayObject.height;
            displayObject.x = _spaceLeft + x;
            displayObject.y = _spaceTop + y;
        }

        public function get spaceLeft():int {
            return _spaceLeft;
        }

        public function get spaceTop():int {
            return _spaceTop;
        }

        public function get spaceBottom():int {
            return _spaceBottom;
        }

        public function get spaceRight():int {
            return _spaceRight;
        }
    }
}