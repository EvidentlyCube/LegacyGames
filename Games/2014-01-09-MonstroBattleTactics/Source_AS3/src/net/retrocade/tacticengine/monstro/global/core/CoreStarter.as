package net.retrocade.tacticengine.monstro.global.core {
	CF::desktop {
		import flash.desktop.NativeApplication;
	}
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.UncaughtErrorEvent;

	import net.retrocade.retrocamel.core.RetrocamelCore;
	import net.retrocade.retrocamel.core.RetrocamelStarlingCore;
	import net.retrocade.tacticengine.monstro.global.core.MonstroGraphicFilesLoader;
	import net.retrocade.tacticengine.core.injector.MonstroInjector;
	import net.retrocade.tacticengine.core.log;
	import net.retrocade.tacticengine.monstro.global.enum.EnumCampaignType;
	import net.retrocade.tacticengine.monstro.global.enum.EnumUnitFaction;
	import net.retrocade.tacticengine.monstro.global.states.MonstroStateDrmFreeUpdateCheck;
	import net.retrocade.tacticengine.monstro.global.states.MonstroStateImportProgress;
	import net.retrocade.tacticengine.monstro.global.states.MonstroStateIngame;
	import net.retrocade.tacticengine.monstro.global.states.MonstroStateIntro;
	import net.retrocade.tacticengine.monstro.global.states.MonstroStateOutro;
	import net.retrocade.tacticengine.monstro.global.states.MonstroStateRetrocade;
	import net.retrocade.tacticengine.monstro.global.states.MonstroStateTitle;
	import net.retrocade.tacticengine.monstro.global.states.MonstroStateUpdateInfo;
	import net.retrocade.tacticengine.monstro.global.states.introOutro.outro.OutroScreenGenerator;
	import net.retrocade.tacticengine.monstro.gui.helpers.MonstroCursorManager;
	import net.retrocade.tacticengine.monstro.gui.hud.MonstroHud;
	import net.retrocade.tacticengine.monstro.gui.hud.MonstroHudAttackResults;
	import net.retrocade.tacticengine.monstro.gui.hud.MonstroHudStatsWindow;
	import net.retrocade.tacticengine.monstro.gui.hud.MonstroHudTurnsLeft;
	import net.retrocade.tacticengine.monstro.gui.render.MonstroBackgroundManager;
	import net.retrocade.tacticengine.monstro.gui.render.MonstroFieldRenderer;
	import net.retrocade.tacticengine.monstro.gui.windows.MonstroWindowAchievements;
	import net.retrocade.tacticengine.monstro.gui.windows.MonstroWindowCredits;
	import net.retrocade.tacticengine.monstro.gui.windows.MonstroWindowHelp;
	import net.retrocade.tacticengine.monstro.ingame.achievements.AchievementManager;
	import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventLoadLevel;
	import net.retrocade.tacticengine.monstro.ingame.tutorial.MonstroTutorialManager;
	import net.retrocade.tacticengine.monstro.ingame.utils.MonstroIngameMusicManager;
	import net.retrocade.tacticengine.monstro.ingame.utils.MonstroLevelStats;
	import net.retrocade.tacticengine.monstro.levelSelector.LevelSelectionWindow;

	public class CoreStarter extends Sprite {
		private var _isCoreInit:Boolean = false;

		private var _imagesLoaded:Boolean = false;
		private var _apiInitialized:Boolean = false;

		public function CoreStarter() {
			if (!CF::debug){
				stage.loaderInfo.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR, onUncaughtError);
				loaderInfo.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR, onUncaughtError);
				RetrocamelCore.errorCallback = onError;
			}
			log("Game started.");


			CF::steam{
				_l("Initializing Steam");
				SteamInterface.onSteamworksInitialized.add(apiInitializedHandler);
				SteamInterface.init();
			}

			CF::drmFree{
				_l("Initializing DRM Free Version");
				RetrocadeInterface.onInitialized.add(apiInitializedHandler);
				RetrocadeInterface.init();
			}

			CF::flash {
				_l("Initializing Flash Version");
				apiInitializedHandler();
			}

			_l("Initializing Graphics");
			MonstroGraphicFilesLoader.onLoadingFinished.add(imagesLoadedHandler);
			MonstroGraphicFilesLoader.loadGraphicFiles();

			_l("Initializing Voices");
			VoicesSfx.init();

			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}

		private function apiInitializedHandler():void{
			_l("Version initialized");
			_apiInitialized = true;
		}

		private function imagesLoadedHandler(wasSuccess:Boolean):void{
			if (wasSuccess){
				_imagesLoaded = true;
			} else {
				throw new Error("Failed to load necessary image data");
			}
		}

		private function onEnterFrame(e:Event):void {
			try {
				onEnterFrame_impl();
			} catch (error: Error) {
				_e("CoreStarter.onEnterFrame()", error);
			}
		}

		private function onEnterFrame_impl(): void {
			CF::desktop {
				if (!NativeApplication.nativeApplication.activeWindow) {
					return;
				}
			}

			if (!_apiInitialized || !_imagesLoaded){
				return;
			}

			if (stage && !_isCoreInit) {
				CoreInit.init(this);

				_isCoreInit = true;
			}

			if (stage && RetrocamelStarlingCore.isInitialized) {
				removeEventListener(Event.ENTER_FRAME, onEnterFrame);

				_l("CoreStarter.update() -> MonstroLoadedGfx.initialize()")
				MonstroLoadedGfx.initialize();

				_l("CoreStarter.update() -> initializeInjector()")
				initializeInjector();

				_l("CoreStarter.update() -> Initialize graphics")
				MonstroGfx.init();
				MonstroCursorManager.resetCursor();

				_l("CoreStarter.update() -> Initialize Achievement Manager")
				AchievementManager.init();
				AchievementManager.updateGeneral();

				_l("CoreStarter.update() -> Show first state")
				CF::isRelease{
					CF::drmFree{
						MonstroStateDrmFreeUpdateCheck.setState();
					}

					CF::steam{
						MonstroStateUpdateInfo.setState();
					}
				}

				CF::debug{
					MonstroStateDrmFreeUpdateCheck.setState();

//					MonstroStateImportProgress.show();
//					MonstroStateRetrocade.show();
//					MonstroStateUpdateInfo.setState();
//					MonstroStateTitle.show();

//					MonstroStateIntro.set();
//					MonstroStateOutro.show(EnumCampaignType.MONSTER_HARD);

//					MonstroStateUpdateInfo.setState();
//					MonstroStateIngame.show(EnumUnitFaction.MONSTER);
//					new MonstroEventLoadLevel(10, EnumCampaignType.MONSTER);

//					LevelSelectionWindow.show(EnumCampaignType.HUMAN, false);
//					MonstroWindowIntroductionCompleted.show();
//					MonstroWindowCredits.showWindow();
//					MonstroWindowHelp.showWindow();
//					MonstroWindowAchievements.showWindow(false);
				}

			}
		}

		private function initializeInjector():void {
			MonstroInjector.prepareClass(MonstroHud);
			MonstroInjector.prepareClass(MonstroBackgroundManager);
			MonstroInjector.prepareClass(MonstroIngameMusicManager);
			MonstroInjector.prepareClass(MonstroFieldRenderer);
			MonstroInjector.prepareClass(ProcessManager);
			MonstroInjector.prepareClass(MonstroLevelStats);
			MonstroInjector.prepareClass(MonstroHudStatsWindow);
			MonstroInjector.prepareClass(MonstroHudAttackResults);
			MonstroInjector.prepareClass(MonstroHudTurnsLeft);
			MonstroInjector.prepareClass(MonstroTutorialManager);
			MonstroInjector.mapValue(MonstroGameplayDefinition, MonstroGameplayDefinition.instance);
		}

		private function onError(error:Error):void {
			_e("RetrocamelCore error handler", error);
		}

		private function onUncaughtError(errorEvent:UncaughtErrorEvent):void {
			_e("Uncaught error handler", errorEvent.error);
		}
	}
}
