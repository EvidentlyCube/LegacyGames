package submuncher.ingame.gameObjects {
    import net.retrocade.collision.CollisionShapeRectangle;

    import submuncher.core.constants.GameObjectType;
    import submuncher.core.constants.LockColor;
    import submuncher.ingame.core.Level;

    public class ObjectDoor extends GameObject{
        private var _color:LockColor;
        private var _isOpened:Boolean;

        override public function get objectType():GameObjectType {
            return GameObjectType.DOOR;
        }

        public function ObjectDoor(level:Level, x:Number, y:Number, color:LockColor) {
            super(level, x, y);

            _color = color;
            _isOpened = false;

            collisionShape = new CollisionShapeRectangle(x, y, 0, 0, 16, 16);
        }

        override public function update():void {
            super.update();
        }

        public function open():void {
            destroy();
        }

        override public function get isObstacle():Boolean {
            return true;
        }

        public function get color():LockColor {
            return _color;
        }

        public function get isOpened():Boolean {
            return _isOpened;
        }
    }
}