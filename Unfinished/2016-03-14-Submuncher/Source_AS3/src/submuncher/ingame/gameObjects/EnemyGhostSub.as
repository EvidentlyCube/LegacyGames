package submuncher.ingame.gameObjects {
    import net.retrocade.collision.CollisionShapeRectangle;

    import submuncher.core.constants.GameObjectType;
    import submuncher.ingame.core.Level;

    public class EnemyGhostSub extends GameObject{
        private var _hp:uint;
        private var _playerPositions:Vector.<Number>;
        private var _delay:uint;
        private var _isActive:Boolean;
        private var _preciseX:Number;
        private var _preciseY:Number;

        override public function get objectType():GameObjectType {
            return GameObjectType.GHOST_SUB;
        }

        override public function get isObstacle():Boolean {
            return false;
        }

        public function EnemyGhostSub(level:Level, x:Number, y:Number, delay:uint, hp:uint) {
            super(level, x, y);

            _hp = hp;
            _delay = delay;
            _isActive = false;
            _playerPositions = new Vector.<Number>();
            _preciseX = x;
            _preciseY = y;
        }

        override public function update():void {
            if (_isActive){
                _playerPositions.push(player.preciseX);
                _playerPositions.push(player.preciseY);

                if (_delay > 0){
                    _delay--;

                    if (_delay === 0){
                        collisionShape = new CollisionShapeRectangle(x, y, 4, 6, 8, 6);
                    }
                } else {
                    _preciseX = _playerPositions.shift();
                    _preciseY = _playerPositions.shift();
                    refreshCollisionShapePosition();
                }

                if (doesCollideWith(player)){
                    player.damagedByHazard(this);
                }
            } else if (player.x === x && player.y === y && !player.isMoving){
                _isActive = true;
            }
        }

        override public function damagedByHazard(hazard:GameObject):void {
            _hp--;

            if (_hp === 0){
                destroy();
            }
        }

        override public function get preciseX():Number {
            return _preciseX;
        }

        override public function get preciseY():Number {
            return _preciseY;
        }

        public function get isActive():Boolean {
            return _delay === 0;
        }
    }
}