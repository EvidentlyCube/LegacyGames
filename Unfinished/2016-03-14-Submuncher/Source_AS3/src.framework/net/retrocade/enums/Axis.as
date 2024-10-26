package net.retrocade.enums {
    import flash.errors.MemoryError;

    public class Axis {
        private static var _creationLock:Boolean = false;
        private static var _collection:Vector.<Axis> = new Vector.<Axis>();

        public static var HORIZONTAL:Axis = new Axis(0, "horizontal");
        public static var VERTICAL:Axis = new Axis(1, "vertical");

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

        public function Axis(id:int, name:String) {
            if (_creationLock) {
                throw new MemoryError("Cannot create instances of Enum class");
            }

            _id = id;
            _name = name;

            _collection.push(this);
        }

        public static function byId(id:int):Axis {
            for each(var element:Axis in _collection) {
                if (element._id == id) {
                    return element;
                }
            }

            throw new ArgumentError("Invalid enum");
        }

        public static function byName(name:String):Axis {
            for each(var element:Axis in _collection) {
                if (element._name == name) {
                    return element;
                }
            }

            throw new ArgumentError("Invalid enum");
        }


        public static function hasId(id:int):Boolean {
            for each(var element:Axis in _collection) {
                if (element._id == id) {
                    return true;
                }
            }

            return false;
        }

        public static function hasName(name:String):Boolean {
            for each(var element:Axis in _collection) {
                if (element._name == name) {
                    return true;
                }
            }

            return false;
        }
    }
}
