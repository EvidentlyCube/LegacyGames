package submuncher.ingame.gameObjects {
    import net.retrocade.collision.CollisionShapeRectangle;
    import net.retrocade.enums.Direction4;

    import submuncher.core.constants.GameObjectType;
    import submuncher.ingame.core.Level;
    import submuncher.ingame.gameObjects.helpers.IJellyfishSegment;

    public class EnemyJellyfishSegment extends GameObjectMoving implements IJellyfishSegment{
        private var _extHead:EnemyJellyfish;
        private var _segmentIndex:int;
        private var _extToHeadSegment:EnemyJellyfishSegment;
        private var _extToTailSegment:EnemyJellyfishSegment;

        override public function get objectType():GameObjectType {
            return GameObjectType.JELLYFISH_SEGMENT;
        }

        public function EnemyJellyfishSegment(level:Level, x:Number, y:Number, head:EnemyJellyfish, toHeadSegment:EnemyJellyfishSegment, index:int) {
            super(level, x, y);

            collisionShape = new CollisionShapeRectangle(x, y, 0, 0, 16, 16);

            var prevousElement:GameObjectMoving = toHeadSegment ? toHeadSegment : head;
            _direction = Direction4.byDeltas(prevousElement.x - x, prevousElement.y - y);

            _extHead = head;
            _extToHeadSegment = toHeadSegment;
            _segmentIndex = index;
        }

        override public function dispose():void {
            _extHead = null;
            _extToHeadSegment = null;
            _extToTailSegment = null;
            super.dispose();
        }

        override public function update():void {
            if (isMoving) {
                movementCounterPosition = _extHead.getMovementCounterPosition();
                refreshCollisionShapePosition();
            }
        }

        override public function damagedByHazard(hazard:GameObject):void {
            if (_extToHeadSegment){
                _extToHeadSegment.toTailSegment = null;
            }
            if (_extToTailSegment){
                _extToTailSegment.damagedByHazard(this);
            }

            _extHead.segmentDestroyed(this);
            destroy();

            if (hazard.objectType === GameObjectType.TORPEDO){

            }
        }

        public function set toTailSegment(value:EnemyJellyfishSegment):void {
            if (_extToTailSegment && value !== null) {
                throw new ArgumentError("Next segment is already set");
            }

            _extToTailSegment = value;


            if (_extToTailSegment){
                _direction = Direction4.byDeltas(x - _extToTailSegment.x, y - _extToTailSegment.y);
            }
        }

        override public function move(direction:Direction4):void {
            _direction = direction;
            speed = _extHead.getSpeed();
            super.move(direction);
        }

        public function headDestroyed():void {
            destroy();
        }

        override public function get isObstacle():Boolean {
            return true;
        }

        public function get head():EnemyJellyfish {
            return _extHead;
        }

        public function get segmentIndex():int {
            return _segmentIndex;
        }
    }
}