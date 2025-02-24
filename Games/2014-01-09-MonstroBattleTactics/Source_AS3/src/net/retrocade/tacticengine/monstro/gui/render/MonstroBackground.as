
package net.retrocade.tacticengine.monstro.gui.render {
    import flash.events.Event;

    import net.retrocade.retrocamel.core.RetrocamelDisplayManager;
    import net.retrocade.tacticengine.core.Eventer;
    import net.retrocade.tacticengine.monstro.global.core.MonstroConsts;
    import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventResize;

    import starling.display.Image;
    import starling.textures.Texture;

    public class MonstroBackground extends Image{
        private var _offsetX:Number = 0;
        private var _offsetY:Number = 0;
        private var _offsetFraction:Number;

        public var scale:Number = 1;

        public function MonstroBackground(texture:Texture, offset:Number){
            super(texture);

            _offsetFraction = offset;

            resize();

            Eventer.listen(MonstroEventResize.NAME, resize, this);

            RetrocamelDisplayManager.flashApplication.addEventListener(Event.ENTER_FRAME, function(e:*):void{resize()});
        }


		override public function dispose():void {
			RetrocamelDisplayManager.flashApplication.removeEventListener(Event.ENTER_FRAME, function(e:*):void{resize()});
			Eventer.releaseContext(this);

			super.dispose();
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
            var widthRatio :Number = MonstroConsts.gameWidth / (texture.width * scale);
            var heightRatio:Number = MonstroConsts.gameHeight / (texture.height * scale);

            var offsetX:Number = _offsetX / (texture.width * scale) * _offsetFraction;
            var offsetY:Number = _offsetY / (texture.height * scale) * _offsetFraction;

            width = MonstroConsts.gameWidth;
            height = MonstroConsts.gameHeight;

            mVertexData.setTexCoords(0, offsetX, offsetY);
            mVertexData.setTexCoords(1, widthRatio + offsetX, offsetY);
            mVertexData.setTexCoords(2, offsetX, heightRatio + offsetY);
            mVertexData.setTexCoords(3, widthRatio + offsetX, heightRatio + offsetY);

            readjustSize();
        }
    }
}
