package net.retrocade.tacticengine.monstro.global.enum {
    import flash.errors.MemoryError;

    public class EnumTileset {
        private static var _creationLock:Boolean = false;
        private static var _collection:Vector.<EnumTileset> = new Vector.<EnumTileset>();

        public static var GREENLAND:EnumTileset = new EnumTileset(0, "greenland");
        public static var LAVA:EnumTileset = new EnumTileset(1, "lava");
        public static var ICE:EnumTileset = new EnumTileset(2, "ice");

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

        public function EnumTileset(id:int, name:String, metadata:Object = null) {
            if (_creationLock) {
                throw new MemoryError("Cannot create instances of Enum class");
            }

            _id = id;
            _name = name;
            _metadata = metadata;

            _collection.push(this);
        }

        public static function byId(id:int):EnumTileset {
            for each(var element:EnumTileset in _collection) {
                if (element._id == id) {
                    return element;
                }
            }

            throw new ArgumentError("Invalid enum");
        }

        public static function byName(name:String):EnumTileset {
            for each(var element:EnumTileset in _collection) {
                if (element._name == name) {
                    return element;
                }
            }

            throw new ArgumentError("Invalid enum");
        }


        public static function hasId(id:int):Boolean{
            for each(var element:EnumTileset in _collection) {
                if (element._id == id) {
                    return true;
                }
            }

            return false;
        }

        public static function hasName(name:String):Boolean{
            for each(var element:EnumTileset in _collection) {
                if (element._name == name) {
                    return true;
                }
            }

            return false;
        }
    }
}
