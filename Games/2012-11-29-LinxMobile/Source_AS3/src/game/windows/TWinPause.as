package game.windows{
    import flash.events.Event;
    import flash.net.URLRequest;
    import flash.net.navigateToURL;

    import game.global.Game;
    import game.global.Make;
    import game.global.Sfx;
    import game.mobiles.MobileButton;
    import game.mobiles.rMobileWindow;
    import game.objects.TDragButton;
    import game.states.TStateLevelSelect;
    import game.states.TStateTitle;

    import net.retrocade.camel.effects.rEffFade;
    import net.retrocade.camel.effects.rEffMusicFade;
    import net.retrocade.camel.effects.rEffSolidScreen;
    import net.retrocade.camel.global.rCore;
    import net.retrocade.camel.global.rGfx;
    import net.retrocade.camel.global.rSave;
    import net.retrocade.camel.global.rSfx;
    import net.retrocade.camel.objects.rBitmap;
    import net.retrocade.standalone.Grid9;
    import net.retrocade.standalone.Text;

    public class TWinPause extends rMobileWindow{
        private static var _instance:TWinPause = new TWinPause();

        public static function get instance():TWinPause{
            return _instance;
        }

        protected var iconMusic:rBitmap;
        protected var dragMusic:TDragButton;

        protected var iconSfx  :rBitmap;
        protected var dragSound:TDragButton;

        protected var toMenu :MobileButton;
        protected var toSelect:MobileButton;
        protected var closer :MobileButton;
        protected var walkthrough:MobileButton;


        protected var bg:Grid9;

        protected var darkener:rEffSolidScreen;

        private var disableButtons:Boolean = false;

        public function TWinPause() {
            this._blockUnder = true;
            this._pauseGame  = true;

            bg = Grid9.getGrid("windowBG");

            var txt:Text = Make().textCaps(_("Game is Paused"), 0xFFFFFF, 48, 8);

            iconSfx   = rGfx.getB(TWinOptions._icon_sfx);

            iconSfx.smoothing = true;
            iconSfx.width = iconSfx.height = 60 * S().sizeScaler;


            dragSound = new TDragButton();

            iconMusic = rGfx.getB(TWinOptions._icon_music);
            iconMusic.smoothing = true;
            iconMusic.width = iconMusic.height = 60 * S().sizeScaler;
            dragMusic = new TDragButton();

            var bg:Grid9 = Grid9.getGrid("windowBG");

            iconSfx.y = txt.bottom + 20 * S().sizeScaler;

            dragMusic.x = 10;

            iconMusic.y = txt.bottom + 20 * S().sizeScaler;
            dragMusic.y = iconMusic.bottom;

            iconSfx  .y = dragMusic.bottom + 20 * S().sizeScaler;

            dragSound.x = 10
            dragSound.y = iconSfx.bottom;


            closer   = Make().button(onClose, _('Return to Game'));
            toSelect = Make().button(onSelect, _('Return to level selection'));
            toMenu   = Make().button(onMenu, _('Return to Title Screen'));
            walkthrough = Make().button(onWalkthrough, _('Walkthrough'));


            addChild(bg);
            addChild(txt);
            addChild(iconSfx);
            addChild(iconMusic);
            addChild(dragMusic);
            addChild(dragSound);
            addChild(closer);
            addChild(toSelect);
            addChild(toMenu);
            addChild(walkthrough);


            iconSfx  .alignCenterParent();
            txt.alignCenterParent();
            closer.alignCenterParent();
            closer.y = dragSound.bottom + 30 * S().sizeScaler | 0;

            txt      .filters = Game.FILTER_SHADOW;
            iconSfx  .filters = Game.FILTER_SHADOW;

            closer  .y = dragSound.bottom + 25 * S().sizeScaler | 0;
            walkthrough.y = closer.bottom + 5 * S().sizeScaler | 0;
            toSelect.y = walkthrough.bottom + 5 * S().sizeScaler | 0;
            toMenu  .y = toSelect.bottom + 5 * S().sizeScaler | 0;

            bg.width  = dragSound.width + 20 ;
            bg.height = toMenu.bottom + 5;

            txt     .alignCenterParent();
            closer  .alignCenterParent();
            toSelect.alignCenterParent();
            toMenu  .alignCenterParent();
            walkthrough.alignCenterParent();

            center();

            dragSound.addEventListener(Event.CHANGE, onSliderChanged);
            dragSound.addEventListener(Event.SELECT, function():void{
                Sfx.sfxClick.play();
            });

            iconMusic.filters = Game.FILTER_SHADOW;
            iconMusic.alignCenterParent();
            dragMusic.addEventListener(Event.CHANGE, onSliderChanged);
        }

        override protected function resized(e:Event):void{
            center();
        }

        override public function show():void{
            super.show();

            disableButtons = true;

            darkener = new rEffSolidScreen(0, 0.5)
            new rEffFade(this, 0, 1, 250);
            new rEffFade(darkener.layer.displayObject, 0, 1, 250, function():void{disableButtons = false;});

            mouseEnabled  = true;
            mouseChildren = true;

            dragMusic.value = rSfx.musicVolume;
            dragSound.value = rSfx.soundVolume;

            center();
        }

        override public function close():void {
            rSave.write("musicVolume", rSfx.musicVolume);
            rSave.write("soundVolume", rSfx.soundVolume);
            rSave.flush(1024 * 32);

            super.close();
            darkener.stop();
        }



        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Button Callbacks
        // ::::::::::::::::::::::::::::::::::::::::::::::

        private function onSliderChanged(e:Event):void{
            if (e.target == dragMusic)
                rSfx.musicVolume = dragMusic.value;

            if (e.target == dragSound)
                rSfx.soundVolume = dragSound.value;
        }

        private function onClose():void {
            if (disableButtons)
                return;

            disableButtons = true;

            mouseEnabled  = false;
            mouseChildren = false;
            new rEffFade(this, 1, 0, 250, efFinClose);
            new rEffFade(darkener.layer.displayObject, 1, 0, 250);

            Sfx.sfxClick.play();
        }

        private function onMenu():void{
            if (disableButtons)
                return;

            disableButtons = true;

            new rEffFade(this, 1, 0, 400);
            new rEffFade(darkener.layer.displayObject, 1, 0, 400);
            new rEffFade(Game.lGame.displayObject, 1, 0, 600);
            new rEffFade(Game.lMain.displayObject, 1, 0, 600, efFinReturnToMenu);
            new rEffMusicFade(0, 200);

            Sfx.sfxClick.play();
        }

        private function onWalkthrough():void{
            Sfx.sfxClick.play();

            navigateToURL(new URLRequest('http://www.retrocade.net/post/125/linx-mobile-walkthrough'), "_blank");
        }

        private function onSelect():void{
            if (disableButtons)
                return;

            disableButtons = true;

            new rEffFade(this, 1, 0, 400);
            new rEffFade(darkener.layer.displayObject, 1, 0, 400);
            new rEffFade(Game.lGame.displayObject, 1, 0, 600);
            new rEffFade(Game.lMain.displayObject, 1, 0, 600, efFinLevelSelect);
            new rEffMusicFade(0, 200);

            Sfx.sfxClick.play();
        }



        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Effect Callbacks
        // ::::::::::::::::::::::::::::::::::::::::::::::

        private function efFinClose():void {
            close();
        }

        private function efFinReturnToMenu():void{
            close();
            rSfx.stopMusic();
            rSfx.resetMusicFadeVolume();
            rCore.setState(TStateTitle.instance);
        }

        private function efFinLevelSelect():void{
            close();
            rSfx.stopMusic();
            TStateLevelSelect.instance.set();
        }
    }
}