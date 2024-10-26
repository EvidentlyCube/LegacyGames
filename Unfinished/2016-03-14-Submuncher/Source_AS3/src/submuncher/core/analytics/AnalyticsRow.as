package submuncher.core.analytics {
    import submuncher.core.repositories.LevelMetadata;
    import submuncher.ingame.gameObjects.GameObject;
    import submuncher.ingame.ghost.GhostData;

    public class AnalyticsRow {
        private var _userName:String;
        private var _extLevelMeta:LevelMetadata;
        private var _extGhostReplay:GhostData;
        private var _completionStatus:AnalyticsLevelCompletionType;
        private var _time:int;
        private var _extPlayerKiller:GameObject;

        public function AnalyticsRow(userName:String, levelMeta:LevelMetadata) {
            _userName = userName;
            _extLevelMeta = levelMeta;
        }

        public function setGhostReplay(value:GhostData):void {
            _extGhostReplay = value;
        }

        public function setCompletionStatus(completed:Boolean, secret:Boolean, document:Boolean, par:Boolean):void {
            _completionStatus = AnalyticsLevelCompletionType.byParams(completed, secret, document, par);
        }

        public function setPlayerKiller(value:GameObject):void {
            _extPlayerKiller = value;
        }

        public function get isCommitable():Boolean {
            return _extGhostReplay && _completionStatus;
        }

        public function set time(value:int):void {
            _time = value;
        }

        public function get asString():String {
            return (
                _userName + ":::" +
                _extLevelMeta.id + ":" +
                _completionStatus.name + ":" +
                _time + ":" +
                (_extPlayerKiller ? _extPlayerKiller.id : "---") + ":" +
                _extGhostReplay.stringValue
            );
        }

        public function dispose():void {
            _userName = null;
            _extLevelMeta = null;
            _extGhostReplay = null;
            _completionStatus = null;
            _extPlayerKiller = null;
        }
    }
}
