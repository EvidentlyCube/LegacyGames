package game.objects{
    import flash.events.Event;

    import net.retrocade.camel.global.rDisplay;
    import net.retrocade.camel.global.rGfx;
    import net.retrocade.camel.objects.rBitmap;

    public class TInvalid{
        [Embed(source="/../assets/gfx/by_cage/bgs/x2.png")] private static var x_class:Class;

        { init(); }

        private static var _x:rBitmap;

        private static var _timer:uint = 0;

        public static function show(x:Number, y:Number):void{
            if (!rDisplay.application.contains(_x))
                rDisplay.application.addChild(_x);

            if (Main.isLandscape()){
                _x.alignCenterParent(S().playfieldOffsetX, S().gameWidth - S().playfieldOffsetX);
                _x.alignMiddle();
            } else {
                _x.alignCenter();
                _x.alignMiddleParent(0, S().tileGridWidth * S().realTileWidth);
            }
            _x.alpha = 0;

            _timer = 20;
        }

        private static function init():void{
            Main.self.addEventListener(Event.ENTER_FRAME, step);

            _x = rGfx.getB(x_class);

            _x.scaleX = _x.scaleY = 0.9;
            _x.smoothing = true;
            _x.cacheAsBitmap = true;
        }

        private static function step(e:Event):void{
            if (_timer){
                if (_x.alpha < 1)
                    _x.alpha += 0.10;
                else
                    _timer--;
            } else if (_x.alpha > 0){
                _x.alpha -= 0.05;
                if (_x.alpha <= 0 && _x.parent){
                    _x.alpha = 0;
                    _x.parent.removeChild(_x);
                }
            }
        }
    }
}