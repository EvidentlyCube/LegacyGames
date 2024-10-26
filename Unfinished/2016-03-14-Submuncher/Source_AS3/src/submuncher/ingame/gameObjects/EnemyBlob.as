package submuncher.ingame.gameObjects {
    import net.retrocade.collision.CollisionShapeRectangle;

    import net.retrocade.enums.Direction4;

    import submuncher.core.constants.GameObjectType;
    import submuncher.ingame.core.Level;

    public class EnemyBlob extends GameObjectMoving{
        private var _hp:uint;

        override public function get objectType():GameObjectType {
            return GameObjectType.BLOB;
        }

        override public function get isObstacle():Boolean {
            return true;
        }

        public function EnemyBlob(level:Level, x:Number, y:Number, speed:uint, hp:uint) {
            super(level, x, y);

            _hp = hp;
            _direction = Direction4.LEFT;
            this.speed = speed;

            collisionShape = new CollisionShapeRectangle(x, y, 2, 2, 12, 12);
        }

        override public function update():void {
            if (!isMoving){
                for each (var direction4:Direction4 in getDirectionToPlayer(level.player)) {
                    if (canMove(direction4)){
                        move(direction4);
                        break;
                    }
                }
            }

            if (level.player && doesCollideWith(level.player)){
                level.player.damagedByHazard(this);
            }

            super.update();
        }

        private function getDirectionToPlayer(player:ObjectPlayer):Vector.<Direction4>{
            var deltaX:int = player.x - x;
            var deltaY:int = player.y - y;

            if (deltaX === 0){
                return new <Direction4>[deltaY > 0 ? Direction4.DOWN : Direction4.UP];
            } else if (deltaY === 0){
                return new <Direction4>[deltaX > 0 ? Direction4.RIGHT : Direction4.LEFT];
            } else {
                var directions:Vector.<Direction4> = new Vector.<Direction4>();

                directions.push(deltaX > 0 ? Direction4.RIGHT : Direction4.LEFT);
                directions.push(deltaY > 0 ? Direction4.DOWN : Direction4.UP);

                if (Math.abs(deltaY) > Math.abs(deltaX)){
                    var temp:Direction4 = directions[0];
                    directions[0] = directions[1];
                    directions[1] = temp;
                }

                return directions;
            }
        }

        override public function damagedByHazard(hazard:GameObject):void {
            _hp--;

            if (_hp === 0){
                destroy();
            }
        }
    }
}