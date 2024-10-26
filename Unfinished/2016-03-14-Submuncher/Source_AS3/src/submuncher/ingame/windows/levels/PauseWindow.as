package submuncher.ingame.windows.levels {
    // import flash.desktop.NativeApplication;
    import flash.geom.Rectangle;

    import net.retrocade.constants.KeyConst;
    import net.retrocade.retrocamel.core.RetrocamelInputManager;
    import net.retrocade.retrocamel.locale._;

    import starling.display.BlendMode;
    import starling.utils.VAlign;

    import submuncher.core.constants.Gfx;
    import submuncher.core.constants.GuiNames;
    import submuncher.core.display.SubmuncherTextField;
    import submuncher.core.repositories.LevelGroupMetadata;
    import submuncher.core.repositories.LevelGroupsRepository;
    import submuncher.core.repositories.LevelRepository;
    import submuncher.ingame.core.Game;

    public class PauseWindow extends ScreenWindowBase {


        public static function showWindow(game:Game):void {
            var window:PauseWindow = new PauseWindow(game);
            window.show();
        }


        private var _buttonResume:PanelWindowButton;
        private var _buttonChangeLocation:PanelWindowButton;
        private var _buttonReturnToHub:PanelWindowButton;
        private var _buttonKnowledgebase:PanelWindowButton;
        private var _buttonOptions:PanelWindowButton;
        private var _buttonQuit:PanelWindowButton;

        private var _labelResume:SubmuncherTextField;
        private var _labelChangeLocation:SubmuncherTextField;
        private var _labelReturnToHub:SubmuncherTextField;
        private var _labelKnowledgebase:SubmuncherTextField;
        private var _labelOptions:SubmuncherTextField;
        private var _labelQuit:SubmuncherTextField;

        private var _extSelectedButton:PanelWindowButton;

        public function PauseWindow(game:Game) {
            super(_("window.pause.header"), game);

            initCreateObjects();
            initSetProperties();
            initSetPositions();
            initAddChildren();

            linkButtons();

            _extSelectedButton = _buttonResume;
            _extSelectedButton.isSelected = true;
        }

        override public function dispose():void {
            _extSelectedButton = null;

            super.dispose();
        }

        private function initCreateObjects():void {
            _buttonResume = new PanelWindowButton(Gfx.guiAtlas.getTexture(GuiNames.MONITOR_LEVEL), Gfx.guiAtlas.getTexture(GuiNames.MONITOR_NEXT_LEVEL_SELECTED), true);
            _buttonChangeLocation = new PanelWindowButton(Gfx.guiAtlas.getTexture(GuiNames.MONITOR_LEVEL), Gfx.guiAtlas.getTexture(GuiNames.MONITOR_NEXT_LEVEL_SELECTED));
            _buttonReturnToHub = new PanelWindowButton(Gfx.guiAtlas.getTexture(GuiNames.MONITOR_LEVEL), Gfx.guiAtlas.getTexture(GuiNames.MONITOR_NEXT_LEVEL_SELECTED));
            _buttonKnowledgebase = new PanelWindowButton(Gfx.guiAtlas.getTexture(GuiNames.MONITOR_LEVEL), Gfx.guiAtlas.getTexture(GuiNames.MONITOR_NEXT_LEVEL_SELECTED));
            _buttonOptions = new PanelWindowButton(Gfx.guiAtlas.getTexture(GuiNames.MONITOR_LEVEL), Gfx.guiAtlas.getTexture(GuiNames.MONITOR_NEXT_LEVEL_SELECTED));
            _buttonQuit = new PanelWindowButton(Gfx.guiAtlas.getTexture(GuiNames.MONITOR_LEVEL), Gfx.guiAtlas.getTexture(GuiNames.MONITOR_NEXT_LEVEL_SELECTED));

            _labelResume = new SubmuncherTextField(_("window.pause.resume"), 1, 0xFFFFFF, 178, 16);
            _labelChangeLocation = new SubmuncherTextField(_("window.pause.levelSelect"), 1, 0xFFFFFF, 178, 16);
            _labelReturnToHub = new SubmuncherTextField(_("window.pause.returnToHub"), 1, 0xFFFFFF, 178, 16);
            _labelKnowledgebase = new SubmuncherTextField(_("window.pause.knowledgebase"), 1, 0xFFFFFF, 178, 16);
            _labelOptions = new SubmuncherTextField(_("window.pause.options"), 1, 0xFFFFFF, 178, 16);
            _labelQuit = new SubmuncherTextField(_("window.pause.quit"), 1, 0xFFFFFF, 178, 16);
        }

        private function initSetProperties():void {
            _labelResume.vAlign = VAlign.CENTER;
            _labelChangeLocation.vAlign = VAlign.CENTER;
            _labelReturnToHub.vAlign = VAlign.CENTER;
            _labelKnowledgebase.vAlign = VAlign.CENTER;
            _labelOptions.vAlign = VAlign.CENTER;
            _labelQuit.vAlign = VAlign.CENTER;
        }

        private function initSetPositions():void {
            _buttonResume.x = 16;
            _buttonResume.y = 24;
            _buttonChangeLocation.x = 16;
            _buttonChangeLocation.y = 56;
            _buttonReturnToHub.x = 16;
            _buttonReturnToHub.y = 88;
            _buttonKnowledgebase.x = 16;
            _buttonKnowledgebase.y = 120;
            _buttonOptions.x = 16;
            _buttonOptions.y = 152;
            _buttonQuit.x = 16;
            _buttonQuit.y = 184;

            _labelResume.x = 48;
            _labelResume.y = 26;
            _labelChangeLocation.x = 48;
            _labelChangeLocation.y = 58;
            _labelReturnToHub.x = 48;
            _labelReturnToHub.y = 90;
            _labelKnowledgebase.x = 48;
            _labelKnowledgebase.y = 122;
            _labelOptions.x = 48;
            _labelOptions.y = 154;
            _labelQuit.x = 48;
            _labelQuit.y = 186;
        }

        private function initAddChildren():void {
            addToBigWindow(
                    _buttonResume,
                    _buttonChangeLocation,
                    _buttonReturnToHub,
                    _buttonKnowledgebase,
                    _buttonOptions,
                    _buttonQuit,
                    _labelResume,
                    _labelChangeLocation,
                    _labelReturnToHub,
                    _labelKnowledgebase,
                    _labelOptions,
                    _labelQuit
            );
        }

        private function linkButtons():void {
            _buttonResume.buttonUp = _buttonQuit;
            _buttonResume.buttonDown = _buttonChangeLocation;
            _buttonChangeLocation.buttonUp = _buttonResume;
            _buttonChangeLocation.buttonDown = _buttonReturnToHub;
            _buttonReturnToHub.buttonUp = _buttonChangeLocation;
            _buttonReturnToHub.buttonDown = _buttonKnowledgebase;
            _buttonKnowledgebase.buttonUp = _buttonReturnToHub;
            _buttonKnowledgebase.buttonDown = _buttonOptions;
            _buttonOptions.buttonUp = _buttonKnowledgebase;
            _buttonOptions.buttonDown = _buttonQuit;
            _buttonQuit.buttonUp = _buttonOptions;
            _buttonQuit.buttonDown = _buttonResume;
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
            _buttonResume.update();
            _buttonChangeLocation.update();
            _buttonReturnToHub.update();
            _buttonKnowledgebase.update();
            _buttonOptions.update();
            _buttonQuit.update();

            if (RetrocamelInputManager.isKeyHit(KeyConst.W) || RetrocamelInputManager.isKeyHit(KeyConst.UP)) {
                switchButton(_extSelectedButton.buttonUp);
            } else if (RetrocamelInputManager.isKeyHit(KeyConst.S) || RetrocamelInputManager.isKeyHit(KeyConst.DOWN)) {
                switchButton(_extSelectedButton.buttonDown);
            } else if (RetrocamelInputManager.isKeyHit(KeyConst.SPACE)) {
                selectedButton(_extSelectedButton);
            } else if (RetrocamelInputManager.isKeyHit(KeyConst.TAB)) {
                closeAll();
                RetrocamelInputManager.flushKeys();
                BackgroundWindow.instance.hide();
            }
        }

        private function switchButton(button:PanelWindowButton):void {
            if (!button) {
                return;
            }

            _extSelectedButton.isSelected = false;
            _extSelectedButton = button;
            _extSelectedButton.isSelected = true;
        }

        private function selectedButton(button:PanelWindowButton):void {
            switch (button) {
                case(_buttonResume):
                    closeAll();
                    break;
                case(_buttonChangeLocation):
                    if (LevelGroupsRepository.isLevelInGroup(game.currentLevelMetadata)) {
                        openWindowAbove(LevelSelectionWindow.showWindow(game, LevelGroupsRepository.getGroupByLevel(levelMetadata), save));
                    } else {
                        openWindowAbove(LevelSelectionWindow.showWindow(game, LevelGroupsRepository.getGroupByIndex(0), save));
                    }
                    startHiding(false);
                    break;
                case(_buttonReturnToHub):
                    if (LevelGroupsRepository.isLevelInGroup(levelMetadata)) {
                        var levelGroup:LevelGroupMetadata = LevelGroupsRepository.getGroupByLevel(levelMetadata);
                        game.startLevel(LevelRepository.getLevelById(levelGroup.hubLevelId));
                    }
                    closeAll();
                    break;
                case(_buttonOptions):
                    openWindowAbove(OptionsWindow.showWindow(game));
                    startHiding(false);
                    break;
                case(_buttonQuit):
                    // NativeApplication.nativeApplication.exit();
                    break;
            }
        }
    }
}
