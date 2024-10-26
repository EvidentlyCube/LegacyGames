package submuncher.core.save {
    import submuncher.core.repositories.LevelGroupEntryMetadata;
    import submuncher.core.repositories.LevelGroupMetadata;
    import submuncher.core.repositories.LevelGroupsRepository;

    public class SaveGameProgress {
        private var _levels:Vector.<SaveLevelProgress>;

        public function SaveGameProgress() {
            _levels = new Vector.<SaveLevelProgress>();
        }

        public function getLevelProgressByLevelId(levelId:String):SaveLevelProgress {
            for each (var entry:SaveLevelProgress in _levels) {
                if (entry.levelId === levelId){
                    return entry;
                }
            }

            entry = new SaveLevelProgress(levelId);
            _levels.push(entry);

            return entry;
        }

        public function getPercentProgressByGroupId(groupId:String):Number {
            if (!LevelGroupsRepository.groupExists(groupId)){
                return 0;
            }

            var group:LevelGroupMetadata = LevelGroupsRepository.getGroupById(groupId);
            var score:Number = 0;

            for each (var meta:LevelGroupEntryMetadata in group.levels) {
                score += getLevelProgressByLevelId(meta.level.id).progress;
            }

            return score / group.levels.length;
        }

        public function toJson():Object {
            var levels:Array = [];
            for each (var entry:SaveLevelProgress in _levels) {
                levels.push(entry.toJson());
            }

            return {
                levels: levels
            };
        }

        public function fromJson(value:Object):void {
            _levels.length = 0;

            for (var i:int = 0; i < value.levels.length; i++) {
                var level:SaveLevelProgress = new SaveLevelProgress('');
                level.fromJson(value.levels[i]);
                _levels.push(level);
            }
        }
    }
}
