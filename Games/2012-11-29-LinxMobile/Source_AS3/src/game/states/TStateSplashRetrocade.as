package game.states
{
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.events.TouchEvent;
    import flash.utils.clearTimeout;
    import flash.utils.setTimeout;

    import game.global.Game;
    import game.mobiles.rMobileState;

    import net.retrocade.camel.effects.rEffFade;
    import net.retrocade.camel.effects.rEffFadeScreen;
    import net.retrocade.camel.global.rDisplay;
    import net.retrocade.camel.global.rGfx;
    import net.retrocade.camel.objects.rBitmap;
    import net.retrocade.utils.UDisplay;

    public class TStateSplashRetrocade extends rMobileState
    {
        [Embed(source="/../assets/gfx/by_cage/bgs/background_retrocade.png")] private static var _retro:Class;

        private var _retroLogo:rBitmap;

        private var _isLocked:Boolean = true;

        private var _timeoutTimer:int = -1;

        public function TStateSplashRetrocade()
        {
            _retroLogo = rGfx.getB(_retro);
            _retroLogo.smoothing = true;

            Game.lMain.add(_retroLogo);

            _retroLogo.alignCenter();
            _retroLogo.alignMiddle();

            new rEffFadeScreen(0, 1, 0, 1500, function():void{
                rDisplay.stage.addEventListener(TouchEvent.TOUCH_BEGIN, endSplash);
                rDisplay.stage.addEventListener(MouseEvent.MOUSE_DOWN,  endSplash);

                _timeoutTimer = setTimeout(endSplash, 2000);
            });
        }

        override protected function resized(e:Event):void{
            UDisplay.scaleDisplayObjectDown(_retroLogo, S().swfWidth * 0.9, S().swfHeight * 0.9, UDisplay.SHOW_ALL);

            _retroLogo.alignCenter();
            _retroLogo.alignMiddle();
        }

        private function endSplash(e:* = null):void{
            clearTimeout(_timeoutTimer);

            rDisplay.stage.removeEventListener(TouchEvent.TOUCH_BEGIN, endSplash);
            rDisplay.stage.removeEventListener(MouseEvent.MOUSE_DOWN,  endSplash);

            new rEffFade(_retroLogo, 1, 0, 800, function():void{
                TStateTitle.instance.set();
            });
        }

    }
}