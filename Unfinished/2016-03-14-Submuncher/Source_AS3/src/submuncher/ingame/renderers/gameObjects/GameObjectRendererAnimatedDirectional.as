package submuncher.ingame.renderers.gameObjects {
    import net.retrocade.enums.Direction4;

    import starling.textures.Texture;

    import submuncher.ingame.gameObjects.GameObject;
    import submuncher.ingame.gameObjects.GameObjectMoving;
    import submuncher.ingame.renderers.core.LevelFrontend;

    public class GameObjectRendererAnimatedDirectional extends GameObjectRendererBase{
        private var _textures:Vector.<Vector.<Texture>>;
        private var _frameFactor:Number;
        private var _animationSpeed:Number;

        private function get movingGameObject():GameObjectMoving{
            return gameObject as GameObjectMoving;
        }

        public function GameObjectRendererAnimatedDirectional(gameObject:GameObject, levelRenderer:LevelFrontend) {
            super(gameObject, levelRenderer);

            _frameFactor = _random.getNumber();
            _animationSpeed = 0.5 / movingGameObject.getSpeed();
        }

        override public function dispose():void {
            _textures = null;

            super.dispose();
        }

        override public function update():void {
            super.update();

            _frameFactor = (_frameFactor + _animationSpeed ) % 1;

            texture = getTextureForCurrentDirection(_frameFactor);
        }

        public function setTextures(up:Vector.<Texture>, right:Vector.<Texture>, down:Vector.<Texture>, left:Vector.<Texture>):void {
            _textures = new Vector.<Vector.<Texture>>(4, true);
            _textures[Direction4.UP.id] = up;
            _textures[Direction4.RIGHT.id] = right;
            _textures[Direction4.DOWN.id] = down;
            _textures[Direction4.LEFT.id] = left;

            texture = getTextureForCurrentDirection(_frameFactor);
            readjustSize();
        }

        private function getTextureForCurrentDirection(frameFactor:Number):Texture {
            var textures:Vector.<Texture> = _textures[gameObject.direction.id];

            return textures[textures.length * frameFactor | 0];
        }

        protected function getTexturesForDirection(direction:Direction4):Vector.<Texture> {
            return _textures[direction.id];
        }
    }
}
