package game.states{
    import flash.display.BitmapData;
    import flash.events.Event;
    import flash.net.URLRequest;
    import flash.net.navigateToURL;

    import game.global.Game;
    import game.global.Level;
    import game.global.Make;
    import game.global.Score;
    import game.global.Sfx;
    import game.mobiles.MobileButton;
    import game.mobiles.rMobileState;
    import game.standalone.LinxButton;

    import net.retrocade.camel.effects.rEffFade;
    import net.retrocade.camel.effects.rEffMusicFade;
    import net.retrocade.camel.global.rSave;
    import net.retrocade.camel.global.rSfx;
    import net.retrocade.camel.objects.rSprite;
    import net.retrocade.standalone.Text;
    import net.retrocade.camel.effects.rEffVolumeFade;

    public class TStateLevelSelect extends rMobileState{
        private static var _instance:TStateLevelSelect;

        public static function get instance():TStateLevelSelect{
            return _instance ? _instance : _instance = new TStateLevelSelect;
        }


        private var _textureDisabled :BitmapData;
        private var _textureCompleted:BitmapData;
        private var _texturePlayable :BitmapData;

        private var _buttons     :Array = [];
        private var _buttonHolder:rSprite;
        private var _topMessage  :Text;
        private var _secretButton:LinxButton;
        private var _returnToMenu:LinxButton;

        private var _switchSetLower:LinxButton;
        private var _switchSetHigher:LinxButton;

        private var _disableButtons:Boolean = false;

        public function TStateLevelSelect(){
            _buttonHolder = new rSprite();

            var button:LinxButton;
            for (var i:int = 0; i < S().totalLevels; i++){
                button   = new LinxButton(onLevelClick, (i + 1).toString());
                button.x = 65 * S().sizeScaler * (i % 8) | 0;
                button.y = 65 * S().sizeScaler * (i / 8 | 0);

                button.data.level = i+1;
                button.grid9lit.height = button.grid9normal.height = 65 * S().sizeScaler;
                button.grid9lit.width  = button.grid9normal.width  = 65 * S().sizeScaler;

                button.textField.alignCenterParent();
                button.textField.alignMiddleParent(-4);

                _buttons.push(button);

                _buttonHolder.addChild(button);
            }

            _topMessage   = Make().text(_("Select level:"), 0xFFFFFF, 48);
            _secretButton = new LinxButton(onSecretClick, '');
            _returnToMenu = new LinxButton(onReturnClick, _("Return to Title Screen"));

            _topMessage.y = 5;
            _topMessage.alignCenter();
            _topMessage.setShadow();

            _secretButton.x = 4;
            _secretButton.y = 300;
            _secretButton.resize()

            _returnToMenu.x = (S().gameWidth - _returnToMenu.width) / 2 | 0;
            _returnToMenu.y = 400;

            _switchSetLower = new LinxButton(onLevelsetLeft, "<<<");
            _switchSetHigher = new LinxButton(onLevelsetRight, ">>>");

            _switchSetLower.y = _switchSetHigher.y = 350;
            _switchSetLower.x = 4;
            _switchSetHigher.x = S().gameWidth - _switchSetHigher.width - 4;
            _switchSetHigher.enabled = Score.wasNormalCompleted;
        }

        override protected function resized(e:Event):void{
            setGameMode(Score.gameMode);

            for each(var button:LinxButton in _buttons){
                button.resize();

                button.grid9lit.height = button.grid9normal.height = 65 * S().sizeScaler;
                button.grid9lit.width  = button.grid9normal.width  = 65 * S().sizeScaler;

                button.textField.alignCenterParent();
                button.textField.alignMiddleParent(-4);
            }

            const row:uint = rowsForWidth();
            const l  :uint = S().totalLevels;
            const lastRowCount:uint = (l - (l / row | 0) * row);
            const lastRowPixels:uint = lastRowCount * 65 * S().sizeScaler;
            const lastRowFirstIndex:uint = l - lastRowCount;
            var   lastRowPixelOffset:uint = (65 * row * S().sizeScaler - lastRowPixels) / 2 | 0;

            for (var i:int = 0; i < l; i++){
                button = _buttons[i];

                button.x = 65 * S().sizeScaler * (i % row) | 0;
                button.y = 65 * S().sizeScaler * (i / row | 0);

                if (i >= lastRowFirstIndex){
                    button.x += lastRowPixelOffset;
                }
            }

            _topMessage.size = 48 * S().sizeScaler;

            _buttonHolder.y = _topMessage.bottom + 10 | 0;
            _buttonHolder.alignCenter();

            _switchSetLower.x = 5;
            _switchSetHigher.right = S().gameWidth - 5;

            _topMessage.alignCenter();

            var switchY:uint = _buttonHolder.y + ((S().gameWidth - button.right) > _switchSetLower.width + 10 ? button.y : button.bottom + 10);
            _switchSetLower.y = _switchSetHigher.y = switchY + 3;

            _secretButton.resize();
            _returnToMenu.resize();

            _secretButton.alignCenter();
            _returnToMenu.alignCenter();

            _returnToMenu.bottom = S().gameHeight - 10;
            _secretButton.y = _buttonHolder.y + button.bottom + 10;

            while (_returnToMenu.y <= _secretButton.bottom){
                if (_secretButton.y > button.bottom + 7){
                    _secretButton.y--;
                }

                _returnToMenu.y++;
            }
        }

        private function onLevelsetLeft():void{
            Sfx.sfxClick.play();

            setGameMode(Score.getPrevGameMode(Score.gameMode));
        }

        private function onLevelsetRight():void{
            Sfx.sfxClick.play();

            setGameMode(Score.getNextGameMode(Score.gameMode));
        }

        private function setGameMode(mode:uint):void{
            switch(mode){
                case(Score.MODE_NORMAL):
                    _switchSetHigher.enabled = true;
                    _switchSetLower .enabled = true;
                    Score.gameMode = mode;
                    _topMessage.text = "Levelset: Normal";

                    _secretButton.visible = true;

                    if (rSave.read("outroSeen" + Score.gameMode, false)){
                        _secretButton.enabled = true;
                        _secretButton.textField.text = "Show Outro";
                    } else {
                        _secretButton.enabled = false;
                        _secretButton.textField.text = "???";
                    }
                    _secretButton.resize();

                    break;

                case(Score.MODE_EASY):
                    _switchSetHigher.enabled = true;
                    _switchSetLower .enabled = false;
                    Score.gameMode = mode;
                    _topMessage.text = "Levelset: Easy";

                    _secretButton.visible = false;
                    break;

                case(Score.MODE_BRANDED):
                    _switchSetHigher.enabled = Score.wasNormalCompleted;
                    _switchSetLower .enabled = true;
                    Score.gameMode = mode;
                    _topMessage.text = "Levelset: Exclusive A";

                    _secretButton.visible = false;
                    break;

                case(Score.MODE_HARD):
                    _switchSetHigher.enabled = false;
                    _switchSetLower .enabled = true;
                    Score.gameMode = mode;
                    _topMessage.text = "Levelset: Hard";

                    _secretButton.visible = true;

                    if (rSave.read("outroSeen" + Score.gameMode, false)){
                        _secretButton.enabled = true;
                        _secretButton.textField.text = "Show Outro";
                    } else {
                        _secretButton.enabled = false;
                        _secretButton.textField.text = "???";
                    }
                    _secretButton.resize();
                    break;
            }

            _topMessage.fitSize();
            _topMessage.alignCenter();
            updateButtons();
        }

        private function updateButtons():void{
            var button:LinxButton;
            for (var i:int = 0; i < S().totalLevels; i++){
                button = _buttons[i];

                if (Score.isLevelCompleted(i)){
                    button.enable();
                    button.textField.color = 0x00FF00;

                } else {
                    button.enable();
                    button.textField.color = 0xA0A0A0;

                }
            }
        }

        override public function create():void{
            //new rEffFadeScreen(0, 1, 0, 500);

            if (!rSfx.musicIsPlaying()){
                new rEffVolumeFade(true, 250);
                rSfx.playMusic(Game.getMusic(Game._music_title_), 100);
            }

            updateButtons();

            _secretButton.resize();

            Game.lMain.add(_buttonHolder);
            Game.lMain.add(_topMessage);
            Game.lMain.add(_secretButton);
            Game.lMain.add(_returnToMenu);

            Game.lMain.add(_switchSetLower);
            Game.lMain.add(_switchSetHigher);

            new rEffFade(Game.lMain.displayObject, 0, 1, 500, function():void{_disableButtons = false;});

            _disableButtons = true;

            super.create();
        }

        override public function destroy():void{
            super.destroy();

            Game.lMain.clear();
        }



        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: On Level
        // ::::::::::::::::::::::::::::::::::::::::::::::

        private var _clickedData:MobileButton;

        private function onLevelClick(clicked:MobileButton):void{
            if (_disableButtons)
                return;

            _disableButtons = true;

            _clickedData = clicked;

            Sfx.sfxClick.play();

            new rEffFade(Game.lMain.displayObject, 1, 0, 500, onLevelFade);
            new rEffMusicFade(0, 400, NaN, function():void{rSfx.stopMusic();});
        }

        private function onLevelFade():void{
            TStateGame.instance.set();

            Level.continueGame(_clickedData.data.level);
        }

        private function onSecretClick():void{
            Sfx.sfxClick.play();
            new TStateSplashOutro(Score.gameMode == Score.MODE_NORMAL);
        }

        private function onReturnClick():void{

            new rEffFade(Game.lMain.displayObject, 1, 0, 500, onReturnFade);

            Sfx.sfxClick.play();
        }

        private function onReturnFade():void{
            TStateTitle.instance.set();
        }

        private function rowsForWidth():uint{
            return 8;
        }
    }
}