package submuncher.ingame.windows.levels {
    import net.retrocade.constants.KeyConst;
    import net.retrocade.retrocamel.core.RetrocamelInputManager;
    import net.retrocade.retrocamel.effects.RetrocamelEffectFadeStarling;
    import net.retrocade.retrocamel.locale._;

    import starling.display.BlendMode;

    import starling.display.DisplayObjectContainer;
    import starling.display.MovieClip;
    import starling.display.Sprite;
    import starling.textures.Texture;
    import starling.utils.HAlign;
    import starling.utils.VAlign;

    import submuncher.core.constants.Gfx;
    import submuncher.core.constants.GuiNames;
    import submuncher.core.constants.GuiTextureCollections;
    import submuncher.core.display.SubmuncherTextField;
    import submuncher.core.repositories.LevelGroupEntryMetadata;
    import submuncher.core.repositories.LevelGroupMetadata;
    import submuncher.core.repositories.LevelGroupsRepository;
    import submuncher.core.save.Save;
    import submuncher.core.save.SaveLevelProgress;
    import submuncher.ingame.core.Game;

    public class LevelSelectionWindow extends ScreenWindowBase {
        public static function showWindow(game:Game, group:LevelGroupMetadata, save:Save):LevelSelectionWindow {
            var window:LevelSelectionWindow = new LevelSelectionWindow(game, group, save);
            window.show();

            return window;
        }

        private var _extGroup:LevelGroupMetadata;
        private var _extSave:Save;

        private var _nextGroupButton:PanelWindowButton;
        private var _prevGroupButton:PanelWindowButton;
        private var _exitButton:PanelWindowButton;

        private var _levelTitle:SubmuncherTextField;
        private var _nextGroupLabel:SubmuncherTextField;
        private var _prevGroupLabel:SubmuncherTextField;
        private var _exitLabel:SubmuncherTextField;

        private var _levelButtons:Vector.<PanelWindowButton>;
        private var _levelIcons:Vector.<MovieClip>;

        private var _extSelectedButton:PanelWindowButton;

        public var closeAllOnClose:Boolean = false;

        public function LevelSelectionWindow(game:Game, group:LevelGroupMetadata, save:Save) {
            super(_("window.level_selection.header"), game);

            _extGroup = group;
            _extSave = save;
            _blockUnder = false;

            initCreateObjects();
            initSetProperties();
            initSetPositions();
            initAddChildren();

            refreshGroup();
            selectDefaultButton();
        }

        override public function dispose():void {
            for each (var clip:MovieClip in _levelIcons) {
                clip.dispose();
            }
            for each (var button:PanelWindowButton in _levelButtons) {
                button.dispose();
            }

            _nextGroupButton.dispose();
            _prevGroupButton.dispose();
            _exitButton.dispose();
            _levelTitle.dispose();
            _nextGroupLabel.dispose();
            _prevGroupLabel.dispose();
            _exitLabel.dispose();

            _nextGroupButton = null;
            _prevGroupButton = null;
            _exitButton = null;
            _levelTitle = null;
            _nextGroupLabel = null;
            _prevGroupLabel = null;
            _exitLabel = null;
            _levelIcons = null;
            _levelButtons = null;
            _extSelectedButton = null;

            super.dispose();
        }

        private function initCreateObjects():void {
            _levelButtons = new Vector.<PanelWindowButton>();
            _levelIcons = new Vector.<MovieClip>();

            _prevGroupButton = new PanelWindowButton(Gfx.guiAtlas.getTexture(GuiNames.MONITOR_PREV), Gfx.guiAtlas.getTexture(GuiNames.MONITOR_PREV_SELECTED));
            _nextGroupButton = new PanelWindowButton(Gfx.guiAtlas.getTexture(GuiNames.MONITOR_NEXT), Gfx.guiAtlas.getTexture(GuiNames.MONITOR_NEXT_SELECTED));
            _exitButton = new PanelWindowButton(Gfx.guiAtlas.getTexture(GuiNames.MONITOR_EXIT), Gfx.guiAtlas.getTexture(GuiNames.MONITOR_EXIT_SELECTED));

            _levelTitle = new SubmuncherTextField("", 1, 0xFFFFFF, 192, 22);
            _prevGroupLabel = new SubmuncherTextField("", 1, 0xFFFFFF, 168, 16);
            _nextGroupLabel = new SubmuncherTextField("", 1, 0xFFFFFF, 168, 16);
            _exitLabel = new SubmuncherTextField(_("window.level_selection.exit"), 1, 0xFFFFFF, 168, 16);
        }

        private function initSetProperties():void {
            _levelTitle.hAlign = HAlign.CENTER;
            _levelTitle.vAlign = VAlign.CENTER;

            _prevGroupLabel.vAlign = VAlign.CENTER;
            _nextGroupLabel.vAlign = VAlign.CENTER;
            _exitLabel.vAlign = VAlign.CENTER;
        }

        private function initSetPositions():void {
            _prevGroupButton.x = 16;
            _prevGroupButton.y = 144;
            _nextGroupButton.x = 16;
            _nextGroupButton.y = 168;
            _exitButton.x = 16;
            _exitButton.y = 192;

            _levelTitle.x = 16;
            _levelTitle.y = 8;
            _prevGroupLabel.x = 48;
            _prevGroupLabel.y = 146;
            _nextGroupLabel.x = 48;
            _nextGroupLabel.y = 170;
            _exitLabel.x = 48;
            _exitLabel.y = 194;
        }

        private function initAddChildren():void {
            addToBigWindow(
                    _levelTitle,
                    _prevGroupButton,
                    _nextGroupButton,
                    _exitButton,
                    _prevGroupLabel,
                    _nextGroupLabel,
                    _exitLabel
            );
        }

        private function refreshGroup():void {
            for each (var clip:MovieClip in _levelIcons) {
                clip.dispose();
            }
            for each (var button:PanelWindowButton in _levelButtons) {
                button.dispose();
            }

            _levelIcons.length = 0;
            _levelButtons.length = 0;

            _levelTitle.text = group.levels[0].name + "\n" + "Par time: " + group.levels[0].level.parTime;
            _prevGroupLabel.text = "<< " + prevGroup.name;
            _nextGroupLabel.text = nextGroup.name + " >>";

            _prevGroupButton.data = prevGroup;
            _nextGroupButton.data = nextGroup;

            createButtons();
            linkButtons();
        }

        private function selectDefaultButton():void {
            for each (var button:PanelWindowButton in _levelButtons) {
                if (LevelGroupEntryMetadata(button.data).level === levelMetadata) {
                    _extSelectedButton = button;
                    _extSelectedButton.isSelected = true;
                    _extSelectedButton.forceRedraw();
                    break;
                }
            }
            if (!_extSelectedButton) {
                _extSelectedButton = _levelButtons[0];
                _extSelectedButton.isSelected = true;
                _extSelectedButton.forceRedraw();
            }
        }

        private function createButtons():void {
            var i:int = 0;
            for each (var metadata:LevelGroupEntryMetadata in group.levels) {
                var state:SaveLevelProgress = _extSave.progress.getLevelProgressByLevelId(metadata.level.id);
                var button:PanelWindowButton = new PanelWindowButton(
                        getIdleIcon(metadata, state),
                        getSelectedIcon(metadata, state)
                );

                button.x = 24 + i * 32;
                button.y = 32;
                button.data = metadata;

                _levelButtons.push(button);
                addToBigWindow(button);

                addIcons(button.x, metadata, state);

                i++;
            }
        }

        private function getIdleIcon(metadata:LevelGroupEntryMetadata, state:SaveLevelProgress):Texture {
            if (state.isFullyCompleted) {
                if (metadata.required) {
                    return Gfx.guiAtlas.getTexture(GuiNames.MONITOR_LEVEL_COMPLETED)
                } else {
                    return Gfx.guiAtlas.getTexture(GuiNames.MONITOR_OPTIONAL_COMPLETED)
                }
            } else {
                if (metadata.required) {
                    return Gfx.guiAtlas.getTexture(GuiNames.MONITOR_LEVEL)
                } else {
                    return Gfx.guiAtlas.getTexture(GuiNames.MONITOR_OPTIONAL)
                }
            }
        }

        private function getSelectedIcon(metadata:LevelGroupEntryMetadata, state:SaveLevelProgress):Texture {
            if (state.isFullyCompleted) {
                if (metadata.required) {
                    return Gfx.guiAtlas.getTexture(GuiNames.MONITOR_LEVEL_COMPLETED_SELECTED)
                } else {
                    return Gfx.guiAtlas.getTexture(GuiNames.MONITOR_OPTIONAL_COMPLETED_SELECTED)
                }
            } else {
                if (metadata.required) {
                    return Gfx.guiAtlas.getTexture(GuiNames.MONITOR_LEVEL_SELECTED)
                } else {
                    return Gfx.guiAtlas.getTexture(GuiNames.MONITOR_OPTIONAL_SELECTED)
                }
            }
        }

        private function addIcons(x:int, metadata:LevelGroupEntryMetadata, state:SaveLevelProgress):void {
            var isRequired:Boolean = metadata.required;

            var completedIcon:MovieClip = new MovieClip(!state.isCompleted ? GuiTextureCollections.monitorCompletion : GuiTextureCollections.monitorCompletionDone);
            var parTimeIcon:MovieClip = new MovieClip(!state.isParTime ? GuiTextureCollections.monitorPar : GuiTextureCollections.monitorParDone);

            if (isRequired) {
                var secretIcon:MovieClip = new MovieClip(!state.areSecretsCollected ? GuiTextureCollections.monitorSecret : GuiTextureCollections.monitorSecretDone);
                var documentIcon:MovieClip = new MovieClip(!state.isDocumentCollected ? GuiTextureCollections.monitorDocument : GuiTextureCollections.monitorDocumentDone);
            }


            completedIcon.x = x;
            parTimeIcon.x = x;

            if (isRequired) {
                secretIcon.x = x;
                documentIcon.x = x;
            }

            completedIcon.y = 56;
            parTimeIcon.y = 72 + 2;

            if (isRequired) {
                secretIcon.y = 88 + 4;
                documentIcon.y = 104 + 6;
            }

            addToBigWindow(completedIcon);
            addToBigWindow(parTimeIcon);
            if (isRequired) {
                addToBigWindow(secretIcon);
                addToBigWindow(documentIcon);
                _levelIcons.push(secretIcon, documentIcon);
            }

            _levelIcons.push(completedIcon, parTimeIcon);
        }

        private function linkButtons():void {
            for (var i:int = 0; i < _levelButtons.length; i++) {
                var button:PanelWindowButton = _levelButtons[i];
                button.buttonLeft = i === 0 ? _levelButtons[_levelButtons.length - 1] : _levelButtons[i - 1];
                button.buttonRight = i === _levelButtons.length - 1 ? _levelButtons[0] : _levelButtons[i + 1];
                button.buttonDown = _prevGroupButton;
                button.buttonUp = _exitButton;
            }

            _exitButton.buttonUp = _nextGroupButton;
            _exitButton.buttonDown = _levelButtons[0];

            _nextGroupButton.buttonUp = _prevGroupButton;
            _nextGroupButton.buttonDown = _exitButton;

            _prevGroupButton.buttonUp = _levelButtons[0];
            _prevGroupButton.buttonDown = _nextGroupButton;
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
            for each (var button:PanelWindowButton in _levelButtons) {
                button.update();
            }

            _nextGroupButton.update();
            _prevGroupButton.update();
            _exitButton.update();

            if (RetrocamelInputManager.isKeyHit(KeyConst.W) || RetrocamelInputManager.isKeyHit(KeyConst.UP)) {
                switchButton(_extSelectedButton.buttonUp);
            } else if (RetrocamelInputManager.isKeyHit(KeyConst.S) || RetrocamelInputManager.isKeyHit(KeyConst.DOWN)) {
                switchButton(_extSelectedButton.buttonDown);
            } else if (RetrocamelInputManager.isKeyHit(KeyConst.A) || RetrocamelInputManager.isKeyHit(KeyConst.LEFT)) {
                switchButton(_extSelectedButton.buttonLeft);
            } else if (RetrocamelInputManager.isKeyHit(KeyConst.D) || RetrocamelInputManager.isKeyHit(KeyConst.RIGHT)) {
                switchButton(_extSelectedButton.buttonRight);
            } else if (RetrocamelInputManager.isKeyHit(KeyConst.SPACE)) {
                selectedButton(_extSelectedButton);
            } else if (RetrocamelInputManager.isKeyHit(KeyConst.TAB)) {
                RetrocamelInputManager.flushKeys();
                startHiding(true);
            }
        }

        private function switchButton(button:PanelWindowButton):void {
            if (!button) {
                return;
            }

            if (_extSelectedButton.data is LevelGroupEntryMetadata) {
                if (!(button.data is LevelGroupEntryMetadata)) {
                    _prevGroupButton.buttonUp = _extSelectedButton;
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
            if (button.data === null) {
                if (closeAllOnClose) {
                    closeAll();
                } else {
                    startHiding(true);
                }
            } else if (button.data is LevelGroupMetadata) {
                group = button.data as LevelGroupMetadata;
            } else if (button.data is LevelGroupEntryMetadata) {
                game.startLevel(LevelGroupEntryMetadata(button.data).level);
                closeAll();
            }
        }

        private function get prevGroup():LevelGroupMetadata {
            var index:int = LevelGroupsRepository.getGroupIndex(_extGroup);

            index--;

            return LevelGroupsRepository.getGroupByIndex(index < 0 ? LevelGroupsRepository.totalGroups() - 1 : index);
        }

        private function get nextGroup():LevelGroupMetadata {
            var index:int = LevelGroupsRepository.getGroupIndex(_extGroup);

            index++;

            return LevelGroupsRepository.getGroupByIndex(index === LevelGroupsRepository.totalGroups() ? 0 : index);
        }


        public function get group():LevelGroupMetadata {
            return _extGroup;
        }

        public function set group(value:LevelGroupMetadata):void {
            _extGroup = value;

            var clone:Sprite = _bigWindowContainer.clone();
            clone.blendMode = BlendMode.ADD;
            refreshGroup();
            addChildAt(clone, 0);

            RetrocamelEffectFadeStarling.make(clone).alpha(1, 0).duration(100).callback(function():void{removeChild(clone)}).run();
            RetrocamelEffectFadeStarling.make(_bigWindowContainer).alpha(0, 1).duration(100).run();
        }
    }
}
