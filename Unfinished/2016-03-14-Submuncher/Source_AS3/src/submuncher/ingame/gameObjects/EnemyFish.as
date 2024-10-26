package submuncher.ingame.gameObjects {
    import net.retrocade.collision.CollisionShapeRectangle;

    import net.retrocade.enums.Direction4;

    import submuncher.core.constants.GameObjectType;
    import submuncher.ingame.core.Level;

    public class EnemyFish extends GameObjectMoving{
        private var _hp:uint;

        override public function get objectType():GameObjectType {
            return GameObjectType.FISH;
        }

        public function EnemyFish(level:Level, x:Number, y:Number, startingDirection:Direction4, speed:uint, hp:uint) {
            super(level, x, y);

            _hp = hp;
            _direction = startingDirection;
            this.speed = speed;

            if (startingDirection.isVertical){
                collisionShape = new CollisionShapeRectangle(x, y, 5, 1,  7, 14);

            } else {
                collisionShape = new CollisionShapeRectangle(x, y, 1, 5,  14, 7);
            }
        }


        override public function update():void {
            if (!isMoving){
                if (canMove(_direction)){
                    move(_direction);
                } else {
                    _direction = _direction.opposite;
                }
            }

            if (level.player && doesCollideWith(level.player)){
                level.player.damagedByHazard(this);
            }

            super.update();
        }

        override public function damagedByHazard(hazard:GameObject):void {
            _hp--;

            if (_hp === 0){
                destroy();
            }
        }
    }
}