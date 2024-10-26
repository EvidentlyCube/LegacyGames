/**
 * Created with IntelliJ IDEA.
 * User: Ryc
 * Date: 03.03.13
 * Time: 12:41
 * To change this template use File | Settings | File Templates.
 */
package net.retrocade.tacticengine.monstro.windows {
    import net.retrocade.camel.global.rSfx;
    import net.retrocade.camel.objects.rSound;
    import net.retrocade.camel.objects.rWindowStarling;
    import net.retrocade.tacticengine.monstro.core.Monstro;
    import net.retrocade.tacticengine.monstro.core.MonstroData;
    import net.retrocade.tacticengine.monstro.core.MonstroGfx;
    import net.retrocade.tacticengine.monstro.render.MonstroCheckbox;
    import net.retrocade.tacticengine.monstro.render.MonstroDragButton;
    import net.retrocade.tacticengine.monstro.render.MonstroGrid9;
    import net.retrocade.tacticengine.monstro.render.MonstroTextButton;

    import starling.events.Event;

    import starling.text.TextField;

    public class MonstroWindowOptions extends rWindowStarling{
        private static var _instance:MonstroWindowOptions;

        public static function show():void{
            if (!_instance){
                _instance = new MonstroWindowOptions();
            }

            _instance.show();
        }

        private var _background:MonstroGrid9;
        private var _header:TextField;
        private var _soundVolumeText:TextField;
        private var _musicVolumeText:TextField;
        private var _gameSpeedText  :TextField;
        private var _soundVolumeSlider:MonstroDragButton;
        private var _musicVolumeSlider:MonstroDragButton;
        private var _gameSpeedSlider  :MonstroDragButton;
        private var _waitForTapCheckbox  :MonstroCheckbox;
        private var _close:MonstroTextButton;

        public function MonstroWindowOptions() {
            _background = MonstroGfx.getGrid9WindowHeader();
            _header = new TextField(273, 32, "Options", Monstro.FONT_MEDIUM, -1, 0xFFFFFF);
            _soundVolumeText = new TextField(273, 30, "Sound volume:", Monstro.FONT_MEDIUM, 20, 0xFFFFFF);
            _musicVolumeText = new TextField(273, 30, "Music volume:", Monstro.FONT_MEDIUM, 20, 0xFFFFFF);
            _gameSpeedText = new TextField(273, 30, "Game speed:", Monstro.FONT_MEDIUM, 20, 0xFFFFFF);

            _soundVolumeSlider = new MonstroDragButton();
            _musicVolumeSlider = new MonstroDragButton();
            _gameSpeedSlider = new MonstroDragButton();
            _waitForTapCheckbox = new MonstroCheckbox("Wait for click on enemy attack", MonstroData.getWaitForConfirmation(), onWaitForTapChanged);
            _close = new MonstroTextButton("Close", onClose);

            _soundVolumeSlider.addEventListener(Event.CHANGE, onSliderChange);
            _musicVolumeSlider.addEventListener(Event.CHANGE, onSliderChange);
            _gameSpeedSlider  .addEventListener(Event.CHANGE, onSliderChange);

            _gameSpeedSlider.values = new <Number>[0.091, 0.12, 0.16, 0.20, 0.25, 0.30, 0.50, 1];

            addChild(_background);
            addChild(_header);
            addChild(_soundVolumeText);
            addChild(_musicVolumeText);
            addChild(_gameSpeedText);
            addChild(_soundVolumeSlider);
            addChild(_musicVolumeSlider);
            addChild(_gameSpeedSlider);
            addChild(_waitForTapCheckbox);
            addChild(_close);

            _soundVolumeText.y = _header.bottom + Monstro.hudSpacer * 2;
            _soundVolumeSlider.y = _soundVolumeText.bottom + Monstro.hudSpacer;
            _musicVolumeText.y = _soundVolumeSlider.bottom + Monstro.hudSpacer * 2;
            _musicVolumeSlider.y = _musicVolumeText.bottom + Monstro.hudSpacer;
            _gameSpeedText.y = _musicVolumeSlider.bottom + Monstro.hudSpacer * 2;
            _gameSpeedSlider.y = _gameSpeedText.bottom + Monstro.hudSpacer;
            _waitForTapCheckbox.y = _gameSpeedSlider.bottom + Monstro.hudSpacer * 2;

            _close.y = _waitForTapCheckbox.bottom + Monstro.hudSpacer * 2;

            _background.width = width + Monstro.hudSpacer * 4;
            _background.height = height + Monstro.hudSpacer * 2;

            _header.alignCenterParent();
            _soundVolumeText.alignCenterParent();
            _soundVolumeSlider.alignCenterParent();
            _musicVolumeText.alignCenterParent();
            _musicVolumeSlider.alignCenterParent();
            _gameSpeedText.alignCenterParent();
            _gameSpeedSlider.alignCenterParent();
            _waitForTapCheckbox.alignCenterParent();
            _close.alignCenterParent();

            alignCenter();
            alignMiddle();

            _musicVolumeSlider.value = MonstroData.getMusicVolume();
            _soundVolumeSlider.value = MonstroData.getSfxVolume();
            _gameSpeedSlider.value = MonstroData.getGameSpeed();
        }

        private function onSliderChange(e:Event):void{
            switch(e.target){
                case(_musicVolumeSlider):
                    rSfx.musicVolume = _musicVolumeSlider.value;
                    MonstroData.setMusicVolume(_musicVolumeSlider.value);
                    break;
                case(_soundVolumeSlider):
                    rSfx.soundVolume = _soundVolumeSlider.value;
                    MonstroData.setSfxVolume(_soundVolumeSlider.value);
                    break;
                case(_gameSpeedSlider):
                    MonstroData.gameSpeed = _gameSpeedSlider.value;
                    MonstroData.setGameSpeed(_gameSpeedSlider.value);
                    break;
            }
        }

        private function onWaitForTapChanged():void{
            MonstroData.setWaitForConfirmation(_waitForTapCheckbox.isChecked);
        }


        private function onClose():void{
            MonstroData.commitData();
            hide();
        }
    }
}
