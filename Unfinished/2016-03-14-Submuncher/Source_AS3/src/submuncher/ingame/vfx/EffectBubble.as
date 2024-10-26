package submuncher.ingame.vfx {
    import net.retrocade.random.IRandomEngine;
    import net.retrocade.random.RandomEngineKiss;
    import net.retrocade.retrocamel.interfaces.IRetrocamelUpdatable;

    import starling.display.Image;
    import starling.textures.Texture;

    import submuncher.core.constants.Gfx;
    import submuncher.core.constants.SpriteNames;

    public class EffectBubble extends EffectBase {
        private static var _textureCache:Vector.<Texture>;
        private static var _pool:Vector.<EffectBubble>;
        private static var _poolCapacity:uint;
        private static var _indexInPool:uint;
        private static var _random:IRandomEngine;

        public static function getBubble(x:Number, y:Number, dir:Number = NaN):EffectBubble {
            if (!_pool){
                init();
            }

            if (_indexInPool === _poolCapacity){
                _poolCapacity += 10;

                for(var i:uint = _indexInPool; i < _poolCapacity; i++){
                    _pool[i] = new EffectBubble();
                }
            }

            var bubble:EffectBubble = _pool[_indexInPool++];
            bubble.init(x, y, dir);
            return bubble;
        }

        private static function init():void {
            _textureCache = new <Texture>[
                Gfx.spritesAtlas.getTexture(SpriteNames.PARTICLE_BUBBLE_0),
                Gfx.spritesAtlas.getTexture(SpriteNames.PARTICLE_BUBBLE_1),
                Gfx.spritesAtlas.getTexture(SpriteNames.PARTICLE_BUBBLE_2),
                Gfx.spritesAtlas.getTexture(SpriteNames.PARTICLE_BUBBLE_3),
                Gfx.spritesAtlas.getTexture(SpriteNames.PARTICLE_BUBBLE_4)
            ];

            _poolCapacity = 100;
            _pool = new Vector.<EffectBubble>(_poolCapacity);
            _random = new RandomEngineKiss();

            for(var i:uint = 0; i < _poolCapacity; i++){
                _pool[i] = new EffectBubble();
            }
        }

        private static function getTextureForSize(size:uint):Texture {
            return _textureCache[size];
        }

        private var _bubbleSize:uint;

        private var _movementDirection:Number;
        private var _movementWave:Number;
        private var _movementWaveDelta:Number;

        private var _movementSpeed:Number;

        private var _lifePerSize:uint;
        private var _lifeLeft:uint;

        private var _isFinished:Boolean;

        public function EffectBubble() {
            super(getTextureForSize(0));

            pivotX = 8;
            pivotY = 8;

            _isFinished = true;
        }

        override public function update():void {
            if (isFinished){
                return;
            }

            x += Math.cos(_movementDirection + Math.sin(_movementWave) * Math.PI / 4) * _movementSpeed;
            y += Math.sin(_movementDirection + Math.sin(_movementWave) * Math.PI / 4) * _movementSpeed;

            _movementWave += _movementWaveDelta;

            if (_lifeLeft == 0) {
                _lifeLeft = _lifePerSize;

                if (_bubbleSize == 4) {
                    _isFinished = true;

                } else {
                    _bubbleSize++;
                    texture = getTextureForSize(_bubbleSize);
                }
            } else {
                _lifeLeft--;
            }
        }

        override public function get isFinished():Boolean {
            return _isFinished;
        }

        private function init(x:Number, y:Number, initialDirection:Number = NaN):void {
            this.x = x;
            this.y = y;

            _bubbleSize = _random.getUintRange(0, 5);

            _movementSpeed = _random.getNumberRange(0.5, 1.5);

            if (isNaN(initialDirection)) {
                _movementDirection = _random.getNumberRange(0, Math.PI * 2);

            } else {
                _movementDirection = _random.getNumberRange(-Math.PI / 4, Math.PI / 4) + initialDirection;
            }

            _movementWave = _random.getNumberRange(0, Math.PI * 2);
            _movementWaveDelta = _random.getNumberRange(Math.PI / 80, Math.PI / 16);

            _lifePerSize = _random.getUintRange(3, 15);
            _lifeLeft = _random.getNumber() * _lifePerSize;

            _isFinished = false;
        }

        override public function dispose():void {
            removeFromParent();

            _pool[--_indexInPool] = this;

            alpha = 1;
        }

        override public function get objectClass():Class {
            return EffectBubble;
        }
    }
}
