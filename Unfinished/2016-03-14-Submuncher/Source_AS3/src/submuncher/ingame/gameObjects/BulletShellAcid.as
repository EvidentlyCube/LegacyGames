package submuncher.ingame.gameObjects {
    import net.retrocade.collision.CollisionShapeCircle;
    import net.retrocade.collision.CollisionShapeRectangle;

    import net.retrocade.enums.Direction4;

    import submuncher.core.constants.GameObjectType;
    import submuncher.ingame.core.Level;
    import submuncher.ingame.core.Tiles;

    public class BulletShellAcid extends GameObjectMoving{
        override public function get objectType():GameObjectType {
            return GameObjectType.BULLET_SHELL;
        }

        public function BulletShellAcid(level:Level, x:Number, y:Number, startingDirection:Direction4, speed:uint) {
            super(level, x, y);

            _isBlockedByArrows = false;
            _direction = startingDirection;
            this.speed = speed;

            if (startingDirection.isHorizontal){
                collisionShape = new CollisionShapeRectangle(x, y, 2, 5, 12, 6);
            } else {
                collisionShape = new CollisionShapeRectangle(x, y, 5, 2, 6, 12);
            }
        }


        override public function update():void {
            if (calculateCollisions()){
                destroy();
                return;
            }

            if (!isMoving){
                move(_direction);
            }

            super.update();

            if (calculateCollisions() || isHittingWall()){
                destroy();
                return;
            }
        }

        private function fixPositionToTile():void {
            switch(direction){
                case(Direction4.RIGHT):
                    _overridePreciseX = this.x - 14;
                    break;
                case(Direction4.LEFT):
                    _overridePreciseX = this.x + 14;
                    break;
                case(Direction4.DOWN):
                    _overridePreciseY = this.y - 14;
                    break;
                case(Direction4.UP):
                    _overridePreciseY = this.y + 14;
                    break;
            }
        }

        private function calculateCollisions():Boolean {
            var collidable:Vector.<GameObject> = level.gameObjectCollisionMap.getAllAtRectangle(collisionX, collisionY, collisionWidth, collisionHeight);

            var hitTarget:Boolean = false;
            for each (var gameObject:GameObject in collidable) {
                if (isTargetType(gameObject.objectType) && doesCollideWith(gameObject)){
                    hitTarget = true;
                    gameObject.damagedByHazard(this);
                }
            }

            return hitTarget;
        }

        private function isHittingWall():Boolean {
            for each (var tile:uint in getTouchedTiles()) {
                switch(tile){
                    case(0):
                    case(Tiles.ARROW_DOWN):
                    case(Tiles.ARROW_LEFT):
                    case(Tiles.ARROW_RIGHT):
                    case(Tiles.ARROW_UP):
                        break;
                    default:
                        fixPositionToTile();
                        return true;
                }
            }

            return false;
        }

        override public function isDirectionBlockedByGameObject(direction:Direction4):Boolean {
            for each (var object:GameObject in level.gameObjectCollisionMap.getAllAtStrict(x + direction.dX, y + direction.dY)) {
                if (!isTargetType(object.objectType) && object.isObstacle){
                    return true;
                }
            }

            return false;
        }

        private function isTargetType(objectType:GameObjectType):Boolean {
            return objectType === GameObjectType.EYE
                || objectType === GameObjectType.FISH
                || objectType === GameObjectType.TURTLE
                || objectType === GameObjectType.BLOB
                || objectType === GameObjectType.CRATE_STRONG
                || objectType === GameObjectType.BARREL
                || objectType === GameObjectType.CRATE_WEAK
                || objectType === GameObjectType.PLAYER;

        }

        override public function get collisionX():Number {
            return preciseX + 3;
        }

        override public function get collisionY():Number {
            return preciseY + 3;
        }

        override public function get collisionWidth():Number {
            return 10;
        }

        override public function get collisionHeight():Number {
            return 10;
        }
    }
}