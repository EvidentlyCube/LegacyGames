package net.retrocade.enums {
    import flash.errors.MemoryError;

    public class Direction4 {
        private static var _creationLock:Boolean = false;
        private static var _collection:Vector.<Direction4> = new Vector.<Direction4>();

        public static var UP:Direction4 = new Direction4(0, "up", 0, -1, -Math.PI / 2);
        public static var RIGHT:Direction4 = new Direction4(1, "right", 1, 0, 0);
        public static var DOWN:Direction4 = new Direction4(2, "down", 0, 1, Math.PI / 2);
        public static var LEFT:Direction4 = new Direction4(3, "left", -1, 0, Math.PI);

        {
            UP.setProperties(RIGHT, LEFT, DOWN);
            RIGHT.setProperties(DOWN, UP, LEFT);
            DOWN.setProperties(LEFT, RIGHT, UP);
            LEFT.setProperties(UP, DOWN, RIGHT);

            _creationLock = true;
        }

        private var _id:int;
        private var _name:String;
        private var _dTileX:int;
        private var _dTileY:int;
        private var _dX:int;
        private var _dY:int;
        private var _radians:Number;
        private var _nextClockwise:Direction4;
        private var _nextCounterClockwise:Direction4;
        private var _invert:Direction4;

        public function get id():int {
            return _id;
        }

        public function get name():String {
            return _name;
        }

        public function get dTileX():int {
            return _dTileX;
        }

        public function get dTileY():int {
            return _dTileY;
        }

        public function get dX():int {
            return _dX;
        }

        public function get dY():int {
            return _dY;
        }

        public function get nextClockwise():Direction4 {
            return _nextClockwise;
        }

        public function get nextCounterClockwise():Direction4 {
            return _nextCounterClockwise;
        }

        public function get opposite():Direction4 {
            return _invert;
        }

        public function get isVertical():Boolean {
             return this === DOWN || this === UP;
        }

        public function get isHorizontal():Boolean {
             return this === LEFT || this === RIGHT;
        }

        public function get radians():Number {
            return _radians;
        }

        public function getHalfAngleTo(direction:Direction4):Number {
            if (direction === nextClockwise){
                return radians + Math.PI / 4;
            } else if (direction === nextCounterClockwise){
                return radians - Math.PI / 4;
            } else {
                return radians;
            }
        }

        public function getRotated(clockwisity:Clockwisity):Direction4 {
            if (clockwisity.isCW){
                return nextClockwise;
            } else {
                return nextCounterClockwise;
            }
        }

        internal function setProperties(cc:Direction4, ccw:Direction4, invert:Direction4):void{
            _nextClockwise = cc;
            _nextCounterClockwise = ccw;
            _invert = invert;
        }

        public function Direction4(id:int, name:String, dx:int, dy:int, directionRadians:Number) {
            if (_creationLock) {
                throw new MemoryError("Cannot create instances of Enum class");
            }

            _id = id;
            _name = name;
            _dTileX = dx;
            _dTileY = dy;
            _dX = dx * 16;
            _dY = dy * 16;
            _radians = directionRadians;

            _collection.push(this);
        }

        public static function byId(id:int):Direction4 {
            for each(var element:Direction4 in _collection) {
                if (element._id == id) {
                    return element;
                }
            }

            throw new ArgumentError("Invalid enum");
        }

        public static function byName(name:String):Direction4 {
            for each(var element:Direction4 in _collection) {
                if (element._name == name) {
                    return element;
                }
            }

            throw new ArgumentError("Invalid enum");
        }


        public static function hasId(id:int):Boolean {
            for each(var element:Direction4 in _collection) {
                if (element._id == id) {
                    return true;
                }
            }

            return false;
        }

        public static function hasName(name:String):Boolean {
            for each(var element:Direction4 in _collection) {
                if (element._name == name) {
                    return true;
                }
            }

            return false;
        }

        public static function byDeltas(dX:Number, dY:Number):Direction4 {
            if (dX !== 0 && dY !== 0){
                throw new ArgumentError("Can't work with diagonals");
            } else if (dX > 0){
                return RIGHT;
            } else if (dX < 0){
                return LEFT;
            } else if (dY > 0){
                return DOWN;
            } else if (dY < 0){
                return UP;
            } else {
                throw new ArgumentError("Must not be zero");
            }
        }

        public static function isDiagonal(dX:Number, dY:Number):Boolean {
            return dX !== 0  && dY !=- 0;
        }
    }
}
