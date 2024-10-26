/**
 * Created with IntelliJ IDEA.
 * User: Ryc
 * Date: 13.02.13
 * Time: 18:10
 * To change this template use File | Settings | File Templates.
 */
package net.retrocade.tacticengine.monstro.render {
    import flash.events.Event;

    import net.retrocade.camel.global.rDisplay;
    import net.retrocade.camel.global.rInput;
    import net.retrocade.tacticengine.core.Eventer;
    import net.retrocade.tacticengine.monstro.core.Monstro;
    import net.retrocade.tacticengine.monstro.events.MonstroEventResize;

    import starling.display.Image;
    import starling.textures.Texture;

    public class MonstroBackground extends Image{
        private var _offsetX:Number = 0;
        private var _offsetY:Number = 0;
        private var _offsetFraction:Number;

        public function MonstroBackground(texture:Texture, offset:Number){
            super(texture);

            texture.repeat = true;

            _offsetFraction = offset;

            resize();

            Eventer.listen(MonstroEventResize.NAME, resize);

            rDisplay.flashApplication.addEventListener(flash.events.Event.ENTER_FRAME, function(e:*):void{resize()});
        }

        override public function set x(value:Number):void{
            _offsetX = value;
            resize();
        }

        override public function set y(value:Number):void{
            _offsetY = value;
            resize();
        }

        override public function get x():Number{
            return _offsetX;
        }

        override public function get y():Number{
            return _offsetY;
        }

        public function resize():void{
            var widthRatio :Number = Monstro.gameWidth / texture.width;
            var heightRatio:Number = Monstro.gameHeight / texture.height;

            var offsetX:Number = _offsetX * _offsetFraction;
            var offsetY:Number = _offsetY * _offsetFraction;

            width = Monstro.gameWidth;
            height = Monstro.gameHeight;

            mVertexData.setTexCoords(0, offsetX, offsetY);
            mVertexData.setTexCoords(1, widthRatio + offsetX, offsetY);
            mVertexData.setTexCoords(2, offsetX, heightRatio + offsetY);
            mVertexData.setTexCoords(3, widthRatio + offsetX, heightRatio + offsetY);

            readjustSize();
        }
    }
}
