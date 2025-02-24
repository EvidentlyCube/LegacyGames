
package net.retrocade.tacticengine.monstro.gui.windows {
	import net.retrocade.retrocamel.display.starling.RetrocamelWindowStarling;
	import net.retrocade.retrocamel.locale._;
	import net.retrocade.tacticengine.monstro.global.core.MonstroConsts;
	import net.retrocade.tacticengine.monstro.global.core.MonstroEscapeBlocker;
	import net.retrocade.tacticengine.monstro.global.enum.EnumCampaignType;
	import net.retrocade.tacticengine.monstro.global.states.MonstroStateIngame;
	import net.retrocade.tacticengine.monstro.gui.helpers.MonstroCursorManager;
	import net.retrocade.tacticengine.monstro.gui.helpers.WindowSliderCounter;
	import net.retrocade.tacticengine.monstro.gui.render.MonstroButton;
	import net.retrocade.tacticengine.monstro.gui.render.MonstroDisplayGroup;
	import net.retrocade.tacticengine.monstro.gui.render.MonstroPrettyWindowGrid9;
	import net.retrocade.tacticengine.monstro.gui.render.MonstroTextButton;
	import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventClearAllActions;
	import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventPrepareLoadLevel;
	import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventTransition;
	import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventWindowClosed;
	import net.retrocade.tacticengine.monstro.levelSelector.LevelSelectionWindow;

	public class MonstroWindowPauseGame extends RetrocamelWindowStarling {
		private static const BUTTON_WIDTH:Number = 400;

		private static var _instance:MonstroWindowPauseGame;

		public static function show():void {
			if (!_instance) {
				_instance = new MonstroWindowPauseGame();
			}

			MonstroCursorManager.resetCursor();

			_instance.show();
		}

		public static function get isVisible():Boolean {
			return _instance && _instance.parent;
		}

		protected var _background:MonstroPrettyWindowGrid9;
		protected var _continue:MonstroTextButton;
		protected var _restart:MonstroTextButton;
		protected var _displayOptions:MonstroTextButton;
		protected var _gameOptions:MonstroTextButton;
		protected var _audioOptions:MonstroTextButton;
		protected var _achievements:MonstroTextButton;
		protected var _returnToMenu:MonstroTextButton;
		protected var _changeLevel:MonstroTextButton;
		protected var _buttonsGroup:MonstroDisplayGroup;

		private var _levelSelectionWindow:LevelSelectionWindow;
		private var _isHiding:Boolean;
		private var _sliderCounter:WindowSliderCounter;
		private var _modal:MonstroWindowModal;
		private var _invertHiding:Boolean;
		private var _isClosing:Boolean;

		private var _isSelectingLevel:Boolean;
		private var _levelIndexToLoad:uint;
		private var _campaignToLoad:EnumCampaignType;

		public function MonstroWindowPauseGame() {
			_blockUnder = false;

			initCreateObjects();
			initSetProperties();

			_buttonsGroup.addElements(buttonsArray);
			_buttonsGroup.alignAllCenter();
			_buttonsGroup.verticalize(MonstroConsts.hudSpacer);

			_background.wrapAround(_buttonsGroup);
			_background.header = _("pause.header");

			addChild(_background);
			addChildren(buttonsArray);
		}

		override public function show():void {
			_modal = MonstroWindowModal.show();
			super.show();

			_isSelectingLevel = false;
			_isHiding = false;
			_isClosing = false;
			_sliderCounter.show();

			resize();
		}

		override public function hide():void {
			_levelSelectionWindow = null;

			super.hide();

			new MonstroEventWindowClosed();
		}

		override public function update():void {
			visible = true;

			if (MonstroEscapeBlocker.isEscapeDown) {
				MonstroEscapeBlocker.flush();

				if (_sliderCounter.isHiding){
					startShowing();
					_modal.cancelHiding();
				} else {
					startClosing();
				}
			}


			if (_sliderCounter.update()) {
				refreshPosition();
			}

			if (_sliderCounter.isFullyHidden) {
				visible = false;
				if (_isClosing){
					hide();
				}
			}
		}

		private function refreshPosition():void {
			var calculatedPosition:Number = _sliderCounter.positionFactor;
			if (_invertHiding){
				middle = MonstroConsts.gameHeight / 2 - calculatedPosition * (MonstroConsts.gameHeight / 2 + height);
			} else {
				middle= MonstroConsts.gameHeight / 2 + calculatedPosition * (MonstroConsts.gameHeight / 2 + height);
			}

			alignCenter();
		}

		private function startHiding():void {
			if (_isHiding) {
				return;
			}

			_isHiding = true;
			_sliderCounter.hide();
		}

		private function startClosing():void {
			startHiding();

			_modal.startHiding();

			_isClosing = true;
		}

		private function startShowing():void{
			if (_isSelectingLevel){
				return;
			}

			visible = true;
			_isClosing = false;
			_isHiding = false;
			if (_sliderCounter.position >= 1){
				_sliderCounter.position = 1.2;
			}
			_sliderCounter.show();
		}

		private function initCreateObjects():void {
			_background = new MonstroPrettyWindowGrid9();
			_continue = new MonstroTextButton(_("pause.continue"), onClose, BUTTON_WIDTH, MonstroButton.COLOR_GREEN);
			_displayOptions = new MonstroTextButton(_("pause.options.video"), onOptionsDisplay, BUTTON_WIDTH);
			_gameOptions = new MonstroTextButton(_("pause.options.gameplay"), onOptionsGameplay, BUTTON_WIDTH);
			_audioOptions = new MonstroTextButton(_("pause.options.sound"), onOptionsSound, BUTTON_WIDTH);
			_achievements = new MonstroTextButton(_("pause.achievements"), onAchievements, BUTTON_WIDTH);
			_returnToMenu = new MonstroTextButton(_("pause.return"), onQuit, BUTTON_WIDTH, MonstroButton.COLOR_RED);
			_restart = new MonstroTextButton(_("pause.restartMission"), onRestart, BUTTON_WIDTH, MonstroButton.COLOR_RED);
			_changeLevel = new MonstroTextButton("Change level", onLevelChange, BUTTON_WIDTH, MonstroButton.COLOR_RED);
			_buttonsGroup = new MonstroDisplayGroup();

			_sliderCounter = new WindowSliderCounter(1);
		}

		private function initSetProperties():void {
			touchable = false;
			_sliderCounter.onStartHiding.add(makeUntouchable);
			_sliderCounter.onFinishedShowing.add(makeTouchable);
			_sliderCounter.onFinishedShowing.add(resetHidingInversion);
		}

		override public function resize():void {
			refreshPosition();
		}

		private function onClose():void {
			startClosing();
		}

		private function onRestart():void {
			startClosing();

			new MonstroEventClearAllActions();
			new MonstroEventTransition(MonstroEventTransition.TRANSITION_RESTART_MISSION);
		}

		private function onLevelChange():void {
			_invertHiding = true;
			startHiding();

			_levelSelectionWindow = LevelSelectionWindow.show(MonstroStateIngame.instance.currentCampaignType, true, MonstroStateIngame.instance.currentLevelIndex);
			_levelSelectionWindow.onClosing.add(startShowing);
			_levelSelectionWindow.onClosed.add(levelSelectionWindowClosedHandler);
			_levelSelectionWindow.onLevelSelected.add(levelSelectedHandler);
		}

		private function onOptionsSound():void {
			_invertHiding = true;
			startHiding();
			MonstroWindowOptionsSound.show(true).onClosing.add(startShowing);
		}

		private function onAchievements():void {
			_invertHiding = true;
			startHiding();
			MonstroWindowAchievements.showWindow(true).onClosing.add(startShowing);
		}

		private function onOptionsDisplay():void {
			_invertHiding = true;
			startHiding();
			MonstroWindowOptionsDisplay.show(true).onClosing.add(startShowing);
		}

		private function onOptionsGameplay():void {
			_invertHiding = true;
			startHiding();
			MonstroWindowOptionsGameplay.show(true).onClosing.add(startShowing);
		}

		private function onQuit():void {
			startClosing();
			new MonstroEventTransition(MonstroEventTransition.TRANSITION_RETURN_TO_MENU);
		}

		private function levelSelectedHandler(levelIndex:int, campaignType:EnumCampaignType):void{
			_levelIndexToLoad = levelIndex;
			_campaignToLoad = campaignType;
			_isSelectingLevel = true;

			_modal.startHiding();
			_levelSelectionWindow.startHiding();
		}

		private function levelSelectionWindowClosedHandler():void{
			if (_isSelectingLevel){
				new MonstroEventPrepareLoadLevel(_levelIndexToLoad, _campaignToLoad);
				hide();
			}
		}

		private function get buttonsArray():Array {
			if (CF::drmFree || CF::flash){
				return [_continue, _gameOptions, _displayOptions, _audioOptions, _achievements, _restart, _changeLevel, _returnToMenu];
			} else {
				return [_continue, _gameOptions, _displayOptions, _audioOptions, _restart, _changeLevel, _returnToMenu];
			}
		}

		private function resetHidingInversion():void{
			_invertHiding = false;
		}
	}
}
