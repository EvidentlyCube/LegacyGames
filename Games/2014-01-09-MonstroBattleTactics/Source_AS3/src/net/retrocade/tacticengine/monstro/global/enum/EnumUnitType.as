package net.retrocade.tacticengine.monstro.global.enum {
    import flash.errors.MemoryError;

    public class EnumUnitType {
        private static var _creationLock:Boolean = false;
        private static var _collection:Vector.<EnumUnitType> = new Vector.<EnumUnitType>();

        public static var SOLDIER:EnumUnitType = new EnumUnitType(0, "soldier");
        public static var PIKEMAN:EnumUnitType = new EnumUnitType(1, "pikeman");
        public static var ARCHER:EnumUnitType = new EnumUnitType(2, "archer");
        public static var KNIGHT:EnumUnitType = new EnumUnitType(3, "knight");
        public static var CAVALRY:EnumUnitType = new EnumUnitType(4, "cavalry");
        public static var SLIME:EnumUnitType = new EnumUnitType(5, "slime");
        public static var SHROOM:EnumUnitType = new EnumUnitType(6, "shroom");
        public static var GARGOYLE:EnumUnitType = new EnumUnitType(7, "gargoyle");
        public static var MINOTAUR:EnumUnitType = new EnumUnitType(8, "minotaur");
        public static var MANTICORE:EnumUnitType = new EnumUnitType(9, "manticore");
        public static var MOBILE_WALL:EnumUnitType = new EnumUnitType(10, "wallMovable");
        public static var FAKE_WALL:EnumUnitType = new EnumUnitType(11, "wallFake");
        public static var FLAG_KING:EnumUnitType = new EnumUnitType(12, "flagHumans");
        public static var FLAG_BRAIN:EnumUnitType = new EnumUnitType(13, "flagMonsters");
        public static var GRUNT:EnumUnitType = new EnumUnitType(14, "grunt");
        public static var GOO:EnumUnitType = new EnumUnitType(15, "cottonBall");
        public static var BONFIRE:EnumUnitType = new EnumUnitType(16, "bonfire");
        public static var LANTERN:EnumUnitType = new EnumUnitType(17, "lantern");
        public static var TORCH:EnumUnitType = new EnumUnitType(18, "torch");
        public static var TIKI_BLOCK:EnumUnitType = new EnumUnitType(19, "tikiBlock");

        {
            _creationLock = true;
        }

        public static function isFlag(enumUnitType:EnumUnitType):Boolean {
            return enumUnitType === FLAG_KING || enumUnitType === FLAG_BRAIN;
        }

		public function get isBreakableTile():Boolean{
			return this === FAKE_WALL;
		}

        public static function isHuman(enumUnitType:EnumUnitType):Boolean {
            return enumUnitType === GRUNT ||
                enumUnitType === SOLDIER ||
                enumUnitType === PIKEMAN ||
                enumUnitType === ARCHER ||
                enumUnitType === KNIGHT ||
                enumUnitType === CAVALRY ||
                enumUnitType === FLAG_KING;
        }

        public static function byId(id:int):EnumUnitType {
            for each(var element:EnumUnitType in _collection) {
                if (element._id == id) {
                    return element;
                }
            }

            throw new ArgumentError("Invalid enum");
        }

        public static function byName(name:String):EnumUnitType {
            for each(var element:EnumUnitType in _collection) {
                if (element._name == name) {
                    return element;
                }
            }

            throw new ArgumentError("Invalid enum");
        }



        public static function hasId(id:int):Boolean{
            for each(var element:EnumUnitType in _collection) {
                if (element._id == id) {
                    return true;
                }
            }

            return false;
        }

        public static function hasName(name:String):Boolean{
            for each(var element:EnumUnitType in _collection) {
                if (element._name == name) {
                    return true;
                }
            }

            return false;
        }

        private var _id:int;
        private var _name:String;
        private var _metadata:Object;

        public function EnumUnitType(id:int, name:String, metadata:Object = null) {
            if (_creationLock) {
                throw new MemoryError("Cannot create instances of Enum class");
            }

            _id = id;
            _name = name;
            _metadata = metadata;

            _collection.push(this);
        }

        public function isFlag():Boolean {
            return EnumUnitType.isFlag(this);
        }

        public function isHuman():Boolean {
            return EnumUnitType.isHuman(this);
        }

        public function get id():int {
            return _id;
        }

        public function get name():String {
            return _name;
        }

        public function get metadata():Object {
            return _metadata;
        }
    }
}
