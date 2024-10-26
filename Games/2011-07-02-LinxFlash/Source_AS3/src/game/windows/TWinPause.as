package game.windows{
    import flash.net.URLRequest;
    import flash.net.navigateToURL;

    import game.global.Level;
    import game.global.Make;
    import game.global.Options;
    import game.global.Sfx;
    import game.states.TStateLevelSelect;
    import game.states.TStateTitle;

    import net.retrocade.camel.core.rCore;
    import net.retrocade.camel.core.rSound;
    import net.retrocade.camel.core.rTooltip;
    import net.retrocade.camel.core.rWindow;
    import net.retrocade.camel.effects.rEffFade;
    import net.retrocade.camel.effects.rEffFadeScreen;
    import net.retrocade.camel.effects.rEffSolidScreen;
    import net.retrocade.camel.effects.rEffVolumeFade;
    import net.retrocade.camel.rCollide;
    import net.retrocade.standalone.Bitext;
    import net.retrocade.standalone.Button;
    import net.retrocade.standalone.Grid9;
    import net.retrocade.standalone.Text;
    import net.retrocade.utils.UGraphic;

    public class TWinPause extends rWindow{
        private static var _instance:TWinPause = new TWinPause();

        public static function get instance():TWinPause{
            return _instance;
        }



        protected var options:Options;

        protected var toMenu :Button;
        protected var toSelect:Button;
        protected var closer :Button;


        protected var bg:Grid9;

        protected var darkener:rEffSolidScreen;

        public function TWinPause() {
            this._blockUnder = true;
            this._pauseGame  = true;

            bg = Grid9.getGrid("windowBG");

            var txt:Bitext = Make().text(_("Game is Paused"), 0xFFFFFF, 3);

            options  = new Options();
            closer   = Make().button(onClose, _('Return to Game'));
            toSelect = Make().button(onSelect, _('Return to level selection'));
            toMenu   = Make().button(onMenu, _('Return to Title Screen'));


            addChild(bg);
            addChild(txt);
            addChild(options);
            addChild(closer);
            addChild(toSelect);
            addChild(toMenu);


            options .y = 55;
            closer  .y = options. y + options .height + 25;
            toSelect.y = closer  .y + closer  .height + 5;
            toMenu  .y = toSelect.y + toSelect.height + 5;

            bg.innerY     = 42
            bg.innerWidth = options.width;
            bg.innerHeight = toMenu.y + toMenu.height - 56;

            txt     .x = (width - txt     .width) / 2 | 0;
            closer  .x = (width - closer  .width) / 2 | 0;
            options .x = (width - options .width) / 2 | 0;
            toSelect.x = (width - toSelect.width) / 2 | 0;
            toMenu  .x = (width - toMenu  .width) / 2 | 0;


            center();

            toMenu .rollOverCallback = rTooltip.show;
            toMenu .rollOutCallback  = rTooltip.hide;

            rTooltip.hookToObject(toMenu,  _('Click loses progress'));
        }

        override public function show():void{
            super.show();
            darkener = new rEffSolidScreen(0, 0.5)
            new rEffFade(this, 0, 1, 250);
            new rEffFade(darkener.layer.displayObject, 0, 1, 250);

            mouseEnabled  = true;
            mouseChildren = true;
        }

        override public function close():void {
            super.close();
            darkener.stop();
        }



        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Button Callbacks
        // ::::::::::::::::::::::::::::::::::::::::::::::

        private function onClose():void {
            mouseEnabled  = false;
            mouseChildren = false;
            new rEffFade(this, 1, 0, 250, efFinClose);
            new rEffFade(darkener.layer.displayObject, 1, 0, 250);

            Sfx.sfxClickPlay();
        }

        private function onMenu():void{
            new rEffFade(this, 1, 0, 250);
            new rEffFadeScreen(1, 0, 0, 1000, efFinReturnToMenu);
            new rEffVolumeFade(false, 200);

            Sfx.sfxClickPlay();
        }

        private function onSelect():void{
            new rEffFade(this, 1, 0, 250);
            new rEffFadeScreen(1, 0, 0, 1000, efFinLevelSelect);
            new rEffVolumeFade(false, 200);

            Sfx.sfxClickPlay();
        }



        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Effect Callbacks
        // ::::::::::::::::::::::::::::::::::::::::::::::

        private function efFinClose():void {
            close();
        }

        private function efFinReturnToMenu():void{
            close();
            rSound.stopMusic();
            rSound.musicVolumeResetTemp();
            rCore.setState(TStateTitle.instance);
        }

        private function efFinLevelSelect():void{
            close();
            rSound.stopMusic();
            TStateLevelSelect.instance.set();
        }
    }
}