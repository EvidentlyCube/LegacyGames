package submuncher.ingame.windows.levels {
    import net.retrocade.constants.KeyConst;
    import net.retrocade.enums.Direction4;
    import net.retrocade.retrocamel.core.RetrocamelInputManager;
    import net.retrocade.retrocamel.locale._;

    import starling.utils.VAlign;

    import submuncher.core.constants.Gfx;
    import submuncher.core.constants.GuiNames;
    import submuncher.core.display.SubmuncherTextField;
    import submuncher.ingame.core.Game;

    public class OptionsWindow extends ScreenWindowBase {
        public static function showWindow(game:Game):OptionsWindow {
            var window:OptionsWindow = new OptionsWindow(game);
            window.show();

            return window;
        }


        private var _buttonTimeDisplay:PanelWindowButton;
        private var _buttonMusicVolume:PanelWindowButton;
        private var _buttonSoundVolume:PanelWindowButton;
        private var _buttonExit:PanelWindowButton;

        private var _labelTimeDisplay:SubmuncherTextField;
        private var _labelMusicVolume:SubmuncherTextField;
        private var _labelSoundVolume:SubmuncherTextField;
        private var _labelExit:SubmuncherTextField;

        private var _extSelectedButton:PanelWindowButton;

        public function OptionsWindow(game:Game) {
            super(_("window.options.header"), game);

            initCreateObjects();
            initSetProperties();
            initSetPositions();
            initAddChildren();

            linkButtons();

            _extSelectedButton = _buttonTimeDisplay;
            _extSelectedButton.isSelected = true;
        }

        override public function dispose():void {
            _extSelectedButton = null;

            super.dispose();
        }

        private function initCreateObjects():void {
            _buttonTimeDisplay = new PanelWindowButton(Gfx.guiAtlas.getTexture(GuiNames.MONITOR_LEVEL), Gfx.guiAtlas.getTexture(GuiNames.MONITOR_NEXT_LEVEL_SELECTED), true);
            _buttonMusicVolume = new PanelWindowButton(Gfx.guiAtlas.getTexture(GuiNames.MONITOR_LEVEL), Gfx.guiAtlas.getTexture(GuiNames.MONITOR_NEXT_LEVEL_SELECTED));
            _buttonSoundVolume = new PanelWindowButton(Gfx.guiAtlas.getTexture(GuiNames.MONITOR_LEVEL), Gfx.guiAtlas.getTexture(GuiNames.MONITOR_NEXT_LEVEL_SELECTED));
            _buttonExit = new PanelWindowButton(Gfx.guiAtlas.getTexture(GuiNames.MONITOR_LEVEL), Gfx.guiAtlas.getTexture(GuiNames.MONITOR_NEXT_LEVEL_SELECTED));

            _labelTimeDisplay = new SubmuncherTextField(displayTimeText, 1, 0xFFFFFF, 178, 16);
            _labelMusicVolume = new SubmuncherTextField(musicVolumeText, 1, 0xFFFFFF, 178, 16);
            _labelSoundVolume = new SubmuncherTextField(soundVolumeText, 1, 0xFFFFFF, 178, 16);
            _labelExit = new SubmuncherTextField(_("window.options.close"), 1, 0xFFFFFF, 178, 16);
        }

        private function initSetProperties():void {
            _labelTimeDisplay.vAlign = VAlign.CENTER;
            _labelMusicVolume.vAlign = VAlign.CENTER;
            _labelSoundVolume.vAlign = VAlign.CENTER;
            _labelExit.vAlign = VAlign.CENTER;
        }

        private function initSetPositions():void {
            _buttonTimeDisplay.x = 16;
            _buttonTimeDisplay.y = 24;
            _buttonMusicVolume.x = 16;
            _buttonMusicVolume.y = 56;
            _buttonSoundVolume.x = 16;
            _buttonSoundVolume.y = 88;
            _buttonExit.x = 16;
            _buttonExit.y = 184;

            _labelTimeDisplay.x = 48;
            _labelTimeDisplay.y = 26;
            _labelMusicVolume.x = 48;
            _labelMusicVolume.y = 58;
            _labelSoundVolume.x = 48;
            _labelSoundVolume.y = 90;
            _labelExit.x = 48;
            _labelExit.y = 186;
        }

        private function initAddChildren():void {
            addToBigWindow(
                    _buttonTimeDisplay,
                    _buttonMusicVolume,
                    _buttonSoundVolume,
                    _buttonExit,
                    _labelTimeDisplay,
                    _labelMusicVolume,
                    _labelSoundVolume,
                    _labelExit
            );
        }

        private function linkButtons():void {
            _buttonTimeDisplay.buttonUp = _buttonExit;
            _buttonTimeDisplay.buttonDown = _buttonMusicVolume;
            _buttonMusicVolume.buttonUp = _buttonTimeDisplay;
            _buttonMusicVolume.buttonDown = _buttonSoundVolume;
            _buttonSoundVolume.buttonUp = _buttonMusicVolume;
            _buttonSoundVolume.buttonDown = _buttonExit;
            _buttonExit.buttonUp = _buttonSoundVolume;
            _buttonExit.buttonDown = _buttonTimeDisplay;
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
            _buttonTimeDisplay.update();
            _buttonMusicVolume.update();
            _buttonSoundVolume.update();
            _buttonExit.update();

            if (RetrocamelInputManager.isKeyHit(KeyConst.W) || RetrocamelInputManager.isKeyHit(KeyConst.UP)) {
                switchButton(_extSelectedButton.buttonUp, _extSelectedButton, Direction4.UP);
            } else if (RetrocamelInputManager.isKeyHit(KeyConst.S) || RetrocamelInputManager.isKeyHit(KeyConst.DOWN)) {
                switchButton(_extSelectedButton.buttonDown, _extSelectedButton, Direction4.UP);
            } else if (RetrocamelInputManager.isKeyHit(KeyConst.A) || RetrocamelInputManager.isKeyHit(KeyConst.LEFT)) {
                switchButton(_extSelectedButton.buttonLeft, _extSelectedButton, Direction4.LEFT);
            } else if (RetrocamelInputManager.isKeyHit(KeyConst.D) || RetrocamelInputManager.isKeyHit(KeyConst.RIGHT)) {
                switchButton(_extSelectedButton.buttonRight, _extSelectedButton, Direction4.RIGHT);
            } else if (RetrocamelInputManager.isKeyHit(KeyConst.SPACE)) {
                selectedButton(_extSelectedButton);
            } else if (RetrocamelInputManager.isKeyHit(KeyConst.TAB)) {
                closeAll();
                RetrocamelInputManager.flushKeys();
                BackgroundWindow.instance.hide();
            }
        }

        private function switchButton(button:PanelWindowButton, from:PanelWindowButton, direction:Direction4):void {
            if (button) {
                _extSelectedButton.isSelected = false;
                _extSelectedButton = button;
                _extSelectedButton.isSelected = true;
            } else if (from === _buttonMusicVolume){
                if (direction === Direction4.RIGHT){
                    save.musicVolume += 0.1;
                    if (save.musicVolume > 1){
                        save.musicVolume = 0;
                    }
                    _labelMusicVolume.text = musicVolumeText;
                } else if (direction === Direction4.LEFT){
                    save.musicVolume -= 0.1;
                    if (save.musicVolume < 0){
                        save.musicVolume = 1;
                    }
                    _labelMusicVolume.text = musicVolumeText;
                }
            } else if (from === _buttonSoundVolume){
                if (direction === Direction4.RIGHT){
                    save.soundVolume += 0.1;
                    if (save.soundVolume > 1){
                        save.soundVolume = 0;
                    }
                    _labelSoundVolume.text = soundVolumeText;
                } else if (direction === Direction4.LEFT){
                    save.soundVolume -= 0.1;
                    if (save.soundVolume < 0){
                        save.soundVolume = 1;
                    }
                    _labelSoundVolume.text = soundVolumeText;
                }
            }
        }

        private function selectedButton(button:PanelWindowButton):void {
            switch (button) {
                case(_buttonTimeDisplay):
                    save.displayTimeAsFrames = !save.displayTimeAsFrames;
                    _labelTimeDisplay.text = displayTimeText;
                    break;
                case(_buttonMusicVolume):
                    save.musicVolume += 0.1;
                    if (save.musicVolume > 1){
                        save.musicVolume = 0;
                    }
                    _labelMusicVolume.text = musicVolumeText;
                    break;
                case(_buttonSoundVolume):
                    save.soundVolume += 0.1;
                    if (save.soundVolume > 1){
                        save.soundVolume = 0;
                    }
                    _labelSoundVolume.text = soundVolumeText;
                    break;
                case(_buttonExit):
                    startHiding(true);
                    break;
            }
        }

        private function get displayTimeText():String {
            return _(
                    "window.options.par_time_display",
                    save.displayTimeAsFrames
                            ? _("window.options.par_time_display.frames")
                            : _("window.options.par_time_display.seconds")
            );
        }
        private function get musicVolumeText():String {
            return _(
                    "window.options.volume_music",
                    (save.musicVolume * 100).toFixed(0)
            );
        }
        private function get soundVolumeText():String {
            return _(
                    "window.options.sound_music",
                    (save.soundVolume * 100).toFixed(0)
            );
        }
    }
}
