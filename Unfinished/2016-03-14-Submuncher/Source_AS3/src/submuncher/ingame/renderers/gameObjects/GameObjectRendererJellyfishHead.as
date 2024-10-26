package submuncher.ingame.renderers.gameObjects {
    import net.retrocade.utils.UtilsAngle;

    import submuncher.core.constants.SpriteTextureCollections;
    import submuncher.ingame.gameObjects.EnemyJellyfish;
    import submuncher.ingame.gameObjects.ObjectPlayer;

    import submuncher.ingame.renderers.core.LevelFrontend;

    public class GameObjectRendererJellyfishHead extends GameObjectRendererAnimated{
        private function get jellyfish():EnemyJellyfish{
            return gameObject as EnemyJellyfish;
        }

        public function GameObjectRendererJellyfishHead(gameObject:EnemyJellyfish, levelRenderer:LevelFrontend) {
            super(gameObject, 0.022, levelRenderer);

            x = gameObject.x;
            y = gameObject.y;

            setTextures(SpriteTextureCollections.jellyfish);

            pivotX = 32;
            pivotY = 8;

            rotation = jellyfish.direction.radians;
        }

        override public function update():void{
            if (jellyfish.isMoving){
                _animationSpeed = 0.03;
            } else {
                _animationSpeed = 0.018
            }

            rotation = UtilsAngle.easeTwoRadiansByStep(rotation, jellyfish.direction.radians, Math.PI / 30);

            super.update();

            this.x = gameObject.preciseX + 8;
            this.y = gameObject.preciseY + 8;
        }

        private function lookAtPlayer():void {
            var angle360:Number = Math.PI * 2;
            var angle180:Number = Math.PI;
            var angle135:Number = Math.PI * 3 / 4;
            var angle45:Number = Math.PI / 4;

            var angle:Number = Math.atan2(player.preciseY - jellyfish.preciseY, player.preciseX - jellyfish.preciseX);
            angle -= jellyfish.direction.radians;

            if (angle > angle180){
                angle -= angle360;
            } else if (angle < -angle180){
                angle += angle360;
            }

            if (angle > angle135){
                angle = angle180 - angle;
            } else if (angle < -angle135){
                angle = -angle180 - angle;
            }

            if (angle < -angle45){
                angle = -angle45;
            } else if (angle > angle45){
                angle = angle45;
            }

            angle += jellyfish.direction.radians;

            rotation = angle;
        }

        private function get player():ObjectPlayer{
            return jellyfish.player;
        }
    }
}
