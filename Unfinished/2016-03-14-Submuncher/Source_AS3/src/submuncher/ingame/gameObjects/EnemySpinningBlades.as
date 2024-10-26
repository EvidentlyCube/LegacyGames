package submuncher.ingame.gameObjects {
    import net.retrocade.collision.CollisionShapeCircle;

    import net.retrocade.utils.UtilsNumber;

    import submuncher.core.constants.GameObjectType;
    import submuncher.ingame.core.Level;

    public class EnemySpinningBlades extends GameObject{
        private var _hp:uint;
        private var _startX:Number;
        private var _startY:Number;
        private var _radius:Number;
        private var _angle:Number;
        private var _speed:Number;

        override public function get objectType():GameObjectType {
            return GameObjectType.SPINNING_BLADES;
        }

        override public function get isObstacle():Boolean {
            return true;
        }

        public function EnemySpinningBlades(level:Level, x:Number, y:Number, radius:Number, angle:Number, speed:Number, hp:uint) {
            super(level, x, y);

            _startX = x + 8;
            _startY = y + 8;
            _hp = hp;
            _radius = radius;
            _angle = angle * Math.PI / 180;
            _speed = speed * Math.PI / 180;

            collisionShape = new CollisionShapeCircle(x, y, 8, 8, 8);
            updatePosition();
        }


        override public function update():void {
            this._angle += this._speed;
            updatePosition();
            refreshCollisionShapePosition();
            if (player && doesCollideWith(player)){
                player.damagedByHazard(this);
            }
        }

        private function updatePosition():void{
            this.x = _startX + Math.cos(this._angle) * this._radius - 8;
            this.y = _startY + Math.sin(this._angle) * this._radius - 8;
        }

        override public function damagedByHazard(hazard:GameObject):void {
            _hp--;

            if (_hp === 0){
                destroy();
            }
        }

        public function get angle():Number {
            return _angle;
        }

        public function get speed():Number {
            return _speed;
        }

        public function get radius():Number {
            return _radius;
        }
    }
}