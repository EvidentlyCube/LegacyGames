package submuncher.core.repositories {
    public class LevelGroupEntryMetadata {
        private var _level:LevelMetadata;
        private var _required:Boolean;
        private var _name:String;

        public function LevelGroupEntryMetadata(level:LevelMetadata, required:Boolean) {
            _level = level;
            _required = required;
        }

        public function get level():LevelMetadata {
            return _level;
        }

        public function get required():Boolean {
            return _required;
        }

        public function set name(value:String):void {
            if (_name){
                throw new ArgumentError("Group name is already set");
            }

            _name = value;
        }

        public function get name():String {
            return _name;
        }
    }
}
