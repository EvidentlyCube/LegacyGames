package game.states{
    import flash.display.Bitmap;
    import flash.display.Sprite;
    import flash.events.MouseEvent;
    import flash.filters.DropShadowFilter;
    import flash.filters.GlowFilter;
    import flash.net.navigateToURL;
    import flash.net.URLRequest;
    import game.global.CaravelConnect;
    import game.interfaces.TNewsString;
    import game.windows.TWindowAbout;
    import game.windows.TWindowBrowseHolds;
    import game.windows.TWindowMessage;
    import game.windows.TWindowOptions;
    import net.retrocade.camel.effects.rEffFade;
    import net.retrocade.camel.effects.rEffFadeScreen;
    import net.retrocade.camel.effects.rEffScreenshot;
    import net.retrocade.utils.UDisplay;
    import net.retrocade.utils.UNumber;

    import game.global.Core;
    import game.global.Gfx;
    import game.global.Make;
    import game.global.Progress;
    import game.global.Sfx;
    import game.interfaces.TTitleButton;
    import game.windows.TWindowAchievements;

    import net.retrocade.camel.core.rGfx;
    import net.retrocade.camel.core.rInput;
    import net.retrocade.camel.core.rState;
    import net.retrocade.standalone.Button;
    import net.retrocade.standalone.Text;
    import net.retrocade.utils.Key;
    import net.retrocade.utils.Rand;

    public class TStateTitle extends rState{
        private static var _instance:TStateTitle = new TStateTitle();

        public static function show():void{
            _instance.set();
        }



        private var _logo          :Bitmap;
        private var _background    :Bitmap;

        private var _logoRetrocade :Sprite;
        private var _logoCaravel   :Sprite;

        private var _buttonNewGame      :Button;
        private var _buttonContinue     :Button;
        private var _buttonRestore      :Button;
        private var _buttonAchievements :Button;
        private var _buttonOptions      :Button;
        private var _buttonAbout        :Button;
        private var _buttonGames        :Button;

        private var _version       :Text;

        private var _newsString:TNewsString;

        private var _backgroundX:Number;
        private var _backgroundY:Number;

        private var _backgroundTargetX:Number;
        private var _backgroundTargetY:Number;

        private var _backgroundAccel  :Number = 0;
        private var _backgroundWait   :uint   = 0;

        CF::play
        public function TStateTitle() {
            const FIRST_BUTTON:int = 245;
            const BUTTON_SPACE:int = -8;

            _background     = rGfx.getB(Gfx.CLASS_TITLE_SCREEN_BACKGROUND);
            _logo           = rGfx.getB(Gfx.CLASS_LOGO);
            _logoRetrocade  = UDisplay.wrapInSprite(rGfx.getB(Gfx.CLASS_LOGO_RETROCADE));
            _logoCaravel    = UDisplay.wrapInSprite(rGfx.getB(Gfx.CLASS_LOGO_CARAVEL));

            _buttonNewGame      = new TTitleButton(onClickedNewGame,  _("tsStartNew"), _("tsStartNewKey"));
            _buttonContinue     = new TTitleButton(onClickedContinue, _("tsContinue"), _("tsContinueKey"));
            _buttonRestore      = new TTitleButton(onClickedRestore,  _("tsRestore"), _("tsRestoreKey"));
            _buttonAchievements = new TTitleButton(onClickedAchievements, _("tsAchievements"), _("tsAchievementsKey"));
            _buttonOptions      = new TTitleButton(onClickedOptions,  _("tsOptions"), _("tsOptionsKey"));
            _buttonAbout        = new TTitleButton(onClickedAbout,    _("tsHelp"), _("tsHelpKey"));
            _buttonGames        = new TTitleButton(onClickedGames,    _("tsBrowse"), _("tsBrowseKey"));
            _newsString         = new TNewsString();

            _version = Make.text(14, 0xFFFFFF);

            _version.text         = S.VERSION;
            _version.filters      = [ new GlowFilter(0, 1, 3, 3, 200), new DropShadowFilter(4, 45, 0, 1, 2, 2, 0.5) ];
            _version.mouseEnabled = false;
            _version.color        = 0xFFFFFF;
            _version.x            = S.SIZE_GAME_WIDTH - _version.textWidth - 10;
            _version.y            = 0;

            _logo.x = (S.SIZE_GAME_WIDTH - _logo.width) / 2 | 0;
            _logo.y = 10;

            _buttonNewGame     .alignCenter();
            _buttonContinue    .alignCenter();
            _buttonRestore     .alignCenter();
            _buttonAchievements.alignCenter();
            _buttonOptions     .alignCenter();
            _buttonAbout       .alignCenter();
            _buttonGames       .alignCenter();

            _buttonNewGame     .y = FIRST_BUTTON;
            _buttonContinue    .y = _buttonNewGame     .bottom + BUTTON_SPACE;
            _buttonRestore     .y = _buttonContinue    .bottom + BUTTON_SPACE;
            _buttonAchievements.y = _buttonRestore     .bottom + BUTTON_SPACE;
            _buttonOptions     .y = _buttonAchievements.bottom + BUTTON_SPACE;
            _buttonAbout       .y = _buttonOptions     .bottom + BUTTON_SPACE;
            _buttonGames       .y = _buttonAbout       .bottom + BUTTON_SPACE;


            _logoCaravel.y = S.SIZE_GAME_HEIGHT - _logoCaravel.height;5

            _logoRetrocade.x = S.SIZE_GAME_WIDTH  - _logoRetrocade.width;
            _logoRetrocade.y = S.SIZE_GAME_HEIGHT - _logoRetrocade.height;

            _logoCaravel  .buttonMode = true;
            _logoRetrocade.buttonMode = true;

            _logoCaravel  .addEventListener(MouseEvent.CLICK, onLogoClicked);
            _logoRetrocade.addEventListener(MouseEvent.CLICK, onLogoClicked);
        }

        override public function create():void{
            Core.lMain.add2(_background);
            Core.lMain.add2(_logo);
            Core.lMain.add2(_buttonGames);
            Core.lMain.add2(_buttonAbout);
            Core.lMain.add2(_buttonOptions);
            Core.lMain.add2(_buttonAchievements);
            Core.lMain.add2(_buttonRestore);
            Core.lMain.add2(_buttonContinue);
            Core.lMain.add2(_buttonNewGame);
            Core.lMain.add2(_logoCaravel);
            Core.lMain.add2(_logoRetrocade);
            Core.lMain.add2(_version);
            Core.lMain.add2(_newsString)

            _buttonContinue.enabled = Progress.hasSaveGame();
            _buttonRestore .enabled = Progress.hasRestoreProgress();

            update();

            Sfx.playMusic(C.MUSIC_TITLE);

            new rEffFadeScreen(0, 1, 0, 600);

            _backgroundX = _background.x = -Rand.om * (_background.width  - S.SIZE_SWF_WIDTH);
            _backgroundY = _background.y = -Rand.om * (_background.height - S.SIZE_SWF_HEIGHT);

            if (Rand.b){
                _backgroundTargetX = -Rand.om * (_background.width  - S.SIZE_SWF_WIDTH);
                _backgroundTargetY = _backgroundY;
            } else {
                _backgroundTargetY = -Rand.om * (_background.height - S.SIZE_SWF_HEIGHT);
                _backgroundTargetX = _backgroundX;
            }
        }

        override public function destroy():void{
            Core.lMain.clear();
        }

        override public function update():void {
            if (_backgroundWait)
                _backgroundWait--;

            else {
                var backgroundDir :Number = Math.atan2(_backgroundTargetY - _background.y, _backgroundTargetX - _background.x);
                var backgroundDist:Number = Math.sqrt(UNumber.distance(_background.x, _background.y, _backgroundTargetX, _backgroundTargetY));

                if (backgroundDist > 40)
                    backgroundDist = 40;

                if (_backgroundAccel < 1)
                    _backgroundAccel += 0.012;

                _background.x = _backgroundX += Math.cos(backgroundDir) * backgroundDist * _backgroundAccel / 100;
                _background.y = _backgroundY += Math.sin(backgroundDir) * backgroundDist * _backgroundAccel / 100;

                if (backgroundDist < 10) {
                    if (Rand.b)
                        _backgroundTargetX = -Rand.om * (_background.width  - S.SIZE_SWF_WIDTH);
                    else
                        _backgroundTargetY = -Rand.om * (_background.height - S.SIZE_SWF_HEIGHT);
                    _backgroundWait = Rand.u(20, 200);
                    _backgroundAccel = 0;
                }
            }

            _buttonGames.visible = CaravelConnect.isDataLoaded();

            _newsString.update();

            if (rInput.isKeyHit(_n("tsHelpKeyCode")))
                onClickedAbout();

            else if (rInput.isKeyHit(_n("tsStartNewKeyCode")))
                onClickedNewGame();

            else if (rInput.isKeyHit(_n("tsContinueKeyCode")) && Progress.hasSaveGame())
                onClickedContinue();

            else if (rInput.isKeyHit(_n("tsRestoreKeyCode")) && Progress.hasRestoreProgress())
                onClickedRestore();

            else if (rInput.isKeyHit(_n("tsOptionsKeyCode")))
                onClickedOptions();

            else if (rInput.isKeyHit(_n("tsAchievementsKeyCode")) || rInput.isKeyHit(Key.TAB))
                onClickedAchievements();
				
			else if (rInput.isKeyHit(_n("tsBrowseKeyCode")))
                onClickedGames();

            else if (rInput.isKeyHit(Key.ENTER)){
                if (Progress.hasSaveGame())
                    onClickedContinue();
                else
                    onClickedNewGame();
            }
        }


        /****************************************************************************************************************/
        /**                                                                                            EVENT LISTENERS  */
        /****************************************************************************************************************/

        private function onClickedNewGame():void {
            Progress.restartHold();

            TStateGame.startHold();
            Sfx.buttonClick();
        }

        private function onClickedContinue():void {
            var screenshot:rEffScreenshot = new rEffScreenshot();

            TStateGame.continuePlaying();
            Sfx.buttonClick();

            new rEffFade(screenshot.layer.displayObject, 1, 0, 500, screenshot.stop);
            screenshot.moveForward();
        }

        private function onClickedRestore():void{
            TStateRestore.show();
            Sfx.buttonClick();
        }

        private function onClickedAchievements():void{
            TWindowAchievements.show();
            Sfx.buttonClick();
        }

        private function onClickedOptions():void{
            TWindowOptions.show();
            Sfx.buttonClick();
        }

        private function onClickedAbout():void {
            TWindowAbout.show();
            Sfx.buttonClick();
        }

        private function onClickedGames():void {
            TWindowBrowseHolds.show();
            Sfx.buttonClick();
        }

        private function onLogoClicked(e:MouseEvent):void {
            var target:String;
            if (e.target == _logoCaravel)
                target = "http://caravelgames.com";
            else
                target = "http://retrocade.net";

            navigateToURL(new URLRequest(target), "_blank");
        }
    }
}