package net.retrocade.enums {
    import flash.errors.MemoryError;

    public class Clockwisity {
        private static var _creationLock:Boolean = false;
        private static var _collection:Vector.<Clockwisity> = new Vector.<Clockwisity>();

        public static var CLOCKWISE:Clockwisity = new Clockwisity(0, "cw");
        public static var COUNTER_CLOCKWISE:Clockwisity = new Clockwisity(1, "ccw");

        {
            _creationLock = true;
        }

        private var _id:int;
        private var _name:String;

        public function get id():int {
            return _id;
        }

        public function get name():String {
            return _name;
        }

        public function get isCW():Boolean {
              return this === CLOCKWISE;
        }

        public function get isCCW():Boolean {
              return this === COUNTER_CLOCKWISE;
        }

        public function get inverse():Clockwisity {
             return this === CLOCKWISE ? COUNTER_CLOCKWISE : CLOCKWISE;
        }

        public function Clockwisity(id:int, name:String) {
            if (_creationLock) {
                throw new MemoryError("Cannot create instances of Enum class");
            }

            _id = id;
            _name = name;

            _collection.push(this);
        }

        public static function byId(id:int):Clockwisity {
            for each(var element:Clockwisity in _collection) {
                if (element._id == id) {
                    return element;
                }
            }

            throw new ArgumentError("Invalid enum");
        }

        public static function byName(name:String):Clockwisity {
            for each(var element:Clockwisity in _collection) {
                if (element._name == name) {
                    return element;
                }
            }

            throw new ArgumentError("Invalid enum");
        }


        public static function hasId(id:int):Boolean {
            for each(var element:Clockwisity in _collection) {
                if (element._id == id) {
                    return true;
                }
            }

            return false;
        }

        public static function hasName(name:String):Boolean {
            for each(var element:Clockwisity in _collection) {
                if (element._name == name) {
                    return true;
                }
            }

            return false;
        }
    }
}
