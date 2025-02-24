
package net.retrocade.tacticengine.monstro.gui.windows {
	import net.retrocade.retrocamel.core.RetrocamelDisplayManager;
	import net.retrocade.retrocamel.display.starling.RetrocamelWindowStarling;
	import net.retrocade.retrocamel.locale._;
	import net.retrocade.signal.Signal;
	import net.retrocade.tacticengine.core.Eventer;
	import net.retrocade.tacticengine.core.injector.injectCreate;
	import net.retrocade.tacticengine.monstro.global.core.MonstroConsts;
	import net.retrocade.tacticengine.monstro.global.core.MonstroData;
	import net.retrocade.tacticengine.monstro.global.core.MonstroEscapeBlocker;
	import net.retrocade.tacticengine.monstro.global.core.MonstroGameplayDefinition;
	import net.retrocade.tacticengine.monstro.global.core.MonstroGfx;
	import net.retrocade.tacticengine.monstro.gui.helpers.WindowSliderCounter;
	import net.retrocade.tacticengine.monstro.gui.render.MonstroCheckbox;
	import net.retrocade.tacticengine.monstro.gui.render.MonstroDisplayGroup;
	import net.retrocade.tacticengine.monstro.gui.render.MonstroDragButton;
	import net.retrocade.tacticengine.monstro.gui.render.MonstroGrid9;
	import net.retrocade.tacticengine.monstro.gui.render.MonstroPrettyWindowGrid9;
	import net.retrocade.tacticengine.monstro.gui.render.MonstroTextButton;
	import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventLightingChanged;

	import starling.events.Event;
	import starling.text.TextField;

	public class MonstroWindowOptionsDisplay extends RetrocamelWindowStarling {
		public static function show(isVerticalHiding:Boolean):MonstroWindowOptionsDisplay {
			var instance:MonstroWindowOptionsDisplay = injectCreate(MonstroWindowOptionsDisplay);

			instance.isVerticalHiding = isVerticalHiding;
			instance.show();

			return instance;
		}

		[Inject]
		public var gameplayDefinition:MonstroGameplayDefinition;

		private var _background:MonstroPrettyWindowGrid9;
		private var _parchment:MonstroGrid9;
		private var _lightingHeader:TextField;
		private var _darknessLevelSlider:MonstroDragButton;
		private var _enableLights:MonstroCheckbox;
		private var _enableShadows:MonstroCheckbox;
		private var _miscHeader:TextField;
		private var _isFullscreen:MonstroCheckbox;
		private var _close:MonstroTextButton;

		private var _optionsDisplayGroup:MonstroDisplayGroup;
		private var _isHiding:Boolean;
		private var _sliderCounter:WindowSliderCounter;

		public var isVerticalHiding:Boolean;
		public var onClosing:Signal;

		public function init():void {
			CF::debug{
				ASSERT(gameplayDefinition);
			}

			initCreateObjects();
			initSettings();

			_optionsDisplayGroup = new MonstroDisplayGroup();
			_optionsDisplayGroup.addElements(optionElements);
			_optionsDisplayGroup.alignAllCenter();
			_optionsDisplayGroup.verticalizePrecise(MonstroConsts.hudSpacer, 0, [_miscHeader]);

			var insidesDisplayGroup:MonstroDisplayGroup = new MonstroDisplayGroup();
			insidesDisplayGroup.addElement(_parchment);
			insidesDisplayGroup.addElements(optionElements);
			insidesDisplayGroup.addElement(_close);

			_parchment.wrapAround(_optionsDisplayGroup);
			_close.forcedWidth = _parchment.innerWidth * 0.8;
			_close.alignCenterParent(0, _parchment.width);
			_close.y = _parchment.bottom;

			_background.header = _("Staroptions.header.display");
			_background.wrapAround(insidesDisplayGroup);

			addChild(_background);
			addChild(_parchment);
			addChildren(optionElements);
			addChild(_close);

			insidesDisplayGroup.dispose();
		}

		override public function hide():void {
			removeChildren();

			_background.dispose();
			_darknessLevelSlider.dispose();
			_enableLights.dispose();
			_close.dispose();
			_optionsDisplayGroup.dispose();
			_sliderCounter.dispose();
			_isFullscreen.dispose();
			_miscHeader.dispose();
			onClosing.clear();

			_background = null;
			_darknessLevelSlider = null;
			_enableLights = null;
			_close = null;
			_optionsDisplayGroup = null;
			_sliderCounter = null;
			_isFullscreen = null;
			_miscHeader = null;
			onClosing = null;

			super.hide();
		}



		private function initCreateObjects():void {
			_background = new MonstroPrettyWindowGrid9();
			_parchment = MonstroGfx.getGrid9Parchment();
			_darknessLevelSlider = new MonstroDragButton();
			_lightingHeader = new TextField(323, 45, _("options.header.gameplay.lighting"), MonstroConsts.FONT_EBORACUM_48, 32, 0x382010);
			_enableLights = new MonstroCheckbox(_("optionsEnableLights"), MonstroData.getShowLights(), onCheckboxChanged);
			_enableShadows = new MonstroCheckbox(_("optionsEnableShadowcasting"), MonstroData.getShowShadows(), onCheckboxChanged);
			_miscHeader = new TextField(323, 45, _("options.header.gameplay.misc"), MonstroConsts.FONT_EBORACUM_48, 32, 0x382010);
			_isFullscreen = new MonstroCheckbox(_("optionsIsFullscreen"), MonstroData.getIsFullscreen(), onCheckboxChanged);
			_close = new MonstroTextButton(_("options.close"), onClose);

			_sliderCounter = new WindowSliderCounter(1.2);
			onClosing = new Signal();
		}

		private function initSettings():void {
			_darknessLevelSlider.addEventListener(Event.CHANGE, onSliderChange);

			_darknessLevelSlider.minValue = 0.1;
			_darknessLevelSlider.maxValue = 1;
			_darknessLevelSlider.value = MonstroData.getDarknessLevel();

			_isHiding = false;
			_pauseGame = false;
			_blockUnder = false;

			touchable = false;
			_sliderCounter.onStartHiding.add(makeUntouchable);
			_sliderCounter.onFinishedShowing.add(makeTouchable);
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

			if (_sliderCounter.update()){
				refreshPosition();
			}

			if (_sliderCounter.isFullyHidden){
				hide();
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

		private function startHiding():void {
			if (_isHiding){
				return;
			}

			_isHiding = true;

			MonstroData.commitData();
			_sliderCounter.hide();
			onClosing.call();
		}

		private function onSliderChange(e:Event):void {
			switch (e.target) {
				case(_darknessLevelSlider):
					if (_darknessLevelSlider.value !== MonstroData.getDarknessLevel()){
						MonstroData.setDarknessLevel(_darknessLevelSlider.value);
						new MonstroEventLightingChanged();
					}
					break;
			}
		}

		private function onCheckboxChanged(checkbox:MonstroCheckbox):void {
			switch (checkbox) {
				case(_isFullscreen):
					RetrocamelDisplayManager.isFullscreen = !RetrocamelDisplayManager.isFullscreen;
					break;
				case(_enableLights):
					MonstroData.setShowLights(_enableLights.isChecked);
					new MonstroEventLightingChanged();
					break;
				case(_enableShadows):
					MonstroData.setShowShadows(_enableShadows.isChecked);
					new MonstroEventLightingChanged();
					break;

			}
		}

		private function onClose():void {
			MonstroData.commitData();
			startHiding();
		}


		override public function resize():void {
			super.resize();

			refreshPosition();

			_isFullscreen.isChecked = RetrocamelDisplayManager.isFullscreen;
		}

		private function get optionElements():Array {
			return [_lightingHeader, _darknessLevelSlider, _enableLights, _enableShadows,
				_miscHeader, _isFullscreen];
		}
	}
}