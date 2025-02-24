
package net.retrocade.tacticengine.monstro.gui.windows {
	import net.retrocade.retrocamel.display.starling.RetrocamelWindowStarling;
	import net.retrocade.retrocamel.locale._;
	import net.retrocade.signal.Signal;
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
	import net.retrocade.tacticengine.monstro.ingame.achievements.AchievementManager;

    import flash.utils.getTimer;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.VAlign;

	import starling.events.Touch;
    import starling.events.TouchEvent;

	public class MonstroWindowOptionsGameplay extends RetrocamelWindowStarling {
		public static function show(isVerticalHiding:Boolean):MonstroWindowOptionsGameplay {
			var instance:MonstroWindowOptionsGameplay = injectCreate(MonstroWindowOptionsGameplay);

			instance.isVerticalHiding = isVerticalHiding;
			instance.show();

			return instance;
		}

		[Inject]
		public var gameplayDefinition:MonstroGameplayDefinition;

		private var _background:MonstroPrettyWindowGrid9;
		private var _parchment:MonstroGrid9;
		private var _gameOptionsHeader:TextField;
		private var _gameSpeedText:TextField;
		private var _gameSpeedSlider:MonstroDragButton;
		private var _waitForTapCheckbox:MonstroCheckbox;
		private var _centerBeforeMoveCheckbox:MonstroCheckbox;
		private var _close:MonstroTextButton;
		private var _clearAchievements:MonstroTextButton;

		private var _altControlsHeader:TextField;
		private var _altControlsDescription:TextField;
		private var _altControlsCheckbox:MonstroCheckbox;

		private var _optionsDisplayGroup:MonstroDisplayGroup;
		private var _isHiding:Boolean;
		private var _sliderCounter:WindowSliderCounter;
		private var _clearAchievementsState: Number = 1;
		private var _clearAchievementsLastClick: Number = 0;

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
			_optionsDisplayGroup.verticalizePrecise(MonstroConsts.hudSpacer, 0, [_altControlsHeader]);

			var insidesDisplayGroup:MonstroDisplayGroup = new MonstroDisplayGroup();
			insidesDisplayGroup.addElement(_parchment);
			insidesDisplayGroup.addElements(optionElements);
			insidesDisplayGroup.addElement(_close);

			_parchment.wrapAround(_optionsDisplayGroup);
			_close.forcedWidth = _parchment.innerWidth * 0.8;
			_close.alignCenterParent(0, _parchment.width);
			_close.y = _parchment.bottom;

			_background.header = _("options.header.gameplay");
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
			_gameOptionsHeader.dispose();
			_gameSpeedSlider.dispose();
			_waitForTapCheckbox.dispose();
			_centerBeforeMoveCheckbox.dispose();
			_close.dispose();
			_optionsDisplayGroup.dispose();
			_sliderCounter.dispose();
			onClosing.clear();

			_background = null;
			_gameOptionsHeader = null;
			_gameSpeedSlider = null;
			_waitForTapCheckbox = null;
			_centerBeforeMoveCheckbox = null;
			_close = null;
			_optionsDisplayGroup = null;
			_sliderCounter = null;
			onClosing = null;

			super.hide();
		}

		private function initCreateObjects():void {
			_background = new MonstroPrettyWindowGrid9();
			_parchment = MonstroGfx.getGrid9Parchment();
			_gameOptionsHeader = new TextField(323, 45, _("options.header.gameplay.gameplay"), MonstroConsts.FONT_EBORACUM_48, 32, 0x382010);
			_gameSpeedText = new TextField(323, 30, _("options.speed"), MonstroConsts.FONT_EBORACUM_48, 20, 0x382010);
			_gameSpeedSlider = new MonstroDragButton();
			_waitForTapCheckbox = new MonstroCheckbox(_("options.waitForClick"), MonstroData.getWaitForConfirmation(), onCheckboxChanged);
			_centerBeforeMoveCheckbox = new MonstroCheckbox(_("options.centerBeforeMove"), MonstroData.getCenterBeforeUnitMove(), onCheckboxChanged);
			_close = new MonstroTextButton(_("options.close"), onClose);
			_clearAchievements = new MonstroTextButton(_("options.clearAchievements"), onClearAchievements);
			_clearAchievements.rollOutCallback = onClearAchievementsTouch;

			_altControlsHeader = new TextField(323, 45, _("options.header.gameplay.alt_controls"), MonstroConsts.FONT_EBORACUM_48, 32, 0x382010);
			_altControlsDescription = new TextField(453, 300, _("options.description.gameplay.alt_controls"), MonstroConsts.FONT_EBORACUM_48, 22, 0x382010);
			_altControlsCheckbox = new MonstroCheckbox(_("options.altControls"), MonstroData.getIsDragControls(), onCheckboxChanged);

			_sliderCounter = new WindowSliderCounter(1.2);
			onClosing = new Signal();
		}

		private function initSettings():void {
			_gameSpeedSlider.addEventListener(Event.CHANGE, onSliderChange);

			_gameSpeedSlider.minValue = 0.067;
			_gameSpeedSlider.maxValue = 1;
			_gameSpeedSlider.value = MonstroData.getGameSpeed();

			_isHiding = false;
			_pauseGame = false;
			_blockUnder = false;

			touchable = false;
			_sliderCounter.onStartHiding.add(makeUntouchable);
			_sliderCounter.onFinishedShowing.add(makeTouchable);

			_altControlsDescription.vAlign = VAlign.TOP;
			_altControlsDescription.height = _altControlsDescription.textHeight + 10;
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
				case(_gameSpeedSlider):
					gameplayDefinition.gameSpeed = _gameSpeedSlider.value;
					MonstroData.setGameSpeed(_gameSpeedSlider.value);
					break;
			}
		}

		private function onCheckboxChanged(checkbox:MonstroCheckbox):void {
			switch (checkbox) {
				case(_waitForTapCheckbox):
					gameplayDefinition.waitForAttackConfirmation = _waitForTapCheckbox.isChecked;
					MonstroData.setWaitForConfirmation(_waitForTapCheckbox.isChecked);
					break;
				case(_centerBeforeMoveCheckbox):
					gameplayDefinition.centerBeforeUnitMoves = _centerBeforeMoveCheckbox.isChecked;
					MonstroData.setCenterBeforeUnitMove(_centerBeforeMoveCheckbox.isChecked);
					break;
				case(_altControlsCheckbox):
					MonstroData.setIsDragControls(_altControlsCheckbox.isChecked);
					break;
			}
		}

		private function onClose():void {
			MonstroData.commitData();
			startHiding();
		}

		private function onClearAchievements():void {
			if (_clearAchievementsLastClick + 500 > getTimer() || _clearAchievementsState >= 4) {
				return;
			}

			_clearAchievementsLastClick = getTimer();

			_clearAchievementsState++;
			_clearAchievements.text = _("options.clearAchievements" + _clearAchievementsState);

			if (_clearAchievementsState === 4) {
				AchievementManager.clearAchievements();
			}

			_clearAchievements.alignCenterParent();
		}

		private function onClearAchievementsTouch():void {
			_clearAchievements.text = _("options.clearAchievements");
			_clearAchievementsState = 1;
			_clearAchievements.alignCenterParent();
		}


		override public function resize():void {
			super.resize();

			refreshPosition();
		}

		private function get optionElements():Array {
			return [_gameOptionsHeader, _gameSpeedText, _gameSpeedSlider, _waitForTapCheckbox, _centerBeforeMoveCheckbox,
				_altControlsHeader, _altControlsDescription, _altControlsCheckbox, _clearAchievements];
		}
	}
}