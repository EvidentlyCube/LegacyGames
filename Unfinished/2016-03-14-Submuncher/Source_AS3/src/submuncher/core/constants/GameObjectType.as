package submuncher.core.constants {
    import flash.errors.MemoryError;

    public class GameObjectType {
        private static var _creationLock:Boolean = false;
        private static var _collection:Vector.<GameObjectType> = new Vector.<GameObjectType>();

        public static var PLAYER:GameObjectType = new GameObjectType("player");
        public static var LEVEL_ENTRANCE:GameObjectType = new GameObjectType("level_entrance");
        public static var SCREEN:GameObjectType = new GameObjectType("screen");

        public static var DNA_STRAND:GameObjectType = new GameObjectType("collectible");
        public static var DNA_SECRET_STRAND:GameObjectType = new GameObjectType("collectible_secret");
        public static var DOCUMENT:GameObjectType = new GameObjectType("document");
        public static var KEY:GameObjectType = new GameObjectType("key");
        public static var AMMO:GameObjectType = new GameObjectType("ammo");

        public static var CRATE_WEAK:GameObjectType = new GameObjectType("crate_weak");
        public static var CRATE_STRONG:GameObjectType = new GameObjectType("crate_strong");
        public static var FLOOR_TRIGGER:GameObjectType = new GameObjectType("floor_trigger");
        public static var FAKE_WALL:GameObjectType = new GameObjectType("fake_wall");
        public static var BARRIER:GameObjectType = new GameObjectType("barrier");
        public static var DETECTOR:GameObjectType = new GameObjectType("detector");
        public static var SPONGE:GameObjectType = new GameObjectType("sponge");
        public static var DOOR:GameObjectType = new GameObjectType("door");

        public static var BARREL:GameObjectType = new GameObjectType("barrel");
        public static var FISH:GameObjectType = new GameObjectType("fish");
        public static var TURTLE:GameObjectType = new GameObjectType("turtle");
        public static var BLOB:GameObjectType = new GameObjectType("blob");
        public static var EYE:GameObjectType = new GameObjectType("eye");
        public static var SPIKES:GameObjectType = new GameObjectType("spikes");
        public static var SHELL:GameObjectType = new GameObjectType("shell");
        public static var SPINNING_BLADES:GameObjectType = new GameObjectType("spinning_blades");
        public static var GHOST_SUB:GameObjectType = new GameObjectType("ghost_sub");
        public static var EEL:GameObjectType = new GameObjectType("eel");
        public static var EEL_SEGMENT:GameObjectType = new GameObjectType("eel_segment");
        public static var JELLYFISH:GameObjectType = new GameObjectType("jellyfish");
        public static var JELLYFISH_SEGMENT:GameObjectType = new GameObjectType("jellyfish_segment");

        public static var TORPEDO:GameObjectType = new GameObjectType("torpedo");
        public static var BULLET_SHELL:GameObjectType = new GameObjectType("shell_acid");
        public static var BULLET_PENETRATING_LASER:GameObjectType = new GameObjectType("shell_acid");

        public static var BOSS_FISH:GameObjectType = new GameObjectType("boss_fish");

        {
            _creationLock = true;
        }

        private var _name:String;

        public function get name():String {
            return _name;
        }

        public function get isEnemy():Boolean {
            return this === FISH ||
                this === TURTLE ||
                this === BLOB ||
                this === EYE;
        }

        public function GameObjectType(name:String) {
            if (_creationLock) {
                throw new MemoryError("Cannot create instances of Enum class");
            }

            _name = name;

            _collection.push(this);
        }

        public static function byName(name:String):GameObjectType {
            for each(var element:GameObjectType in _collection) {
                if (element._name == name) {
                    return element;
                }
            }

            throw new ArgumentError("Invalid enum");
        }

        public static function hasName(name:String):Boolean {
            for each(var element:GameObjectType in _collection) {
                if (element._name == name) {
                    return true;
                }
            }

            return false;
        }

        public static function getAll():Vector.<GameObjectType> {
            return _collection.concat();
        }
    }
}
