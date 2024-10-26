package submuncher.ingame.gameObjects {
    import net.retrocade.collision.CollisionShapeRectangle;
    import net.retrocade.enums.Direction4;

    import submuncher.core.constants.GameObjectType;
    import submuncher.core.constants.LockColor;
    import submuncher.ingame.core.Level;
    import submuncher.ingame.gameObjects.helpers.Ray;

    public class ObjectDetector extends GameObject {
        private var _color:LockColor;
        private var _rays:Vector.<Ray>;
        private var _isTriggered:Boolean;

        override public function get objectType():GameObjectType {
            return GameObjectType.DETECTOR;
        }

        override public function get isObstacle():Boolean {
            return true;
        }

        public function ObjectDetector(level:Level, x:Number, y:Number, color:LockColor) {
            super(level, x, y);

            _color = color;
            collisionShape = new CollisionShapeRectangle(x, y, 0, 0, 16, 16);
            _isTriggered = false;
            _rays = new <Ray>[
                new Ray(6, x + 5, y + 5, Direction4.UP, level),
                new Ray(6, x + 5, y + 5, Direction4.RIGHT, level),
                new Ray(6, x + 5, y + 5, Direction4.DOWN, level),
                new Ray(6, x + 5, y + 5, Direction4.LEFT, level)
            ];
        }

        override public function update():void {
            if (_isTriggered){
                return;
            }

            _rays[0].cast();
            _rays[1].cast();
            _rays[2].cast();
            _rays[3].cast();

            if (checkCollission(_rays[0]) || checkCollission(_rays[1]) || checkCollission(_rays[2]) || checkCollission(_rays[3])){
                triggered();
            }
        }

        private function checkCollission(ray:Ray):Boolean {
            var rect:CollisionShapeRectangle = ray.collisionRectangle;
            for each (var object:GameObject in level.gameObjectCollisionMap.getAllAtRectangle(rect.x, rect.y, rect.width, rect.height)) {
                switch(object.objectType){
                    case(GameObjectType.TORPEDO):
                        if (object.collisionShape.collide(rect)){
                            return true;
                        }
                        break;
                }
            }

            return false;
        }

        private function triggered():void {
            _isTriggered = true;

            for each (var object:GameObject in level.gameObjectsList.getAllOriginal()) {
                if (object.objectType === GameObjectType.BARRIER && ObjectBarrier(object).color === color){
                    ObjectBarrier(object).trigger();
                }
            }
        }

        public function get color():LockColor {
            return _color;
        }

        public function get rays():Vector.<Ray> {
            return _rays;
        }

        public function get isTriggered():Boolean {
            return _isTriggered;
        }
    }
}