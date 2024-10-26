package submuncher.ingame.gameObjects {
    import net.retrocade.collision.CollisionShapeBase;

    import net.retrocade.enums.Direction4;
    import net.retrocade.functions.printf;
    import net.retrocade.retrocamel.components.RetrocamelUpdatableObject;
    import net.retrocade.utils.UtilsNumber;

    import submuncher.core.constants.GameObjectType;
    import submuncher.ingame.core.GameCommunication;
    import submuncher.ingame.core.Level;

    public class GameObject extends RetrocamelUpdatableObject{
        private var _id:String;
        private var _extLevel:Level;

        private var _x:Number;
        private var _y:Number;

        private var _width:uint;
        private var _height:uint;

        private var _isAlive:Boolean = true;
        private var _collisionShape:CollisionShapeBase;

        protected var _direction:Direction4;

        public function get id():String {
            return _id;
        }

        public function get level():Level {
            return _extLevel;
        }

        public function get x():Number {
            return _x;
        }

        public function set x(value:Number):void {
            _x = value;
        }

        public function get y():Number {
            return _y;
        }

        public function set y(value:Number):void {
            _y = value;
        }

        public function get tileX():uint {
             return _x / 16;
        }

        public function get tileY():uint {
             return _y / 16;
        }

        public function get preciseX():Number {
            return _x;
        }

        public function get preciseY():Number {
            return _y;
        }

        public function get collisionShape():CollisionShapeBase {
            return _collisionShape;
        }

        public function set collisionShape(value:CollisionShapeBase):void {
            _collisionShape = value;
        }

        public function get isAlive():Boolean {
            return _isAlive;
        }

        public function get direction():Direction4 {
            return _direction;
        }

        public function get objectType():GameObjectType {
            throw new Error("Abstract game object");
        }

        public function get right():Number {
             return _x + _width;
        }

        public function get bottom():Number {
             return _y + _height;
        }


        public function get width():uint {
            return _width;
        }

        public function get height():uint {
            return _height;
        }

        public function get isObstacle():Boolean {
            return false;
        }

        protected function refreshCollisionShapePosition():void {
            if (_collisionShape){
                _collisionShape.setPosition(preciseX, preciseY);
            }
        }

        public function GameObject(level:Level, x:Number, y:Number, width:uint = 16, height:uint = 16) {
            _id = level.nextGameObjectIndex + "-" + this.objectType.name;

            _extLevel = level;
            _width = width;
            _height = height;

            _x = x;
            _y = y;
            _extLevel.gameObjectCollisionMap.addSingle(this);
        }

        public function dispose():void {
            removeFromLevel();

            _extLevel = null;
            _collisionShape = null;
            _direction = null;
        }

        public function setPosition(x:Number, y:Number):void {
            _extLevel.gameObjectCollisionMap.removeSingle(this);
            _x = x;
            _y = y;
            _extLevel.gameObjectCollisionMap.addSingle(this);
        }

        protected function removeFromLevel():void {
            _extLevel.gameObjectCollisionMap.removeSingle(this);
            gameCommunication.onGameObjectRemoved.call(this);

            _isAlive = false;
        }

        public function toString():String {
            return "GameObject[" + objectType.name + "]";
        }

        public function doesCollideWith(collidee:GameObject):Boolean{
            if (_collisionShape && collidee.collisionShape){
                return _collisionShape.collide(collidee.collisionShape);

            } else {
                return false;
            }
        }

        public function get player():ObjectPlayer {
            return _extLevel.player;
        }

        public function damagedByHazard(hazard:GameObject):void {}

        public function destroy():void {
            gameCommunication.onGameObjectDestroyed.call(this);
            dispose();
        }

        public function get distanceFromPlayer():Number {
            return Math.sqrt(UtilsNumber.distanceSquared(preciseX, preciseY, player.preciseX, player.preciseY));
        }

        public function getTouchedTiles():Vector.<uint> {
            var tiles:Vector.<uint> = new Vector.<uint>();
            var tX1:Number = collisionX / 16 | 0;
            var tX2:Number = (collisionX + collisionWidth) / 16 | 0;
            var tY1:Number = collisionY / 16 | 0;
            var tY2:Number = (collisionY + collisionHeight) / 16 | 0;

            for (var x:Number = tX1; x <= tX2; x++) {
                for (var y:Number = tY1; y <= tY2; y++) {
                    tiles.push(level.tilesForeground.getTile(x, y));
                }
            }

            return tiles;
        }

        public function get gameCommunication():GameCommunication {
            return _extLevel.gameCommunication;
        }

        public function get collisionX():Number {
            throw new Error("Not implemented");
        }

        public function get collisionY():Number {
            throw new Error("Not implemented");
        }

        public function get collisionWidth():Number {
            throw new Error("Not implemented");
        }

        public function get collisionHeight():Number {
            throw new Error("Not implemented");
        }

        protected function markAsNotAlive():void{
            _isAlive = false;
        }
    }
}