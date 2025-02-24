package net.retrocade.tacticengine.monstro.global.enum {
    import flash.errors.MemoryError;

    public class EnumUnitController {
        private static var _creationLock:Boolean = false;
        private static var _collection:Vector.<EnumUnitController> = new Vector.<EnumUnitController>();

        public static var PLAYER:EnumUnitController = new EnumUnitController(0, "player");
        public static var ENEMY:EnumUnitController = new EnumUnitController(1, "enemy");
        public static var MISC:EnumUnitController = new EnumUnitController(2, "misc");

        public static function invert(faction:EnumUnitController):EnumUnitController{
            if (faction === PLAYER){
                return ENEMY;

            } else if (faction === ENEMY){
                return PLAYER;

            } else {
                return MISC;
            }
        }

        public function isPlayer():Boolean{
            return this == PLAYER;
        }

        public function isEnemy():Boolean{
            return this == ENEMY;
        }

        public function isMisc():Boolean{
            return this == MISC;
        }

		public function canAttack(controller:EnumUnitController):Boolean{
			return this !== controller && this !== MISC;
		}

        {
            _creationLock = true;
        }

        private var _id:int;
        private var _name:String;
        private var _metadata:Object;

        public function get metadata():Object {
            return _metadata;
        }

        public function get id():int {
            return _id;
        }

        public function get name():String {
            return _name;
        }

        public function EnumUnitController(id:int, name:String, metadata:Object = null) {
            if (_creationLock) {
                throw new MemoryError("Cannot create instances of Enum class");
            }

            _id = id;
            _name = name;
            _metadata = null;

            _collection.push(this);
        }

        public static function byId(id:int):EnumUnitController {
            for each(var element:EnumUnitController in _collection) {
                if (element._id == id) {
                    return element;
                }
            }

            throw new ArgumentError("Invalid enum");
        }

        public static function byName(name:String):EnumUnitController {
            for each(var element:EnumUnitController in _collection) {
                if (element._name == name) {
                    return element;
                }
            }

            throw new ArgumentError("Invalid enum");
        }


        public static function hasId(id:int):Boolean{
            for each(var element:EnumUnitController in _collection) {
                if (element._id == id) {
                    return true;
                }
            }

            return false;
        }

        public static function hasName(name:String):Boolean{
            for each(var element:EnumUnitController in _collection) {
                if (element._name == name) {
                    return true;
                }
            }

            return false;
        }
    }
}
