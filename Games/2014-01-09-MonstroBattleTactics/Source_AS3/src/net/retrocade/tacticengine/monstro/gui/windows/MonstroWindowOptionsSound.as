
package net.retrocade.tacticengine.monstro.gui.windows {
	import net.retrocade.random.Random;
	import net.retrocade.retrocamel.core.RetrocamelSoundManager;
	import net.retrocade.retrocamel.display.starling.RetrocamelWindowStarling;
	import net.retrocade.retrocamel.locale._;
	import net.retrocade.retrocamel.sound.RetrocamelSound;
	import net.retrocade.signal.Signal;
	import net.retrocade.tacticengine.core.injector.injectCreate;
	import net.retrocade.tacticengine.monstro.global.core.MonstroConsts;
	import net.retrocade.tacticengine.monstro.global.core.MonstroData;
	import net.retrocade.tacticengine.monstro.global.core.MonstroEscapeBlocker;
	import net.retrocade.tacticengine.monstro.global.core.MonstroGameplayDefinition;
	import net.retrocade.tacticengine.monstro.global.core.MonstroGfx;
	import net.retrocade.tacticengine.monstro.global.core.MonstroSfx;
	import net.retrocade.tacticengine.monstro.global.core.VoicesSfx;
	import net.retrocade.tacticengine.monstro.global.enum.EnumUnitType;
	import net.retrocade.tacticengine.monstro.gui.helpers.WindowSliderCounter;
	import net.retrocade.tacticengine.monstro.gui.render.MonstroCheckbox;
	import net.retrocade.tacticengine.monstro.gui.render.MonstroDisplayGroup;
	import net.retrocade.tacticengine.monstro.gui.render.MonstroDragButton;
	import net.retrocade.tacticengine.monstro.gui.render.MonstroGrid9;
	import net.retrocade.tacticengine.monstro.gui.render.MonstroPrettyWindowGrid9;
	import net.retrocade.tacticengine.monstro.gui.render.MonstroTextButton;

	import starling.events.Event;
	import starling.text.TextField;

	public class MonstroWindowOptionsSound extends RetrocamelWindowStarling {

		public static function show(isVerticalHiding:Boolean):MonstroWindowOptionsSound {
			var instance:MonstroWindowOptionsSound = injectCreate(MonstroWindowOptionsSound);

			instance.isVerticalHiding = isVerticalHiding;
			instance.show();

			return instance;
		}

		[Inject]
		public var gameplayDefinition:MonstroGameplayDefinition;

		private var _background:MonstroPrettyWindowGrid9;
		private var _parchment:MonstroGrid9;
		private var _soundVolumeText:TextField;
		private var _musicVolumeText:TextField;
		private var _voicesVolumeText:TextField;
		private var _soundVolumeSlider:MonstroDragButton;
		private var _musicVolumeSlider:MonstroDragButton;
		private var _voicesVolumeSlider:MonstroDragButton;
		private var _soundEnabled:MonstroCheckbox;
		private var _musicEnabled:MonstroCheckbox;
		private var _voicesEnabled:MonstroCheckbox;
		private var _close:MonstroTextButton;

		private var _isHiding:Boolean;
		private var _sliderCounter:WindowSliderCounter;
		public var onClosing:Signal;
		public var isVerticalHiding:Boolean;

		private var _playTestSounds:Boolean = false;
		private var _playTestSoundWaiter:int = 0;

		public function init():void {
			CF::debug{
				ASSERT(gameplayDefinition);
			}
			initCreateObjects();
			initializeSettings();

			var optionsDisplayGroup:MonstroDisplayGroup = new MonstroDisplayGroup();
			optionsDisplayGroup.addElements(optionElements);
			optionsDisplayGroup.alignAllCenter();
			optionsDisplayGroup.verticalizePrecise(MonstroConsts.hudSpacer, 0, [_musicVolumeText]);

			var insidesDisplayGroup:MonstroDisplayGroup = new MonstroDisplayGroup();
			insidesDisplayGroup.addElement(_parchment);
			insidesDisplayGroup.addElements(optionElements);
			insidesDisplayGroup.addElement(_close);

			_parchment.wrapAround(optionsDisplayGroup);
			_close.forcedWidth = _parchment.innerWidth * 0.8;
			_close.alignCenterParent(0, _parchment.width);
			_close.y = _parchment.bottom;

			_background.wrapAround(insidesDisplayGroup);

			addChild(_background);
			addChild(_parchment);
			addChildren(optionElements);
			addChild(_close);
		}

		override public function hide():void {
			removeChildren();

			_background.dispose();
			_soundVolumeText.dispose();
			_musicVolumeText.dispose();
			_voicesVolumeText.dispose();
			_soundVolumeSlider.dispose();
			_musicVolumeSlider.dispose();
			_voicesVolumeSlider.dispose();
			_soundEnabled.dispose();
			_musicEnabled.dispose();
			_voicesEnabled.dispose();
			_close.dispose();
			_sliderCounter.dispose();
			onClosing.clear();

			_background = null;
			_soundVolumeText = null;
			_musicVolumeText = null;
			_voicesVolumeText = null;
			_soundVolumeSlider = null;
			_musicVolumeSlider = null;
			_voicesVolumeSlider = null;
			_soundEnabled = null;
			_musicEnabled = null;
			_voicesEnabled = null;
			_close = null;
			_sliderCounter = null;
			onClosing = null;

			super.hide();
		}

		private function initializeSettings():void {
			_soundVolumeSlider.addEventListener(Event.CHANGE, onSliderChange);
			_musicVolumeSlider.addEventListener(Event.CHANGE, onSliderChange);
			_voicesVolumeSlider.addEventListener(Event.CHANGE, onSliderChange);

			_musicVolumeSlider.value = MonstroData.getMusicVolume() * 2;
			_soundVolumeSlider.value = MonstroData.getSfxVolume();
			_voicesVolumeSlider.value = MonstroData.getVoicesVolume();

			_voicesVolumeSlider.dragEnded.add(dragEndedHandler);
			_soundVolumeSlider.dragEnded.add(dragEndedHandler);

			_background.header = _("options.header.sound");
			_isHiding = false;
			_pauseGame = false;
			_blockUnder = false;

			touchable = false;

			_sliderCounter.onStartHiding.add(makeUntouchable);
			_sliderCounter.onFinishedShowing.add(makeTouchable);

			_soundVolumeSlider.dragStarted.add(function():void{
				_playTestSounds = true;
				_playTestSoundWaiter = 0;
			});
			_soundVolumeSlider.dragEnded.add(function():void{
				_playTestSounds = false;
			});
		}

		private function initCreateObjects():void {
			_background = new MonstroPrettyWindowGrid9();
			_parchment = MonstroGfx.getGrid9Parchment();
			_soundVolumeText = new TextField(323, 50, _("options.sound"), MonstroConsts.FONT_EBORACUM_48, 32, 0x382010);
			_musicVolumeText = new TextField(323, 50, _("options.music"), MonstroConsts.FONT_EBORACUM_48, 32, 0x382010);
			_voicesVolumeText = new TextField(323, 50, _("options.voices"), MonstroConsts.FONT_EBORACUM_48, 32, 0x382010);
			_soundVolumeSlider = new MonstroDragButton();
			_musicVolumeSlider = new MonstroDragButton();
			_voicesVolumeSlider = new MonstroDragButton();
			_soundEnabled = new MonstroCheckbox(_("options.sound.enable"), MonstroData.getSoundEnabled(), checkboxClickedHandler);
			_musicEnabled = new MonstroCheckbox(_("options.music.enable"), MonstroData.getMusicEnabled(), checkboxClickedHandler);
			_voicesEnabled = new MonstroCheckbox(_("options.voices.enable"), MonstroData.getVoicesEnabled(), checkboxClickedHandler);

			_close = new MonstroTextButton(_("options.close"), onClose);
			_sliderCounter = new WindowSliderCounter(1.2);
			onClosing = new Signal();
		}

		override public function show():void {
			super.show();

			resize();
		}

		override public function update():void {
			if (MonstroEscapeBlocker.isEscapeDown) {
				MonstroEscapeBlocker.flush();
				startHiding();
			}

			if (_sliderCounter.update()) {
				refreshPosition();
			}

			if (_sliderCounter.isFullyHidden) {
				hide();
			}
		}

		private function onSliderChange(e:Event):void {
			switch (e.target) {
				case(_musicVolumeSlider):
					RetrocamelSoundManager.musicVolume = _musicVolumeSlider.value / 2;
					MonstroData.setMusicVolume(_musicVolumeSlider.value / 2);
					break;

				case(_soundVolumeSlider):
					RetrocamelSoundManager.soundVolume = _soundVolumeSlider.value;
					MonstroData.setSfxVolume(_soundVolumeSlider.value);
					break;

				case(_voicesVolumeSlider):
					MonstroData.setVoicesVolume(_voicesVolumeSlider.value);
					break;
			}
		}

		private function refreshPosition():void {
			var calculatedPosition:Number = _sliderCounter.positionFactor;

			if (isVerticalHiding){
				middle = MonstroConsts.gameHeight / 2 + calculatedPosition * (MonstroConsts.gameHeight/ 2 + height);
				alignCenter();
			} else {
				center = MonstroConsts.gameWidth / 2 + calculatedPosition * (MonstroConsts.gameWidth / 2 + width);
				alignMiddle();
			}
		}

		private function onClose():void {
			startHiding();
		}

		private function startHiding():void {
			if (_isHiding) {
				return;
			}

			_isHiding = true;

			MonstroData.commitData();
			_sliderCounter.hide();
			onClosing.call();
		}

		override public function resize():void {
			refreshPosition();
		}

		private function get optionElements():Array {
			return [_soundVolumeText, _soundVolumeSlider, _soundEnabled, _musicVolumeText, _musicVolumeSlider, _musicEnabled, _voicesVolumeText, _voicesVolumeSlider, _voicesEnabled];
		}

		private function checkboxClickedHandler(checkbox:MonstroCheckbox):void {
			if (checkbox === _soundEnabled) {
				MonstroData.setSoundEnabled(checkbox.isChecked);
				RetrocamelSoundManager.suppressSounds = !checkbox.isChecked;
			} else if (checkbox === _musicEnabled) {
				MonstroData.setMusicEnabled(checkbox.isChecked);
				RetrocamelSoundManager.suppressMusic = !checkbox.isChecked;
			} else if (checkbox === _voicesEnabled) {
				MonstroData.setVoicesEnabled(checkbox.isChecked);
			}
		}

		private function dragEndedHandler(slider:MonstroDragButton):void{
			if (slider === _soundVolumeSlider){
				MonstroSfx.playSoundTest();
			} else if (slider === _voicesVolumeSlider){
				VoicesSfx.playMove(EnumUnitType.GRUNT);
			}
		}
	}
}