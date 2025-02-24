

package net.retrocade.collision {
    import flash.errors.MemoryError;

    public class CollisionShapeType {
        private static var _creationLock:Boolean = false;
        private static var _collection:Vector.<CollisionShapeType> = new Vector.<CollisionShapeType>();

        public static var CIRCLE:CollisionShapeType = new CollisionShapeType(0, "circle");
        public static var RECTANGLE:CollisionShapeType = new CollisionShapeType(1, "rectangle");
        public static var LINE:CollisionShapeType = new CollisionShapeType(2, "line");
        public static var POINT:CollisionShapeType = new CollisionShapeType(3, "point");
        public static var POLYGON:CollisionShapeType = new CollisionShapeType(4, "polygon");

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

        public function CollisionShapeType(id:int, name:String, metadata:Object = null) {
            if (_creationLock) {
                throw new MemoryError("Cannot create instances of Enum class");
            }

            _id = id;
            _name = name;
            _metadata = metadata;

            _collection.push(this);
        }

        public static function byId(id:int):CollisionShapeType {
            for each(var element:CollisionShapeType in _collection) {
                if (element._id == id) {
                    return element;
                }
            }

            throw new ArgumentError("Invalid enum");
        }

        public static function byName(name:String):CollisionShapeType {
            for each(var element:CollisionShapeType in _collection) {
                if (element._name == name) {
                    return element;
                }
            }

            throw new ArgumentError("Invalid enum");
        }


        public static function hasId(id:int):Boolean {
            for each(var element:CollisionShapeType in _collection) {
                if (element._id == id) {
                    return true;
                }
            }

            return false;
        }

        public static function hasName(name:String):Boolean {
            for each(var element:CollisionShapeType in _collection) {
                if (element._name == name) {
                    return true;
                }
            }

            return false;
        }
    }
}
