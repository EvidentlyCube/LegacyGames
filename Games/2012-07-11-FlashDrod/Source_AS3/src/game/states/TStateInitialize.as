package game.states {
    import flash.display.Bitmap;
    import game.global.CaravelConnect;
    import game.global.Core;
    import game.global.DB;
    import game.global.Gfx;
    import game.global.Make;
	import net.retrocade.camel.core.rCore;
    import net.retrocade.camel.core.rGfx;
    import net.retrocade.camel.core.rSave;
	import net.retrocade.camel.core.rState;
    import net.retrocade.camel.effects.rEffFade;
    import net.retrocade.camel.effects.rEffFadeScreen;
    import net.retrocade.standalone.Text;
    import net.retrocade.utils.Rand;
	
	/**
     * ...
     * @author Maurycy Zarzycki
     */
    public class TStateInitialize extends rState {

        private static const SWING_STEP:Number = Math.PI / 30;
        private static const SWING_SIZE:Number = 15;

        private var _text   :Text;
        private var _stepOdd:uint = 0;

        private var _swing  :Number = Rand.om * Math.PI;

        private var _bg:Bitmap;

        public function TStateInitialize() {
            set();

            _text = Make.text(24, 0xFFFFFF);

            Core.lMain.add2(_text);

            new rEffFadeScreen(0, 1, 0, 250);

            CaravelConnect.loadCnetCredentials();
            CaravelConnect.getData();

            CaravelConnect.login();
        }

        override public function update():void {
            if (!_bg/* && rGfx.isAvailable(Gfx.CLASS_LEVEL_START_BACKGROUND)*/) {
                _bg = rGfx.getB(Gfx.CLASS_LEVEL_START_BACKGROUND);
                Core.lMain.addAt2(_bg, 0);
                new rEffFade(_bg, 0);
            }


            if ((_stepOdd = 1 - _stepOdd)) {
                DB.advanceQueue();
            }

            if ((_stepOdd = 1 - _stepOdd)) {
                DB.advanceQueue();
            }

            _text.text = _("initAssets", DB.queueLoaded, DB.queueTotal);

            _text.center = S.SIZE_SWF_WIDTH  / 2;
            _text.middle = S.SIZE_SWF_HEIGHT / 2;

            if (DB.queueLoaded == DB.queueTotal)
                new rEffFadeScreen(1, 0, 0, 250, onFadeOut);
        }

        private function onFadeOut():void {
            TStateTitle.show();
        }
    }
}