package submuncher.ingame.gameObjects {
    import flash.geom.Rectangle;

    import net.retrocade.collision.CollisionShapeRectangle;

    import net.retrocade.collision.CollisionShapeRectangle;

    import net.retrocade.enums.Clockwisity;

    import net.retrocade.enums.Direction4;

    import submuncher.core.constants.GameObjectType;
    import submuncher.ingame.core.Level;
    import submuncher.ingame.gameObjects.helpers.MovementCounter;

    public class EnemyTurtle extends GameObjectMoving{
        private var _hp:uint;
        private var _clockwisity:Clockwisity;
        private var _forceMovementForwardNow:Boolean;

        private var _isInvertedRotation:Boolean;
        private var _rotationCounter:MovementCounter;

        public function get isRotating():Boolean {
             return !_rotationCounter.isFinished();
        }

        public function get rotationFactor():Number {
            return _rotationCounter.position;
        }

        public function get isInvertedRotation():Boolean {
            return _isInvertedRotation;
        }

        public function get clockwisity():Clockwisity {
            return _clockwisity;
        }

        override public function get objectType():GameObjectType {
            return GameObjectType.TURTLE;
        }

        public function EnemyTurtle(level:Level, x:Number, y:Number, startingDirection:Direction4, clockwisity:Clockwisity, speed:uint, hp:uint) {
            super(level, x, y);

            _hp = hp;
            _direction = startingDirection;
            _clockwisity = clockwisity;
            _rotationCounter = new MovementCounter();

            this.speed = speed;

            collisionShape = new CollisionShapeRectangle(x, y, 0, 0, 0, 0);
            refreshCollisionShapeArea();
        }

        override public function update():void {
            if (isRotating){
                _rotationCounter.update();

                if (_rotationCounter.position > 0.5){
                    refreshCollisionShapeArea();
                }

            } else {
                if (!isMoving){
                    if (_forceMovementForwardNow){
                        move(_direction);
                        _forceMovementForwardNow = false;

                    } else if (canMove(_direction.getRotated(_clockwisity))){
                        rotate(_clockwisity);
                        _isInvertedRotation = false;
                        _forceMovementForwardNow = true

                    } else if (canMove(_direction)){
                        move(_direction);

                    } else {
                        rotate(_clockwisity.inverse);
                        _isInvertedRotation = true;

                    }
                }
            }

            if (level.player && doesCollideWith(level.player)){
                level.player.damagedByHazard(this);
            }

            super.update();
        }

        private function rotate(clockwisity:Clockwisity):void{
            _rotationCounter.startMove(speed);
            _direction = _direction.getRotated(clockwisity);
        }

        override public function damagedByHazard(hazard:GameObject):void {
            _hp--;

            if (_hp === 0){
                destroy();
            }
        }

        private function refreshCollisionShapeArea():void {
            if (_direction.isVertical){
                collisionShape.offsetX = 4;
                collisionShape.offsetY = 1;
                CollisionShapeRectangle(collisionShape).width = 8;
                CollisionShapeRectangle(collisionShape).height = 14;
            } else {
                collisionShape.offsetX = 1;
                collisionShape.offsetY = 4;
                CollisionShapeRectangle(collisionShape).width = 14;
                CollisionShapeRectangle(collisionShape).height = 8;
            }
        }
    }
}