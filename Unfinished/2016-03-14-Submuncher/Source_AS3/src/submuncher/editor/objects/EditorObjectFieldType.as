package submuncher.editor.objects {
    import flash.errors.MemoryError;

    public class EditorObjectFieldType {
        private static var _creationLock:Boolean = false;
        private static var _collection:Vector.<EditorObjectFieldType> = new Vector.<EditorObjectFieldType>();

        public static var STRING:EditorObjectFieldType = new EditorObjectFieldType("string");
        public static var INTEGER:EditorObjectFieldType = new EditorObjectFieldType("integer");
        public static var BOOLEAN:EditorObjectFieldType = new EditorObjectFieldType("boolean");

        {
            _creationLock = true;
        }

        private var _name:String;

        public function get name():String {
            return _name;
        }

        public function EditorObjectFieldType(name:String) {
            if (_creationLock) {
                throw new MemoryError("Cannot create instances of Enum class");
            }

            _name = name;

            _collection.push(this);
        }

        public static function byName(name:String):EditorObjectFieldType {
            for each(var element:EditorObjectFieldType in _collection) {
                if (element._name == name) {
                    return element;
                }
            }

            throw new ArgumentError("Invalid enum");
        }

        public static function hasName(name:String):Boolean {
            for each(var element:EditorObjectFieldType in _collection) {
                if (element._name == name) {
                    return true;
                }
            }

            return false;
        }
    }
}
