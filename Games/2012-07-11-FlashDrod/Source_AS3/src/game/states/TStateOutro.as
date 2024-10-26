package game.states {
    import flash.display.Bitmap;
    import flash.utils.ByteArray;
    import flash.utils.getTimer;
    import game.global.Core;
    import game.global.Gfx;
    import game.global.Make;
    import game.global.Sfx;
    import game.windows.TWindowGameCompleted;
    import net.retrocade.camel.core.rGfx;
    import net.retrocade.camel.core.rInput;
	import net.retrocade.camel.core.rState;
    import net.retrocade.camel.effects.rEffFade;
    import net.retrocade.camel.effects.rEffFadeScreen;
    import net.retrocade.camel.effects.rEffScreenshot;
    import net.retrocade.standalone.Text;
    import net.retrocade.utils.Key;
	
	/**
     * ...
     * @author Maurycy Zarzycki
     */
    public class TStateOutro extends rState {
        private var _bg  :Bitmap;
        private var _text:Text;

        private var _lastStepTime:Number = 0;

        private var _screenshot:rEffScreenshot;

        public function TStateOutro() {
            _screenshot = new rEffScreenshot();

            _bg = rGfx.getB(Gfx.CLASS_LEVEL_START_BACKGROUND);

            _text = Make.text(21, 0xFFFFFF);

            _text.color     = 0xFFFFFF;
            _text.x         = 20;
            _text.y         = S.SIZE_GAME_HEIGHT + 25;
            _text.wordWrap  = true;
            _text.multiline = true;
			_text.width     = S.SIZE_GAME_WIDTH - 40;
			_text.textAlignCenter();
			_text.htmlText  = _('outro');

            set();

            Core.lMain.add2(_bg);
            Core.lMain.add2(_text);

            _text.height = _text.textHeight + 10;

            new rEffFade(_screenshot.layer.displayObject, 1, 0, 1000, function():void {
                if (_screenshot)
                    _screenshot.stop();
            });

            Sfx.crossFadeMusic(C.MUSIC_OUTRO);
        }

        override public function update():void {
            if (_lastStepTime == 0)
                _lastStepTime = getTimer();

            if (rInput.isKeyDown(Key.UP) || rInput.isKeyDown(Core.keyUp) || rInput.isKeyDown(Key.NUMPAD_8))
                _text.y = Math.min(S.SIZE_GAME_HEIGHT + 25, _text.y + 10);

            if (rInput.isKeyDown(Key.DOWN) || rInput.isKeyDown(Core.keyDown) || rInput.isKeyDown(Key.NUMPAD_2))
                _text.y -= 10;


            if (!rInput.isKeyDown(Key.SPACE) && !rInput.isKeyDown(Core.keyWait) && !rInput.isKeyDown(Key.NUMPAD_5))
                _text.y -= (getTimer() - _lastStepTime) / (rInput.isMouseDown() ? 5 : 70);

            _lastStepTime = getTimer();

            if (_text.y + _text.textHeight < S.SIZE_SWF_HEIGHT / 2 || rInput.isKeyHit(Key.ESCAPE) || rInput.isKeyHit(Key.ENTER)){
                TWindowGameCompleted.show();
            }
        }

    }
}