

package net.retrocade.random {
    import flash.errors.MemoryError;

    public class RandomEngineType {
        private static var _creationLock:Boolean = false;
        private static var _collection:Vector.<RandomEngineType> = new Vector.<RandomEngineType>();

        public static var KISS:RandomEngineType = new RandomEngineType(0, "kiss", RandomEngineKiss);
        public static var LGM_1969:RandomEngineType = new RandomEngineType(1, "lgm_1969", RandomEngineLGM1969);

        {
            _creationLock = true;
        }

        private var _id:int;
        private var _name:String;
        private var _metadata:Object;

        public function get id():int {
            return _id;
        }

        public function get name():String {
            return _name;
        }

        public function get metadata():Object {
            return _metadata;
        }

        public function get engineClass():Class{
            return _metadata as Class;
        }

        public function RandomEngineType(id:int, name:String, metadata:Object = null) {
            if (_creationLock) {
                throw new MemoryError("Cannot create instances of Enum class");
            }

            _id = id;
            _name = name;
            _metadata = metadata;

            _collection.push(this);
        }

        public static function byId(id:int):RandomEngineType {
            for each(var element:RandomEngineType in _collection) {
                if (element._id == id) {
                    return element;
                }
            }

            throw new ArgumentError("Invalid enum");
        }

        public static function byName(name:String):RandomEngineType {
            for each(var element:RandomEngineType in _collection) {
                if (element._name == name) {
                    return element;
                }
            }

            throw new ArgumentError("Invalid enum");
        }


        public static function hasId(id:int):Boolean {
            for each(var element:RandomEngineType in _collection) {
                if (element._id == id) {
                    return true;
                }
            }

            return false;
        }

        public static function hasName(name:String):Boolean {
            for each(var element:RandomEngineType in _collection) {
                if (element._name == name) {
                    return true;
                }
            }

            return false;
        }
    }
}
