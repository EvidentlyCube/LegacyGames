package submuncher.ingame.renderers.core {
    import flash.utils.Dictionary;

    import net.retrocade.retrocamel.components.RetrocamelUpdatableGroup;

    import submuncher.core.constants.Gfx;
    import submuncher.ingame.core.GameCommunication;
    import submuncher.ingame.gameObjects.GameObject;
    import submuncher.ingame.renderers.gameObjects.GameObjectRendererBase;

    import submuncher.ingame.renderers.general.EdgeCoverRenderer;
    import submuncher.ingame.renderers.general.RegularBackgroundRenderer;
    import submuncher.ingame.renderers.general.TilemapRenderer;
    import submuncher.ingame.vfx.IEffect;

    public class LevelFrontendDisplayObjectsCollection {
        private var _extFrontend:LevelFrontend;

        private var _gameObjectToRendererMap:Dictionary;

        private var _tilemapBackground:TilemapRenderer;
        private var _tilemapForeground:TilemapRenderer;
        private var _tilemapForegroundVariant:TilemapRenderer;
        private var _gameObjectRenderersGroup:RetrocamelUpdatableGroup;
        private var _effectsGroup:RetrocamelUpdatableGroup;

        private var _backgroundRenderer:RegularBackgroundRenderer;
        private var _edgeCover:EdgeCoverRenderer;

        public function LevelFrontendDisplayObjectsCollection(extFrontend:LevelFrontend) {
            _extFrontend = extFrontend;

            _gameObjectRenderersGroup = new RetrocamelUpdatableGroup();
            _effectsGroup = new RetrocamelUpdatableGroup();
            _gameObjectToRendererMap = new Dictionary(true);
            _tilemapBackground = new TilemapRenderer(Gfx.getSingleTileTextureBg);
            _tilemapForeground = new TilemapRenderer(Gfx.getSingleTileTextureFg);
            _tilemapForegroundVariant = new TilemapRenderer(Gfx.getSingleTileTextureFg);
//            _backgroundRenderer = new WavyBackgroundRenderer(Gfx.backgroundWaterTexture, 0.02, 6, 0.02);
            _backgroundRenderer = new RegularBackgroundRenderer();
            _edgeCover = new EdgeCoverRenderer();

            gameCommunication.onGameObjectRendererCreated.add(rendererCreatedHandler);
            gameCommunication.onGameObjectRemoved.add(gameObjectRemovedHandler);
            gameCommunication.onEffectCreated.add(effectCreatedHandler);
            gameCommunication.onEffectRemoved.add(effectRemovedHandler);
        }

        public function dispose():void {
            gameCommunication.onGameObjectRendererCreated.remove(rendererCreatedHandler);
            gameCommunication.onGameObjectRemoved.remove(gameObjectRemovedHandler);
            gameCommunication.onEffectCreated.remove(effectCreatedHandler);
            gameCommunication.onEffectRemoved.remove(effectRemovedHandler);

            for each (var rendererBase:GameObjectRendererBase in _gameObjectRenderersGroup.getAllOriginal()) {
                rendererBase.dispose();
            }

            for each (var effectBase:IEffect in _effectsGroup.getAllOriginal()) {
                effectBase.dispose();
            }

            _gameObjectToRendererMap = null;

            _tilemapBackground.dispose();
            _tilemapForeground.dispose();
            _tilemapForegroundVariant.dispose();
            _gameObjectRenderersGroup.dispose();
            _backgroundRenderer.dispose();
            _edgeCover.dispose();
            _effectsGroup.dispose();

            _tilemapForeground = null;
            _tilemapForegroundVariant = null;
            _gameObjectRenderersGroup = null;
            _backgroundRenderer = null;
            _edgeCover = null;
            _effectsGroup = null;
        }

        public function update():void {
            _backgroundRenderer.update();
            gameObjectRenderersGroup.update();

            for each (var effect:IEffect in effectsGroup.getAllOriginal()) {
                if (effect) {
                    effect.update();

                    if (effect.isFinished) {
                        gameCommunication.onEffectRemoved.call(effect);
                        effect.dispose();
                    } else if (effect.blocksOtherEffects){
                        break;
                    }
                }
            }
        }

        public function cleanupBeforeNextLevel():void {
            for each (var renderer:GameObjectRendererBase in _gameObjectRenderersGroup.getAllOriginal()) {
                renderer.dispose();
            }

            _gameObjectRenderersGroup.clear();

            _gameObjectToRendererMap = new Dictionary(true);

            _effectsGroup.filter(function (object:IEffect):Boolean {
                if (!object) {
                    return false;
                }

                if (object.isPersistent) {
                    return true;
                } else {
                    object.dispose();
                    return false;
                }
            });
            _effectsGroup.garbageCollect();
        }

        public function getRenderer(object:GameObject):GameObjectRendererBase {
            return _gameObjectToRendererMap[object];
        }

        private function effectCreatedHandler(effect:IEffect):void {
            if (effect.blocksOtherEffects){
                effectsGroup.addAt(effect, 0);
            } else {
                effectsGroup.add(effect);
            }
        }

        private function effectRemovedHandler(effect:IEffect):void {
            effectsGroup.nullify(effect);
        }

        private function rendererCreatedHandler(renderer:GameObjectRendererBase):void {
            if (renderer.gameObject in gameObjectToRendererMap){
                throw new Error("Game object already has one renderer defined!");
            }
            gameObjectRenderersGroup.add(renderer);
            gameObjectToRendererMap[renderer.gameObject] = renderer;
        }

        private function gameObjectRemovedHandler(gameObject:GameObject):void {
            if (gameObject in gameObjectToRendererMap) {
                var renderer:GameObjectRendererBase = gameObjectToRendererMap[gameObject];

                gameObjectRenderersGroup.nullify(renderer);
                delete(gameObjectToRendererMap[gameObject]);

                gameCommunication.onGameObjectRendererRemoved.call(renderer);
                renderer.dispose();
            }
        }


        public function hasRenderer(gameObject:GameObject):Boolean {
            return gameObject in _gameObjectToRendererMap;
        }

        public function get gameObjectToRendererMap():Dictionary {
            return _gameObjectToRendererMap;
        }

        public function get tilemapBackground():TilemapRenderer {
            return _tilemapBackground;
        }

        public function get tilemapForeground():TilemapRenderer {
            return _tilemapForeground;
        }

        public function get tilemapForegroundVariant():TilemapRenderer {
            return _tilemapForegroundVariant;
        }

        public function get gameObjectRenderersGroup():RetrocamelUpdatableGroup {
            return _gameObjectRenderersGroup;
        }

        public function get effectsGroup():RetrocamelUpdatableGroup {
            return _effectsGroup;
        }

        public function get backgroundRenderer():RegularBackgroundRenderer {
            return _backgroundRenderer;
        }

        public function get edgeCover():EdgeCoverRenderer {
            return _edgeCover;
        }

        private function get gameCommunication():GameCommunication {
            return _extFrontend.gameCommunication;
        }
    }
}
