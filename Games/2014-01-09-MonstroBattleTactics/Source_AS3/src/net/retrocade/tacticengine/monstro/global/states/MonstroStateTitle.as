
package net.retrocade.tacticengine.monstro.global.states {
    CF::desktop {
	    import flash.desktop.NativeApplication;
    }

	import net.retrocade.constants.KeyConst;

	import net.retrocade.retrocamel.core.RetrocamelInputManager;
	import net.retrocade.retrocamel.core.RetrocamelWindowsManager;
	import net.retrocade.retrocamel.effects.RetrocamelEffectFadeScreen;
	import net.retrocade.tacticengine.core.Eventer;

    import net.retrocade.retrocamel.effects.RetrocamelEffectMusicFade;
    import net.retrocade.retrocamel.core.RetrocamelDisplayManager;
    import net.retrocade.retrocamel.core.RetrocamelSoundManager;
    import net.retrocade.retrocamel.components.RetrocamelStateBase;
    import net.retrocade.retrocamel.display.layers.RetrocamelLayerStarling;
    import net.retrocade.retrocamel.sound.RetrocamelSound;
    import net.retrocade.tacticengine.monstro.global.core.MonstroConsts;
    import net.retrocade.tacticengine.monstro.global.core.MonstroData;
    import net.retrocade.tacticengine.monstro.global.core.MonstroGfx;
    import net.retrocade.tacticengine.monstro.global.data.levels.MonstroMainGameLevels;
    import net.retrocade.tacticengine.monstro.global.core.MonstroSfx;
	import net.retrocade.tacticengine.monstro.global.oldProgressImporter.OldProgressImporter;
	import net.retrocade.tacticengine.monstro.global.states.titleScreen.MonstroTitleScreenVideoPlayer;
    import net.retrocade.tacticengine.monstro.global.states.titleScreen.MonstroTitleSubscreenMain;
    import net.retrocade.tacticengine.monstro.global.states.titleScreen.MonstroTitleSubscreenRoot;
    import net.retrocade.tacticengine.monstro.global.states.titleScreen.MonstroTitleSubscreenSelectCampaign;
    import net.retrocade.tacticengine.monstro.gui.render.MonstroBackground;
    import net.retrocade.tacticengine.monstro.gui.render.MonstroTextButton;
	import net.retrocade.tacticengine.monstro.gui.windows.MonstroWindowAchievements;
	import net.retrocade.tacticengine.monstro.gui.windows.MonstroWindowCredits;
    import net.retrocade.tacticengine.monstro.global.enum.EnumCampaignType;
    import net.retrocade.tacticengine.monstro.global.enum.EnumUnitFaction;
	import net.retrocade.tacticengine.monstro.gui.windows.MonstroWindowOptionsDisplay;
	import net.retrocade.tacticengine.monstro.gui.windows.MonstroWindowOptionsGameplay;
	import net.retrocade.tacticengine.monstro.gui.windows.MonstroWindowOptionsSound;
	import net.retrocade.tacticengine.monstro.ingame.achievements.AchievementManager;
    import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventLoadLevel;
	import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventPrepareLoadLevel;
	import net.retrocade.utils.UtilsNumber;

    import starling.display.Image;
    import starling.events.Touch;
    import starling.events.TouchEvent;
    import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.utils.HAlign;
	import starling.utils.VAlign;

	public class MonstroStateTitle extends RetrocamelStateBase {
        private static const STATE_DEFAULT:int = 0;
        private static const STATE_VIDEO_FADEOUT:int = 3;
        private static const STATE_FINISHED:int = 4;
        private static const STATE_FADEOUT:int = 5;
        private static const TARGET_ACTION_START_MISSION:int = 0;
        private static const TARGET_ACTION_LOAD_SAVE:int = 1;
        private static const TARGET_ACTION_PLAY_INTRO:int = 2;
        private static const TARGET_ACTION_QUIT:int = 3;

        public static function show():void {
            var instance:MonstroStateTitle = new MonstroStateTitle();

            AchievementManager.updateGeneral();

            instance.setToMe();
        }

        private var _layer:RetrocamelLayerStarling;
        private var _background:MonstroBackground;
        private var _modal:Image;
        private var _logo:Image;
        private var _colorOverlay:Image;
        private var _state:int = STATE_DEFAULT;
        private var _stateFactor:Number = 0;
        private var _currentMenu:MonstroTitleSubscreenRoot;
        private var _targetMenu:MonstroTitleSubscreenRoot;
        private var _music:RetrocamelSound;
        private var _targetAction:int;
        private var _missionToStart:int;
        private var _playerControls:EnumUnitFaction;
        private var _campaignType:EnumCampaignType;

		private var _versionNumber:TextField;

        private var _video:MonstroTitleScreenVideoPlayer;

        private var _videoIsFinished:Boolean = false;

        public function MonstroStateTitle() {
        }

        override public function create():void {
            _video = new MonstroTitleScreenVideoPlayer("video/monstroLogo.flv", onVideoFinished);

            _layer = new RetrocamelLayerStarling();

            _background = new MonstroBackground(MonstroGfx.getTitleScreenBackgroundTexture(), 1);
            _logo = MonstroGfx.getTitleScreenLogoImage();
            _modal = MonstroGfx.getBlackColor();
            _colorOverlay = new Image(Texture.fromColor(128, 128, 0xFFFFFFFF));
			_versionNumber = new TextField(100, 30, MonstroConsts.versionString, MonstroConsts.FONT_EBORACUM_48, 20, 0xFFFFFF);
			_versionNumber.hAlign = HAlign.RIGHT;
			_versionNumber.vAlign = VAlign.TOP;

			_music = MonstroSfx.getMusicTitleScreen();
			_music.registerAsMusic();

			_modal.alpha = 0.45;

            _colorOverlay.alpha = 0;

            _logo.visible = false;

            _layer.add(_background);
            _layer.add(_logo);
            _layer.add(_colorOverlay);
            _layer.add(_modal);
            _layer.add(_versionNumber);

            repositionLogo();

            _background.resize();
			_background.alpha = 0;

            _stateFactor = 1;

            _state = STATE_DEFAULT;

            MonstroSfx.playTitleGrowl();
            _music.play(9999);
            RetrocamelEffectMusicFade.make(1).fadeFrom(0).duration(2000).run();

            update();

			Eventer.listen(MonstroEventPrepareLoadLevel.NAME, levelStartHandler, this);
            RetrocamelDisplayManager.starlingStage.addEventListener(TouchEvent.TOUCH, onTouched);

			resize();
        }

		override public function destroy():void {
			RetrocamelDisplayManager.starlingStage.removeEventListener(TouchEvent.TOUCH, onTouched);
			Eventer.releaseContext(this);

			_background.dispose();
			_logo.dispose();
			_colorOverlay.dispose();
			_video.dispose();
			_music.dispose();
			_versionNumber.dispose();

			if (_currentMenu) {
				_currentMenu.dispose()
			}

			if (_targetMenu) {
				_targetMenu.dispose();
			}

			_layer.dispose();

			_background = null;
			_logo = null;
			_colorOverlay = null;
			_music = null;
			_currentMenu = null;
			_targetMenu = null;
			_layer = null;
			_video = null;
			_versionNumber = null;
		}

        private function onTouched(e:TouchEvent):void{
            var touch:Touch = e.getTouch(RetrocamelDisplayManager.starlingStage, TouchPhase.BEGAN);

            if (touch){
                switch(_state){
                    case(STATE_DEFAULT):
                        _video.endVideo();
                        _logo.alpha = 1;
                        break;

                    case(STATE_VIDEO_FADEOUT):
                        _stateFactor = 0;
                        _video.alpha = 0;
                        _logo.alpha = 1;
                        break;
                }
            }
        }

        public function onVideoFinished():void{
			if (_state < STATE_VIDEO_FADEOUT) {
				_videoIsFinished = true;
				_logo.visible = true;
				_state = STATE_VIDEO_FADEOUT;
			}
        }

        override public function update():void {
			if (RetrocamelInputManager.isKeyHit(KeyConst.F8) && OldProgressImporter.hasProgress()){
				OldProgressImporter.importProgress();
			}

            resizeLogo();

			if (_music.isPlaying && _music.volume < 1) {
				_music.volume += 0.02;
			}

            _background.x = -_video.x;
            _background.y = -_video.y;
            _background.resize();

			_modal.width = MonstroConsts.gameWidth;
			_modal.height = MonstroConsts.gameHeight;

            repositionLogo();
            scaleWhiteOverlay();

            if (_videoIsFinished){
				if (_video.alpha <= 0 && _background.alpha < 1){
					_background.alpha += 0.03;
				}

                if (_state == STATE_FINISHED){
                    updateInFinishedState();
                } else {
                    updateInitialAnimation();
                }
            }
        }


		override public function resize():void {
			if (_currentMenu) {
                _currentMenu.resized();
			}

			_versionNumber.right = MonstroConsts.gameWidth;
		}

		private function updateInitialAnimation():void{
            switch (_state) {
                case(STATE_VIDEO_FADEOUT):
                    _video.alpha = UtilsNumber.approach(_video.alpha, 0, 0.14 , 0.001, 0.05);

                    if (_video.alpha > 0){
                        return;
                    }

					ASSERT(!_currentMenu);
					_currentMenu = getMenu(new MonstroTitleSubscreenMain(true));
					_state = STATE_FINISHED;
                    break;

                case(STATE_FADEOUT):
                    if (_currentMenu) {
                        _currentMenu.resized();
                    }

                    _colorOverlay.color = 0;
                    _colorOverlay.alpha += 0.025;
                    _colorOverlay.visible = true;
                    _colorOverlay.moveToFront();

                    if (_colorOverlay.alpha >= 1 && !_music.isPlaying) {
                        onFadeOutFinished();
                    }
                    break;
            }
        }

        private function onFadeOutFinished():void {
			RetrocamelWindowsManager.clearWindows();

            switch (_targetAction) {
                case(TARGET_ACTION_START_MISSION):
                    MonstroStateIngame.show(_playerControls);
                    new MonstroEventLoadLevel(_missionToStart, _campaignType);
                    break;

                case(TARGET_ACTION_LOAD_SAVE):
                    MonstroStateIngame.show(
                        MonstroMainGameLevels.getPlayerFactionByLevel(MonstroData.getSaveStateLevelType())
                    );
                    new MonstroEventLoadLevel(
                        MonstroData.getSaveStateLevelIndex(),
                        MonstroData.getSaveStateLevelType(),
                        MonstroData.getSaveState()
                    );
                    break;

                case(TARGET_ACTION_PLAY_INTRO):
                    MonstroStateIntro.set();
                    break;

                case(TARGET_ACTION_QUIT):
                    CF::desktop {
                        NativeApplication.nativeApplication.exit();
                    }
                    break;
            }
        }

        private function getMenu(menuClassOrInstance:*):MonstroTitleSubscreenRoot {
            var instance:*;

            if (menuClassOrInstance is Class) {
                instance = new menuClassOrInstance();

                if (!(instance is MonstroTitleSubscreenRoot)) {
                    throw new ArgumentError("Given class does not extend MonstroTitleSubscreenRoot");
                }
            } else {
                instance = menuClassOrInstance;
            }

            var root:MonstroTitleSubscreenRoot = instance as MonstroTitleSubscreenRoot;

            root.callback = buttonCallback;
            root.resized();

            _layer.add(root);

            return root;
        }

        private function updateInFinishedState():void {
			_currentMenu.update();

            if (_targetMenu) {
				_targetMenu.update();

				if (_currentMenu.isFullyHidden){
                    _layer.remove(_currentMenu);
                    _currentMenu.dispose();
                    _currentMenu = _targetMenu;
                    _targetMenu = null;
                }
            } else if (_currentMenu.isFullyHidden && RetrocamelWindowsManager.numWindows === 0){
				_currentMenu.show();
			}
        }

        private function buttonCallback(button:MonstroTextButton):void {
            if (_targetMenu || _currentMenu.alpha < 0 || _state != STATE_FINISHED) {
                return;
            }

            switch (button.data.type) {
                case(MonstroTitleSubscreenMain.START_GAME):
                    if (MonstroData.getSawIntro(false)){
                        _targetMenu = getMenu(MonstroTitleSubscreenSelectCampaign);
                    } else {
                        RetrocamelEffectMusicFade.make(0).fadeFrom(1).duration(1000).callback(onMusicFadedOut).run();
                        _targetAction = TARGET_ACTION_PLAY_INTRO;
                        _state = STATE_FADEOUT;
                    }
                    break;

                case(MonstroTitleSubscreenMain.WATCH_INTRO):
                    RetrocamelEffectMusicFade.make(0).fadeFrom(1).duration(1000).callback(onMusicFadedOut).run();
                    _targetAction = TARGET_ACTION_PLAY_INTRO;
                    _state = STATE_FADEOUT;
                    break;

                case(MonstroTitleSubscreenMain.CREDITS):
                    MonstroWindowCredits.showWindow().onClosing.add(_currentMenu.show);
                    break;

                case(MonstroTitleSubscreenMain.QUIT):
                    RetrocamelEffectMusicFade.make(0).fadeFrom(1).duration(1000).callback(onMusicFadedOut).run();
                    _targetAction = TARGET_ACTION_QUIT;
                    _state = STATE_FADEOUT;
                    break;

                case(MonstroTitleSubscreenMain.OPTIONS_SOUND):
                    MonstroWindowOptionsSound.show(false).onClosing.add(_currentMenu.show);
                    break;

                case(MonstroTitleSubscreenMain.OPTIONS_GAMEPLAY):
                    MonstroWindowOptionsGameplay.show(false).onClosing.add(_currentMenu.show);
                    break;

                case(MonstroTitleSubscreenMain.OPTIONS_DISPLAY):
                    MonstroWindowOptionsDisplay.show(false).onClosing.add(_currentMenu.show);
                    break;

                case(MonstroTitleSubscreenMain.ACHIEVEMENTS):
                    MonstroWindowAchievements.showWindow(false).onClosing.add(_currentMenu.show);
                    break;

                case(MonstroTitleSubscreenSelectCampaign.BACK_TO_MAIN_MENU):
                    _targetMenu = getMenu(MonstroTitleSubscreenMain);
                    break;

                case(MonstroTitleSubscreenSelectCampaign.CONTINUE_SAVE):
                    RetrocamelEffectMusicFade.make(0).fadeFrom(1).duration(1000).callback(onMusicFadedOut).run();
                    _targetAction = TARGET_ACTION_LOAD_SAVE;
                    _state = STATE_FADEOUT;
                    break;
            }
        }

        private function onMusicFadedOut():void{
            if (_music){
                _music.stop();
            }
            RetrocamelSoundManager.resetMusicFadeVolume();
        }

        private function scaleWhiteOverlay():void {
            _colorOverlay.width = MonstroConsts.gameWidth;
            _colorOverlay.height = MonstroConsts.gameHeight;
        }

        private function repositionLogo():void {
            const MAGIC_FACTOR_X:Number = 0.505;
            const MAGIC_FACTOR_Y:Number = 0.48;

			_logo.center = MonstroConsts.gameWidth * MAGIC_FACTOR_X;
			_logo.middle = MonstroConsts.gameHeight * MAGIC_FACTOR_Y;
        }

        private function resizeLogo():void {
			var videoWidth:Number = _video.width;

			_logo.width = videoWidth * (739 / 1016);
			_logo.scaleY = _logo.scaleX;
        }

		private function levelStartHandler(event:MonstroEventPrepareLoadLevel):void{
			switch(event.campaignType){
				case(EnumCampaignType.INTRODUCTION):
					_playerControls = EnumUnitFaction.HUMAN;
					break;
				case(EnumCampaignType.HUMAN):
					_playerControls = EnumUnitFaction.HUMAN;
					break;
				case(EnumCampaignType.HUMAN_HARD):
					_playerControls = EnumUnitFaction.HUMAN;
					break;
				case(EnumCampaignType.MONSTER):
					_playerControls = EnumUnitFaction.MONSTER;
					break;
				case(EnumCampaignType.MONSTER_HARD):
					_playerControls = EnumUnitFaction.MONSTER;
					break;
			}

			_targetAction = TARGET_ACTION_START_MISSION;
			_campaignType = event.campaignType;
			_missionToStart = event.levelIndex;

			RetrocamelEffectFadeScreen.makeOut().duration(1000).callback(onFadeOutFinished).run();
			RetrocamelEffectMusicFade.make(0).fadeFrom(1).duration(1000).callback(onMusicFadedOut).run();
		}
    }
}