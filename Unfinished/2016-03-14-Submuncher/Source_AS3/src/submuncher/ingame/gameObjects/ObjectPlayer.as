package submuncher.ingame.gameObjects {
    import net.retrocade.collision.CollisionShapeRectangle;
    import net.retrocade.constants.KeyConst;
    import net.retrocade.enums.Direction4;
    import net.retrocade.retrocamel.core.RetrocamelInputManager;

    import submuncher.core.constants.GameObjectType;
    import submuncher.ingame.core.Level;
    import submuncher.ingame.core.Tiles;

    public class ObjectPlayer extends GameObjectMoving {
        private var _movementDirection:Direction4;
        private var _isAttemptingToMove:Boolean = false;
        private var _torpedoCooldown:uint = 0;
        private var _isFrozen:Boolean;

        override public function get objectType():GameObjectType {
            return GameObjectType.PLAYER;
        }

        public function ObjectPlayer(level:Level, x:Number, y:Number, startingDirection:Direction4) {
            super(level, x, y);

            if (startingDirection.isVertical) {
                throw new ArgumentError("Starting direction can't be vertical, given: " + startingDirection.name);
            }

            _direction = startingDirection;
            _isFrozen = false;

            speed = 10;
            collisionShape = new CollisionShapeRectangle(x, y, 4, 6, 8, 6);

            gameCommunication.onLevelCompleted.add(levelCompletedHandler);
        }

        override public function dispose():void {
            gameCommunication.onLevelCompleted.remove(levelCompletedHandler);
            _movementDirection = null;

            super.dispose();
        }

        override public function update():void {
            if (_isFrozen){
                return;
            }

            _isAttemptingToMove = false;

            if (RetrocamelInputManager.isKeyDown(KeyConst.A)) {
                _movementDirection = Direction4.LEFT;
                _isAttemptingToMove = true;
            }

            if (RetrocamelInputManager.isKeyDown(KeyConst.D)) {
                _movementDirection = Direction4.RIGHT;
                _isAttemptingToMove = true;
            }

            if (RetrocamelInputManager.isKeyDown(KeyConst.W)) {
                _movementDirection = Direction4.UP;
                _isAttemptingToMove = true;
            }

            if (RetrocamelInputManager.isKeyDown(KeyConst.S)) {
                _movementDirection = Direction4.DOWN;
                _isAttemptingToMove = true;
            }

            if (_torpedoCooldown > 0) {
                _torpedoCooldown--;
            } else {
                if (RetrocamelInputManager.isKeyDown(KeyConst.LEFT)) {
                    fireTorpedo(Direction4.LEFT);

                } else if (RetrocamelInputManager.isKeyDown(KeyConst.RIGHT)) {
                    fireTorpedo(Direction4.RIGHT);

                } else if (RetrocamelInputManager.isKeyDown(KeyConst.UP)) {
                    fireTorpedo(Direction4.UP);

                } else if (RetrocamelInputManager.isKeyDown(KeyConst.DOWN)) {
                    fireTorpedo(Direction4.DOWN);

                }
            }

            if (RetrocamelInputManager.isKeyDown(KeyConst.SPACE)) {
                speed = 16;
            } else {
                speed = 10;
            }

            if (!isMoving && _movementDirection && canMove(_movementDirection)) {
                move(_movementDirection);
            }

            super.update();
        }

        private function fireTorpedo(direction:Direction4):void {
            if (level.score.ammo > 0){
                level.score.ammo--;
                _torpedoCooldown = 30;
                gameCommunication.onGameObjectCreated.call(new BulletTorpedo(
                    level,
                        direction.isHorizontal ? preciseX : Math.floor((preciseX + 8) / 16) * 16,
                        direction.isVertical ? preciseY : Math.floor((preciseY + 8) / 16) * 16,
                    direction
                ));
            }
        }

        override public function canMove(direction:Direction4):Boolean {
            var currentTile:uint = level.tilesForeground.getTile(tileX, tileY);
            var targetTile:uint = level.tilesForeground.getTile(tileX + direction.dTileX, tileY + direction.dTileY);
            if (level.isOutsideLevel(tileX + direction.dTileX, tileY + direction.dTileY)) {
                return false;
            }

            switch (currentTile) {
                case(0):
                    break;
                case(Tiles.ARROW_UP):
                    if (direction === Direction4.DOWN) {
                        return false;
                    }
                    break;
                case(Tiles.ARROW_RIGHT):
                    if (direction === Direction4.LEFT) {
                        return false;
                    }
                    break;
                case(Tiles.ARROW_DOWN):
                    if (direction === Direction4.UP) {
                        return false;
                    }
                    break;
                case(Tiles.ARROW_LEFT):
                    if (direction === Direction4.RIGHT) {
                        return false;
                    }
                    break;
            }

            switch (targetTile) {
                case(0):
                    break;
                case(Tiles.ARROW_UP):
                    if (direction === Direction4.DOWN) {
                        return false;
                    }
                    break;
                case(Tiles.ARROW_RIGHT):
                    if (direction === Direction4.LEFT) {
                        return false;
                    }
                    break;
                case(Tiles.ARROW_DOWN):
                    if (direction === Direction4.UP) {
                        return false;
                    }
                    break;
                case(Tiles.ARROW_LEFT):
                    if (direction === Direction4.RIGHT) {
                        return false;
                    }
                    break;
                default:
                    return false;
            }

            if (isDirectionBlockedByGameObject(direction)) {
                return false;
            }

            return true;
        }


        override public function damagedByHazard(hazard:GameObject):void {
            if (!level.isLevelCompleted && isAlive && !_isFrozen) {
                gameCommunication.onPlayerDamagedBy.call(this, hazard);
                markAsNotAlive();
                _isFrozen = true;
            }
        }

        override public function move(direction:Direction4):void {
            moveHandleTargetTile(direction);
            moveHandleTargetObjects(direction);

            super.move(direction);

            if (direction.isHorizontal) {
                _direction = direction;
            }
        }

        override public function isDirectionBlockedByGameObject(direction:Direction4):Boolean {
            var isObstacle:Boolean = false;
            for each (var object:GameObject in level.gameObjectCollisionMap.getAllAt(x + direction.dX, y + direction.dY)) {
                switch (object.objectType) {
                    case(GameObjectType.BARREL):
                        break;

                    case(GameObjectType.CRATE_STRONG):
                    case(GameObjectType.CRATE_WEAK):
                        if (!_isAttemptingToMove || !ObjectCrate(object).canMove(direction)) {
                            return true;
                        }
                        break;

                    case(GameObjectType.DOOR):
                        if (!_isAttemptingToMove || level.score.getKeys(ObjectDoor(object).color) === 0){
                            return true;
                        }
                        break;

                    default:
                        isObstacle ||= object.isObstacle;
                        break;
                }
            }

            return isObstacle;
        }

        public function moveHandleTargetTile(direction:Direction4):void {
//            var targetTile:uint = level.tilesForeground.getTile(tileX + direction.dTileX, tileY + direction.dTileY);
//
//            switch (targetTile) {
//                case(Tiles.DOOR_BLUE):
//                case(Tiles.DOOR_GREEN):
//                case(Tiles.DOOR_RED):
//                case(Tiles.DOOR_GRAY):
//                case(Tiles.DOOR_ORANGE):
//                    gameCommunication.onDoorOpened.call(tileX + direction.dTileX, tileY + direction.dTileY);
//                    level.score.removeKey(LockColor.byTileId(targetTile));
//                    break;
//            }
        }

        private function moveHandleTargetObjects(direction:Direction4):void {
            for each (var object:GameObject in level.gameObjectCollisionMap.getAllAt(x + direction.dX, y + direction.dY)) {
                switch (object.objectType) {
                    case(GameObjectType.CRATE_WEAK):
                    case(GameObjectType.CRATE_STRONG):
                        ObjectCrate(object).push(direction, this);
                        break;

                    case(GameObjectType.DOOR):
                        ObjectDoor(object).open();
                        level.score.removeKey(ObjectDoor(object).color);
                        break;
                }
            }
        }

        public function get isPressingMovementKey():Boolean {
            return RetrocamelInputManager.isKeyDown(KeyConst.W)
                || RetrocamelInputManager.isKeyDown(KeyConst.S)
                || RetrocamelInputManager.isKeyDown(KeyConst.A)
                || RetrocamelInputManager.isKeyDown(KeyConst.D);
        }

        public function stopAutomaticMovement():void {
            _movementDirection = null;
        }

        private function levelCompletedHandler():void {
            _isFrozen = true;
        }

        public function get isFrozen():Boolean {
            return _isFrozen;
        }

        public function get movementDirection():Direction4 {
            return _movementDirection;
        }
    }
}