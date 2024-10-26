package submuncher.ingame.gameObjects {
    import net.retrocade.collision.CollisionShapeCircle;

    import net.retrocade.enums.Direction4;
    import net.retrocade.utils.UtilsNumber;

    import submuncher.core.constants.GameObjectType;
    import submuncher.ingame.core.GameCommunication;
    import submuncher.ingame.core.Level;

    public class EnemyShell extends GameObject{
        private var _hp:uint;
        private var _firePause:uint;
        private var _bulletSpeed:uint;
        private var _fireWaiter:uint;
        private var _isPlayerInAttackablePosition:Boolean;

        override public function get objectType():GameObjectType {
            return GameObjectType.SHELL;
        }

        override public function get isObstacle():Boolean {
            return true;
        }

        public function EnemyShell(level:Level, x:Number, y:Number, startingDirection:Direction4, firePause:uint, bulletSpeed:uint, hp:uint) {
            super(level, x, y);

            _hp = hp;
            _firePause = firePause;
            _bulletSpeed = bulletSpeed;
            _fireWaiter = 0;
            _direction = startingDirection;
            collisionShape = new CollisionShapeCircle(x, y, 8, 8, 8);
        }


        override public function update():void {
            _isPlayerInAttackablePosition = (player && checkIfPlayerInAttackablePosition(player));

            if (_fireWaiter === 0){
                if (_isPlayerInAttackablePosition){
                    _fireWaiter = _firePause;
                    gameCommunication.onGameObjectCreated.call(new BulletShellAcid(level, x, y, direction, _bulletSpeed));
                }
            } else {
                _fireWaiter--;
            }

            super.update();
        }

        private function checkIfPlayerInAttackablePosition(player:ObjectPlayer):Boolean {
            var xDelta:int = player.preciseX - x;
            var yDelta:int = player.preciseY - y;

            if (_direction.isHorizontal){
                return Math.abs(yDelta) <= 16
                    && Math.abs(xDelta) >= 16
                    && UtilsNumber.sign(xDelta) === _direction.dTileX;
            } else {
                return Math.abs(xDelta) <= 16
                    && Math.abs(yDelta) >= 16
                    && UtilsNumber.sign(yDelta) === _direction.dTileY;
            }
        }

        override public function damagedByHazard(hazard:GameObject):void {
            _hp--;

            if (_hp === 0){
                destroy();
            }
        }

        public function get fireWaiter():uint {
            return _fireWaiter;
        }

        public function get hasJustFired():Boolean {
            return _fireWaiter === _firePause
        }


        public function get isPlayerInAttackablePosition():Boolean {
            return _isPlayerInAttackablePosition;
        }
    }
}