package submuncher.ingame.renderers.core {
    import net.retrocade.retrocamel.display.layers.RetrocamelLayerStarling;
    import net.retrocade.retrocamel.locale._;

    import starling.display.DisplayObject;
    import starling.display.Image;

    import submuncher.ingame.core.GameCommunication;
    import submuncher.ingame.renderers.gameObjects.GameObjectRendererBase;
    import submuncher.ingame.vfx.EffectRestartTransition;
    import submuncher.ingame.vfx.IEffect;

    public class LevelFrontendLayersCollection {
        private var _extFrontend:LevelFrontend;
        private var _background:RetrocamelLayerStarling;
        private var _tilemap:RetrocamelLayerStarling;
        private var _gameObjects:RetrocamelLayerStarling;
        private var _effects:RetrocamelLayerStarling;
        private var _edgeCover:RetrocamelLayerStarling;

        public function get background():RetrocamelLayerStarling {
            return _background;
        }

        public function get tilemap():RetrocamelLayerStarling {
            return _tilemap;
        }

        public function get gameObjects():RetrocamelLayerStarling {
            return _gameObjects;
        }

        public function get effects():RetrocamelLayerStarling {
            return _effects;
        }

        public function get edgeCover():RetrocamelLayerStarling {
            return _edgeCover;
        }

        public function LevelFrontendLayersCollection(frontend:LevelFrontend) {
            _extFrontend = frontend;

            _background = new RetrocamelLayerStarling();
            _tilemap = new RetrocamelLayerStarling();
            _gameObjects = new RetrocamelLayerStarling();
            _effects = new RetrocamelLayerStarling();
            _edgeCover = new RetrocamelLayerStarling();

            gameCommunication.onGameObjectRendererCreated.add(rendererCreatedHandler);
            gameCommunication.onGameObjectRendererRemoved.add(rendererRemovedHandler);
            gameCommunication.onGameObjectImageCreated.add(gameObjectImageCreatedHandler);
            gameCommunication.onGameObjectImageRemoved.add(gameObjectImageRemovedHandler);
            gameCommunication.onEffectCreated.add(effectCreatedHandler);
            gameCommunication.onEffectRemoved.add(effectRemovedHandler);
        }

        public function dispose():void {
            gameCommunication.onGameObjectRendererCreated.remove(rendererCreatedHandler);
            gameCommunication.onGameObjectRendererRemoved.remove(rendererRemovedHandler);
            gameCommunication.onGameObjectImageCreated.remove(gameObjectImageCreatedHandler);
            gameCommunication.onGameObjectImageRemoved.remove(gameObjectImageRemovedHandler);
            gameCommunication.onEffectCreated.remove(effectCreatedHandler);
            gameCommunication.onEffectRemoved.remove(effectRemovedHandler);

            _background.dispose();
            _tilemap.dispose();
            _gameObjects.dispose();
            _effects.dispose();
            _edgeCover.dispose();

            _background = null;
            _tilemap = null;
            _gameObjects = null;
            _effects = null;
            _edgeCover = null;
        }

        private function rendererCreatedHandler(renderer:GameObjectRendererBase):void {
            _gameObjects.add(renderer);
        }

        private function rendererRemovedHandler(renderer:GameObjectRendererBase):void {
            _gameObjects.remove(renderer);
        }
        private function gameObjectImageCreatedHandler(image:Image):void {
            _gameObjects.add(image);
        }

        private function gameObjectImageRemovedHandler(image:Image):void {
            _gameObjects.remove(image);
        }

        private function effectCreatedHandler(effect:IEffect):void {
             if (effect.isDisplayEffect) {
                 if (effect.objectClass === EffectRestartTransition) {
                     edgeCover.add(effect as DisplayObject);
                 } else if (effect.isOnGameObjectLayer){
                    gameObjects.add(effect as DisplayObject);
                } else {
                    effects.add(effect as DisplayObject);
                }
            }
        }

        private function effectRemovedHandler(effect:IEffect):void {
            if (effect.isDisplayEffect){
                if (effect.objectClass === EffectRestartTransition) {
                    edgeCover.remove(effect as DisplayObject);
                } else if (effect.isOnGameObjectLayer){
                    gameObjects.remove(effect as DisplayObject);
                } else {
                    effects.remove(effect as DisplayObject);
                }
            }
        }
        private function get gameCommunication():GameCommunication {
            return _extFrontend.gameCommunication;
        }
    }
}
