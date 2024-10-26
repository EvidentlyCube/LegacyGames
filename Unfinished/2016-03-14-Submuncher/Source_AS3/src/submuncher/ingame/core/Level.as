package submuncher.ingame.core {
    import net.retrocade.retrocamel.components.RetrocamelUpdatableGroup;
    import net.retrocade.signal.Signal;
    import net.retrocade.utils.UtilsNumber;

    import submuncher.core.constants.GameObjectIndexes;

    import submuncher.core.constants.GameObjectType;

    import S;
    import submuncher.core.repositories.LevelMetadata;
    import submuncher.ingame.gameObjects.GameObject;
    import submuncher.ingame.gameObjects.ObjectPlayer;

    public class Level {
        public var isLevelActive:Boolean = false;

        private var _gameObjectIndex:int;
        private var _extMetadata:LevelMetadata;
        private var _extGame:Game;

        private var _gameObjectCollisionMap:SpatialHashMap;
        private var _gameObjectsList:RetrocamelUpdatableGroup;
        private var _tilesBackground:LevelTilesArray;
        private var _tilesForeground:LevelTilesArray;
        private var _tilesForegroundVariant:LevelTilesArray;

        private var _player:ObjectPlayer;

        private var _tileWidth:uint;
        private var _tileHeight:uint;

        private var _isLevelStarted:Boolean;
        private var _isLevelCompleted:Boolean;
        private var _interactionManager:LevelInteractionManager;

        private var _score:LevelScore;

        public function Level(metadata:LevelMetadata, game:Game) {
            _extGame = game;
            _extMetadata = metadata;

            _tileWidth = metadata.width;
            _tileHeight = metadata.height;

            _interactionManager = new LevelInteractionManager(this);
            _gameObjectsList = new RetrocamelUpdatableGroup();
            _gameObjectCollisionMap = new SpatialHashMap(S.tileEdge, 1024, _tileWidth);
            _tilesBackground = new LevelTilesArray(_tileWidth, _tileHeight);
            _tilesForeground = new LevelTilesArray(_tileWidth, _tileHeight);
            _tilesForegroundVariant = new LevelTilesArray(_tileWidth, _tileHeight);

            _isLevelStarted = false;
            _isLevelCompleted = false;
            isLevelActive = true;
            _score = new LevelScore();

            gameCommunication.afterLevelLoaded.add(afterLevelLoadedHandler);
        }

        public function dispose():void {
            isLevelActive = false;

            gameCommunication.afterLevelLoaded.remove(afterLevelLoadedHandler);
            for each (var object:GameObject in _gameObjectsList.getAllOriginal()) {
                object.dispose();
            }

            _interactionManager.dispose();
            _gameObjectsList.dispose();
            _gameObjectCollisionMap.dispose();
            _tilesBackground.dispose();
            _tilesForeground.dispose();

            _gameObjectsList = null;
            _gameObjectCollisionMap = null;
            _tilesForeground = null;
            _player = null;
        }

        public function update():void {
            if (!_isLevelStarted && player.isPressingMovementKey){
                _isLevelStarted = true;
                gameCommunication.onLevelStarted.call(this);
            }

            if (_isLevelStarted){
                gameObjectsList.update();
            }
        }

        private function afterLevelLoadedHandler():void {
            reorderGameObjects();
            _score.dnaStrandsLeft = _gameObjectsList.countBy(function(object:GameObject):Boolean{
                return object.objectType === GameObjectType.DNA_STRAND;
            });
            _score.secretDnaStrandsLeft = _gameObjectsList.countBy(function(object:GameObject):Boolean{
                return object.objectType === GameObjectType.DNA_SECRET_STRAND;
            });
        }

        private function reorderGameObjects():void {
            _gameObjectsList.sort(function(left:GameObject, right:GameObject):int{
                return UtilsNumber.sign(
                        GameObjectIndexes.getActionIndex(left.objectType)
                        - GameObjectIndexes.getActionIndex(right.objectType)
                )
            });
        }

        public function isOutsideLevel(tileX:int, tileY:int):Boolean {
            return tileX < 0 || tileY < 0 || tileX >= _tileWidth || tileY >= _tileHeight;
        }

        public function get metadata():LevelMetadata {
            return _extMetadata;
        }

        public function get gameObjectsList():RetrocamelUpdatableGroup {
            return _gameObjectsList;
        }

        public function get gameObjectCollisionMap():SpatialHashMap {
            return _gameObjectCollisionMap;
        }

        public function get tilesBackground():LevelTilesArray {
            return _tilesBackground;
        }

        public function get tilesForeground():LevelTilesArray {
            return _tilesForeground;
        }

        public function get tilesForegroundVariant():LevelTilesArray {
            return _tilesForegroundVariant;
        }

        public function get tileWidth():uint {
            return _tileWidth;
        }

        public function get tileHeight():uint {
            return _tileHeight;
        }

        public function get player():ObjectPlayer {
            return _player;
        }

        public function set player(value:ObjectPlayer):void {
            _player = value;
        }

        public function get isLevelStarted():Boolean {
            return _isLevelStarted;
        }

        public function get isLevelCompleted():Boolean {
            return _isLevelCompleted;
        }

        public function set isLevelCompleted(value:Boolean):void {
            _isLevelCompleted = value;
        }

        public function get score():LevelScore {
            return _score;
        }

        public function get game():Game {
            return _extGame;
        }

        public function get gameCommunication():GameCommunication {
            return _extGame.gameCommunication;
        }

        public function get nextGameObjectIndex():int {
            return _gameObjectIndex++;
        }
    }
}
