package submuncher.ingame.core {
    import flash.utils.setInterval;
    import flash.utils.setTimeout;

    import net.retrocade.constants.KeyConst;
    import net.retrocade.retrocamel.core.RetrocamelInputManager;

    import submuncher.core.GlobalEvents;
    import submuncher.core.repositories.CustomLevelMetadata;
    import submuncher.core.repositories.LevelGroupsRepository;
    import submuncher.core.repositories.LevelMetadata;
    import submuncher.core.repositories.LevelRepository;
    import submuncher.core.save.Save;
    import submuncher.core.save.SaveLevelProgress;
    import submuncher.core.save.SaveLoader;
    import submuncher.ingame.ghost.GhostDataRecorder;
    import submuncher.ingame.levelFactory.LevelLoader;
    import submuncher.ingame.renderers.core.LevelFrontend;
    import submuncher.ingame.renderers.general.hud.HudLayer;
    import submuncher.ingame.vfx.EffectPlayerLeaveLevel;
    import submuncher.ingame.vfx.IEffect;
    import submuncher.ingame.windows.levels.LevelCompletedWindow;
    import submuncher.ingame.windows.levels.PauseWindow;

    public class Game {
        private var _extSave:Save;
        private var _isInitialized:Boolean = false;
        private var _hud:HudLayer;
        private var _currentLevel:Level;
        private var _restartLevel:Boolean;

        public function get currentLevel():Level {
            return _currentLevel;
        }

        private var _frontend:LevelFrontend;

        public function get frontend():LevelFrontend {
            return _frontend;
        }

        private var _ghostDataRecorder:GhostDataRecorder;

        private var _gameCommunication:GameCommunication;

        public function get gameCommunication():GameCommunication {
            return _gameCommunication;
        }

        public function Game(save:Save) {
            _extSave = save;
            _gameCommunication = new GameCommunication();
            _frontend = new LevelFrontend(this);
            _ghostDataRecorder = new GhostDataRecorder(this);
            _restartLevel = false;

            GlobalEvents.onStageResized.add(_gameCommunication.onStageResized.call);
            _gameCommunication.onEffectCreated.add(effectCreatedHandler);
            _gameCommunication.onEffectRemoved.add(effectRemovedHandler);
            _gameCommunication.onLevelCompleted.add(levelCompletedHandler);
        }

        public function dispose():void {
            GlobalEvents.onStageResized.remove(_gameCommunication.onStageResized.call);

            _ghostDataRecorder.dispose();
            _ghostDataRecorder = null;

            _gameCommunication.dispose();

            if (_isInitialized) {
                _frontend.dispose();
                _currentLevel.dispose();

                _frontend = null;
                _currentLevel = null;
            }
        }

        private var _hooked:Boolean = false;

        public function startLevel(levelMetadata:LevelMetadata):void {
            if (levelMetadata.isCustom && !_hooked) {
                _hooked = true;
                var c:CustomLevelMetadata = levelMetadata as CustomLevelMetadata;
                setInterval(function ():void {
                    if (c.file.exists && c.fileLastModified !== c.file.modificationDate.time) {
                        setTimeout(startLevel, 10, levelMetadata);
                    }
                }, 100);
            }
            loadLevel(LevelLoader.loadLevel(levelMetadata, this));
        }

        public function startCustomLevel(level:Level):void{
            loadLevel(level);
        }

        private function loadLevel(level:Level):void {
            disposeCurrentLevel();

            gameCommunication.afterLevelLoaded.call(level);

            _isInitialized = true;
            _currentLevel = level;
            _frontend.switchLevel(level);
            _hud = new HudLayer(this);

            _gameCommunication.onLevelLoaded.call(level);
        }

        public function update():void {
            _isInitialized = false;
            if (!_frontend.isGameBlocked) {
                _currentLevel.update();
            }
            if (_currentLevel.isLevelStarted) {
                if (!_currentLevel.isLevelCompleted) {
                    _currentLevel.score.increaseTime();
                }
                _ghostDataRecorder.update();
            }
            _frontend.update();

            _hud.update();


            if (RetrocamelInputManager.isKeyHit(KeyConst.R)) {
                restartLevel();

            } else if (RetrocamelInputManager.isKeyHit(KeyConst.TAB)) {
                PauseWindow.showWindow(this);
                //                LevelSelectionWindow.showWindow(this, LevelGroupsRepository.getGroupByLevel(_currentLevel.metadata), _extSave);
            } else if (RetrocamelInputManager.isKeyHit(KeyConst.F9)) {
                startLevel(LevelRepository.getFirstTextLevel());
            }

            if (_restartLevel) {
                restartExecute();
            }
        }

        public function restartLevel():void {
            _restartLevel = true;
        }

        private function restartExecute():void {
            _restartLevel = false;
            _gameCommunication.onLevelFailed.call(_currentLevel);
            startLevel(currentLevelMetadata);
        }

        private function disposeCurrentLevel():void {
            if (_hud) {
                _hud.dispose();
            }

            if (_currentLevel) {
                _currentLevel.dispose();
            }

            _currentLevel = null;
        }

        private function effectCreatedHandler(effect:IEffect):void {
        }

        private function effectRemovedHandler(effect:IEffect):void {
            if (effect is EffectPlayerLeaveLevel) {
                if (_currentLevel.metadata.isCustom) {
                    _restartLevel = true;
                } else {
                    LevelCompletedWindow.showWindow(this, LevelGroupsRepository.getEntryByLevel(_currentLevel.metadata), _currentLevel.metadata, _currentLevel.score, _extSave);
                }
            }
        }

        private function levelCompletedHandler():void {
            var progress:SaveLevelProgress = _extSave.progress.getLevelProgressByLevelId(_currentLevel.metadata.id);

            if (progress.importFromScore(_currentLevel.score)) {
                SaveLoader.storeInFile(_extSave);
            }
        }

        public function get currentLevelMetadata():LevelMetadata {
            return _currentLevel.metadata;
        }

        public function get save():Save {
            return _extSave;
        }

        public function get hud():HudLayer {
            return _hud;
        }
    }
}
