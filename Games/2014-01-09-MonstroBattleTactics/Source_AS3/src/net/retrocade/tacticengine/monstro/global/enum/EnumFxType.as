package net.retrocade.tacticengine.monstro.global.enum {
    import flash.errors.MemoryError;

    public class EnumFxType {
        private static var _creationLock:Boolean = false;
        private static var _collection:Vector.<EnumFxType> = new Vector.<EnumFxType>();

        public static var VERTICAL:EnumFxType = new EnumFxType(0, "vertical");
        public static var VERTICAL_SIMPLE:EnumFxType = new EnumFxType(1, "verticalsimple");
        public static var POINT:EnumFxType = new EnumFxType(2, "point");
        public static var HORIZONTAL:EnumFxType = new EnumFxType(3, "horizontal");
        public static var CLAWS:EnumFxType = new EnumFxType(4, "claws");
        public static var SLASH:EnumFxType = new EnumFxType(5, "slash");
        public static var DIAGONAL:EnumFxType = new EnumFxType(6, "diagonal");
		public static var TOTAL:int = 7;

        {
            _creationLock = true;
        }

        public static function byId(id:int):EnumFxType {
            for each(var element:EnumFxType in _collection) {
                if (element._id == id) {
                    return element;
                }
            }

            throw new ArgumentError("Invalid enum");
        }

        public static function byName(name:String):EnumFxType {
            for each(var element:EnumFxType in _collection) {
                if (element._name == name) {
                    return element;
                }
            }

            throw new ArgumentError("Invalid enum");
        }



        public static function hasId(id:int):Boolean{
            for each(var element:EnumFxType in _collection) {
                if (element._id == id) {
                    return true;
                }
            }

            return false;
        }

        public static function hasName(name:String):Boolean{
            for each(var element:EnumFxType in _collection) {
                if (element._name == name) {
                    return true;
                }
            }

            return false;
        }

        private var _id:int;
        private var _name:String;
        private var _metadata:Object;

        public function EnumFxType(id:int, name:String, metadata:Object = null) {
            if (_creationLock) {
                throw new MemoryError("Cannot create instances of Enum class");
            }

            _id = id;
            _name = name;
            _metadata = metadata;

            _collection.push(this);
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
