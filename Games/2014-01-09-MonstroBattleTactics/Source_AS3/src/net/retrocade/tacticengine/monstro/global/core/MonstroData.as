
package net.retrocade.tacticengine.monstro.global.core {
	CF::desktop {
		import flash.filesystem.File;
		import flash.display.NativeWindow;
		import flash.desktop.NativeApplication;
		import flash.display.Screen;
	}
	import flash.geom.Rectangle;

	import net.retrocade.functions.printf;
	import net.retrocade.retrocamel.core.RetrocamelDisplayManager;
	import net.retrocade.retrocamel.core.RetrocamelSoundManager;
	import net.retrocade.storage.IStorage;
	import net.retrocade.storage.StorageFastHash;
	import net.retrocade.storage.StorageIOHandlerToFile;
	import net.retrocade.tacticengine.monstro.global.data.levels.MonstroMainGameLevels;
    import net.retrocade.tacticengine.monstro.global.enum.EnumCampaignType;
    import net.retrocade.tacticengine.monstro.global.enum.EnumUnitFaction;
	import net.retrocade.tacticengine.monstro.global.core.MonstroFile;

	public class MonstroData {
		private static const FILE_NAME:String = "monstro_save.sav";
		private static const CRYPTO_KEY:String = "4yZN2N7sd2x7i3XAcBqmq5lY";
		private static const SALT:String = "p2xp45Z0q7n8NWlQKMzqG1R3";
		private static const SCRAMBLE_KEY:int = 634937;

		private static const STORAGE_NAME_MUSIC:String = "musicVolume";
		private static const STORAGE_NAME_MUSIC_ENABLED:String = "musicEnabled";
		private static const STORAGE_NAME_SFX:String = "sfxVolumne";
		private static const STORAGE_NAME_SFX_ENABLED:String = "sfxEnabled";
		private static const STORAGE_NAME_VOICES:String = "voicesVolumne";
		private static const STORAGE_NAME_VOICES_ENABLED:String = "voicesEnabled";
		private static const STORAGE_NAME_GAME_SPEED:String = "gameSpeed";
		private static const STORAGE_NAME_WAIT_FOR_CONFIRMATION:String = "waitForConfirm";
		private static const STORAGE_NAME_SCROLL_BEFORE_UNIT_MOVE:String = "scrollBeforeMove";
		private static const STORAGE_NAME_SAVE_STATE:String = "saveState";
		private static const STORAGE_NAME_SAVE_STATE_LEVEL_INDEX:String = "saveStateLevelIndex";
		private static const STORAGE_NAME_SAVE_STATE_LEVEL_TYPE:String = "saveStateLevelType";
		private static const STORAGE_NAME_TUTORIAL_COMPLETION_PREFIX:String = "tutorialProgress_";
		private static const STORAGE_NAME_TUTORIAL_DATA_PREFIX:String = "tutorialData_";
		private static const STORAGE_NAME_ZOOM_LEVEL:String = "zoomLevel";
		private static const STORAGE_NAME_SAW_INTRO:String = "sawIntro";
		private static const STORAGE_NAME_CAMPAIGN_COMPLETED_PREFIX:String = "campaignCompleted_";
		private static const STORAGE_NAME_SHOW_LIGHTS:String = "showLights";
		private static const STORAGE_NAME_SHOW_SHADOWS:String = "showShadows";
		private static const STORAGE_NAME_DARKNESS_LEVEL:String = "darknessLevel";
		private static const STORAGE_NAME_IS_FULLSCREEN:String = "isFullscreen";
		private static const STORAGE_NAME_WINDOW_WIDTH:String = "windowWidth";
		private static const STORAGE_NAME_WINDOW_HEIGHT:String = "windowHeight";
		private static const STORAGE_NAME_WINDOW_MAXIMIZED:String = "windowMaximized";
		private static const STORAGE_NAME_ACHIEVEMENT_COMPLETED:String = "achievement_";
		private static const STORAGE_NAME_IS_DRAG_CONTROLS:String = "isDragControls";
		private static const STORAGE_NAME_LAST_UPDATE_SEEN:String = "lastUpdateSeen";

		public static var playerUnitType:EnumUnitFaction;

		private static var _storage:IStorage;
		private static var _isInitialized:Boolean = false;

		public static function get isInitialized():Boolean {
			return _isInitialized;
		}

		public static function init():void {
			_storage = new StorageFastHash(new StorageIOHandlerToFile(getSaveFile(), CRYPTO_KEY, SCRAMBLE_KEY), CRYPTO_KEY, SALT, SCRAMBLE_KEY);

			_isInitialized = true;
		}

		public static function applySettings():void {
			RetrocamelSoundManager.musicVolume = getMusicVolume();
			RetrocamelSoundManager.soundVolume = getSfxVolume();
			RetrocamelSoundManager.suppressMusic = !getMusicEnabled();
			RetrocamelSoundManager.suppressSounds = !getSoundEnabled();

			CF::desktop {
				var activeWindow:NativeWindow = NativeApplication.nativeApplication.activeWindow;
				var screen:Screen = Screen.getScreensForRectangle(activeWindow.bounds)[0];
				var screenBounds:Rectangle = screen.bounds;

				activeWindow.bounds = new Rectangle(
					screenBounds.x + (screenBounds.width - getWindowWidth()) / 2,
					screenBounds.y + (screenBounds.height - getWindowHeight()) / 2,
					getWindowWidth(),
					getWindowHeight()
				);

				if (getWindowMaximized()){
					activeWindow.maximize()
				}
			}

			RetrocamelDisplayManager.isFullscreen = getIsFullscreen();
		}

		public static function getSaveFile():MonstroFile {
			_l("MonstroData.getSaveFile()")
			CF::desktop {
				//noinspection JSUnusedAssignment
				var fileName:String = FILE_NAME;

				CF::debug{
					fileName = "debug_" + FILE_NAME;
				}

				if (CF::steam){
					var file: File = File.applicationDirectory.resolvePath("save/" + fileName)
					_l("MonstroData.getSaveFile() -> " + file.nativePath);
					return new MonstroFile(file.nativePath);

				} else if (CF::drmFree){
					var file: File = File.applicationStorageDirectory.resolvePath("save/" + fileName)
					_l("MonstroData.getSaveFile() -> " + file.nativePath);
					return new MonstroFile(file.nativePath);

				} else {
					throw new Error("Incorrect compilation constants");
				}
			}
			CF::flash {
				return new MonstroFile("flash-" + FILE_NAME);
			}
		}

		public static function setGameSpeed(value:Number, autoCommit:Boolean = false):void {
			_storage.writeNumber(STORAGE_NAME_GAME_SPEED, value);

			if (autoCommit) {
				_storage.save();
			}
		}

		public static function getGameSpeed():Number {
			return _storage.readNumber(STORAGE_NAME_GAME_SPEED, 0.091);
		}

		public static function isLevelCompleted(levelIndex:int, campaignType:EnumCampaignType):Boolean {
			return _storage.readFlag(storageNameLevelCompletion(levelIndex, campaignType.id), false);
		}

		public static function countCompletedLevels():uint {
			var campaignTypes:Vector.<EnumCampaignType> = new <EnumCampaignType>[
				EnumCampaignType.HUMAN,
				EnumCampaignType.HUMAN_HARD,
				EnumCampaignType.MONSTER,
				EnumCampaignType.MONSTER_HARD
			];

			var completedLevels:uint = 0;
			for each(var campaignType:EnumCampaignType in campaignTypes) {
				for (var i:int = 0; i < MonstroMainGameLevels.getLevelCount(); i++) {
					if (isLevelCompleted(i, campaignType)) {
						completedLevels++;
					}
				}
			}

			return completedLevels;
		}

		public static function countCompletedLevelsInCampaign(campaignType:EnumCampaignType):uint {
			var completedLevels:uint = 0;
			for (var i:int = 0; i < MonstroMainGameLevels.getLevelCount(); i++) {
				if (isLevelCompleted(i, campaignType)) {
					completedLevels++;
				}
			}

			return completedLevels;
		}

		public static function setLevelCompleted(levelIndex:int, campaignType:EnumCampaignType, autoCommit:Boolean = true):void {
			_storage.writeFlag(storageNameLevelCompletion(levelIndex, campaignType.id), true);

			if (autoCommit) {
				_storage.save();
			}
		}

		public static function setMusicVolume(value:Number, autoCommit:Boolean = false):void {
			_storage.writeNumber(STORAGE_NAME_MUSIC, value);
			if (autoCommit) {
				_storage.save();
			}
		}

		public static function getMusicVolume():Number {
			return _storage.readNumber(STORAGE_NAME_MUSIC, 0.5);
		}

		public static function setMusicEnabled(value:Boolean, autoCommit:Boolean = false):void {
			_storage.writeFlag(STORAGE_NAME_MUSIC_ENABLED, value);
			if (autoCommit) {
				_storage.save();
			}
		}

		public static function getMusicEnabled():Boolean {
			return _storage.readFlag(STORAGE_NAME_MUSIC_ENABLED, true);
		}

		public static function setSoundEnabled(value:Boolean, autoCommit:Boolean = false):void {
			_storage.writeFlag(STORAGE_NAME_SFX_ENABLED, value);
			if (autoCommit) {
				_storage.save();
			}
		}

		public static function getSoundEnabled():Boolean {
			return _storage.readFlag(STORAGE_NAME_SFX_ENABLED, true);
		}

		public static function setSfxVolume(value:Number, autoCommit:Boolean = false):void {
			_storage.writeNumber(STORAGE_NAME_SFX, value);
			if (autoCommit) {
				_storage.save();
			}
		}

		public static function getSfxVolume():Number {
			return _storage.readNumber(STORAGE_NAME_SFX, 1);
		}

		public static function setVoicesEnabled(value:Boolean, autoCommit:Boolean = false):void {
			_storage.writeFlag(STORAGE_NAME_VOICES_ENABLED, value);
			if (autoCommit) {
				_storage.save();
			}
		}

		public static function getVoicesEnabled():Boolean {
			return _storage.readFlag(STORAGE_NAME_VOICES_ENABLED, true);
		}

		public static function setVoicesVolume(value:Number, autoCommit:Boolean = false):void {
			_storage.writeNumber(STORAGE_NAME_VOICES, value);
			if (autoCommit) {
				_storage.save();
			}
		}

		public static function getVoicesVolume():Number {
			return _storage.readNumber(STORAGE_NAME_VOICES, 1);
		}

		public static function setShowLights(value:Boolean, autoCommit:Boolean = false):void {
			_storage.writeFlag(STORAGE_NAME_SHOW_LIGHTS, value);
			if (autoCommit) {
				_storage.save();
			}
		}

		public static function getShowLights():Boolean {
			return _storage.readFlag(STORAGE_NAME_SHOW_LIGHTS, true);
		}

		public static function setShowShadows(value:Boolean, autoCommit:Boolean = false):void {
			_storage.writeFlag(STORAGE_NAME_SHOW_SHADOWS, value);
			if (autoCommit) {
				_storage.save();
			}
		}

		public static function getShowShadows():Boolean {
			return _storage.readFlag(STORAGE_NAME_SHOW_SHADOWS, true);
		}

		public static function setDarknessLevel(value:Number, autoCommit:Boolean = false):void {
			_storage.writeNumber(STORAGE_NAME_DARKNESS_LEVEL, value);

			if (autoCommit) {
				_storage.save();
			}
		}

		public static function getDarknessLevel():Number {
			return _storage.readNumber(STORAGE_NAME_DARKNESS_LEVEL, 0.9);
		}

		public static function commitData():void {
			_storage.save();
		}

		public static function getCenterBeforeUnitMove():Boolean {
			return _storage.readFlag(STORAGE_NAME_SCROLL_BEFORE_UNIT_MOVE, false);
		}

		public static function setCenterBeforeUnitMove(value:Boolean):void {
			_storage.writeFlag(STORAGE_NAME_SCROLL_BEFORE_UNIT_MOVE, value);
		}

		public static function getWaitForConfirmation():Boolean {
			return _storage.readFlag(STORAGE_NAME_WAIT_FOR_CONFIRMATION, false);
		}

		public static function setWaitForConfirmation(value:Boolean):void {
			_storage.writeFlag(STORAGE_NAME_WAIT_FOR_CONFIRMATION, value);
		}

		public static function setSaveState(save:String, levelIndex:int, campaignType:EnumCampaignType):void {
			_storage.writeString(STORAGE_NAME_SAVE_STATE, save);
			_storage.writeNumber(STORAGE_NAME_SAVE_STATE_LEVEL_INDEX, levelIndex);
			_storage.writeNumber(STORAGE_NAME_SAVE_STATE_LEVEL_TYPE, campaignType.id);
		}

		public static function getSaveState():String {
			return _storage.readString(STORAGE_NAME_SAVE_STATE, null);
		}

		public static function hasSaveState():Boolean {
			return _storage.has(STORAGE_NAME_SAVE_STATE);
		}

		public static function getSaveStateLevelIndex():int {
			return _storage.readNumber(STORAGE_NAME_SAVE_STATE_LEVEL_INDEX, 0);
		}

		public static function getSaveStateLevelType():EnumCampaignType {
			return EnumCampaignType.byId(
				_storage.readNumber(
					STORAGE_NAME_SAVE_STATE_LEVEL_TYPE,
					EnumCampaignType.HUMAN.id
				)
			);
		}

		public static function setTutorialData(tutorialStep:int, data:Object):void {
			_storage.writeObject(STORAGE_NAME_TUTORIAL_DATA_PREFIX + tutorialStep, data);
		}

		public static function getTutorialData(tutorialStep:int):Object {
			return _storage.readObject(STORAGE_NAME_TUTORIAL_DATA_PREFIX + tutorialStep, []);
		}

		public static function setTutorialCompletion(tutorialStep:int, isCompleted:Boolean):void {
			_storage.writeFlag(STORAGE_NAME_TUTORIAL_COMPLETION_PREFIX + tutorialStep, isCompleted);
		}

		public static function getTutorialCompletion(tutorialStep:int):Boolean {
			return _storage.readFlag(STORAGE_NAME_TUTORIAL_COMPLETION_PREFIX + tutorialStep, false);
		}

		public static function setZoomLevel(value:int):void {
			_storage.writeNumber(STORAGE_NAME_ZOOM_LEVEL, value);
			_storage.save();
		}

		public static function getZoomLevel(defaultValue:int):int {
			return _storage.readNumber(STORAGE_NAME_ZOOM_LEVEL, defaultValue);
		}

		public static function setSawIntro(value:Boolean):void {
			_storage.writeFlag(STORAGE_NAME_SAW_INTRO, value);
			_storage.save();
		}

		public static function getSawIntro(defaultValue:Boolean):Boolean {
			return _storage.readFlag(STORAGE_NAME_SAW_INTRO, defaultValue);
		}

		public static function getCampaignCompleted(campaign:EnumCampaignType):Boolean {
			return _storage.readFlag(STORAGE_NAME_CAMPAIGN_COMPLETED_PREFIX + campaign.name, false);
		}

		public static function setCampaignCompleted(campaign:EnumCampaignType, value:Boolean):void {
			_storage.writeFlag(STORAGE_NAME_CAMPAIGN_COMPLETED_PREFIX + campaign.name, value);
			_storage.save();
		}

		public static function getIsFullscreen():Boolean {
			return _storage.readFlag(STORAGE_NAME_IS_FULLSCREEN, true);
		}

		public static function setIsFullscreen(value:Boolean):void {
			_storage.writeFlag(STORAGE_NAME_IS_FULLSCREEN, value);
			_storage.save();
		}

		public static function getWindowWidth():uint {
			return Math.max(1024, _storage.readNumber(STORAGE_NAME_WINDOW_WIDTH, 1024));
		}

		public static function setWindowWidth(value:uint):void {
			_storage.writeNumber(STORAGE_NAME_WINDOW_WIDTH, value);
			_storage.save();
		}

		public static function getWindowHeight():uint {
			return Math.max(768, _storage.readNumber(STORAGE_NAME_WINDOW_HEIGHT, 768));
		}

		public static function setWindowHeight(value:uint):void {
			_storage.writeNumber(STORAGE_NAME_WINDOW_HEIGHT, value);
			_storage.save();
		}

		public static function getWindowMaximized():Boolean{
			return _storage.readFlag(STORAGE_NAME_WINDOW_MAXIMIZED, false);
		}

		public static function setWindowMaximized(value:Boolean):void {
			_storage.writeFlag(STORAGE_NAME_WINDOW_MAXIMIZED, value);
			_storage.save();
		}

		public static function setAchievementCompleted(achievementId:String, value: Boolean = true):void {
			_storage.writeFlag(STORAGE_NAME_ACHIEVEMENT_COMPLETED + achievementId, value);
			_storage.save();
		}

		public static function getAchievementCompleted(achievementId:String):Boolean {
			return _storage.readFlag(STORAGE_NAME_ACHIEVEMENT_COMPLETED + achievementId, false);
		}

		private static function storageNameLevelCompletion(index:int, levelType:int):String {
			return printf("level_%%_%%", index, levelType);
		}

		public static function setIsDragControls(value:Boolean):void {
			_storage.writeFlag(STORAGE_NAME_IS_DRAG_CONTROLS, value);
		}

		public static function getIsDragControls():Boolean {
			return _storage.readFlag(STORAGE_NAME_IS_DRAG_CONTROLS, false);
		}

		public static function setLastUpdateSeen(value:String):void {
			_storage.writeString(STORAGE_NAME_LAST_UPDATE_SEEN, value);
		}

		public static function getLastUpdateSeen():String {
			return _storage.readString(STORAGE_NAME_LAST_UPDATE_SEEN, "");
		}
	}
}
