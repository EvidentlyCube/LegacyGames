package submuncher.core.constants {
    import flash.errors.MemoryError;

    import submuncher.ingame.core.Tiles;

    public class LockColor {
        private static var _idCounter:uint = 0;
        private static var _creationLock:Boolean = false;
        private static var _collection:Vector.<LockColor> = new Vector.<LockColor>();

        public static var RED:LockColor = new LockColor("red");
        public static var GREEN:LockColor = new LockColor("green");
        public static var BLUE:LockColor = new LockColor("blue");
        public static var ORANGE:LockColor = new LockColor("orange");
        public static var GRAY:LockColor = new LockColor("gray");

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

        public function LockColor(name:String) {
            if (_creationLock) {
                throw new MemoryError("Cannot create instances of Enum class");
            }

            _id = _idCounter++;
            _name = name;

            _collection.push(this);
        }

        public static function byId(id:int):LockColor {
            for each(var element:LockColor in _collection) {
                if (element._id == id) {
                    return element;
                }
            }

            throw new ArgumentError("Invalid enum");
        }

        public static function byName(name:String):LockColor {
            for each(var element:LockColor in _collection) {
                if (element._name == name) {
                    return element;
                }
            }

            throw new ArgumentError("Invalid enum");
        }


        public static function hasId(id:int):Boolean {
            for each(var element:LockColor in _collection) {
                if (element._id == id) {
                    return true;
                }
            }

            return false;
        }

        public static function hasName(name:String):Boolean {
            for each(var element:LockColor in _collection) {
                if (element._name == name) {
                    return true;
                }
            }

            return false;
        }

        public static function getAllOriginal():Vector.<LockColor> {
            return _collection;
        }

        public static function get count():uint{
            return _collection.length;
        }
    }
}
