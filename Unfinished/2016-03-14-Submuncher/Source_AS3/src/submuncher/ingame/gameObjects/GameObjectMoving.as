package submuncher.ingame.gameObjects {
    import net.retrocade.enums.Direction4;

    import submuncher.core.constants.GameObjectType;
    import submuncher.ingame.core.Level;
    import submuncher.ingame.core.LevelTilesArray;
    import submuncher.ingame.core.Tiles;
    import submuncher.ingame.gameObjects.helpers.MovementCounter;

    public class GameObjectMoving extends GameObject{
        private var _prevX:Number;
        private var _prevY:Number;

        private var _speed:uint;
        private var _movementCounter:MovementCounter;
        private var _isMoving:Boolean;

        protected var _isBlockedByArrows:Boolean;
        protected var _overridePreciseX:Number = NaN;
        protected var _overridePreciseY:Number = NaN;

        public function get prevX():Number {
            return _prevX;
        }

        public function get prevY():Number {
            return _prevY;
        }

        override public function get preciseX():Number {
             return isNaN(_overridePreciseX) ? Math.round(_prevX + (x - _prevX) * _movementCounter.position) : _overridePreciseX;
        }

        override public function get preciseY():Number {
             return isNaN(_overridePreciseY) ? Math.round(_prevY + (y - _prevY) * _movementCounter.position) : _overridePreciseY;
        }

        public function get isMoving():Boolean {
            return _isMoving;
        }

        protected function get speed():uint {
            return _speed;
        }

        protected function set speed(value:uint):void {
            if (_speed !== value){
                _speed = value;
                _movementCounter.speed = value;
            }
        }

        protected function set movementCounterPosition(value:Number):void{
            _movementCounter.position = value;

            if (_isMoving && _movementCounter.isFinished()){
                level.gameObjectCollisionMap.removeSingleAt(this, _prevX, _prevY);
                _isMoving = false;
            }
        }

        public function GameObjectMoving(level:Level, x:Number, y:Number, width:uint = 16, height:uint = 16) {
            super(level, x, y, width, height);

            _prevX = x;
            _prevY = y;
            _isBlockedByArrows = true;

            _movementCounter = new MovementCounter();
        }

        override public function dispose():void {
            _movementCounter.dispose();
            _movementCounter = null;

            super.dispose();
        }

        override public function update():void {
            super.update();

            if (_isMoving){
                _movementCounter.update();
                refreshCollisionShapePosition();

                if (_movementCounter.isFinished()){
                    level.gameObjectCollisionMap.removeSingleAt(this, _prevX, _prevY);
                    _isMoving = false;
                }
            }
        }

        override protected function removeFromLevel():void {
            level.gameObjectCollisionMap.removeSingleAt(this, prevX, prevY);

            super.removeFromLevel();
        }

        public function canMove(direction:Direction4):Boolean {
            var currentTile:uint = level.tilesForeground.getTile(tileX,  tileY);
            var targetTile:uint = level.tilesForeground.getTile(tileX + direction.dTileX,  tileY + direction.dTileY);
            if (level.isOutsideLevel(tileX + direction.dTileX,  tileY + direction.dTileY)){
                return false;
            }

            switch(currentTile){
                case(0): break;
                case(Tiles.ARROW_UP): if (_isBlockedByArrows && direction === Direction4.DOWN){ return false; } break;
                case(Tiles.ARROW_RIGHT): if (_isBlockedByArrows && direction === Direction4.LEFT){ return false; } break;
                case(Tiles.ARROW_DOWN): if (_isBlockedByArrows && direction === Direction4.UP){ return false; } break;
                case(Tiles.ARROW_LEFT): if (_isBlockedByArrows && direction === Direction4.RIGHT){ return false; } break;
            }

            switch(targetTile){
                case(0): break;
                case(Tiles.ARROW_UP): if (_isBlockedByArrows && direction === Direction4.DOWN){ return false; } break;
                case(Tiles.ARROW_RIGHT): if (_isBlockedByArrows && direction === Direction4.LEFT){ return false; } break;
                case(Tiles.ARROW_DOWN): if (_isBlockedByArrows && direction === Direction4.UP){ return false; } break;
                case(Tiles.ARROW_LEFT): if (_isBlockedByArrows && direction === Direction4.RIGHT){ return false; } break;
                default:
                    return false;
            }

            if (isDirectionBlockedByGameObject(direction)){
                return false;
            }

            return true;
        }

        public function isDirectionBlockedByGameObject(direction:Direction4):Boolean{
            var targetX:Number = x + direction.dX;
            var targetY:Number = y + direction.dY;
            for each (var object:GameObject in level.gameObjectCollisionMap.getAllAtStrict(targetX, targetY)) {
                if (object.isObstacle){
                    return true;
                }
            }

            return false;
        }

        public function move(direction:Direction4):void {
            A::SSERT{ASSERT(!_isMoving);}

            _isMoving = true;
            _movementCounter.startMove(_speed);

            _prevX = x;
            _prevY = y;

            x += direction.dX;
            y += direction.dY;

            level.gameObjectCollisionMap.addSingle(this);
        }

        public function getSpeed():Number {
            return _speed;
        }

        public function getMovementCounterPosition():Number {
            return _movementCounter.position;
        }
    }
}