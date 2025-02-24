package net.retrocade.tacticengine.monstro.global.enum {
    import flash.errors.MemoryError;

    public class EnumTrapType {
        private static var _creationLock:Boolean = false;
        private static var _collection:Vector.<EnumTrapType> = new Vector.<EnumTrapType>();

        public static var WEB:EnumTrapType = new EnumTrapType(0, "trapLazy");
        public static var SPIKES_SMALL:EnumTrapType = new EnumTrapType(0, "trapSpikes0");
        public static var SPIKES_MEDIUM:EnumTrapType = new EnumTrapType(0, "trapSpikes1");
        public static var SPIKES_BIG:EnumTrapType = new EnumTrapType(0, "trapSpikes2");

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

        public function EnumTrapType(id:int, name:String, metadata:Object = null) {
            if (_creationLock) {
                throw new MemoryError("Cannot create instances of Enum class");
            }

            _id = id;
            _name = name;
            _metadata = metadata;

            _collection.push(this);
        }

        public static function byId(id:int):EnumTrapType {
            for each(var element:EnumTrapType in _collection) {
                if (element._id == id) {
                    return element;
                }
            }

            throw new ArgumentError("Invalid enum " + id);
        }

        public static function byName(name:String):EnumTrapType {
            for each(var element:EnumTrapType in _collection) {
                if (element._name == name) {
                    return element;
                }
            }

            throw new ArgumentError("Invalid enum " + name);
        }


        public static function hasId(id:int):Boolean {
            for each(var element:EnumTrapType in _collection) {
                if (element._id == id) {
                    return true;
                }
            }

            return false;
        }

        public static function hasName(name:String):Boolean {
            for each(var element:EnumTrapType in _collection) {
                if (element._name == name) {
                    return true;
                }
            }

            return false;
        }
    }
}
