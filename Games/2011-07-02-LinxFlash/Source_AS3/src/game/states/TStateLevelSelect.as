package game.states{
    import flash.display.BitmapData;
    import flash.net.URLRequest;
    import flash.net.navigateToURL;

    import game.global.Game;
    import game.global.Level;
    import game.global.Make;
    import game.global.Pre;
    import game.global.Score;
    import game.global.Sfx;
    import game.objects.TBackground;
    import game.objects.TRibbon;

    import net.retrocade.camel.core.rGfx;
    import net.retrocade.camel.core.rInput;
    import net.retrocade.camel.core.rSave;
    import net.retrocade.camel.core.rSound;
    import net.retrocade.camel.core.rState;
    import net.retrocade.camel.core.rTooltip;
    import net.retrocade.camel.effects.rEffFadeScreen;
    import net.retrocade.camel.effects.rEffVolumeFade;
    import net.retrocade.standalone.Bitext;
    import net.retrocade.standalone.Button;
    import net.retrocade.utils.UDisplay;

    public class TStateLevelSelect extends rState{
        private static var _instance:TStateLevelSelect = new TStateLevelSelect();

        public static function get instance():TStateLevelSelect{
            return _instance;
        }


        private var _textureDisabled :BitmapData;
        private var _textureCompleted:BitmapData;
        private var _texturePlayable :BitmapData;

        private var _buttons     :Array = [];
        private var _topMessage  :Bitext;
        private var _secretButton:Button;
        private var _returnToMenu:Button;

        private var _bg:TBackground;

        private var _playEasierButton:Button;
        private var _playHarderButton:Button;

        public function TStateLevelSelect(){
            var button:Button;
            for (var i:int = 0; i < S().TOTAL_LEVELS; i++){
                button   = Make().button(onLevelClick, (i + 1).toString(), 56);
                button.x = 4 + 64 * (i % 8) | 0;
                button.y = 60 + 48 * (i / 8 | 0);
                button.data.level = i+1;

                Bitext(button.data.txt).positionToCenter();

                _buttons.push(button);
            }

            _textureDisabled  = Make().textTexture([0x666666, 0x333333],           [1,1],   [0, 255],     13);
            _textureCompleted = Make().textTexture([0x00FF00, 0xAAFFAA, 0x00FF00], [1,1,1], [0, 80, 255], 13);
            _texturePlayable  = Make().textTexture([0x888800, 0xFFFF00, 0x888800], [1,1,1], [0, 80, 255], 13);

            _topMessage   = new Bitext(_("Select level:"));
            _secretButton = Make().button(onSecretClick, '', 504);
            _returnToMenu = Make().button(onReturnClick, _('Return to Title Screen'));

            _topMessage.y = 10;
            _topMessage.setScale(2);
            _topMessage.positionToCenterScreen();
            _topMessage.addShadow();

            _secretButton.x = 4;
            _secretButton.y = 300;
            _secretButton.data.txt.positionToCenter();

            _returnToMenu.x = (S().gameWidth - _returnToMenu.width) / 2 | 0;
            _returnToMenu.y = 400;

            _playEasierButton = Make().button(onEasierClick, "<--");
            _playHarderButton = Make().button(onHarderClick, "-->");

            _playEasierButton.y = _playHarderButton.y = 350;
            _playEasierButton.x = 4;
            _playHarderButton.x = S().gameWidth - _playHarderButton.width - 4;

            _bg = new TBackground(rGfx.getBD(Pre._bg_), Game.lBG, 0, 0);
        }

        private function onEasierClick():void{
            if (Level.levelsMode == 'regular') {
                Level.levelsMode = 'easy';
            } else if (Level.levelsMode == 'hard') {
                Level.levelsMode = 'regular';
            } else {
                return;
            }

            Sfx.sfxClickPlay();
            create();
        }

        private function onHarderClick():void{
            if (Level.levelsMode == 'regular') {
                Level.levelsMode = 'hard';
            } else if (Level.levelsMode == 'easy') {
                Level.levelsMode = 'regular';
            } else {
                return;
            }

            Sfx.sfxClickPlay();
            create();
        }

        override public function update():void{
            super.update();

            Game.lBG.clear();

            _bg.xspeed = (rInput.mouseX - S().gameWidth / 2) / 100;
            _bg.yspeed = (rInput.mouseY - S().gameHeight / 2) / 100;

            _bg.update();
        }

        override public function create():void{
            //new rEffFadeScreen(0, 1, 0, 500);

            if (!rSound.musicIsPlaying()){
                new rEffVolumeFade(true, 250);
                rSound.playMusic(Game.getMusic(Game._music_title_), 0, 100);
            }

            var button:Button;
            for (var i:int = 0; i < S().TOTAL_LEVELS; i++){
                button = _buttons[i];

                if (Score.getCompletedArray()[i]){
                    button.enable();
                    button.data.txt.texture = _textureCompleted;
                    button.refresh();

                } else {
                    button.enable();
                    button.data.txt.texture = _textureDisabled;
                    button.refresh();
                }

                Game.lMain.add2(button);
            }

            if (rSave.read("outroSeen", false)){
                _secretButton.data.txt.text = _('secretShow');
                _secretButton.enable();

            } else {
                _secretButton.data.txt.text = _('secretHidden');
                _secretButton.disable();
            }

            _secretButton.data.txt.positionToCenter();

            Game.lMain.add2(_topMessage);
            Game.lMain.add2(_secretButton);
            Game.lMain.add2(_returnToMenu);
            Game.lMain.add2(_playEasierButton);
            Game.lMain.add2(_playHarderButton);

            new rEffFadeScreen(0, 1, 0, 500);

            _topMessage.text = _("levels_" + Level.levelsMode);
            _topMessage.positionToCenter();

            _playEasierButton.visible = Level.levelsMode !== 'easy';
            _playHarderButton.visible = Level.levelsMode !== 'hard';

        }

        override public function destroy():void{
            Game.lMain.clear();
        }



        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: On Level
        // ::::::::::::::::::::::::::::::::::::::::::::::

        private var _clickedData:Button;

        private function onLevelClick(clicked:Button):void{
            _clickedData = clicked;

            Sfx.sfxClickPlay();

            new rEffFadeScreen(1, 0, 0, 500, onLevelFade);
            new rEffVolumeFade(false, 400, function():void{rSound.stopMusic();});
        }

        private function onLevelFade():void{
            TStateGame.instance.set();

            Level.continueGame(_clickedData.data.level);
        }

        private function onSecretClick():void{
            Sfx.sfxClickPlay();
            TStateFinish.instance.set();
        }

        private function onReturnClick():void{
            TStateTitle.instance.set();
            Sfx.sfxClickPlay();
        }
    }
}