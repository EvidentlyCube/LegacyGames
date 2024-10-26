package net.retrocade.retrocamel.particles{
    import flash.display.BitmapData;

    import net.retrocade.retrocamel.components.RetrocamelDisplayObject;
    import net.retrocade.retrocamel.core.RetrocamelCore;
    import net.retrocade.retrocamel.display.layers.RetrocamelLayerFlashBlit;

    public class rAnimGravitated extends RetrocamelDisplayObject {
        public static var blitLayer:RetrocamelLayerFlashBlit;

        public var bitmapData:BitmapData;

        public var xSpeed:Number;
        public var ySpeed:Number;

        public var xGravity:Number;
        public var yGravity:Number;

        public function rAnimGravitated(gfx:*, x:Number, y:Number, dir:Number, speed:Number, hGravity:Number, vGravity:Number) {
            _x = x;
            _y = y;

            if (gfx is BitmapData) {
                bitmapData = gfx;
                _width = bitmapData.width;
                _height = bitmapData.height;

            } else {
                this.gfx = gfx;
                this.gfx.x = _x;
                this.gfx.y = _y;
                _width = gfx.width;
                _height = gfx.height;
            }

            xSpeed = Math.cos(dir * Math.PI / 180) * speed;
            ySpeed = Math.sin(dir * Math.PI / 180) * speed;

            xGravity = hGravity;
            yGravity = vGravity;

            addDefault();
        }

        override public function update():void {
            _x += xSpeed;
            _y += ySpeed;

            if (_x + _width >= RetrocamelCore.settings.gameHeight && xSpeed > 0) {
                xSpeed *= -1;
            }

            else if (_x < 0 && xSpeed < 0) {
                xSpeed *= -1;
            }


            if (_y + _height > RetrocamelCore.settings.gameWidth && ySpeed > 4) {
                ySpeed *= -0.9;
            }

            if (_y > RetrocamelCore.settings.gameHeight) {
                kill();
            }

            if (xSpeed > xGravity) {
                xSpeed -= xGravity;
            }

            else if (xSpeed < xGravity) {
                xSpeed += xGravity;
            }

            ySpeed += yGravity;

            if (bitmapData != null && blitLayer != null) {
                blitLayer.blit(bitmapData, _x, _y);
            }

            if (gfx) {
                gfx.x = _x;
                gfx.y = _y;
            }
        }

        public function kill():void {
            if (gfx) {
                gfx.parent.removeChild(gfx);
            }

            nullifyDefault();
        }
    }
}