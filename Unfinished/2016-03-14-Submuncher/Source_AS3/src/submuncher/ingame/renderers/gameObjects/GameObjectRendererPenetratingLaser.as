package submuncher.ingame.renderers.gameObjects {
    import submuncher.core.constants.Gfx;
    import submuncher.core.constants.SpriteNames;
import submuncher.core.constants.SpriteTextureCollections;
import submuncher.ingame.gameObjects.BulletPenetratingLaser;

import submuncher.ingame.renderers.core.LevelFrontend;

    import submuncher.ingame.gameObjects.GameObject;

    public class GameObjectRendererPenetratingLaser extends GameObjectRendererAnimated{
        public function get laser():BulletPenetratingLaser {
            return gameObject as BulletPenetratingLaser;
        }

        public function GameObjectRendererPenetratingLaser(gameObject:GameObject, levelRenderer:LevelFrontend) {
            super(gameObject, 0.05, levelRenderer);

            this.pivotX = 8;
            this.pivotY = 8;

            setTextures(SpriteTextureCollections.bulletPenetratingLaser);

            this.rotation = laser.angleRadians;

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
