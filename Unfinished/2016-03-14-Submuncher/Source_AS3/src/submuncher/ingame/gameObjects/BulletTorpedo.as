package submuncher.ingame.gameObjects {
    import flash.geom.Rectangle;

    import net.retrocade.collision.CollisionShapeRectangle;

    import net.retrocade.enums.Direction4;

    import submuncher.core.constants.GameObjectType;
    import submuncher.ingame.core.Level;
    import submuncher.ingame.core.Tiles;
    import submuncher.ingame.gameObjects.GameObject;

    public class BulletTorpedo extends GameObjectMoving{
        private var speedChangeTimer:int = 0;

        override public function get objectType():GameObjectType {
            return GameObjectType.TORPEDO;
        }

        public function BulletTorpedo(level:Level, x:Number, y:Number, startingDirection:Direction4) {
            super(level, x, y);

            _isBlockedByArrows = false;
            _direction = startingDirection;
            this.speed = 10;
            speedChangeTimer = 3;

            if (startingDirection.isVertical){
                collisionShape = new CollisionShapeRectangle(x, y, 6, 4,  4, 8);

            } else {
                collisionShape = new CollisionShapeRectangle(x, y, 4, 6,  8, 4);
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

            if (speed > 3 && speedChangeTimer-- === 0){
                speedChangeTimer = 3;
                speed -= 1;
            }

            if (calculateCollisions() || isHittingWall()){
                destroy();
                return;
            }

            super.update();
        }

        private function calculateCollisions():Boolean {
            var collidable:Vector.<GameObject> = level.gameObjectCollisionMap.getAllAtRectangle(collisionX, collisionY, collisionWidth, collisionHeight);

            var hitTarget:Boolean = false;
            for each (var gameObject:GameObject in collidable) {
                if ((isTargetType(gameObject.objectType) || gameObject.isObstacle) && doesCollideWith(gameObject)){
                    hitTarget = true;
                    gameObject.damagedByHazard(this);
                }
            }

            return hitTarget;
        }

        private function isTargetType(objectType:GameObjectType):Boolean {
            return objectType === GameObjectType.EYE
                || objectType === GameObjectType.FISH
                || objectType === GameObjectType.TURTLE
                || objectType === GameObjectType.BLOB
                || objectType === GameObjectType.CRATE_STRONG
                || objectType === GameObjectType.BARREL
                || objectType === GameObjectType.CRATE_WEAK
                || objectType === GameObjectType.BOSS_FISH
                || objectType === GameObjectType.SPONGE;
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

        private function fixPositionToTile():void {
            switch(direction){
                case(Direction4.RIGHT):
                    _overridePreciseX = this.x - 13;
                    break;
                case(Direction4.LEFT):
                    _overridePreciseX = this.x + 13;
                    break;
                case(Direction4.DOWN):
                    _overridePreciseY = this.y - 13;
                    break;
                case(Direction4.UP):
                    _overridePreciseY = this.y + 13;
                    break;
            }
        }

        override public function get collisionX():Number {
            return collisionShape.x;
        }

        override public function get collisionY():Number {
            return collisionShape.y;
        }

        override public function get collisionWidth():Number {
            return CollisionShapeRectangle(collisionShape).width;
        }

        override public function get collisionHeight():Number {
            return CollisionShapeRectangle(collisionShape).height;
        }
    }
}