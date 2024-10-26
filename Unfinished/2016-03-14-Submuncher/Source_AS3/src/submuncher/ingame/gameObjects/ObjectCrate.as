package submuncher.ingame.gameObjects {
    import net.retrocade.collision.CollisionShapeRectangle;
    import net.retrocade.enums.Direction4;

    import submuncher.core.constants.GameObjectType;
    import submuncher.ingame.core.Level;

    public class ObjectCrate extends GameObjectMoving {
        private var _isStrong:Boolean;

        private var _pushedBy:GameObjectMoving;

        override public function get objectType():GameObjectType {
            return _isStrong ? GameObjectType.CRATE_STRONG : GameObjectType.CRATE_WEAK;
        }

        override public function get isObstacle():Boolean {
            return true;
        }

        public function ObjectCrate(level:Level, x:Number, y:Number, isStrong:Boolean) {
            super(level, x, y);

            _isStrong = isStrong;
            collisionShape = new CollisionShapeRectangle(x, y, 0, 0, 16, 16);
        }

        public function push(direction:Direction4, pushedBy:GameObjectMoving):void {
            A::SSERT{
                ASSERT(canMove(direction));
            }
            A::SSERT{
                ASSERT(!isMoving);
            }

            gameCommunication.onCratePushed.call(this);

            _pushedBy = pushedBy;
            speed = pushedBy.getSpeed();
            move(direction);
        }

        override public function update():void {
            if (isMoving) {
                movementCounterPosition = _pushedBy.getMovementCounterPosition();
                refreshCollisionShapePosition();
            }
        }

        override public function isDirectionBlockedByGameObject(direction:Direction4):Boolean {
            for each (var object:GameObject in level.gameObjectCollisionMap.getAllAtStrict(x + direction.dX, y + direction.dY)) {
                if (object.isObstacle || object.objectType.isEnemy) {
                    return true;
                }
            }

            return false;
        }

        public function get isStrong():Boolean {
            return _isStrong;
        }

        override public function damagedByHazard(hazard:GameObject):void {
            if (!isStrong){
                destroy();
            }
        }
    }
}