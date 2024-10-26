package submuncher.core.repositories {
    import flash.utils.Dictionary;

    import submuncher.ingame.ghost.GhostData;

    public class GhostRepository {
        private static var _ghostRepository:Dictionary;

        {
            init();
        }

        private static function init():void {
            _ghostRepository = new Dictionary();
        }

        public static function addGhost(levelMeta:LevelMetadata, ghostData:GhostData):void {
            if (!(levelMeta in _ghostRepository)){
                _ghostRepository[levelMeta] = [];
            }

            _ghostRepository[levelMeta].push(ghostData);
        }

        public static function getGhostsForLevel(levelMeta:LevelMetadata):Array {
            if (levelMeta in _ghostRepository){
                return _ghostRepository[levelMeta];
            } else {
                return [];
            }
        }
    }
}
