package submuncher.ingame.vfx {
    import net.retrocade.enums.Direction4;

    import submuncher.core.constants.GameObjectIndexes;
    import submuncher.core.constants.GameObjectType;
    import submuncher.core.constants.Gfx;
    import submuncher.core.constants.SpriteNames;
    import submuncher.ingame.gameObjects.ObjectDetector;

    import submuncher.ingame.gameObjects.helpers.Ray;

    public class EffectDetectorRay extends EffectBase {
        private var _extRay:Ray;
        private var _detector:ObjectDetector;
        private var _isFinished:Boolean;
        private var _widthOffset:Number;
        private var _baseAlpha:Number;

        public function EffectDetectorRay(detector:ObjectDetector, ray:Ray) {
            super(Gfx.spritesAtlas.getTexture(SpriteNames.getDetectorRaySpriteName(detector)));

            _extRay = ray;
            _detector = detector;
            _isFinished = false;

            rotation = ray.direction.radians;
            pivotY = 8;

            z = GameObjectIndexes.getDisplayIndex(GameObjectType.DETECTOR) - 0.1;

            switch(ray.direction){
                case(Direction4.RIGHT): _widthOffset = -3; break;
                case(Direction4.DOWN): _widthOffset = -3; break;
                case(Direction4.LEFT): _widthOffset = 2; break;
                case(Direction4.UP): _widthOffset = 2; break;
            }
        }

        override public function dispose():void {
            _extRay = null;

            super.dispose();
        }

        override public function update():void {
            alpha = _baseAlpha + _random.getNumberRange(-0.1, 0.1);
            x = _detector.x + 8;
            y = _detector.y + 8;
            width = Math.max(_extRay.collisionRectangle.width, _extRay.collisionRectangle.height) + _widthOffset;

            if (_isFinished){
                _baseAlpha -= 0.05;
            }
        }

        public function finish():void {
            _isFinished = true;
        }

        override public function get isFinished():Boolean {
            return _isFinished && _baseAlpha <= 0;
        }

        override public function get isOnGameObjectLayer():Boolean {
            return true;
        }

        public function set baseAlpha(value:Number):void {
            _baseAlpha = value;
        }
        override public function get objectClass():Class {
            return EffectDetectorRay;
        }
    }
}
