package submuncher.core.constants {
    import flash.errors.MemoryError;

    public class GameFileType {
        private static var _creationLock:Boolean = false;
        private static var _collection:Vector.<GameFileType> = new Vector.<GameFileType>();

        public static var BITMAP:GameFileType = new GameFileType(0, "bitmap");
        public static var AUDIO:GameFileType = new GameFileType(1, "audio");
        public static var DATA:GameFileType = new GameFileType(2, "data");

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

        public function GameFileType(id:int, name:String) {
            if (_creationLock) {
                throw new MemoryError("Cannot create instances of Enum class");
            }

            _id = id;
            _name = name;

            _collection.push(this);
        }

        public static function byId(id:int):GameFileType {
            for each(var element:GameFileType in _collection) {
                if (element._id == id) {
                    return element;
                }
            }

            throw new ArgumentError("Invalid enum");
        }

        public static function byName(name:String):GameFileType {
            for each(var element:GameFileType in _collection) {
                if (element._name == name) {
                    return element;
                }
            }

            throw new ArgumentError("Invalid enum");
        }


        public static function hasId(id:int):Boolean {
            for each(var element:GameFileType in _collection) {
                if (element._id == id) {
                    return true;
                }
            }

            return false;
        }

        public static function hasName(name:String):Boolean {
            for each(var element:GameFileType in _collection) {
                if (element._name == name) {
                    return true;
                }
            }

            return false;
        }
    }
}
