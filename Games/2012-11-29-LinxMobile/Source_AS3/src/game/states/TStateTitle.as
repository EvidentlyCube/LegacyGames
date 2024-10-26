package game.states{
    import flash.events.Event;
    import flash.filters.DropShadowFilter;
    import flash.net.URLRequest;
    import flash.net.navigateToURL;
    import flash.utils.setTimeout;

    import game.global.Game;
    import game.global.Level;
    import game.global.Make;
    import game.global.Score;
    import game.global.Sfx;
    import game.mobiles.MobileButton;
    import game.mobiles.rMobileState;
    import game.standalone.LinxButton;
    import game.windows.TWinCredits;
    import game.windows.TWinOptions;

    import net.retrocade.camel.effects.rEffFade;
    import net.retrocade.camel.global.rGfx;
    import net.retrocade.camel.global.rSfx;
    import net.retrocade.camel.global.rTooltip;
    import net.retrocade.camel.objects.rBitmap;
    import net.retrocade.camel.objects.rWindow;
    import net.retrocade.standalone.Text;
    import net.retrocade.utils.UDisplay;
    import net.retrocade.camel.effects.rEffVolumeFade;

    public class TStateTitle extends rMobileState{
        [Embed(source="/../assets/gfx/by_cage/bgs/title.png")] private var __logo__:Class;

        private static var _instance:TStateTitle = new TStateTitle();
        public static function get instance():TStateTitle{
            return _instance;
        }




        private var _logo          :rBitmap;
        private var _start         :LinxButton;
        private var _options       :LinxButton;
        private var _credits       :LinxButton;
        private var _close         :LinxButton;
        private var _getFullVersion:LinxButton;
        private var _moreGames     :LinxButton;
        private var _activateFull  :LinxButton;

        private var _version:Text;

        private var _background:rBitmap;

        private var _areButtonsDisabled:Boolean = false;

        private var _displayedButtons:Vector.<LinxButton>;

        public function TStateTitle() {
            _logo    = rGfx.getB(__logo__);

            _logo.x  = (S().gameWidth - _logo.width) / 2;
            _logo.y  = 10;

            _logo.filters = [ new DropShadowFilter() ];

            const BUTTON_WIDTH:int = 260;

            _start     = new LinxButton(onStart, _("Start Game"), BUTTON_WIDTH);
            _options   = new LinxButton(onOptions, _("Options"), BUTTON_WIDTH);
            _credits   = new LinxButton(onCredits, _("Credits"), BUTTON_WIDTH);
            _close     = new LinxButton(onClose, _("Quit"), BUTTON_WIDTH);
            _getFullVersion = new LinxButton(onFull, _("Get Full Version"), BUTTON_WIDTH);
            _moreGames = new LinxButton(onMoreGames, _("More Games"), BUTTON_WIDTH);
            _activateFull = new LinxButton(onActivateFullGame, _("Activate Full Version"), BUTTON_WIDTH);

            _background = rGfx.getB(Game._background_title);

            _version = Make().text("v. " + S().version, 0xFFFFFF, 16);

            _background.smoothing = true;
            _logo.smoothing = true;

            _displayedButtons = new Vector.<LinxButton>();

            _displayedButtons.push(_start);
            _displayedButtons.push(_options);
            _displayedButtons.push(_credits);

            _displayedButtons.push(_moreGames);

            _displayedButtons.reverse();
        }

        override protected function resized(e:Event):void{
            UDisplay.scaleDisplayObject(_background, S().swfWidth, S().swfHeight, UDisplay.NO_BORDER);

            _background.alignCenter();
            _background.alignMiddle();

            _logo.scaleX = _logo.scaleY = S().sizeScaler;

            _logo.alignCenter();
            _logo.y = 10;

            const BUTTON_SPACE:Number = 5 * S().sizeScaler;

            var previousItem:LinxButton;
            for each(var button:LinxButton in _displayedButtons){
                button.resize();
                button.right = S().gameWidth - BUTTON_SPACE;

                button.bottom = (previousItem ? previousItem.y : S().gameHeight) - BUTTON_SPACE;

                previousItem = button;
            }

            _version.x = 5 * S().sizeScaler;
            _version.bottom = S().gameHeight - 5 * S().sizeScaler;
        }


        override public function create():void{
            Game.lMain.clear();

            Game.lMain.add(_background);
            Game.lMain.add(_version);
            Game.lMain.add(_logo);

            for each(var button:LinxButton in _displayedButtons){
                Game.lMain.add(button);
                button.alpha = 0;
                button.visible = false;
                button.fontSize = 28;
            }

            Game.lMain.mouseChildren = true;

            _areButtonsDisabled = true;
            _logo.alpha = 0;

            new rEffFade(_logo, 0, 1, 1000, onLogoAppeared);
            new rEffFade(Game.lMain.displayObject, 0, 1, 500);

            if (!rSfx.musicIsPlaying()){
                rSfx.playMusic(Game.getMusic(Game._music_title_));
                new rEffVolumeFade(true, 500);
            }

            super.create();
        }

        override public function destroy():void{
            rTooltip.unhook(_start);

            Game.lMain.clear();
            _defaultGroup.clear();

            super.destroy();
        }


        private function onLogoAppeared():void{
            for each(var button:LinxButton in _displayedButtons){
                button.visible = true;
                new rEffFade(button, 0, 1, 200);
            }

            setTimeout(function():void{
                _areButtonsDisabled = false;
            }, 200);
        }



        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: On Start
        // ::::::::::::::::::::::::::::::::::::::::::::::

        private function onStart():void{
            if (_areButtonsDisabled)
                return;

            _areButtonsDisabled = true;

            //new rEffFadeScreen(1, 0, 0, 500, onStartFadeFinish);
            new rEffFade(Game.lMain.displayObject, 1, 0, 500, onStartFadeFinish);
            Sfx.sfxClick.play();

        }

        private function onStartFadeFinish():void{
            TStateLevelSelect.instance.set();
        }



        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: On Options
        // ::::::::::::::::::::::::::::::::::::::::::::::

        private function onOptions():void{
            TWinOptions.set();

            Sfx.sfxClick.play();
        }



        private function onCredits():void {
            TWinCredits.instance.show();

            Sfx.sfxClick.play();
        }

        private function onClose():void{
            //new TStateSplashOutro(false);
            // NativeApplication.nativeApplication.exit();
        }


        private function onFull():void{
            Sfx.sfxClick.play();

            navigateToURL(new URLRequest('http://www.retrocade.net/post/120/linx-mobile'), '_blank');
        }

        private function onMoreGames():void{
            Sfx.sfxClick.play();

            navigateToURL(new URLRequest('http://retrocade.net'), '_blank');
        }

        private function onActivateFullGame():void{

        }
    }
}