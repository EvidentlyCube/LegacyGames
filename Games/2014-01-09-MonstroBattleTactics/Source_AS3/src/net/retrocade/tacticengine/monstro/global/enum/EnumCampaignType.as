package net.retrocade.tacticengine.monstro.global.enum {
    import flash.errors.MemoryError;

    public class EnumCampaignType {
        private static var _creationLock:Boolean = false;
        private static var _collection:Vector.<EnumCampaignType> = new Vector.<EnumCampaignType>();

		public static var HUMAN:EnumCampaignType = new EnumCampaignType(0, "human", 24);
        public static var MONSTER:EnumCampaignType = new EnumCampaignType(1, "monster", 24);
        public static var HUMAN_HARD:EnumCampaignType = new EnumCampaignType(2, "human_hard", 24);
        public static var MONSTER_HARD:EnumCampaignType = new EnumCampaignType(3, "monster_hard", 24);
        public static var INTRODUCTION:EnumCampaignType = new EnumCampaignType(4, "tutorial", 3);
        public static var TEST:EnumCampaignType = new EnumCampaignType(998, "test", 1);

        {
            _creationLock = true;
        }

        private var _id:int;
        private var _name:String;
        private var _numberOfLevels:uint;

        public function get id():int {
            return _id;
        }

        public function get name():String {
            return _name;
        }

        public function get numberOfLevels():uint {
            return _numberOfLevels;
        }

        public function get isHuman():Boolean{
            return this === HUMAN || this === HUMAN_HARD || this === INTRODUCTION;
        }

        public function get isMonster():Boolean{
            return this === MONSTER || this === MONSTER_HARD;
        }

        public function EnumCampaignType(id:int, name:String, numberOfLevel:uint) {
            if (_creationLock) {
                throw new MemoryError("Cannot create instances of Enum class");
            }

            _id = id;
            _name = name;
            _numberOfLevels = numberOfLevel;

            _collection.push(this);
        }

        public static function byId(id:int):EnumCampaignType {
            for each(var element:EnumCampaignType in _collection) {
                if (element._id == id) {
                    return element;
                }
            }

            throw new ArgumentError("Invalid enum");
        }

        public static function byName(name:String):EnumCampaignType {
            for each(var element:EnumCampaignType in _collection) {
                if (element._name == name) {
                    return element;
                }
            }

            throw new ArgumentError("Invalid enum");
        }

        public static function hasId(id:int):Boolean{
            for each(var element:EnumCampaignType in _collection) {
                if (element._id == id) {
                    return true;
                }
            }

            return false;
        }

        public static function hasName(name:String):Boolean{
            for each(var element:EnumCampaignType in _collection) {
                if (element._name == name) {
                    return true;
                }
            }

            return false;
        }
    }
}
