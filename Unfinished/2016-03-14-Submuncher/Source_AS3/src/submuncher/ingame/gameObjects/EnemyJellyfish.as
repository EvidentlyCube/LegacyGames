package submuncher.ingame.gameObjects {
    import flash.geom.Point;

    import net.retrocade.collision.CollisionShapeRectangle;
    import net.retrocade.enums.Direction4;

    import submuncher.core.constants.GameObjectType;
    import submuncher.ingame.core.Level;
    import submuncher.ingame.gameObjects.helpers.IJellyfishSegment;
    import submuncher.ingame.gameObjects.helpers.Ray;

    public class EnemyJellyfish extends GameObjectMoving implements IJellyfishSegment {
        private var _hp:uint;
        private var _ray:Ray;
        private var _isStopped:Boolean;
        private var _points:Vector.<Point>;
        private var _extSegments:Vector.<EnemyJellyfishSegment>;

        override public function get objectType():GameObjectType {
            return GameObjectType.JELLYFISH;
        }

        public function EnemyJellyfish(level:Level, x:Number, y:Number, points:Vector.<Point>, speed:uint, hp:uint) {
            super(level, x, y);

            A::SSERT{
                ASSERT(points.length > 0);
            }

            _direction = Direction4.byDeltas(x - points[0].x, y - points[0].y);

            _hp = hp;
            _ray = new Ray(1, x + 8, y + 8, null, level);
            _isStopped = true;
            _points = points;

            this.speed = speed;

            collisionShape = new CollisionShapeRectangle(x, y, 0, 0, 16, 16);

            gameCommunication.afterLevelLoaded.add(createSegments);
        }

        override public function dispose():void {
            gameCommunication.afterLevelLoaded.remove(createSegments);

            _ray.dispose();

            _extSegments = null;
            _points = null;
            _ray = null;

            super.dispose();
        }

        private function createSegments():void {
            gameCommunication.afterLevelLoaded.remove(createSegments);

            _extSegments = new Vector.<EnemyJellyfishSegment>();

            var lastSegment:EnemyJellyfishSegment = null;
            for each (var point:Point in _points) {
                var segment:EnemyJellyfishSegment = new EnemyJellyfishSegment(level, point.x, point.y, this, lastSegment, _extSegments.length + 1);

                if (lastSegment) {
                    lastSegment.toTailSegment = segment;
                }

                gameCommunication.onGameObjectCreated.call(segment);

                _extSegments.push(segment);
                lastSegment = segment;
            }
        }

        override public function update():void {
            if (!_isStopped) {
                if (!isMoving) {
                    if (canMove(_direction)) {
                        move(_direction);
                    } else {
                        _isStopped = true;
                    }
                }
            } else {
                if (player.x === x || player.y === y) {
                    _ray.startX = x + 8;
                    _ray.startY = y + 8;
                    _ray.direction = Direction4.byDeltas(player.x - x, player.y - y);

                    if (_ray.direction === direction.opposite) {
                        return;
                    }

                    _ray.cast();

                    if (player.collisionShape.collide(_ray.collisionRectangle) && canMove(_ray.direction)) {
                        _isStopped = false;
                        _direction = _ray.direction;
                        move(_direction);
                    }
                }
            }

            if (level.player && doesCollideWith(level.player)) {
                level.player.damagedByHazard(this);
            }

            super.update();
        }

        override public function damagedByHazard(hazard:GameObject):void {
            _hp--;

            if (_hp === 0) {
                for each (var segment:EnemyJellyfishSegment in _extSegments) {
                    segment.headDestroyed();
                }

                destroy();
            }
        }


        override public function move(direction:Direction4):void {
            super.move(direction);

            var segment:EnemyJellyfishSegment;
            var oldSegment:GameObjectMoving = this;
            for each (segment in _extSegments) {
                segment.move(Direction4.byDeltas(oldSegment.prevX - segment.x, oldSegment.prevY - segment.y));
                oldSegment = segment;
            }
        }

        public function segmentDestroyed(segment:EnemyJellyfishSegment):void {
            _extSegments.splice(_extSegments.indexOf(segment), 1);
        }

        public function get isStopped():Boolean {
            return _isStopped;
        }

        override public function get isObstacle():Boolean {
            return true;
        }

        public function get head():EnemyJellyfish {
            return this;
        }
    }
}