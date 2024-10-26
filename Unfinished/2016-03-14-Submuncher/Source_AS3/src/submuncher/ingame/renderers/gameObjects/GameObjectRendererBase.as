package submuncher.ingame.renderers.gameObjects {
    import net.retrocade.random.IRandomEngine;
    import net.retrocade.random.RandomEngineKiss;
    import net.retrocade.retrocamel.interfaces.IRetrocamelUpdatable;

    import starling.display.Image;
    import starling.textures.TextureSmoothing;

    import submuncher.core.constants.GameObjectIndexes;

    import submuncher.core.constants.Gfx;
    import submuncher.core.constants.SpriteNames;
    import submuncher.ingame.core.GameCommunication;
    import submuncher.ingame.renderers.core.LevelFrontend;
    import submuncher.ingame.gameObjects.GameObject;

    public class GameObjectRendererBase extends Image implements IRetrocamelUpdatable{
        protected static var _random:IRandomEngine = new RandomEngineKiss();

        private var _gameObject:GameObject;
        private var _extLevelFrontend:LevelFrontend;

        public function get gameObject():GameObject{
            return _gameObject;
        }

        public function get levelFrontend():LevelFrontend {
            return _extLevelFrontend;
        }

        public function GameObjectRendererBase(gameObject:GameObject, levelRenderer:LevelFrontend) {
            super(Gfx.spritesAtlas.getTexture(SpriteNames.EMPTY));

            A::SSERT{ ASSERT(gameObject);}
            A::SSERT{ ASSERT(levelRenderer);}

            _gameObject = gameObject;
            _extLevelFrontend = levelRenderer;

            smoothing = TextureSmoothing.NONE;
            z = GameObjectIndexes.getDisplayIndex(gameObject.objectType);

            x = gameObject.preciseX;
            y = gameObject.preciseY;
        }

        override public function dispose():void {
            _gameObject = null;
            _extLevelFrontend = null;

            super.dispose();
        }

        public function update():void {
            x = _gameObject.preciseX + pivotX | 0;
            y = _gameObject.preciseY + pivotY | 0;
        }
        
        public function get distanceFromPlayer():Number {
            return gameObject.distanceFromPlayer;
        }

        protected function get gameCommunication():GameCommunication {
            return _extLevelFrontend.gameCommunication;
        }
    }
}
