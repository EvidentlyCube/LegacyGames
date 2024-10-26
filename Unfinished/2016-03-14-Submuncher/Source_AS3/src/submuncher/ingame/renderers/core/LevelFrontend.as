package submuncher.ingame.renderers.core {
    import net.retrocade.utils.UtilsNumber;

    import submuncher.core.constants.GameObjectIndexes;
    import S;
    import submuncher.ingame.core.Game;
    import submuncher.ingame.core.GameCommunication;
    import submuncher.ingame.core.Level;
    import submuncher.ingame.renderers.filters.SineFilter;
    import submuncher.ingame.renderers.gameObjects.GameObjectRendererBase;
    import submuncher.ingame.renderers.helpers.CameraPositionManager;
    import submuncher.ingame.vfx.IEffect;

    public class LevelFrontend {
        private var _extGame:Game;
        private var _extLevel:Level;
        private var _levelWidthPx:Number;
        private var _levelHeightPx:Number;

        private var _cameraPositionManager:CameraPositionManager;

        private var _layers:LevelFrontendLayersCollection;
        private var _displayObjects:LevelFrontendDisplayObjectsCollection;
        private var _soundManager:LevelFrontendSoundManager;
        private var _renderer:LevelFrontendRenderer;
        private var _interactionManager:LevelFrontendInteractionManager;

        private var _sineFilter:SineFilter;

        public function LevelFrontend(game:Game) {
            _extGame = game;

            initCreateInstances();
            initSetProperties();
        }

        private function initCreateInstances():void {
            _layers = new LevelFrontendLayersCollection(this);
            _displayObjects = new LevelFrontendDisplayObjectsCollection(this);
            _interactionManager = new LevelFrontendInteractionManager(this);
            _renderer = new LevelFrontendRenderer(this);
            _soundManager = new LevelFrontendSoundManager(_extGame);

            _cameraPositionManager = new CameraPositionManager(_extGame);

            _sineFilter = new SineFilter(3, 60);
            _sineFilter.isHorizontal = false;
            _layers.background.layer.filter = _sineFilter;
        }

        private function initSetProperties():void {
            _layers.background.add(_displayObjects.backgroundRenderer);
            _layers.background.add(_displayObjects.tilemapBackground);
            _layers.tilemap.add(_displayObjects.tilemapForeground);
            _layers.tilemap.add(_displayObjects.tilemapForegroundVariant);
            _layers.edgeCover.add(_displayObjects.edgeCover);
            _cameraPositionManager.setDisplayObjects(
                    _displayObjects.tilemapBackground,
                    _displayObjects.tilemapForeground,
                    _displayObjects.tilemapForegroundVariant,
                    _layers.gameObjects.layer,
                    _layers.effects.layer,
                    _displayObjects.edgeCover
            );

            _levelWidthPx = S.tileEdge;
            _levelHeightPx = S.tileEdge;

            _extGame.gameCommunication.onStageResized.add(stageResizedHandler);
        }

        public function dispose():void {
            _extGame.gameCommunication.onStageResized.remove(stageResizedHandler);

            _sineFilter.dispose();
            _layers.dispose();
            _displayObjects.dispose();
            _interactionManager.dispose();
            _renderer.dispose();
            _soundManager.dispose();
            _cameraPositionManager.dispose();

            _sineFilter = null;
            _layers = null;
            _displayObjects = null;
            _interactionManager = null;
            _renderer = null;
            _soundManager = null;
            _cameraPositionManager = null;
        }

        public function switchLevel(level:Level):void {
            cleanupBeforeNextLevel();

            _extLevel = level;

            _levelWidthPx = _extLevel.tileWidth * S.tileEdge;
            _levelHeightPx = _extLevel.tileHeight * S.tileEdge;

            _displayObjects.tilemapBackground.setForLevel(_extLevel.tileWidth, _extLevel.tileHeight, 10, 10);
            _displayObjects.tilemapForeground.setForLevel(_extLevel.tileWidth, _extLevel.tileHeight, 10, 10);
            _displayObjects.tilemapForegroundVariant.setForLevel(_extLevel.tileWidth, _extLevel.tileHeight, 10, 10);

            _renderer.renderLevel();

            _cameraPositionManager.setLevel(_extLevel);
        }

        private function cleanupBeforeNextLevel():void {
            if (_extLevel) {
                _displayObjects.cleanupBeforeNextLevel();
            }
        }

        public function update():void {
            _sineFilter.ticker += 0.0006;
            _displayObjects.update();
            _renderer.update();
        }

        public function centerDisplayOn(x:Number, y:Number):void {
            _cameraPositionManager.setCenter(x, y);
        }

        public function setOffset(x:Number, y:Number):void {
            _displayObjects.tilemapBackground.x = x;
            _displayObjects.tilemapBackground.y = y;
            _displayObjects.tilemapForeground.x = x;
            _displayObjects.tilemapForeground.y = y;
            _displayObjects.tilemapForegroundVariant.x = x;
            _displayObjects.tilemapForegroundVariant.y = y;
            _layers.gameObjects.layer.x = x;
            _layers.gameObjects.layer.y = y;
            _layers.effects.layer.x = x;
            _layers.effects.layer.y = y;
            _displayObjects.edgeCover.x = x;
            _displayObjects.edgeCover.y = y;
        }

        public function get isGameBlocked():Boolean {
            for each (var effect:IEffect in _displayObjects.effectsGroup.getAllOriginal()) {
                if (effect.blocksGameplay) {
                    return true;
                }
            }

            return false;
        }


        private function stageResizedHandler():void {
            _displayObjects.tilemapBackground.refreshVisiblity();
            _displayObjects.tilemapForeground.refreshVisiblity();
            _displayObjects.tilemapForegroundVariant.refreshVisiblity();
//            _backgroundRenderer.width = _levelWidthPx;
//            _backgroundRenderer.height = _levelHeightPx;
        }

        public function get isLevelStarted():Boolean {
            return _extLevel.isLevelStarted;
        }

        public function get gameCommunication():GameCommunication {
            return _extGame.gameCommunication;
        }

        public function get levelWidthPx():Number {
            return _levelWidthPx;
        }

        public function get levelHeightPx():Number {
            return _levelHeightPx;
        }

        public function get displayObjects():LevelFrontendDisplayObjectsCollection {
            return _displayObjects;
        }

        public function get layers():LevelFrontendLayersCollection {
            return _layers;
        }

        public function get level():Level {
            return _extLevel;
        }

        public function get game():Game {
            return _extGame;
        }
    }
}
