package submuncher.ingame.renderers.gameObjects {
    import submuncher.core.constants.Gfx;
    import submuncher.core.constants.SpriteNames;

    import submuncher.ingame.renderers.core.LevelFrontend;

    import submuncher.ingame.gameObjects.GameObject;

    public class GameObjectRendererShellAcid extends GameObjectRendererBase{
        public function GameObjectRendererShellAcid(gameObject:GameObject, levelRenderer:LevelFrontend) {
            super(gameObject, levelRenderer);

            this.pivotX = 8;
            this.pivotY = 8;

            texture = Gfx.spritesAtlas.getTexture(SpriteNames.SHELL_BULLET);
            this.rotation = gameObject.direction.radians;

            alpha = 0;
        }


        override public function update():void {
            super.update();

            if (alpha < 1){
                alpha += 0.25;
            }
        }

        override public function dispose():void {
            super.dispose();
        }
    }
}
