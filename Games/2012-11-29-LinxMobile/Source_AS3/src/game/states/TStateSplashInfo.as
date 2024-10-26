package game.states
{
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.events.TouchEvent;
    import flash.utils.clearTimeout;
    import flash.utils.setTimeout;
    import flash.ui.Keyboard;
    import net.retrocade.standalone.Text;

    import game.global.Game;
    import game.global.Make;
    import game.mobiles.rMobileState;
    import game.states.TStateSplashRetrocade;

    import net.retrocade.camel.global.rCore;
    import net.retrocade.camel.effects.rEffFade;
    import net.retrocade.camel.effects.rEffFadeScreen;
    import net.retrocade.camel.global.rDisplay;
    import net.retrocade.camel.global.rGfx;
    import net.retrocade.camel.global.rInput;
    import net.retrocade.camel.objects.rBitmap;
    import net.retrocade.utils.UDisplay;

    public class TStateSplashInfo extends rMobileState
    {
        private var _text:Text;

        public function TStateSplashInfo()
        {
            _text = Make().text(
                "Fair warning from 2024: This game is barely holding up.\n\n"
                + "Originally this was a mobile game optimized for touch controls.\n"
                + "At some point in the past I wanted to make a desktop version but it\n"
                + "was never finished - since I only had the latest version of the code\n"
                + "this is the best I could do to make it work without investing\n"
                + "endless amounts of time. Check Readme for the list of known problems.\n\n"
                + "Accept it with all of its shortcomings.\n\n"
                + "Press space to play.",
                0xFFFFFF,
                28
            );
            _text.textAlignCenter()
            _text.x = (S().gameWidth - _text.width) / 2;
            _text.y = (S().gameHeight - _text.height) / 2;

            Game.lMain.add(_text);
        }

        public override function destroy(): void {
            super.destroy();

            Game.lMain.remove(_text);
        }

        public override function update():void{
            super.update();

            _text.scaleX = S().gameWidth / 600;
            _text.scaleY = S().gameHeight / 600;

            _text.scaleX = Math.min(_text.scaleX, _text.scaleY);
            _text.scaleY = _text.scaleX;
            _text.x = (S().gameWidth - _text.width * _text.scaleX) / 2;
            _text.y = (S().gameHeight - _text.height * _text.scaleY) / 2;

            if (rInput.isKeyDown(Keyboard.SPACE)) {
                rCore.setState(new TStateSplashRetrocade);
            }
        }
    }
}