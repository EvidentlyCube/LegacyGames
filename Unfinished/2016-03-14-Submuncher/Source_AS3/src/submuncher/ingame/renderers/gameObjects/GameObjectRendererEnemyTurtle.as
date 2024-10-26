package submuncher.ingame.renderers.gameObjects {
    import submuncher.ingame.renderers.core.LevelFrontend;
    import submuncher.ingame.gameObjects.EnemyTurtle;

    import submuncher.ingame.gameObjects.GameObject;

    public class GameObjectRendererEnemyTurtle extends GameObjectRendererAnimatedDirectional{
        private static const HALF_PI:Number = 1.57079632679;

        private function get turtle():EnemyTurtle{
            return gameObject as EnemyTurtle;
        }

        public function GameObjectRendererEnemyTurtle(gameObject:GameObject, levelRenderer:LevelFrontend) {
            super(gameObject, levelRenderer);

            this.pivotX = 8;
            this.pivotY = 8;
        }

        override public function dispose():void {
            super.dispose();
        }

        override public function update():void {
            super.update();

            if (turtle.isRotating){
                if (turtle.clockwisity.isCW){
                    if (turtle.isInvertedRotation){
                        this.rotation = HALF_PI - HALF_PI * turtle.rotationFactor;
                    } else {
                        this.rotation = -HALF_PI + HALF_PI * turtle.rotationFactor;
                    }
                } else {
                    if (turtle.isInvertedRotation){
                        this.rotation = HALF_PI * turtle.rotationFactor - HALF_PI;
                    } else {
                        this.rotation = HALF_PI - HALF_PI * turtle.rotationFactor;
                    }
                }
            } else {
                this.rotation = 0;
            }
        }


        override public function set x(value:Number):void {
            super.x = value;
        }

        override public function set y(value:Number):void {
            super.y = value;
        }
    }
}
