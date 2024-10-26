package submuncher.ingame.vfx {
    import net.retrocade.enums.Direction4;

    import starling.display.BlendMode;
    import starling.textures.Texture;

    import submuncher.core.constants.SpriteTextureCollections;
    import submuncher.ingame.core.Level;

    public class EffectShellBulletExplosion extends EffectBase {
        private static const FRAME_WAIT:uint = 2;

        private var _extLevel:Level;
        private var _textures:Vector.<Texture>;
        private var _currentFrame:uint;
        private var _frameWaiter:uint;

        public function EffectShellBulletExplosion(level:Level, direction:Direction4, x:int, y:int) {
            _textures = SpriteTextureCollections.shellBulletExplosion;
            _extLevel = level;

            super(_textures[1]);

            this.pivotX = 8;
            this.pivotY = 8;

            this.x = x;
            this.y = y;

            _currentFrame = 1;
            _frameWaiter = FRAME_WAIT;

            this.rotation = direction.radians;
            blendMode = BlendMode.ADD;
        }

        override public function update():void {
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

        override public function dispose():void {
            removeFromParent();

            _textures = null;
        }

        override public function get objectClass():Class {
            return EffectShellBulletExplosion;
        }
    }
}
