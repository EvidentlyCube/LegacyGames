package net.retrocade.tacticengine.monstro.global.enum {
    import flash.errors.MemoryError;

    public class EnumUnitFaction {
        private static var _creationLock:Boolean = false;
        private static var _collection:Vector.<EnumUnitFaction> = new Vector.<EnumUnitFaction>();

        public static var HUMAN:EnumUnitFaction = new EnumUnitFaction(0, "human");
        public static var MONSTER:EnumUnitFaction = new EnumUnitFaction(1, "monster");

        public static function invert(type:EnumUnitFaction):EnumUnitFaction{
            return type == HUMAN ? MONSTER : HUMAN;
        }

        public function getInverted():EnumUnitFaction{
            return invert(this);
        }

        public function isHuman():Boolean{
            return this == HUMAN;
        }

        public function isMonster():Boolean{
            return this == MONSTER;
        }

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

        public function get metadata():Object{
            return _metadata;
        }

        public function EnumUnitFaction(id:int, name:String, metadata:Object = null) {
            if (_creationLock) {
                throw new MemoryError("Cannot create instances of Enum class");
            }

            _id = id;
            _name = name;
            _metadata = metadata;

            _collection.push(this);
        }

        public static function byId(id:int):EnumUnitFaction {
            for each(var element:EnumUnitFaction in _collection) {
                if (element._id == id) {
                    return element;
                }
            }

            throw new ArgumentError("Invalid enum");
        }

        public static function byName(name:String):EnumUnitFaction {
            for each(var element:EnumUnitFaction in _collection) {
                if (element._name == name) {
                    return element;
                }
            }

            throw new ArgumentError("Invalid enum");
        }

        public static function hasId(id:int):Boolean{
            for each(var element:EnumUnitFaction in _collection) {
                if (element._id == id) {
                    return true;
                }
            }

            return false;
        }

        public static function hasName(name:String):Boolean{
            for each(var element:EnumUnitFaction in _collection) {
                if (element._name == name) {
                    return true;
                }
            }

            return false;
        }
    }
}
