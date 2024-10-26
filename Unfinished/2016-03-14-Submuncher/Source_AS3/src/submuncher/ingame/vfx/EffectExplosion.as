package submuncher.ingame.vfx {
    import starling.display.BlendMode;
    import starling.textures.Texture;

    import submuncher.core.constants.SpriteTextureCollections;
    import submuncher.ingame.core.Level;

    public class EffectExplosion extends EffectBase {
        private static const FRAME_WAIT:uint = 3;

        private var _extLevel:Level;
        private var _textures:Vector.<Texture>;
        private var _currentFrame:uint;
        private var _frameWaiter:uint;

        public function EffectExplosion(level:Level, x:int, y:int) {
            _textures = getRandomTextures();
            _extLevel = level;

            super(_textures[0]);


            center = x;
            middle = y;
            z = 10;

            _currentFrame = 0;
            _frameWaiter = FRAME_WAIT;

            blendMode = BlendMode.ADD;
        }

        override public function dispose():void {
            removeFromParent();

            _textures = null;
        }

        override public function update():void {
            for(var i:int = 0; i < 5 - _currentFrame / 2; i++){
                _extLevel.gameCommunication.onEffectCreated.call(EffectBubble.getBubble(center, middle, _random.getNumberRange(-Math.PI, Math.PI)));
            }

            moveToFront();

            if (_frameWaiter-- === 0){
                _frameWaiter = FRAME_WAIT;

                _currentFrame++;

                if (_currentFrame < _textures.length){
                    texture = _textures[_currentFrame];
                }
            }
        }

        override public function get isFinished():Boolean {
            return _currentFrame === _textures.length;
        }

        override public function get objectClass():Class {
            return EffectExplosion;
        }

        private function getRandomTextures():Vector.<Texture> {
            switch(_random.getUintRange(0, 4)){
                case(0): return SpriteTextureCollections.explosionA;
                case(1): return SpriteTextureCollections.explosionB;
                case(2): return SpriteTextureCollections.explosionC;
                case(3): return SpriteTextureCollections.explosionD;
                default: throw new Error("Invalid range");
            }
        }
    }
}
