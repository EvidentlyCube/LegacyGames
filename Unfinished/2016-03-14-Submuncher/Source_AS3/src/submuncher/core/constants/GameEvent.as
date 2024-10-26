package submuncher.core.constants {
    import flash.errors.MemoryError;

    public class GameEvent {
        private static var _creationLock:Boolean = false;
        private static var _collection:Vector.<GameEvent> = new Vector.<GameEvent>();

        public static var FISH_BOSS_WALL_HEADBUTT:GameEvent = new GameEvent("fish_boss_wall_headbutt");

        {
            _creationLock = true;
        }

        private var _name:String;

        public function get name():String {
            return _name;
        }

        public function GameEvent(name:String) {
            if (_creationLock) {
                throw new MemoryError("Cannot create instances of Enum class");
            }

            _name = name;

            _collection.push(this);
        }

        public static function byName(name:String):GameEvent {
            for each(var element:GameEvent in _collection) {
                if (element._name == name) {
                    return element;
                }
            }

            throw new ArgumentError("Invalid enum");
        }

        public static function hasName(name:String):Boolean {
            for each(var element:GameEvent in _collection) {
                if (element._name == name) {
                    return true;
                }
            }

            return false;
        }
    }
}
