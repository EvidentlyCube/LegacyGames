
package net.retrocade.tacticengine.monstro.gui.windows {
	import net.retrocade.constants.KeyConst;
	import net.retrocade.retrocamel.core.RetrocamelInputManager;
	import net.retrocade.retrocamel.display.starling.RetrocamelWindowStarling;
	import net.retrocade.retrocamel.locale._;
	import net.retrocade.signal.Signal;
	import net.retrocade.tacticengine.monstro.global.core.MonstroConsts;
	import net.retrocade.tacticengine.monstro.global.enum.EnumCampaignType;
	import net.retrocade.tacticengine.monstro.global.states.MonstroStateIngame;
	import net.retrocade.tacticengine.monstro.gui.helpers.WindowSliderCounter;
	import net.retrocade.tacticengine.monstro.gui.render.MonstroButton;
	import net.retrocade.tacticengine.monstro.gui.render.MonstroDisplayGroup;
	import net.retrocade.tacticengine.monstro.gui.render.MonstroStatsWindowGrid9;
	import net.retrocade.tacticengine.monstro.gui.render.MonstroTextButton;
	import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventPrepareLoadLevel;
	import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventTransition;
	import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventUndo;
	import net.retrocade.tacticengine.monstro.levelSelector.LevelSelectionWindow;

	public class WindowMissionFinishedOptions extends RetrocamelWindowStarling implements IWindowMissionFinished{
		private static const BUTTON_WIDTH:Number = 400;

		public static function showWindow(isVictory:Boolean):WindowMissionFinishedOptions {
			var instance:WindowMissionFinishedOptions = new WindowMissionFinishedOptions();

			instance.setVictory(isVictory);
			instance.show();

			return instance;
		}

		private var _isVictory:Boolean;
		private var _transitionToUse:int;

		protected var _background:MonstroStatsWindowGrid9;
		protected var _playNextMission:MonstroTextButton;
		protected var _returnToTitleScreen:MonstroTextButton;
		protected var _changeLevel:MonstroTextButton;
		protected var _undoLastMove:MonstroTextButton;
		protected var _restartMission:MonstroTextButton;
		protected var _buttonsGroup:MonstroDisplayGroup;

		private var _levelSelectionWindow:LevelSelectionWindow;
		private var _isHiding:Boolean;
		private var _isClosing:Boolean;
		private var _sliderCounter:WindowSliderCounter;
		private var _invertHiding:Boolean;
		private var _isSelectingLevel:Boolean;
		private var _levelToLoad:uint;

		private var _onClosing:Signal;

		private var _isFinished:Boolean;

		public function get onClosing():Signal {
			return _onClosing;
		}

		public function WindowMissionFinishedOptions() {
			_blockUnder = false;
			_pauseGame = false;
		}

		override public function show():void {
			super.show();

			initCreateObjects();
			initSettings();

			_buttonsGroup.addElements(buttonsArray);
			_buttonsGroup.alignAllCenter();
			_buttonsGroup.verticalize(MonstroConsts.hudSpacer);

			_background.wrapAround(_buttonsGroup);

			addChild(_background);
			addChildren(buttonsArray);

			resize();

			_sliderCounter.speed = 0.04;
			_isHiding = false;
			_pauseGame = false;
			_blockUnder = false;
		}

		override public function hide():void {
			removeChildren();

			_background.dispose();
			_restartMission.dispose();
			_undoLastMove.dispose();
			_changeLevel.dispose();
			_returnToTitleScreen.dispose();
			_playNextMission.dispose();
			_buttonsGroup.dispose();

			_background = null;
			_restartMission = null;
			_undoLastMove = null;
			_changeLevel = null;
			_returnToTitleScreen = null;
			_playNextMission = null;
			_buttonsGroup = null;

			super.hide();

			dispose();
		}

		public function setVictory(isVictory:Boolean):void {
			_isVictory = isVictory;
		}

		override public function update():void {
			if (_isFinished){
				return;
			}

			if (touchable && RetrocamelInputManager.isKeyDown(KeyConst.Q)){
				undoLastMoveHandler();
			}

			if (_sliderCounter.update()) {
				refreshPosition();
			} else {
				_sliderCounter.speed = 0.07;
			}

			if (_sliderCounter.isFullyHidden) {
				visible = false;

				if (_isClosing) {
					if (_transitionToUse === MonstroEventTransition.TRANSITION_UNDO_LAST_MOVE) {
						new MonstroEventUndo(true);
					} else if (_transitionToUse !== -1) {
						new MonstroEventTransition(_transitionToUse);
					}

					_isFinished = true;
				}
			}
		}

		private function initCreateObjects():void {
			_background = new MonstroStatsWindowGrid9();
			_playNextMission = new MonstroTextButton(_("missionEndWindow.next"), playNextMissionHandler, BUTTON_WIDTH, MonstroButton.COLOR_BLUE);
			_returnToTitleScreen = new MonstroTextButton(_("missionEndWindow.title"), returnToTileScreenHandler, BUTTON_WIDTH, MonstroButton.COLOR_RED);
			_undoLastMove = new MonstroTextButton(_("missionEndWindow.undo"), undoLastMoveHandler, BUTTON_WIDTH, MonstroButton.COLOR_BLUE);
			_changeLevel = new MonstroTextButton(_("missionEndWindow.change"), changeLevelHandler, BUTTON_WIDTH, MonstroButton.COLOR_BLUE);
			_restartMission = new MonstroTextButton(_("missionEndWindow.restart"), restartMissionHandler, BUTTON_WIDTH, MonstroButton.COLOR_RED);
			_buttonsGroup = new MonstroDisplayGroup();

			_sliderCounter = new WindowSliderCounter(1.2);
			_onClosing = new Signal();
		}

		private function initSettings():void {
			touchable = false;
			_sliderCounter.onStartHiding.add(makeUntouchable);
			_sliderCounter.onFinishedShowing.add(makeTouchable);
			_sliderCounter.onFinishedShowing.add(resetHidingInversion);
		}

		private function refreshPosition():void {
			var calculatedPosition:Number = _sliderCounter.positionFactor;

			if (_invertHiding){
				middle = MonstroConsts.gameHeight / 2 - calculatedPosition * (MonstroConsts.gameHeight / 2 + height);
			} else {
				middle = MonstroConsts.gameHeight / 2 + calculatedPosition * (MonstroConsts.gameHeight / 2 + height);
			}

			alignCenter();
		}

		private function startShowing():void {
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

		private function startHiding():void {
			if (_isHiding) {
				return;
			}

			_isHiding = true;

			_sliderCounter.hide();
		}

		private function startClosing():void {
			if (_isHiding) {
				return;
			}

			_isHiding = true;
			_isClosing = true;

			_sliderCounter.hide();
			_onClosing.call();
		}

		public function get maxTopPosition():Number {
			return MonstroConsts.gameHeight / 2 - height / 2;
		}

		override public function resize():void {
			refreshPosition();
		}

		private function playNextMissionHandler():void {
			startClosing();

			_transitionToUse = MonstroEventTransition.TRANSITION_NEXT_MISSION;
		}

		private function restartMissionHandler():void {
			startClosing();

			_transitionToUse = MonstroEventTransition.TRANSITION_RESTART_MISSION;
		}

		private function changeLevelHandler():void {
			_invertHiding = true;
			startHiding();

			_levelSelectionWindow = LevelSelectionWindow.show(MonstroStateIngame.instance.currentCampaignType, true, MonstroStateIngame.instance.currentLevelIndex);
			_levelSelectionWindow.onClosing.add(startShowing);
			_levelSelectionWindow.onClosed.add(levelSelectionWindowClosedHandler);
			_levelSelectionWindow.onLevelSelected.add(levelSelectedHandler);
		}

		private function returnToTileScreenHandler():void {
			startClosing();

			_transitionToUse = MonstroEventTransition.TRANSITION_RETURN_TO_MENU;
		}

		private function undoLastMoveHandler():void {
			startClosing();

			_transitionToUse = MonstroEventTransition.TRANSITION_UNDO_LAST_MOVE;
		}

		private function get buttonsArray():Array {
			if (_isVictory) {
				return [_playNextMission, _undoLastMove, _changeLevel, _restartMission, _returnToTitleScreen];
			} else {
				return [_undoLastMove, _changeLevel, _restartMission, _returnToTitleScreen];
			}
		}

		private function levelSelectedHandler(levelIndex:int, campaignType:EnumCampaignType):void{
			_levelToLoad = levelIndex;
			_isSelectingLevel = true;

			_onClosing.call();
			_levelSelectionWindow.startHiding();
		}

		private function levelSelectionWindowClosedHandler():void{
			if (_isSelectingLevel){
				new MonstroEventPrepareLoadLevel(_levelToLoad, MonstroStateIngame.instance.currentCampaignType);
				_onClosing.call();
			}
		}

		private function resetHidingInversion():void{
			_invertHiding = false;
		}
	}
}
