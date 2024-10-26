package submuncher.ingame.gameObjects {
    import net.retrocade.collision.CollisionShapeRectangle;
    import net.retrocade.enums.Direction4;

    import submuncher.core.constants.GameObjectType;
    import submuncher.ingame.core.Level;
    import submuncher.ingame.gameObjects.helpers.IEelSegment;

    public class EnemyEelSegment extends GameObjectMoving implements IEelSegment{
        private var _extHead:EnemyEel;
        private var _lastAngle:Number;
        private var _extPreviousSegment:EnemyEelSegment;
        private var _extNextSegment:IEelSegment;

        override public function get objectType():GameObjectType {
            return GameObjectType.EEL_SEGMENT;
        }

        public function EnemyEelSegment(level:Level, x:Number, y:Number, head:EnemyEel, previousSegment:EnemyEelSegment) {
            super(level, x, y);

            collisionShape = new CollisionShapeRectangle(x, y, 0, 0, 16, 16);

            var prevousElement:GameObjectMoving = previousSegment ? previousSegment : head;
            _direction = Direction4.byDeltas(prevousElement.x - x, prevousElement.y - y);

            _extHead = head;
            _extPreviousSegment = previousSegment;
        }

        override public function dispose():void {
            _extHead = null;
            _extPreviousSegment = null;
            _extNextSegment = null;
            super.dispose();
        }

        override public function update():void {
            if (isMoving) {
                movementCounterPosition = _extHead.getMovementCounterPosition();
                refreshCollisionShapePosition();
            }
        }

        override public function damagedByHazard(hazard:GameObject):void {
            _extHead.damagedByHazard(hazard);
        }

        public function set nextSegment(value:IEelSegment):void {
            if (_extNextSegment) {
                throw new ArgumentError("Next segment is already set");
            }

            _extNextSegment = value;
            _direction = Direction4.byDeltas(x - _extNextSegment.x, y - _extNextSegment.y);
        }

        override public function move(direction:Direction4):void {
            _direction = direction;
            speed = _extHead.getSpeed();
            super.move(direction);
        }

        public function prepareToMove():void {
            _lastAngle = getAngle();
        }

        public function headDestroyed():void {
            destroy();
        }

        override public function get isObstacle():Boolean {
            return true;
        }

        public function get isTurnSegment():Boolean {
            if (_extPreviousSegment){
                return _extPreviousSegment.direction !== direction;
            } else {
                return _extHead.direction !== direction;
            }
        }

        public function getAngle():Number {
            if (isTurnSegment){
                return _direction.getHalfAngleTo(_extPreviousSegment ? _extPreviousSegment.direction : _extHead.direction);
            } else {
                return direction.radians;
            }
        }

        public function get lastAngle():Number {
            return _lastAngle;
        }

        public function get previousSegment():EnemyEelSegment {
            return _extPreviousSegment;
        }

        public function get nextSegment():IEelSegment {
            return _extNextSegment;
        }

        public function get head():EnemyEel {
            return _extHead;
        }
    }
}