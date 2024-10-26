package submuncher.ingame.gameObjects {
    import net.retrocade.collision.CollisionShapeRectangle;
    import net.retrocade.enums.Axis;

    import submuncher.core.constants.GameObjectType;
    import submuncher.core.constants.LockColor;
    import submuncher.ingame.core.Level;

    public class ObjectBarrier extends GameObject {
        private static const OPEN_SPEED:Number = 0.10;
        private var _color:LockColor;
        private var _axis:Axis;

        private var _openState:Number;
        private var _isOpened:Boolean;
        private var _isBlocking:Boolean;

        override public function get objectType():GameObjectType {
            return GameObjectType.BARRIER;
        }

        override public function get isObstacle():Boolean {
            return true;
        }

        public function ObjectBarrier(level:Level, x:Number, y:Number, color:LockColor, axis:Axis) {
            super(level, x, y);

            _axis = axis;
            _color = color;
            _isOpened = false;
            _isBlocking = true;
            _openState = 0;
            collisionShape = new CollisionShapeRectangle(x, y, 0, 0, 16, 16);
        }

        override public function update():void {
            if (_isOpened && _openState < 1){
                _openState += OPEN_SPEED;

                if (_openState >= 1){
                    _openState = 1;
                }

            } else if (!_isOpened && _openState > 0){
                _openState -= OPEN_SPEED;

                if (_openState <= 0){
                    _openState = 0;
                }
            }

            if (_isBlocking && _openState > 0.5){
                _isBlocking = false;
                level.gameObjectCollisionMap.removeSingle(this);

            } else if (!_isBlocking && _openState <= 0.5){
                _isBlocking = true;
                destroyUnderneath();
                level.gameObjectCollisionMap.addSingle(this);
            }
        }

        public function trigger():void {
            _isOpened = !_isOpened;

            if (_isOpened){
            } else {
            }
        }

        public function destroyUnderneath():void {
            for each (var object:GameObject in level.gameObjectCollisionMap.getAllAt(x, y)) {
                if (doesCollideWith(object)){
                    object.damagedByHazard(this);
                }
            }
        }

        public function get color():LockColor {
            return _color;
        }

        public function get axis():Axis {
            return _axis;
        }

        public function get isOpened():Boolean {
            return _isOpened;
        }

        public function get openState():Number {
            return _openState;
        }
    }
}