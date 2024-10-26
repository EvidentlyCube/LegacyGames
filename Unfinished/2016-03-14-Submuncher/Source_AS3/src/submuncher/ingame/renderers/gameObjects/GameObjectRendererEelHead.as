package submuncher.ingame.renderers.gameObjects {
    import submuncher.core.constants.Gfx;
    import submuncher.core.constants.SpriteNames;
    import submuncher.ingame.gameObjects.EnemyEel;
    import submuncher.ingame.gameObjects.ObjectPlayer;

    import submuncher.ingame.renderers.core.LevelFrontend;

    public class GameObjectRendererEelHead extends GameObjectRendererBase{
        private function get eel():EnemyEel{
            return gameObject as EnemyEel;
        }

        public function GameObjectRendererEelHead(gameObject:EnemyEel, levelRenderer:LevelFrontend) {
            super(gameObject, levelRenderer);

            x = gameObject.x;
            y = gameObject.y;

            texture = Gfx.spritesAtlas.getTexture(SpriteNames.EEL_HEAD);
            readjustSize();

            pivotX = 8;
            pivotY = 8;
        }

        override public function update():void{
            if (eel.isStopped){
                lookAtPlayer();
            } else {
                rotation = eel.direction.radians;
            }

            this.x = gameObject.preciseX + 8;
            this.y = gameObject.preciseY + 8;
        }

        private function lookAtPlayer():void {
            var angle360:Number = Math.PI * 2;
            var angle180:Number = Math.PI;
            var angle135:Number = Math.PI * 3 / 4;
            var angle45:Number = Math.PI / 4;

            var angle:Number = Math.atan2(player.preciseY - eel.preciseY, player.preciseX - eel.preciseX);
            angle -= eel.direction.radians;

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

            angle += eel.direction.radians;

            rotation = angle;
        }

        private function get player():ObjectPlayer{
            return eel.player;
        }
    }
}
