package submuncher.ingame.vfx {
    import flash.geom.Point;

    import starling.textures.Texture;

    import submuncher.ingame.core.GameCommunication;
    import submuncher.ingame.vfx.shatter.ShatterData;
    import submuncher.ingame.vfx.shatter.ShatterRepository;

    public class EffectShatter extends EffectBase {
        public static function createShatter(gameCommunication:GameCommunication, texture:Texture, x:int, y:int):void {
            for each (var data:ShatterData in ShatterRepository.randomShatter) {
                gameCommunication.onEffectCreated.call(new EffectShatter(texture, x, y, data));
            }
        }

        private var _direction:Number;
        private var _speed:Number;
        private var _rotationSpeed:Number;

        public function EffectShatter(texture:Texture, x:int, y:int, shatter:ShatterData) {
            super(texture);

            pivotX = texture.width / 2;
            pivotY = texture.height / 2;

            this.x = x;
            this.y = y;

            for (var i:int = 0; i < 4; i++) {
                var point:Point = shatter.points[i];

                mVertexData.setPosition(i, width * point.x, width * point.y);
                mVertexData.setTexCoords(i, point.x, point.y);
            }

            _direction = shatter.randomDirection + _random.getNumberRange(shatter.directionSway, shatter.directionSway);
            _speed = _random.getNumberRange(0.05, 0.3) * shatter.speedMultipler;
            _rotationSpeed = _random.getNumberRange(-Math.PI / 300, -Math.PI / 300);

            onVertexDataChanged();
        }

        override public function update():void {
            x += Math.cos(_direction) * _speed;
            y += Math.sin(_direction) * _speed;
            rotation += _rotationSpeed;
            alpha -= 0.01;
        }

        override public function get isFinished():Boolean {
            return alpha <= 0;
        }

        override public function dispose():void {
            removeFromParent();
        }

        override public function get objectClass():Class {
            return EffectShatter;
        }
    }
}
