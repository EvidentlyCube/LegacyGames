package submuncher.ingame.renderers.core {
    import submuncher.core.repositories.GhostRepository;
    import submuncher.ingame.core.GameCommunication;
    import submuncher.ingame.core.Level;
    import submuncher.ingame.gameObjects.GameObject;
    import submuncher.ingame.ghost.GhostData;
    import submuncher.ingame.renderers.gameObjects.GameObjectRendererBase;
    import submuncher.ingame.renderers.gameObjects.GameObjectRendererFactory;
    import submuncher.ingame.vfx.EffectPlayerGhost;

    public class LevelFrontendRenderer {
        private var _extFrontend:LevelFrontend;
        private var _changedTiles:Vector.<int>;

        public function LevelFrontendRenderer(frontend:LevelFrontend) {
            _extFrontend = frontend;
            _changedTiles = new Vector.<int>();

            gameCommunication.onGameObjectCreated.add(gameObjectCreatedHandler);
            gameCommunication.onTileChanged.add(tileChangedHandler);
        }

        public function dispose():void {
            gameCommunication.onGameObjectCreated.remove(gameObjectCreatedHandler);
            gameCommunication.onTileChanged.remove(tileChangedHandler);

            _extFrontend = null;
        }

        public function update():void {
            refreshChangedTiles();
        }

        public function renderLevel():void {
            displayObjects.edgeCover.width = _extFrontend.levelWidthPx;
            displayObjects.edgeCover.height = _extFrontend.levelHeightPx;
            displayObjects.edgeCover.borderFillerThickness = 1000;

            displayObjects.tilemapBackground.renderFromTileArray(level.tilesBackground);
            displayObjects.tilemapForeground.renderFromTileArray(level.tilesForeground);
            displayObjects.tilemapForegroundVariant.renderFromTileArray(level.tilesForegroundVariant);

            for each (var gameObject:GameObject in level.gameObjectsList.getAllOriginal()) {
                if (!gameObject || displayObjects.hasRenderer(gameObject)) {
                    continue;
                }

                var renderer:GameObjectRendererBase = GameObjectRendererFactory.createRenderer(gameObject, _extFrontend);
                layers.gameObjects.add(renderer);
                displayObjects.gameObjectRenderersGroup.add(renderer);
                displayObjects.gameObjectToRendererMap[gameObject] = renderer;

                renderer.update();
            }

            for each (var data:GhostData in GhostRepository.getGhostsForLevel(level.game.currentLevelMetadata)) {
                gameCommunication.onEffectCreated.call(new EffectPlayerGhost(data, _extFrontend));
            }

            gameCommunication.afterLevelRendered.call();
        }

        private function refreshChangedTiles():void {
            if (_changedTiles.length > 0) {
                displayObjects.tilemapForeground.refreshTiles(_changedTiles);
                displayObjects.tilemapForegroundVariant.refreshTiles(_changedTiles);
                _changedTiles.length = 0;
            }
        }

        private function tileChangedHandler(tileX:int, tileY:int):void {
            _changedTiles.push(tileX);
            _changedTiles.push(tileY);
        }

        private function gameObjectCreatedHandler(gameObject:GameObject):void {
            gameCommunication.onGameObjectRendererCreated.call(GameObjectRendererFactory.createRenderer(gameObject, _extFrontend));
        }

        public function get level():Level {
            return _extFrontend.level;
        }

        public function get displayObjects():LevelFrontendDisplayObjectsCollection {
            return _extFrontend.displayObjects;
        }

        public function get layers():LevelFrontendLayersCollection {
            return _extFrontend.layers;
        }

        public function get gameCommunication():GameCommunication {
            return _extFrontend.gameCommunication;
        }
    }
}
