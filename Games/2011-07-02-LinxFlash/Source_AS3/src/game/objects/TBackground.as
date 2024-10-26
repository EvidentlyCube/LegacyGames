package game.objects{
    import flash.display.BitmapData;

    import net.retrocade.camel.core.rGroup;
    import net.retrocade.camel.layers.rLayerBlit;
    import net.retrocade.camel.objects.rObject;

    public class TBackground extends rObject{
        private var _layer:rLayerBlit;

        private var _x:Number;
        private var _y:Number;

        private var _width :Number;
        private var _height:Number;

        public  var xspeed:Number;

        public  var yspeed:Number;

        private var _gfx:BitmapData;

        public function TBackground(gfx:BitmapData, layer:rLayerBlit, xspeed:Number, yspeed:Number){
            _x      = 0;
            _y      = 0;

            this.xspeed = xspeed;
            this.yspeed = yspeed;

            _layer  = layer;

            _gfx    = gfx;

            _width  = _gfx.width;
            _height = _gfx.height
        }

        override public function update():void{
            _x += xspeed;
            _y += yspeed;

            while (_x < - _width)
                _x += _width;

            while (_y < - _height)
                _y += _height;

            while (_x > 0)
                _x -= _width;

            while (_y > 0)
                _y -= _height;

            var START_X:Number = _x;
            var START_Y:Number = _y;

            var i:Number;
            var j:Number;

            var l:Number = S().gameWidth / 2;
            var k:Number = S().gameHeight / 2;

            for(i = START_X; i < l; i += _width){
                for(j = START_Y; j < k; j += _height){
                    _layer.draw(_gfx, i, j);
                }
            }
        }
    }
}