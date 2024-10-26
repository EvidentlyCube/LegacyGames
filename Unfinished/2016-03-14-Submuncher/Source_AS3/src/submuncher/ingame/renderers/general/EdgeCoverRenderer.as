package submuncher.ingame.renderers.general {
    import flash.geom.Rectangle;

    import starling.display.DisplayObject;

    import starling.display.Image;

    import starling.display.Sprite;
    import starling.textures.Texture;
    import starling.textures.TextureSmoothing;

    import submuncher.core.constants.Gfx;

    public class EdgeCoverRenderer extends Sprite{
        private var _topLeft:Image;
        private var _top:Image;
        private var _topRight:Image;
        private var _left:Image;
        private var _right:Image;
        private var _bottomLeft:Image;
        private var _bottom:Image;
        private var _bottomRight:Image;

        private var _borderFillerTop:Image;
        private var _borderFillerRight:Image;
        private var _borderFillerBottom:Image;
        private var _borderFillerLeft:Image;
        private var _borderFillerThickness:uint = 0;

        private var _spaceLeft:int;
        private var _spaceTop:int;
        private var _spaceBottom:int;
        private var _spaceRight:int;

        private var _explicitWidth:uint;
        private var _explicitHeight:uint;

        public function EdgeCoverRenderer() {
            var texture:Texture = Gfx.edgeCoverGrid9;
            var innerRectangle:Rectangle = new Rectangle(63, 63, 2, 2);
            var outerRectangle:Rectangle = new Rectangle(0, 0, texture.width, texture.height);

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

            var borderFillerTexture:Texture = Texture.fromTexture(texture, new Rectangle(0, 0, 2, 2));
            _borderFillerTop = new Image(borderFillerTexture);
            _borderFillerRight = new Image(borderFillerTexture);
            _borderFillerBottom = new Image(borderFillerTexture);
            _borderFillerLeft = new Image(borderFillerTexture);

            addChild(_left);
            addChild(_right);
            addChild(_top);
            addChild(_bottom);
            addChild(_topLeft);
            addChild(_topRight);
            addChild(_bottomLeft);
            addChild(_bottomRight);
            addChild(_borderFillerTop);
            addChild(_borderFillerRight);
            addChild(_borderFillerBottom);
            addChild(_borderFillerLeft);

            _top.x = innerRectangle.x;
            _bottom.x = innerRectangle.x;
            _topRight.x = innerRectangle.right;
            _right.x = innerRectangle.right;
            _bottomRight.x = innerRectangle.right;

            _left.y = innerRectangle.y;
            _right.y = innerRectangle.y;
            _bottomLeft.y = innerRectangle.bottom;
            _bottom.y = innerRectangle.bottom;
            _bottomRight.y = innerRectangle.bottom;

            _explicitWidth = innerRectangle.width;
            _explicitHeight = innerRectangle.height;

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

            _explicitWidth = value;

            var midWidth:Number = value - _spaceLeft - _spaceRight;

            _top.width = midWidth;
            _bottom.width = midWidth;
            _topRight.x = value - _spaceRight;
            _right.x = value - _spaceRight;
            _bottomRight.x = value - _spaceRight;
            recalculateBorderFillers();
        }

        override public function set height(value:Number):void {
            if (value < _spaceTop + _spaceBottom + 1) {
                value = _spaceTop + _spaceBottom + 1;
            }

            _explicitHeight = value;

            var midHeight:Number = value - _spaceTop - _spaceBottom;

            _left.height = midHeight;
            _right.height = midHeight;
            _bottomLeft.y = value - _spaceBottom;
            _bottom.y = value - _spaceBottom;
            _bottomRight.y = value - _spaceBottom;
            recalculateBorderFillers();
        }

        override public function dispose():void {
            removeChildren();

            _topLeft.dispose();
            _top.dispose();
            _topRight.dispose();
            _left.dispose();
            _right.dispose();
            _bottomLeft.dispose();
            _bottom.dispose();
            _bottomRight.dispose();

            _topLeft = null;
            _top = null;
            _topRight = null;
            _left = null;
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

        public function get borderFillerThickness():uint {
            return _borderFillerThickness;
        }

        public function set borderFillerThickness(value:uint):void {
            _borderFillerThickness = value;
            recalculateBorderFillers();
        }

        private function recalculateBorderFillers():void {
            _borderFillerTop.width = _explicitWidth + _borderFillerThickness * 2;
            _borderFillerTop.height = _borderFillerThickness;

            _borderFillerLeft.width = _borderFillerThickness;
            _borderFillerLeft.height = _explicitHeight + _borderFillerThickness;

            _borderFillerRight.width = _borderFillerThickness;
            _borderFillerRight.height = _explicitHeight + _borderFillerThickness;

            _borderFillerBottom.width = _explicitWidth;
            _borderFillerBottom.height = _borderFillerThickness;

            _borderFillerTop.x = -_borderFillerThickness;
            _borderFillerTop.y = -_borderFillerThickness;

            _borderFillerLeft.x = -_borderFillerThickness;
            _borderFillerLeft.y = 0;

            _borderFillerRight.x = _explicitWidth;
            _borderFillerRight.y = 0;

            _borderFillerBottom.x = 0;
            _borderFillerBottom.y = _explicitHeight;
        }
    }
}
