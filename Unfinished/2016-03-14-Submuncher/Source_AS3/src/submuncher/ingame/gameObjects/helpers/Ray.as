package submuncher.ingame.gameObjects.helpers {
    import flash.utils.getDefinitionByName;

    import net.retrocade.collision.CollisionShapeRectangle;
    import net.retrocade.enums.Direction4;

    import submuncher.core.constants.GameObjectType;

    import submuncher.ingame.core.Level;
    import submuncher.ingame.core.Tiles;

    import submuncher.ingame.gameObjects.GameObject;

    public class Ray {
        private var _startX:Number;
        private var _startY:Number;
        private var _thickness:Number;
        private var _collisionRectangle:CollisionShapeRectangle;
        private var _direction:Direction4;
        private var _extLevel:Level;

        private var _currentX:Number;
        private var _currentY:Number;

        public function Ray(thickness:Number, startX:Number, startY:Number, direction:Direction4, level:Level) {
            _extLevel = level;
            _thickness = thickness;
            _startX = startX;
            _startY = startY;
            _direction = direction;
            _collisionRectangle = new CollisionShapeRectangle(0, 0, 0, 0, 0, 0);
        }

        public function dispose():void {
            _collisionRectangle = null;
            _direction = null;
            _extLevel = null;
        }

        public function cast():void {
            _currentX = _startX;
            _currentY = _startY;

            do {
                getNextPosition();

            } while(!doesTileBlockBeam(_currentX / 16 | 0, _currentY / 16 | 0));

            _collisionRectangle.setAll(
                Math.min(_startX, _currentX),
                Math.min(_startY, _currentY),
                Math.abs(_startX - _currentX) + (_direction.isVertical ? _thickness : 0),
                Math.abs(_startY - _currentY) + (_direction.isHorizontal ? _thickness : 0)
            );
        }

        private function getNextPosition():void{
            if (_direction === Direction4.LEFT){
                _currentX = (_currentX / 16 | 0) * 16 - 1;
            } else if (_direction === Direction4.RIGHT){
                _currentX = (_currentX / 16 | 0) * 16 + 16;
            } else if (_direction === Direction4.UP){
                _currentY = (_currentY / 16 | 0) * 16 - 1;
            } else {
                _currentY = (_currentY / 16 | 0) * 16 + 16;
            }
        }

        private function doesTileBlockBeam(tileX:int, tileY:int):Boolean{
            if (_extLevel.isOutsideLevel(tileX,  tileY)){
                return true;
            }

            var tileToCheck:uint = _extLevel.tilesForeground.getTile(tileX,  tileY);

            switch(tileToCheck){
                case(0):
                case(Tiles.ARROW_UP):
                case(Tiles.ARROW_RIGHT):
                case(Tiles.ARROW_DOWN):
                case(Tiles.ARROW_LEFT):
                    break;
                default:
                    return true;
            }

            for each (var object:GameObject in _extLevel.gameObjectCollisionMap.getAllAt(tileX * 16, tileY * 16)) {
                switch(object.objectType){
                    case(GameObjectType.EYE):
                    case(GameObjectType.CRATE_STRONG):
                    case(GameObjectType.CRATE_WEAK):
                    case(GameObjectType.BARRIER):
                    case(GameObjectType.BARREL):
                    case(GameObjectType.DETECTOR):
                    case(GameObjectType.SPONGE):
                        return true;
                }
            }

            return false;
        }

        public function get collisionRectangle():CollisionShapeRectangle {
            return _collisionRectangle;
        }

        public function get direction():Direction4 {
            return _direction;
        }

        public function set direction(value:Direction4):void {
            _direction = value;
        }

        public function get startX():Number {
            return _startX;
        }

        public function set startX(value:Number):void {
            _startX = value;
        }

        public function get startY():Number {
            return _startY;
        }

        public function set startY(value:Number):void {
            _startY = value;
        }
    }
}
