/**
 * Created with IntelliJ IDEA.
 * User: Ryc
 * Date: 17.01.13
 * Time: 21:43
 * To change this template use File | Settings | File Templates.
 */
package net.retrocade.tacticengine.monstro.render {
    import flash.geom.Rectangle;

import net.retrocade.tacticengine.core.IDestruct;

import starling.display.Image;

    import starling.display.Image;
    import starling.display.QuadBatch;
    import starling.display.Sprite;
    import starling.textures.Texture;
    import starling.textures.TextureSmoothing;

    public class MonstroGrid9 extends Sprite implements IDestruct{
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

        public function MonstroGrid9(texture:Texture, innerRectangle:Rectangle, outerRectangle:Rectangle = null) {
            if (!outerRectangle){
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
            _topRight= new Image(Texture.fromTexture(texture, new Rectangle(
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

        override public function set width(value:Number):void{
            if (value < _spaceLeft + _spaceRight + 1){
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

        override public function set height(value:Number):void{
            if (value < _spaceTop + _spaceBottom + 1){
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

        public function destruct():void{

        }
        
        public function set smoothing(value:String):void{
            if (!TextureSmoothing.isValid(value)){
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
    }
}
