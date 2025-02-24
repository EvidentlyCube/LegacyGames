package net.retrocade.tacticengine.monstro.global.enum {
    import flash.errors.MemoryError;

    public class EnumAbilityType {
        private static var _creationLock:Boolean = false;
        private static var _collection:Vector.<EnumAbilityType> = new Vector.<EnumAbilityType>();

        public static var EXPLODE_ON_HIT:EnumAbilityType = new EnumAbilityType(0, "EXPLODE_ON_HIT", EnumUnitType.GOO);
        public static var COUNTER_ATTACK:EnumAbilityType = new EnumAbilityType(1, "COUNTER_ATTACK", EnumUnitType.GARGOYLE);
        public static var THREE_TILE_ATTACK:EnumAbilityType = new EnumAbilityType(2, "THREE_TILE_ATTACK", EnumUnitType.MINOTAUR);
        public static var SUPER_WAIT_DEFENSE:EnumAbilityType = new EnumAbilityType(3, "SUPER_WAIT_DEFENSE", EnumUnitType.KNIGHT);
        public static var HEAL_EACH_TURN:EnumAbilityType = new EnumAbilityType(4, "HEAL_EACH_TURN", EnumUnitType.MANTICORE);
        public static var MOVE_AFTER_ATTACK:EnumAbilityType = new EnumAbilityType(5, "MOVE_AFTER_ATTACK", EnumUnitType.CAVALRY);
        public static var DOUBLE_RANGE_WITHOUT_MOVE:EnumAbilityType = new EnumAbilityType(6, "", EnumUnitType.ARCHER);
        public static var IGNORE_DEFENSE:EnumAbilityType = new EnumAbilityType(7, "", EnumUnitType.GRUNT);
        public static var ATTACK_TWO_TILES:EnumAbilityType = new EnumAbilityType(8, "", EnumUnitType.PIKEMAN);
        public static var POISON_ATTACK:EnumAbilityType = new EnumAbilityType(9, "POISON_ATTACK", EnumUnitType.SHROOM);
        public static var TRAP_LEFT_ON_END_TURN:EnumAbilityType = new EnumAbilityType(10, "", EnumUnitType.SLIME);
        public static var FRIENDS_ATTACK_BONUS:EnumAbilityType = new EnumAbilityType(11, "", EnumUnitType.SOLDIER);

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

        public function EnumAbilityType(id:int, name:String, metadata:Object = null) {
            if (_creationLock) {
                throw new MemoryError("Cannot create instances of Enum class");
            }

            _id = id;
            _name = name;
            _metadata = metadata;

            _collection.push(this);
        }

        public static function byId(id:int):EnumAbilityType {
            for each(var element:EnumAbilityType in _collection) {
                if (element._id == id) {
                    return element;
                }
            }

            throw new ArgumentError("Invalid enum");
        }

        public static function byName(name:String):EnumAbilityType {
            for each(var element:EnumAbilityType in _collection) {
                if (element._name == name) {
                    return element;
                }
            }

            throw new ArgumentError("Invalid enum");
        }


        public static function hasId(id:int):Boolean {
            for each(var element:EnumAbilityType in _collection) {
                if (element._id == id) {
                    return true;
                }
            }

            return false;
        }

        public static function hasName(name:String):Boolean {
            for each(var element:EnumAbilityType in _collection) {
                if (element._name == name) {
                    return true;
                }
            }

            return false;
        }
    }
}
