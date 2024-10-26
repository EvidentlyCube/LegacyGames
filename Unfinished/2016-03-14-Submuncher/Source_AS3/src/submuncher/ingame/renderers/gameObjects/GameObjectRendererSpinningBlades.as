package submuncher.ingame.renderers.gameObjects {
    import net.retrocade.utils.UtilsNumber;

    import submuncher.core.constants.Gfx;
    import submuncher.core.constants.SpriteNames;
    import submuncher.ingame.gameObjects.EnemySpinningBlades;

    import submuncher.ingame.renderers.core.LevelFrontend;

    import submuncher.ingame.gameObjects.GameObject;

    public class GameObjectRendererSpinningBlades extends GameObjectRendererBase{
        private var _rotationDirection:int;

        public function get spinningBlades():EnemySpinningBlades {
            return gameObject as EnemySpinningBlades;
        }

        public function GameObjectRendererSpinningBlades(gameObject:GameObject, levelRenderer:LevelFrontend) {
            super(gameObject, levelRenderer);

            this.texture = Gfx.spritesAtlas.getTexture(SpriteNames.SPIN_BLADE);

            this.pivotX = 8;
            this.pivotY = 8;

            _rotationDirection = -UtilsNumber.sign(spinningBlades.speed);
        }

        override public function dispose():void {
            super.dispose();
        }

        override public function update():void {
            x = gameObject.preciseX + 8 | 0;
            y = gameObject.preciseY + 8 | 0;

            this.rotation += Math.PI * 0.1 * _rotationDirection;
        }

    }
}
