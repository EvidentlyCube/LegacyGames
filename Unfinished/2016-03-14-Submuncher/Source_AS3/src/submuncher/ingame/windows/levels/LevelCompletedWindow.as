package submuncher.ingame.windows.levels {

    import net.retrocade.constants.KeyConst;
    import net.retrocade.functions.printf;
    import net.retrocade.retrocamel.core.RetrocamelInputManager;
    import net.retrocade.retrocamel.locale._;
    import net.retrocade.utils.UtilsString;

    import starling.display.MovieClip;
    import starling.utils.HAlign;
    import starling.utils.VAlign;

    import submuncher.core.constants.Gfx;
    import submuncher.core.constants.GuiNames;
    import submuncher.core.constants.GuiTextureCollections;
    import submuncher.core.display.SubmuncherTextField;
    import submuncher.core.repositories.LevelGroupEntryMetadata;
    import submuncher.core.repositories.LevelGroupMetadata;
    import submuncher.core.repositories.LevelGroupsRepository;
    import submuncher.core.repositories.LevelMetadata;
    import submuncher.core.repositories.LevelRepository;
    import submuncher.core.save.Save;
    import submuncher.core.save.SaveLevelProgress;
    import submuncher.ingame.core.Game;
    import submuncher.ingame.core.LevelScore;
    import submuncher.ingame.core.Utils;

    public class LevelCompletedWindow extends ScreenWindowBase {
        public static function showWindow(game:Game, group:LevelGroupEntryMetadata, level:LevelMetadata, score:LevelScore, save:Save):LevelCompletedWindow {
            var window:LevelCompletedWindow = new LevelCompletedWindow(game, group, level, score, save);
            window.show();

            return window;
        }


        private var _extLevel:LevelMetadata;
        private var _extScore:LevelScore;
        private var _extGroup:LevelGroupEntryMetadata;
        private var _extSave:Save;

        private var _restartButton:PanelWindowButton;
        private var _nextLevelButton:PanelWindowButton;
        private var _exitButton:PanelWindowButton;

        private var _levelTitle:SubmuncherTextField;
        private var _timeLabel:SubmuncherTextField;
        private var _restartLabel:SubmuncherTextField;
        private var _nextLevelLabel:SubmuncherTextField;
        private var _exitLabel:SubmuncherTextField;

        private var _levelIcons:Vector.<MovieClip>;

        private var _extSelectedButton:PanelWindowButton;

        public function LevelCompletedWindow(game:Game, group:LevelGroupEntryMetadata, level:LevelMetadata, score:LevelScore, save:Save) {
            super(_("window.level_completed.header"), game);

            _extLevel = level;
            _extScore = score;
            _extSave = save;
            _extGroup = group;
            _blockUnder = false;

            initCreateObjects();
            initSetProperties();
            initSetPositions();
            initaddToBigWindowren();

            addIcons();
            linkButtons();

            _extSelectedButton = _restartButton;
            _extSelectedButton.isSelected = true;
        }

        override public function dispose():void {
            for each (var clip:MovieClip in _levelIcons) {
                clip.dispose();
            }

            _restartButton.dispose();
            _nextLevelButton.dispose();
            _exitButton.dispose();
            _levelTitle.dispose();
            _restartLabel.dispose();
            _nextLevelLabel.dispose();
            _exitLabel.dispose();
            _timeLabel.dispose();

            _restartButton = null;
            _nextLevelButton = null;
            _exitButton = null;
            _levelTitle = null;
            _restartLabel = null;
            _nextLevelLabel = null;
            _exitLabel = null;
            _levelIcons = null;
            _extSelectedButton = null;
            _timeLabel = null;

            super.dispose();
        }

        private function initCreateObjects():void {
            _levelIcons = new Vector.<MovieClip>();

            _nextLevelButton = new PanelWindowButton(Gfx.guiAtlas.getTexture(GuiNames.MONITOR_NEXT_LEVEL), Gfx.guiAtlas.getTexture(GuiNames.MONITOR_NEXT_LEVEL_SELECTED));
            _restartButton = new PanelWindowButton(Gfx.guiAtlas.getTexture(GuiNames.MONITOR_RESTART), Gfx.guiAtlas.getTexture(GuiNames.MONITOR_RESTART_SELECTED));
            _exitButton = new PanelWindowButton(Gfx.guiAtlas.getTexture(GuiNames.MONITOR_EXIT), Gfx.guiAtlas.getTexture(GuiNames.MONITOR_EXIT_SELECTED));

            _levelTitle = new SubmuncherTextField(_extGroup.name, 1, 0xFFFFFF, 192, 22);
            _timeLabel = new SubmuncherTextField("", 1, 0xFFFFFF, 192, 32);
            _nextLevelLabel = new SubmuncherTextField(_("window.level_completed.next", nextLevel.name), 1, 0xFFFFFF, 168, 16);
            _restartLabel = new SubmuncherTextField(_("window.level_completed.restart"), 1, 0xFFFFFF, 168, 16);
            _exitLabel = new SubmuncherTextField(_("window.level_completed.return"), 1, 0xFFFFFF, 168, 16);
        }

        private function initSetProperties():void {
            _levelTitle.hAlign = HAlign.CENTER;
            _levelTitle.vAlign = VAlign.CENTER;

            _timeLabel.hAlign = HAlign.CENTER;
            _timeLabel.vAlign = VAlign.CENTER;
            setPlayerTimeText();

            _nextLevelLabel.vAlign = VAlign.CENTER;
            _restartLabel.vAlign = VAlign.CENTER;
            _exitLabel.vAlign = VAlign.CENTER;
        }

        private function initSetPositions():void {
            _restartButton.x = 16;
            _restartButton.y = 144;
            _nextLevelButton.x = 16;
            _nextLevelButton.y = 168;
            _exitButton.x = 16;
            _exitButton.y = 192;

            _levelTitle.x = 16;
            _levelTitle.y = 8;
            _timeLabel.x = 16;
            _timeLabel.y = 80;
            _restartLabel.x = 48;
            _restartLabel.y = 146;
            _nextLevelLabel.x = 48;
            _nextLevelLabel.y = 170;
            _exitLabel.x = 48;
            _exitLabel.y = 194;
        }

        private function initaddToBigWindowren():void {
            addToBigWindow(
                    _levelTitle,
                    _timeLabel,
                    _nextLevelButton,
                    _restartButton,
                    _exitButton,
                    _nextLevelLabel,
                    _restartLabel,
                    _exitLabel
            )
        }

        private function addIcons():void {
            var state:SaveLevelProgress = _extSave.progress.getLevelProgressByLevelId(_extLevel.id);
            var isRequired:Boolean = state.isRequired;

            var completedIcon:MovieClip = new MovieClip(!state.isCompleted ? GuiTextureCollections.monitorCompletion : GuiTextureCollections.monitorCompletionDone);
            var parTimeIcon:MovieClip = new MovieClip(!state.isParTime ? GuiTextureCollections.monitorPar : GuiTextureCollections.monitorParDone);

            if (isRequired) {
                var secretIcon:MovieClip = new MovieClip(!state.areSecretsCollected ? GuiTextureCollections.monitorSecret : GuiTextureCollections.monitorSecretDone);
                var documentIcon:MovieClip = new MovieClip(!state.isDocumentCollected ? GuiTextureCollections.monitorDocument : GuiTextureCollections.monitorDocumentDone);
            }


            if (isRequired) {
                completedIcon.x = 32;
                parTimeIcon.x = 80;
                secretIcon.x = 128;
                documentIcon.x = 176;

                completedIcon.y = 48;
                parTimeIcon.y = 48;
                secretIcon.y = 48;
                documentIcon.y = 48;

            } else {
                completedIcon.x = 80;
                parTimeIcon.x = 128;

                completedIcon.y = 48;
                parTimeIcon.y = 48;
            }


            addToBigWindow(completedIcon);
            addToBigWindow(parTimeIcon);
            _levelIcons.push(completedIcon, parTimeIcon);

            if (isRequired) {
                addToBigWindow(secretIcon);
                addToBigWindow(documentIcon);
                _levelIcons.push(secretIcon, parTimeIcon);
            }

        }

        private function linkButtons():void {
            _exitButton.buttonUp = _nextLevelButton;
            _exitButton.buttonDown = _restartButton;

            _restartButton.buttonUp = _exitButton;
            _restartButton.buttonDown = _nextLevelButton;

            _nextLevelButton.buttonUp = _restartButton;
            _nextLevelButton.buttonDown = _exitButton;
        }


        override public function show():void {
            BackgroundWindow.instance.show();
            super.show();
            y = BackgroundWindow.instance.y;
        }

        override public function hide():void {
            super.hide();
            dispose();
        }

        override protected function updateInternal():void {
            _restartButton.update();
            _nextLevelButton.update();
            _exitButton.update();

            if (RetrocamelInputManager.isKeyHit(KeyConst.W) || RetrocamelInputManager.isKeyHit(KeyConst.UP)) {
                switchButton(_extSelectedButton.buttonUp);
            } else if (RetrocamelInputManager.isKeyHit(KeyConst.S) || RetrocamelInputManager.isKeyHit(KeyConst.DOWN)) {
                switchButton(_extSelectedButton.buttonDown);
            } else if (RetrocamelInputManager.isKeyHit(KeyConst.SPACE)) {
                selectedButton(_extSelectedButton);
            } else if (RetrocamelInputManager.isKeyHit(KeyConst.TAB)) {
                startHiding(false);
                openWindowAbove(LevelSelectionWindow.showWindow(game, LevelGroupsRepository.getGroupByLevel(_extLevel), _extSave));
            }
        }

        private function switchButton(button:PanelWindowButton):void {
            if (!button) {
                return;
            }

            if (_extSelectedButton.data is LevelGroupEntryMetadata) {
                if (!(button.data is LevelGroupEntryMetadata)) {
                    _nextLevelButton.buttonUp = _extSelectedButton;
                    _exitButton.buttonDown = _extSelectedButton;
                } else {
                    _levelTitle.text = LevelGroupEntryMetadata(button.data).name + "\n" + "Par time: " + LevelGroupEntryMetadata(button.data).level.parTime;
                }
            }

            _extSelectedButton.isSelected = false;
            _extSelectedButton = button;
            _extSelectedButton.isSelected = true;
        }

        private function selectedButton(button:PanelWindowButton):void {
            switch (button) {
                case(_restartButton):
                    game.restartLevel();
                    closeAll();
                    break;
                case(_nextLevelButton):
                    game.startLevel(nextLevel.level);
                    closeAll();
                    break;
                case(_exitButton):
                    var group:LevelGroupMetadata = LevelGroupsRepository.getGroupByLevel(_extLevel);
                    game.startLevel(LevelRepository.getLevelById(group.hubLevelId));
                    closeAll();
                    break;
            }
        }

        private function setPlayerTimeText():void {
            var delta:int = _extScore.currentTime - _extLevel.parTime;
            var playerTimeColor:uint = (_extScore.currentTime <= _extLevel.parTime ? 0x00FF00 : 0xFFFF00);
            var deltaColor:uint = (_extScore.currentTime <= _extLevel.parTime ? 0x00FF00 : 0xFF8888);

            _timeLabel.resetColoredText();
            _timeLabel.appendColoredText(_("window.level_completed.time") + "\n", 0xFFFFFF);
            _timeLabel.appendColoredText(Utils.timeAsString(_extScore.currentTime, save.displayTimeAsFrames), playerTimeColor);
            _timeLabel.appendColoredText(" / ", 0xFFFFFF);
            _timeLabel.appendColoredText(Utils.timeAsString(_extLevel.parTime, save.displayTimeAsFrames) + "\n", 0xFFFFFF);
            _timeLabel.appendColoredText((delta <= 0 ? "+" : "-") + Utils.timeAsString(Math.abs(delta), save.displayTimeAsFrames), deltaColor);
        }

        private function framesToTime(frames:int):String {
            var minutes:int = frames / 60 / 60 | 0;
            var seconds:int = (frames / 60) % 60 | 0;
            var millisecs:int = Math.round((frames % 60) * 1000 / 60);

            return printf(
                    "%%:%%.%%",
                    UtilsString.padLeft(minutes.toString(), 2, "0"),
                    UtilsString.padLeft(seconds.toString(), 2, "0"),
                    UtilsString.padLeft(millisecs.toString(), 3, "0")
            );
        }

        private function get nextLevel():LevelGroupEntryMetadata {
            var group:LevelGroupMetadata = LevelGroupsRepository.getGroupByLevel(_extLevel);
            var levelIndex:int = group.getLevelIndex(_extLevel);
            levelIndex++;

            if (levelIndex >= group.totalLevels) {
                levelIndex = 0;
            }

            return group.getLevelByIndex(levelIndex);
        }
    }
}
