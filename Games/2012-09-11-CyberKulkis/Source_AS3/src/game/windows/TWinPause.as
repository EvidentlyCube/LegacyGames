package game.windows{
    import flash.net.URLRequest;
    import flash.net.navigateToURL;

    import game.global.Game;
    import game.global.Level;
    import game.global.Make;
    import game.global.Options;
    import game.global.Sfx;
    import game.states.TStateTitle;

    import net.retrocade.camel.core.rCore;
    import net.retrocade.camel.core.rInput;
    import net.retrocade.camel.core.rSave;
    import net.retrocade.camel.core.rSound;
    import net.retrocade.camel.core.rTooltip;
    import net.retrocade.camel.core.rWindow;
    import net.retrocade.camel.easings.exponentialIn;
    import net.retrocade.camel.easings.exponentialOut;
    import net.retrocade.camel.effects.rEffFade;
    import net.retrocade.camel.effects.rEffFadeScreen;
    import net.retrocade.camel.effects.rEffMove;
    import net.retrocade.camel.effects.rEffVolumeFade;
    import net.retrocade.camel.rCollide;
    import net.retrocade.standalone.Button;
    import net.retrocade.standalone.Grid9;
    import net.retrocade.standalone.Text;
    import net.retrocade.utils.Key;
    import net.retrocade.utils.UGraphic;

    public class TWinPause extends rWindow{
        [Embed(source="/../assets/gfx/toggleMusic.png")] public static var _gfxMusic:Class;
        [Embed(source="/../assets/gfx/toggleSound.png")] public static var _gfxSound:Class;


        private static var _instance:TWinPause = new TWinPause();

        public static function get instance():TWinPause{
            return _instance;
        }

        protected var music:Button;
        protected var sound:Button;

        protected var redefine:Button;
        protected var restart:Button;
        protected var toMenu :Button;
        protected var closer :Button;
        //protected var help   :Button;

        protected var bg     :Grid9;

        public function TWinPause() {
            this._blockUnder = true;
            this._pauseGame  = true;

            var txt:Text = new Text(_("Game is Paused"), "font", 22);
            txt.setShadow();

            bg       = Grid9.getGrid("window");
            music    = Make().buttonSound(onMusicClick);
            sound    = Make().buttonSound(onSoundClick);
            redefine = Make().button(onRedefine, _('Redefine'));
            closer   = Make().button(onClose,    _('Return to Game'));
            restart  = Make().button(onRestart,  _('Restart'));
            toMenu   = Make().button(onMenu,     _('Return to Title Screen'));
            //help     = Make().button(onHelp,     _('Walkthrough'));

            music.addChild(new _gfxMusic);
            sound.addChild(new _gfxSound);

            addChild(bg);

            addChild(music);
            addChild(sound);

            addChild(txt);
            addChild(redefine);
            addChild(closer);
            addChild(restart);
            addChild(toMenu);
            //addChild(help);

            txt     .y = 0;
            music   .y = 50;
            sound   .y = 50;
            redefine.y = 110;
            closer  .y = redefine.y + redefine.height + 55;
            restart .y = closer  .y + closer  .height + 5;
            toMenu  .y = restart .y + restart .height + 5;
            //help    .y = toMenu  .y + toMenu  .height + 5;

            bg.width = 300;
            bg.height = toMenu.y + toMenu.height + 10;

            music   .x = width / 2 - music.width  - 5 | 0;
            sound   .x = width / 2                + 5 | 0;
            txt     .x = (width - txt     .width) / 2 | 0;
            closer  .x = (width - closer  .width) / 2 | 0;
            redefine.x = (width - redefine.width) / 2 | 0;
            restart .x = (width - restart .width) / 2 | 0;
            toMenu  .x = (width - toMenu  .width) / 2 | 0;
            //help    .x = (width - help    .width) / 2 | 0;

            center();

            //UGraphic.clear(this).beginFill(0, 0.5).drawRect(-x, -y, S().gameWidth, S().gameHeight)
            //    .beginFill(0).drawRect(0, 0, options.width + 10, help.y + help.height + 10);

            rTooltip.hook(restart, _('Click loses progress'), true);
            rTooltip.hook(toMenu,  _('Click loses progress'), true);
            //rTooltip.hook(help,    _('helpTooltip')         , true);
        }

        override public function show():void{
            super.show();

            mouseEnabled  = false;
            mouseChildren = false;

            center();
            y -= 100;

            (new rEffMove(this, x, y + 100, 400)).easing = exponentialOut;
            new rEffFade(this, 0, 1, 400, function():void{
                mouseEnabled  = true;
                mouseChildren = true;
            });
        }

        override public function update():void{
            super.update();

            sound.alpha = (rSound.soundVolume ? 1 : 0.5);
            music.alpha = (rSound.musicVolume ? 1 : 0.5);

            if ((rInput.isKeyHit(Key.ESCAPE) || rInput.isKeyHit(Key.P)) && mouseEnabled)
                onClose();
        }



        // ::::::::::::::::::::::::::::::::::::::::::::::
		// :: Button Callbacks
		// ::::::::::::::::::::::::::::::::::::::::::::::

        private function onClose():void {
            mouseEnabled  = false;
            mouseChildren = false;

            (new rEffMove(this, x, y + 100, 400)).easing = exponentialIn;
            new rEffFade(this, alpha, 0, 400, efFinClose);
            Sfx.click();
        }

        private function onRestart():void{
            mouseEnabled  = false;
            mouseChildren = false;
            (new rEffMove(this, x, y + 100, 400)).easing = exponentialIn;
            new rEffFade(this, 1, 0, 400, efFinRestart);
            Sfx.click();
        }

        private function onMenu():void{
            (new rEffMove(this, x, y + 100, 400)).easing = exponentialIn;
            new rEffFade(this, 1, 0, 400);
            new rEffFadeScreen(1, 0, 0, 1000, efFinReturnToMenu);
            new rEffVolumeFade(false, 200);
            Sfx.click();
        }

        private function onHelp():void {
            navigateToURL(new URLRequest("http://retrocade.net/article/9/walkthrough-kulkis-15"), "_blank");
            Sfx.click();
        }

        private function onMusicClick():void{
            rSound.musicVolume = (rSound.musicVolume ? 0 : 1);
            Sfx.click();
            rSave.write('optVolumeMusic', rSound.musicVolume);
        }

        private function onSoundClick():void{
            rSound.soundVolume = (rSound.soundVolume ? 0 : 1);
            Sfx.click();
            rSave.write('optVolumeSound', rSound.musicVolume);
        }

        private function onRedefine():void{
            TWinRedefine.instance.show();
            Sfx.click();
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
            TStateTitle.instance.set();
        }

        private function efFinRestart():void{
            close();
        }

    }
}