package submuncher.ingame.renderers.gameObjects {
    import submuncher.core.constants.Gfx;

    import submuncher.ingame.renderers.core.LevelFrontend;

    import submuncher.ingame.gameObjects.GameObject;

    public class GameObjectRendererUnanimated extends GameObjectRendererBase{
        public function GameObjectRendererUnanimated(sprite:String, gameObject:GameObject, levelRenderer:LevelFrontend) {
            super(gameObject, levelRenderer);

            texture = Gfx.spritesAtlas.getTexture(sprite);
            readjustSize();
        }
    }
}
