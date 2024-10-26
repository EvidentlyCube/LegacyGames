package submuncher.ingame.gameObjects {
    import net.retrocade.collision.CollisionShapeRectangle;

    import submuncher.core.constants.GameObjectType;
    import submuncher.core.constants.LockColor;
    import submuncher.ingame.core.Level;

    public class ObjectFloorTrigger extends GameObject{
        private var _color:LockColor;
        private var _isHeldDown:Boolean;

        override public function get objectType():GameObjectType {
            return GameObjectType.FLOOR_TRIGGER;
        }

        override public function get isObstacle():Boolean {
            return false;
        }

        public function ObjectFloorTrigger(level:Level, x:Number, y:Number, color:LockColor) {
            super(level, x, y);

            _color = color;
            _isHeldDown = false;

            collisionShape = new CollisionShapeRectangle(x, y, 0, 0, 16, 16);
        }

        override public function update():void {
            if (isAnythingHoldingDown !== _isHeldDown){
                triggered();
            }


            super.update();
        }

        public function get isAnythingHoldingDown():Boolean{
            for each (var object:GameObject in level.gameObjectCollisionMap.getAllAt(x, y)) {
                switch(object.objectType){
                    case(GameObjectType.BARREL):
                    case(GameObjectType.PLAYER):
                    case(GameObjectType.FISH):
                    case(GameObjectType.CRATE_STRONG):
                    case(GameObjectType.CRATE_WEAK):
                    case(GameObjectType.BLOB):
                    case(GameObjectType.EEL):
                    case(GameObjectType.EEL_SEGMENT):
                    case(GameObjectType.EYE):
                    case(GameObjectType.GHOST_SUB):
                    case(GameObjectType.BULLET_SHELL):
                    case(GameObjectType.SPINNING_BLADES):
                    case(GameObjectType.TORPEDO):
                    case(GameObjectType.TURTLE):
                        if (collisionShape.collide(object.collisionShape)){
                            return true;
                        }
                        break;
                }
            }

            return false;
        }

        private function triggered():void {
            _isHeldDown = !_isHeldDown;

            for each (var object:GameObject in level.gameObjectsList.getAllOriginal()) {
                if (object.objectType === GameObjectType.BARRIER && ObjectBarrier(object).color === _color){
                    ObjectBarrier(object).trigger();
                }
            }
        }

        public function get color():LockColor {
            return _color;
        }

        public function get isHeldDown():Boolean {
            return _isHeldDown;
        }
    }
}