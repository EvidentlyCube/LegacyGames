package net.retrocade.tacticengine.monstro.global.states {
	import net.retrocade.constants.KeyConst;
	import net.retrocade.retrocamel.components.RetrocamelStateBase;
	import net.retrocade.retrocamel.core.RetrocamelInputManager;
	import net.retrocade.retrocamel.core.RetrocamelWindowsManager;
	import net.retrocade.retrocamel.display.layers.RetrocamelLayerStarling;
	import net.retrocade.retrocamel.global.RetrocamelEventsQueue;
	import net.retrocade.tacticengine.core.Eventer;
	import net.retrocade.tacticengine.core.MonstroField;
	import net.retrocade.tacticengine.core.injector.MonstroInjector;
	import net.retrocade.tacticengine.core.injector.injectCreate;
	import net.retrocade.tacticengine.core.log;
	import net.retrocade.tacticengine.monstro.global.core.MonstroConsts;
	import net.retrocade.tacticengine.monstro.global.core.MonstroData;
	import net.retrocade.tacticengine.monstro.global.core.MonstroEscapeBlocker;
	import net.retrocade.tacticengine.monstro.global.core.MonstroGfx;
	import net.retrocade.tacticengine.monstro.global.core.MonstroLevelLoader;
	import net.retrocade.tacticengine.monstro.global.core.ProcessManager;
	import net.retrocade.tacticengine.monstro.global.core.SmartTouch;
	import net.retrocade.tacticengine.monstro.global.core.ZoomManager;
	import net.retrocade.tacticengine.monstro.global.data.levels.MonstroMainGameLevels;
	import net.retrocade.tacticengine.monstro.global.enum.EnumCampaignType;
	import net.retrocade.tacticengine.monstro.global.enum.EnumUnitController;
	import net.retrocade.tacticengine.monstro.global.enum.EnumUnitFaction;
	import net.retrocade.tacticengine.monstro.gui.helpers.MonstroCursorManager;
	import net.retrocade.tacticengine.monstro.gui.hud.MonstroHud;
	import net.retrocade.tacticengine.monstro.gui.render.MonstroBackgroundManager;
	import net.retrocade.tacticengine.monstro.gui.render.MonstroFieldRenderer;
	import net.retrocade.tacticengine.monstro.gui.windows.MonstroIntroductionTutorial;
	import net.retrocade.tacticengine.monstro.gui.windows.MonstroWindowHelp;
	import net.retrocade.tacticengine.monstro.gui.windows.MonstroWindowMissionObjective;
	import net.retrocade.tacticengine.monstro.gui.windows.MonstroWindowPauseGame;
	import net.retrocade.tacticengine.monstro.ingame.achievements.AchievementManager;
	import net.retrocade.tacticengine.monstro.ingame.actions.IMonstroAction;
	import net.retrocade.tacticengine.monstro.ingame.actions.MonstroActionFadeFromBlack;
	import net.retrocade.tacticengine.monstro.ingame.actions.MonstroActionFadeToBlack;
	import net.retrocade.tacticengine.monstro.ingame.actions.MonstroActionMissionEnded;
	import net.retrocade.tacticengine.monstro.ingame.actions.MonstroActionSlideLevelIn;
	import net.retrocade.tacticengine.monstro.ingame.actions.MonstroActionSlideLevelOut;
	import net.retrocade.tacticengine.monstro.ingame.ais.classic.MonstroEnemyTurnProcess;
	import net.retrocade.tacticengine.monstro.ingame.ais.classic.MonstroPlayerTurnProcess;
	import net.retrocade.tacticengine.monstro.ingame.condition.IMonstroCondition;
	import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventChangeConditions;
	import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventClearAllActions;
	import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventLevelLoaded;
	import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventLoadLevel;
	import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventMissionFinished;
	import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventNewAction;
	import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventPlayfieldOffsetChange;
	import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventPrepareLoadLevel;
	import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventResize;
	import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventSaveStateLoaded;
	import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventTransition;
	import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventTurnProcessHasChanged;
	import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventUndidCurrentTurn;
	import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventUndo;
	import net.retrocade.tacticengine.monstro.ingame.undo.UndoManager;
	import net.retrocade.tacticengine.monstro.ingame.utils.MonstroIngameMusicManager;
	import net.retrocade.tacticengine.monstro.ingame.utils.MonstroLevelStats;
	import net.retrocade.tacticengine.monstro.ingame.utils.MonstroSaveStateManager;

	import starling.display.DisplayObject;

	public class MonstroStateIngame extends RetrocamelStateBase {
		public static var instance:MonstroStateIngame;

		public static function show(playerControls:EnumUnitFaction):void {
			instance = new MonstroStateIngame(playerControls);
			instance.setToMe();
		}

		private static function returnToMainmenu():void {
			MonstroStateTitle.show();
		}


		private var _field:MonstroField;
		private var _fieldRenderer:MonstroFieldRenderer;
		private var _backgroundManager:MonstroBackgroundManager;
		private var _layerHud:MonstroHud;
		private var _processManager:ProcessManager;
		private var _introductionTutorial:MonstroIntroductionTutorial;
		private var _zoomManager:ZoomManager;
		private var _musicManager:MonstroIngameMusicManager;
		private var _backgroundLayer:RetrocamelLayerStarling;
		/**
		 * A stack of all the actions (visual effects) which are queued for execution
		 */
		private var _actionsStack:Vector.<IMonstroAction>;
		/**
		 * Is a level currently loaded
		 */
		private var _isLevelLoaded:Boolean;
		/**
		 * Unit type which the player controls
		 */
		private var _playerControls:EnumUnitFaction;
		/**
		 * Index of the currently played level (numeric)
		 */
		private var _currentLevelIndex:int;
		/**
		 * Type of the currently played level
		 */
		private var _currentCampaignType:EnumCampaignType;
		private var _isMissionFinished:Boolean = false;
		private var _victoryCondition:IMonstroCondition;
		private var _lossCondition:IMonstroCondition;
		private var _levelStats:MonstroLevelStats;

		public function MonstroStateIngame(playerControls:EnumUnitFaction) {
			super();

			_playerControls = playerControls;

			MonstroData.playerUnitType = _playerControls;

			MonstroInjector.mapValue(MonstroStateIngame, this);
		}

		override public function create():void {
			Eventer.listen(MonstroEventNewAction.NAME, onAddAction, this);
			Eventer.listen(MonstroEventMissionFinished.NAME, onMissionFinished, this);
			Eventer.listen(MonstroEventTransition.NAME, onTransition, this);
			Eventer.listen(MonstroEventLoadLevel.NAME, onLoadLevel, this);
			Eventer.listen(MonstroEventUndo.NAME, onUndo, this);
			Eventer.listen(MonstroEventChangeConditions.NAME, onConditionsChanged, this);
			Eventer.listen(MonstroEventTurnProcessHasChanged.NAME, onTurnProcessHasChanged, this);
			Eventer.listen(MonstroEventClearAllActions.NAME, onClearAllActions, this);
			Eventer.listen(MonstroEventPrepareLoadLevel.NAME, onPrepareLevelLoaded, this);
			Eventer.listen(MonstroEventUndidCurrentTurn.NAME, onCurrentTurnUndid, this);
			Eventer.listen(MonstroEventResize.NAME, onResize, this);

			initCreateObjects();
			initBackgroundManager();
		}

		override public function destroy():void {
			MonstroData.commitData();

			instance = null;

			for each(var action:IMonstroAction in _actionsStack) {
				action.dispose();
			}

			MonstroInjector.unmap(MonstroField);
			MonstroInjector.unmap(MonstroFieldRenderer);
			MonstroInjector.unmap(MonstroStateIngame);

			_introductionTutorial.dispose();
			_zoomManager.dispose();
			_backgroundManager.dispose();
			_processManager.dispose();
			_fieldRenderer.dispose();
			_field.dispose();
			_backgroundLayer.dispose();
			_musicManager.dispose();
			_layerHud.dispose();
			_victoryCondition.dispose();
			_lossCondition.dispose();
			_levelStats.dispose();
			_actionsStack.length = 0;

			_introductionTutorial = null;
			_actionsStack = null;
			_zoomManager = null;
			_backgroundManager = null;
			_processManager = null;
			_fieldRenderer = null;
			_field = null;
			_backgroundLayer = null;
			_musicManager = null;
			_layerHud = null;
			_victoryCondition = null;
			_lossCondition = null;
			_levelStats = null;
			_playerControls = null;
			_currentCampaignType = null;
			_isLevelLoaded = false;

			Eventer.releaseContext(this);

			MonstroInjector.unmap(MonstroStateIngame);

			MonstroCursorManager.resetCursor();
		}

		override public function update():void {
			super.update();

			CF::enableCheats{
				if (RetrocamelInputManager.isKeyHit(KeyConst.F12)) {
					doMissionCompletion();
				}
			}

			CF::enableCheats{
				if (RetrocamelInputManager.isKeyHit(KeyConst.F8)) {
					new MonstroEventTransition(MonstroEventTransition.TRANSITION_LOAD_SPECIFIC_LEVEL, _currentCampaignType, _currentLevelIndex + 1);
				}
			}

			_zoomManager.update();
			_backgroundManager.update();
			_musicManager.update();

			var actionCallback:Function;
			var processManagerIsBlocked:Boolean = false;
			if (_actionsStack.length && _actionsStack[0]) {
				var blocksOtherActions:Boolean;
				var actionIndex:int = 0;

				do {
					blocksOtherActions = _actionsStack[actionIndex].isBlockingOtherActions;
					processManagerIsBlocked = processManagerIsBlocked || _actionsStack[actionIndex].isProcessManagerBlocked;

					if (_actionsStack.length > 0 && _actionsStack[actionIndex].update()) {
						var isStoppingAction:Boolean = _actionsStack[actionIndex].shouldSkipFrameAfterFinished;
						var actionToDestroy:IMonstroAction = _actionsStack[actionIndex];
						_actionsStack.splice(actionIndex, 1);

						actionCallback = actionToDestroy.callback;
						actionToDestroy.dispose();

						AchievementManager.updateInGame(_field, _currentLevelIndex, _currentCampaignType, this);

						if (actionCallback !== null) {
							if (actionCallback.length == 0) {
								actionCallback();
							} else {
								actionCallback(this);
							}
						}

						if (!isSet()) {
							return;
						}

						missionCompletedCheck();

						if (isStoppingAction) {
							blocksOtherActions = true;
						}
					} else {
						actionIndex++;
					}


				} while (_actionsStack.length > actionIndex && !blocksOtherActions);
			}

			_processManager.enabled = !processManagerIsBlocked;

			if (!processManagerIsBlocked) {
				missionCompletedCheck();

				if (!_isMissionFinished) {
					_processManager.update();
				}
			}

			if (!_isMissionFinished) {
				checkWindowShortcutKeys();
			}

			if (_layerHud) {
				_layerHud.update();
			}

			_fieldRenderer.update();
			_introductionTutorial.update();
		}

		private function showEndCampaignScreen():void {
			MonstroStateOutro.show(currentCampaignType);
		}

		public function onTransition(event:MonstroEventTransition):void {
			if (event.type == MonstroEventTransition.TRANSITION_RESTART_MISSION) {
				addAction(new MonstroActionSlideLevelOut(_fieldRenderer, doMissionRestart));

			} else if (event.type == MonstroEventTransition.TRANSITION_RETURN_TO_MENU) {
				addAction(new MonstroActionFadeToBlack(returnToMainmenu));

			} else if (event.type == MonstroEventTransition.TRANSITION_NEXT_MISSION) {
				addAction(new MonstroActionSlideLevelOut(_fieldRenderer, doNextMission));

			} else if (event.type == MonstroEventTransition.TRANSITION_RESTART_AND_LOAD_STATE) {
				addAction(new MonstroActionSlideLevelOut(_fieldRenderer, doMissionRestartWithStateLoad));

			} else if (event.type == MonstroEventTransition.TRANSITION_SHOW_END_CAMPAIGN_SCREEN) {
				addAction(new MonstroActionFadeToBlack(showEndCampaignScreen));

			} else if (event.type == MonstroEventTransition.TRANSITION_LOAD_SPECIFIC_LEVEL) {
				_goToSpecificMissionCampaignType = event.campaignToLoad;
				_goToSpecificMissionLevelIndex = event.levelIndexToLoad;
				addAction(new MonstroActionSlideLevelOut(_fieldRenderer, goToSpecificMission));
			}

			_zoomManager.isEnabled = false;
		}

		private function initCreateObjects():void {
			_actionsStack = new Vector.<IMonstroAction>();
			_backgroundLayer = new RetrocamelLayerStarling();

			_backgroundManager = injectCreate(MonstroBackgroundManager);
			_musicManager = injectCreate(MonstroIngameMusicManager);
		}

		private function initNewLevel(levelIndex:int, campaignType:EnumCampaignType, saveState:String = null):void {
			_field = new MonstroField();
			MonstroInjector.mapValue(MonstroField, _field);

			_fieldRenderer = injectCreate(MonstroFieldRenderer);
			MonstroInjector.mapValue(MonstroFieldRenderer, _fieldRenderer);

			_processManager = injectCreate(ProcessManager);
			_levelStats = injectCreate(MonstroLevelStats);

			UndoManager.instance = new UndoManager();

			MonstroLevelLoader.loadLevel(
				MonstroMainGameLevels.getLevel(levelIndex, campaignType),
				_field,
				_playerControls,
				saveState
			);

			_fieldRenderer.tileset = levelStats.levelTileset;
			_fieldRenderer.renderAll();
			_fieldRenderer.playerControls = _playerControls;

			_processManager.addProcess(injectCreate(MonstroPlayerTurnProcess));
			_processManager.addProcess(injectCreate(MonstroEnemyTurnProcess));

			_layerHud = injectCreate(MonstroHud);
			_levelStats.start();

			SmartTouch.hook(new <DisplayObject>[
				_fieldRenderer.layerFloor.layer,
				_fieldRenderer.layerAnimatedFloor.layer,
				_fieldRenderer.layerSprites.layer,
				_fieldRenderer.layerRects.layer
			]);
			_zoomManager = new ZoomManager(_field);
			_zoomManager.hook(new <DisplayObject>[
				_fieldRenderer.layerFloor.layer,
				_fieldRenderer.layerAnimatedFloor.layer,
				_fieldRenderer.layerSprites.layer,
				_fieldRenderer.layerRects.layer
			]);
			_introductionTutorial = injectCreate(MonstroIntroductionTutorial);

			_isMissionFinished = false;

			new MonstroEventLevelLoaded(levelIndex, campaignType, saveState);

			if (saveState) {
				new MonstroEventSaveStateLoaded();
			}
		}

		private function initBackgroundManager():void {
			_backgroundManager.setBackgrounds(MonstroGfx.getGameplayBgBottom());
			_backgroundManager.setBackgroundLayer(_backgroundLayer);
		}

		private function missionCompletedCheck():void {
			if (_isMissionFinished) {
				return;
			}

			if (isMissionFailed()) {
				_isMissionFinished = true;
				new MonstroEventMissionFinished(false);

			} else if (isMissionWon()) {
				doMissionCompletion();
			}
		}

		public function isMissionFailed():Boolean {
			return _lossCondition.check();
		}

		public function isMissionWon():Boolean {
			return _victoryCondition.check();
		}

		private function doMissionCompletion():void {
			var oldCompletedLevelCount:uint = MonstroMainGameLevels.getCompletedLevelCount(_currentCampaignType);
			MonstroData.setLevelCompleted(_currentLevelIndex, _currentCampaignType);

			var showEndCampaign:Boolean = (
				isCurrentCampaignCompleted()
				&& oldCompletedLevelCount != MonstroMainGameLevels.getCompletedLevelCount(_currentCampaignType)
				);

			_isMissionFinished = true;
			new MonstroEventMissionFinished(true, showEndCampaign);

			if (showEndCampaign) {
				MonstroData.setCampaignCompleted(_currentCampaignType, true);
			}

			AchievementManager.updateGeneral();
		}

		private function isCurrentCampaignCompleted():Boolean {
			return MonstroMainGameLevels.getCompletedLevelCount(_currentCampaignType) == MonstroMainGameLevels.getLevelCountInCampaign(_currentCampaignType);
		}

		private function onAddAction(event:MonstroEventNewAction):void {
			addAction(event.action);
		}

		private function onMissionFinished(event:MonstroEventMissionFinished):void {
			var action:MonstroActionMissionEnded = new MonstroActionMissionEnded(
				event.isVictory,
				_playerControls.isHuman(),
				event.showEndCampaignScreen
			);

			addAction(action);

			if (event.isVictory){
				MonstroData.setSaveState(null, -1, EnumCampaignType.HUMAN);
			}
		}

		private function onLoadLevel(event:MonstroEventLoadLevel):void {
			if (_isLevelLoaded) {
				_layerHud.dispose();
				_processManager.dispose();
				_zoomManager.dispose();
				_fieldRenderer.dispose();
				_field.dispose();
				_introductionTutorial.dispose();

				UndoManager.instance.dispose();

				while (_actionsStack.length > 0) {
					_actionsStack.pop().dispose();
				}
			}

			_currentLevelIndex = event.levelIndex;
			_currentCampaignType = event.campaignType;

			initNewLevel(_currentLevelIndex, _currentCampaignType, event.saveState);

			_zoomManager.update();
			_zoomManager.isEnabled = false;

			if (!_isLevelLoaded) {
				addAction(new MonstroActionFadeFromBlack());
			}


			addAction(new MonstroActionSlideLevelIn(_fieldRenderer, enableZoomManager));

			_isLevelLoaded = true;
		}

		private function onUndo(event:MonstroEventUndo):void {
			if (UndoManager.instance.hasAnyUndo()) {
				_isMissionFinished = false;
				_processManager.onUndo();
				UndoManager.instance.undo(_field);

				if (event.undidFromMissionEnd) {
					processManager.silentlySwitchTo(MonstroPlayerTurnProcess);
				}
			}
		}

		private function onConditionsChanged(event:MonstroEventChangeConditions):void {
			if (_victoryCondition) {
				_victoryCondition.dispose();
			}

			if (_lossCondition) {
				_lossCondition.dispose();
			}

			_victoryCondition = event.victoryCondition;
			_lossCondition = event.lossCondition;
		}

		private function onTurnProcessHasChanged(event:MonstroEventTurnProcessHasChanged):void {
			if (event.newProcess is MonstroPlayerTurnProcess) {
				MonstroData.setSaveState(
					MonstroSaveStateManager.makeDump(
						_field,
						_victoryCondition,
						_lossCondition
					),
					_currentLevelIndex,
					_currentCampaignType
				);
			}
		}

		private function onClearAllActions():void {
			while (_actionsStack.length) {
				_actionsStack.shift().dispose();
			}
		}

		private function onPrepareLevelLoaded(event:MonstroEventPrepareLoadLevel):void {
			new MonstroEventTransition(MonstroEventTransition.TRANSITION_LOAD_SPECIFIC_LEVEL, event.campaignType, event.levelIndex);
		}

		private function onCurrentTurnUndid(event:MonstroEventUndidCurrentTurn):void {
			_field.currentTurn = event.newCurrentTurn;
		}

		private function onResize():void {
			for each (var action:IMonstroAction in _actionsStack) {
				action.resize();
			}
		}

		private function doMissionRestart():void {
			new MonstroEventLoadLevel(_currentLevelIndex, _currentCampaignType);
		}

		private function doMissionRestartWithStateLoad():void {
			new MonstroEventLoadLevel(
				_currentLevelIndex,
				_currentCampaignType,
				MonstroData.getSaveState()
			);
		}

		private function doNextMission():void {
			_currentLevelIndex = MonstroMainGameLevels.getFirstUncompletedLevelAfter(_currentLevelIndex, _currentCampaignType);
			new MonstroEventLoadLevel(_currentLevelIndex, _currentCampaignType);
		}

		private var _goToSpecificMissionCampaignType:EnumCampaignType;
		private var _goToSpecificMissionLevelIndex:uint;

		private function goToSpecificMission():void {
			new MonstroEventLoadLevel(_goToSpecificMissionLevelIndex, _goToSpecificMissionCampaignType);
		}

		private function enableZoomManager():void {
			_zoomManager.isEnabled = true;
		}

		private function addAction(action:IMonstroAction):void {
			_l("Adding action " + String(action));
			if (!action.canHaveMultipleInstances) {
				_l("Action cant have multiple instances...");
				var classInstance:Class = Object(action).constructor;

				for each(var actionToCheck:IMonstroAction in _actionsStack) {
					if (actionToCheck is classInstance) {
						_l("Found instance of an action, skipping");
						return;
					}
				}
				_l("No other instances of the action found");
			}

			action.field = _field;
			_actionsStack.push(action);
		}

		private function checkWindowShortcutKeys():void {
			if (MonstroEscapeBlocker.isEscapeDown && !MonstroWindowPauseGame.isVisible) {
				MonstroEscapeBlocker.flush();

				MonstroWindowPauseGame.show();
				RetrocamelEventsQueue.add(MonstroConsts.EVENT_PAUSE_MENU_OPENED);
			}

			if (RetrocamelWindowsManager.numWindows > 0) {
				return;
			}

			if (RetrocamelInputManager.isKeyDown(KeyConst.LEFT) || RetrocamelInputManager.isKeyDown(KeyConst.A)){
				new MonstroEventPlayfieldOffsetChange(-15, 0);
			}
			if (RetrocamelInputManager.isKeyDown(KeyConst.RIGHT) || RetrocamelInputManager.isKeyDown(KeyConst.D)){
				new MonstroEventPlayfieldOffsetChange(15, 0);
			}
			if (RetrocamelInputManager.isKeyDown(KeyConst.UP) || RetrocamelInputManager.isKeyDown(KeyConst.W)){
				new MonstroEventPlayfieldOffsetChange(0, -15);
			}
			if (RetrocamelInputManager.isKeyDown(KeyConst.DOWN) || RetrocamelInputManager.isKeyDown(KeyConst.S)){
				new MonstroEventPlayfieldOffsetChange(0, 15);
			}


			if (RetrocamelInputManager.isKeyHit(KeyConst.F1)) {
				MonstroWindowHelp.showWindow();
			} else if (RetrocamelInputManager.isKeyHit(KeyConst.F2)) {
				MonstroWindowMissionObjective.show();
			}
		}

		public function get processManager():ProcessManager {
			return _processManager;
		}

		public function get actionsCount():uint {
			return _actionsStack.length;
		}

		public function get zoomManager():ZoomManager {
			return _zoomManager;
		}

		public function get playerControls():EnumUnitFaction {
			return _playerControls;
		}

		public function get victoryCondition():IMonstroCondition {
			return _victoryCondition;
		}

		public function get lossCondition():IMonstroCondition {
			return _lossCondition;
		}

		public function get levelStats():MonstroLevelStats {
			return _levelStats;
		}

		public function get currentLevelIndex():int {
			return _currentLevelIndex;
		}

		public function get currentCampaignType():EnumCampaignType {
			return _currentCampaignType;
		}

		public function get currentFaction():EnumUnitController {
			return processManager.currentProcess.controlledBy;
		}

		public function get hasBlockingActions():Boolean {
			for each(var action:IMonstroAction in _actionsStack) {
				if (action.isProcessManagerBlocked || action.isBlockingOtherActions) {
					return true;
				}
			}

			return false;
		}
	}
}