package submuncher.core.repositories {
    public class LevelGroupMetadata {
        private var _id:String;
        private var _hubLevelId:String;
        private var _name:String;
        private var _levels:Vector.<LevelGroupEntryMetadata>;

        public function LevelGroupMetadata(id:String, hubLevelId:String, name:String, levels:Vector.<LevelGroupEntryMetadata>) {
            _id = id;
            _hubLevelId = hubLevelId;
            _name = name;
            _levels = levels;
        }

        public function containsLevel(level:LevelMetadata):Boolean {
            for each (var metadata:LevelGroupEntryMetadata in _levels) {
                if (metadata.level === level){
                    return true;
                }
            }

            return false;
        }

        public function getLevelIndex(level:LevelMetadata):int {
            for (var i:int = 0; i < _levels.length; i++) {
                if (_levels[i].level === level){
                    return i;
                }
            }

            throw new ArgumentError("Level of id " + level.id + " not found in group " + _id);
        }

        public function getLevelByIndex(index:int):LevelGroupEntryMetadata {
            return _levels[index];
        }

        public function get totalLevels():uint {
            return _levels.length;
        }

        public function get id():String {
            return _id;
        }

        public function get hubLevelId():String {
            return _hubLevelId;
        }

        public function get name():String {
            return _name;
        }

        public function get levels():Vector.<LevelGroupEntryMetadata> {
            return _levels;
        }
    }
}
