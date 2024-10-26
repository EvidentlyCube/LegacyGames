package submuncher.core.save {
    import submuncher.core.repositories.LevelGroupsRepository;
    import submuncher.core.repositories.LevelMetadata;
    import submuncher.core.repositories.LevelRepository;
    import submuncher.ingame.core.LevelScore;

    public class SaveLevelProgress {
        private var _levelId:String;
        public var bestTime:uint;
        public var isCompleted:Boolean;
        public var isParTime:Boolean;
        public var areSecretsCollected:Boolean;
        public var isDocumentCollected:Boolean;

        public function SaveLevelProgress(levelId:String = null) {
            _levelId = levelId;
            bestTime = 9999;
            isCompleted = false;
            isParTime = false;
            areSecretsCollected = false;
            isDocumentCollected = false;
        }

        public function get progress():Number {
            var score:Number = 0;

            score += (isCompleted ? 1 : 0);
            score += (isParTime ? 1 : 0);
            score += (areSecretsCollected ? 1 : 0);
            score += (isDocumentCollected ? 1 : 0);

            return isRequired ? score / 4 : score / 2;
        }

        public function get isRequired():Boolean {
            return LevelGroupsRepository.isLevelRequired(LevelRepository.getLevelById(_levelId));
        }

        public function importFromScore(score:LevelScore):Boolean {
            var hasChanged:Boolean = false;

            if (!this.isCompleted){
                this.isCompleted = true;
                hasChanged = true;
            }

            if (!this.isParTime && score.currentTime <= level.parTime ){
                this.isParTime = true;
                hasChanged = true;
            }

            if (!this.areSecretsCollected && score.secretDnaStrandsLeft === 0){
                this.areSecretsCollected = true;
                hasChanged = true;
            }

            if (!this.isDocumentCollected && score.isDocumentCollected){
                this.isDocumentCollected = true;
                hasChanged = true;
            }

            if (bestTime > score.currentTime){
                this.bestTime = score.currentTime;
                hasChanged = true;
            }

            return hasChanged;
        }

        public function toJson():Object {
            return {
                levelId:             _levelId,
                bestTime:            bestTime,
                isCompleted:         isCompleted,
                areSecretsCollected: areSecretsCollected,
                isParTime:           isParTime,
                isDocumentCollected: isDocumentCollected
            };
        }

        public function fromJson(value:Object):void {
            _levelId = value.levelId;
            bestTime = value.bestTime;
            isCompleted = value.isCompleted;
            isParTime = value.isParTime;
            areSecretsCollected = value.areSecretsCollected;
            isDocumentCollected = value.isDocumentCollected;
        }

        public function get levelId():String {
            return _levelId;
        }

        public function get isFullyCompleted():Boolean {
            return isCompleted && isParTime
                && (!isRequired || (areSecretsCollected && isDocumentCollected));
        }

        private function get level():LevelMetadata {
            return LevelRepository.getLevelById(_levelId);
        }
    }
}
