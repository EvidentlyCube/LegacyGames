package submuncher.ingame.core {
    import submuncher.core.constants.GameObjectType;
    import submuncher.ingame.gameObjects.GameObject;

    public class LevelInteractionManager {
        private var _extLevel:Level;

        public function LevelInteractionManager(level:Level) {
            _extLevel = level;

            _extLevel.gameCommunication.onBonusCollected.add(bonusCollectedHandler);
            _extLevel.gameCommunication.onGameObjectCreated.add(gameObjectAddedHandler);
            _extLevel.gameCommunication.onGameObjectRemoved.add(gameObjectRemovedHandler);
            _extLevel.gameCommunication.onDoorOpened.add(doorOpenedHandler);
            _extLevel.gameCommunication.onFakeWallInitialized.add(fakeWallInitializedHandler);
        }

        public function dispose():void {
            _extLevel.gameCommunication.onBonusCollected.remove(bonusCollectedHandler);
            _extLevel.gameCommunication.onGameObjectCreated.remove(gameObjectAddedHandler);
            _extLevel.gameCommunication.onGameObjectRemoved.remove(gameObjectRemovedHandler);
            _extLevel.gameCommunication.onDoorOpened.remove(doorOpenedHandler);
            _extLevel.gameCommunication.onFakeWallInitialized.remove(fakeWallInitializedHandler);
        }

        private function gameObjectAddedHandler(gameObject:GameObject):void {
            _extLevel.gameObjectsList.add(gameObject);
        }

        private function gameObjectRemovedHandler(gameObject:GameObject):void {
            _extLevel.gameObjectsList.nullify(gameObject);
        }

        private function bonusCollectedHandler(bonus:GameObject):void {
            switch(bonus.objectType){
                case(GameObjectType.DNA_STRAND):
                    _extLevel.score.dnaStrandsLeft--;
                    if (_extLevel.score.dnaStrandsLeft === 0){
                        _extLevel.isLevelCompleted = true;
                        _extLevel.gameCommunication.onLevelCompleted.call(_extLevel);
                    }
                    break;

                case(GameObjectType.DNA_SECRET_STRAND):
                    _extLevel.score.secretDnaStrandsLeft--;
                    break;

                case(GameObjectType.DOCUMENT):
                    _extLevel.score.isDocumentCollected = true;
                    break;
            }
        }

        private function doorOpenedHandler(tileX:int, tileY:int):void {
            _extLevel.tilesForeground.setTile(tileX, tileY, 0);
            _extLevel.gameCommunication.onTileChanged.call(tileX, tileY);
        }

        private function fakeWallInitializedHandler(tileX:int, tileY:int):void {
            _extLevel.tilesForeground.setTile(tileX, tileY, 0);
            _extLevel.gameCommunication.onTileChanged.call(tileX, tileY);
        }
    }
}
