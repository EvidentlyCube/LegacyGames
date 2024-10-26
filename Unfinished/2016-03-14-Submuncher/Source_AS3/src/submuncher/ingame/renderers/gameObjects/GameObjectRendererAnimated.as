package submuncher.ingame.renderers.gameObjects {
    import starling.textures.Texture;

    import submuncher.ingame.renderers.core.LevelFrontend;

    import submuncher.ingame.gameObjects.GameObject;

    public class GameObjectRendererAnimated extends GameObjectRendererBase{
        private var _textures:Vector.<Texture>;
        private var _frameFactor:Number;
        protected var _animationSpeed:Number;

        public function GameObjectRendererAnimated(gameObject:GameObject, animationSpeed:Number, levelRenderer:LevelFrontend) {
            super(gameObject, levelRenderer);

            _frameFactor = _random.getNumber();
            _animationSpeed = animationSpeed;
        }

        override public function dispose():void {
            _textures = null;

            super.dispose();
        }

        override public function update():void {
            super.update();

            _frameFactor = (_frameFactor + _animationSpeed ) % 1;

            texture = getCurrentTexture();
        }

        public function setTextures(textures:Vector.<Texture>):void {
            _textures = textures;
            texture = getCurrentTexture();
            readjustSize();
        }

        private function getCurrentTexture():Texture {
            return _textures[currentFrame];
        }

        protected function get currentFrame():uint {
            return _textures.length * _frameFactor | 0;
        }

        public function get frameFactor():Number {
            return _frameFactor;
        }
    }
}
