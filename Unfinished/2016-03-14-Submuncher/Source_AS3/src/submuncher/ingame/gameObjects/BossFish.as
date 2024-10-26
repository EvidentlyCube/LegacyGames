package submuncher.ingame.gameObjects {
    import net.retrocade.collision.CollisionShapeRectangle;
    import net.retrocade.enums.Direction4;
    import net.retrocade.utils.UtilsNumber;

    import submuncher.core.constants.GameEvent;
    import submuncher.core.constants.GameObjectType;
    import submuncher.ingame.core.Level;

    public class BossFish extends GameObjectMoving {
        private var _hp:uint;
        private var _isActive:Boolean;

        private var _chargesLeft:uint;
        private var _chargePause:uint;

        private var _firingDuration:uint;
        private var _nextFireWait:uint;

        private var _preciseSpeed:Number;
        private var _isCharging:Boolean;

        private var _shieldTimeout:uint

        override public function get objectType():GameObjectType {
            return GameObjectType.BOSS_FISH;
        }

        public function BossFish(level:Level, x:Number, y:Number) {
            super(level, x, y, 48, 48);

            _hp = 6;
            this.speed = 12;


            _isActive = true;
            _chargesLeft = CHARGES;
            _chargePause = 0;
            _firingDuration = FIRING_DURATION;
            _nextFireWait = 0;
            _shieldTimeout = 0;

            _direction = Direction4.RIGHT;

            collisionShape = new CollisionShapeRectangle(x, y, 0, 0, width, height);
            level.gameObjectCollisionMap.addMultiTile(this);
        }


        override public function update():void {
            if (_shieldTimeout > 0){
                _shieldTimeout--;
            }

            if (!isMoving) {
                if (_isCharging) {
                    if (canMove(_direction)) {
                        move(_direction);
                    } else {
                        gameCommunication.onGameObjectCreated.call(new BulletPenetratingLaser(level, x + 16, y + 16, 45, 2));
                        gameCommunication.onGameObjectCreated.call(new BulletPenetratingLaser(level, x + 16, y + 16, 45 + 90, 2));
                        gameCommunication.onGameObjectCreated.call(new BulletPenetratingLaser(level, x + 16, y + 16, -45, 2));
                        gameCommunication.onGameObjectCreated.call(new BulletPenetratingLaser(level, x + 16, y + 16, -45 - 90, 2));

                        _isCharging = false;
                        gameCommunication.onEvent.call(GameEvent.FISH_BOSS_WALL_HEADBUTT, this);
                    }
                } else if (_chargePause > 0) {
                    _chargePause--;
                } else if (_chargesLeft) {
                    _chargesLeft--;
                    _chargePause = CHARGE_PAUSE;

                    for each (var direction:Direction4 in approximatePlayerDirection()) {
                        if (canMove(direction)) {
                            move(direction);
                            level.gameObjectCollisionMap.addMultiTile(this);
                            _direction = direction;
                            _preciseSpeed = 20;
                            _isCharging = true;
                            speed = _preciseSpeed;
                            break;
                        }
                    }
                } else if (_firingDuration > 0) {
                    _firingDuration--;
                    if (_nextFireWait === 0) {
                        _nextFireWait = FIRE_PAUSE;
                        fire();
                    } else {
                        _nextFireWait--;
                    }
                } else {
                    _chargePause = CHARGE_PAUSE_AFTER_FIRING;
                    _chargesLeft = CHARGES;
                    _firingDuration = FIRING_DURATION;
                    _nextFireWait = 0;
                }
            } else {
                if (_preciseSpeed > 1) {
                    _preciseSpeed -= 1;
                }
                speed = _preciseSpeed | 0;

                super.update();
                if (!isMoving){
                    level.gameObjectCollisionMap.removeMultiTileAt(this, prevX, prevY);
                    level.gameObjectCollisionMap.addMultiTile(this);
                }
            }

            if (level.player && doesCollideWith(level.player)) {
                level.player.damagedByHazard(this);
            }
        }

        private function fire():void {
            gameCommunication.onGameObjectCreated.call(new BulletShellAcid(level, x, y, Direction4.UP, 5));
            gameCommunication.onGameObjectCreated.call(new BulletShellAcid(level, x + 16, y, Direction4.UP, 5));
            gameCommunication.onGameObjectCreated.call(new BulletShellAcid(level, x + 32, y, Direction4.UP, 5));
            gameCommunication.onGameObjectCreated.call(new BulletShellAcid(level, x, y + 32, Direction4.DOWN, 5));
            gameCommunication.onGameObjectCreated.call(new BulletShellAcid(level, x + 16, y + 32, Direction4.DOWN, 5));
            gameCommunication.onGameObjectCreated.call(new BulletShellAcid(level, x + 32, y + 32, Direction4.DOWN, 5));

            gameCommunication.onGameObjectCreated.call(new BulletShellAcid(level, x, y, Direction4.LEFT, 5));
            gameCommunication.onGameObjectCreated.call(new BulletShellAcid(level, x, y + 16, Direction4.LEFT, 5));
            gameCommunication.onGameObjectCreated.call(new BulletShellAcid(level, x, y + 32, Direction4.LEFT, 5));
            gameCommunication.onGameObjectCreated.call(new BulletShellAcid(level, x + 32, y, Direction4.RIGHT, 5));
            gameCommunication.onGameObjectCreated.call(new BulletShellAcid(level, x + 32, y + 16, Direction4.RIGHT, 5));
            gameCommunication.onGameObjectCreated.call(new BulletShellAcid(level, x + 32, y + 32, Direction4.RIGHT, 5));

        }

        override public function canMove(direction:Direction4):Boolean {
            var offsetX:int = direction === Direction4.RIGHT ? 2 : 0;
            var offsetY:int = direction === Direction4.DOWN ? 2 : 0;
            var dX:int = direction.isHorizontal ? 0 : 1;
            var dY:int = direction.isVertical ? 0 : 1;
            for (var i:int = 0; i < width / 16; i++) {
                var targetTile:uint = level.tilesForeground.getTile(tileX + offsetX + dX * i + direction.dTileX, tileY + offsetY + dY * i + direction.dTileY);

                if (targetTile) {
                    return false;
                }
            }

            return true;
        }

        override public function damagedByHazard(hazard:GameObject):void {
            if (_shieldTimeout > 0){
                return;
            }

            _hp--;
            _shieldTimeout = SHIELD_TIMEOUT_MAX;

            if (_hp === 0) {
                level.isLevelCompleted = true;
//                level.gameCommunication.onLevelCompleted.call(level);
                destroy();
            }
        }

        private function approximatePlayerDirection():Vector.<Direction4> {
            var directions:Vector.<Direction4> = new Vector.<Direction4>();

            var dX:Number = player.preciseX - preciseX;
            var dY:Number = player.preciseY - preciseY;

            var cw:Direction4 = _direction.nextClockwise;
            var ccw:Direction4 = _direction.nextCounterClockwise;

            if (UtilsNumber.distanceSquared(cw.dX, cw.dY, dX, dY) < UtilsNumber.distanceSquared(ccw.dX, ccw.dY, dX, dY)){
                directions.push(_direction.nextClockwise);
                directions.push(_direction.nextCounterClockwise);
            } else {
                directions.push(_direction.nextCounterClockwise);
                directions.push(_direction.nextClockwise);
            }
            directions.push(_direction.opposite);
            directions.push(_direction);

            return directions;
        }

        private function get CHARGES():int {
            return 3;
        }

        private function get CHARGE_PAUSE():int {
            return 15;
        }

        private function get CHARGE_PAUSE_AFTER_FIRING():int {
            return 60;
        }

        private function get FIRING_DURATION():int {
            return 60;
        }

        private function get FIRE_PAUSE():int {
            return 10;
        }

        public function get SHIELD_TIMEOUT_MAX():int {
            return 30;
        }

        public function get shieldTimeout():uint {
            return _shieldTimeout;
        }
    }
}