

package net.retrocade.log {
    import flash.errors.MemoryError;

    public class LogType {
        private static var _creationLock:Boolean = false;
        private static var _collection:Vector.<LogType> = new Vector.<LogType>();

        public static var DEBUG:LogType = new LogType(0, "<D>");
        public static var MESSAGE:LogType = new LogType(1, "<M>");
        public static var WARNING:LogType = new LogType(2, "<W>");
        public static var ERROR:LogType = new LogType(3, "<E>");

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

        public function LogType(id:int, name:String, metadata:Object = null) {
            if (_creationLock) {
                throw new MemoryError("Cannot create instances of Enum class");
            }

            _id = id;
            _name = name;
            _metadata = metadata;

            _collection.push(this);
        }

        public static function byId(id:int):LogType {
            for each(var element:LogType in _collection) {
                if (element._id == id) {
                    return element;
                }
            }

            throw new ArgumentError("Invalid enum");
        }

        public static function byName(name:String):LogType {
            for each(var element:LogType in _collection) {
                if (element._name == name) {
                    return element;
                }
            }

            throw new ArgumentError("Invalid enum");
        }


        public static function hasId(id:int):Boolean {
            for each(var element:LogType in _collection) {
                if (element._id == id) {
                    return true;
                }
            }

            return false;
        }

        public static function hasName(name:String):Boolean {
            for each(var element:LogType in _collection) {
                if (element._name == name) {
                    return true;
                }
            }

            return false;
        }
    }
}
