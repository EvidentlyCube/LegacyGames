package submuncher.core.analytics {
    // import flash.filesystem.File;
    // import flash.filesystem.FileMode;
    // import flash.filesystem.FileStream;
    import flash.system.Capabilities;

    import net.retrocade.retrocamel.core.RetrocamelCore;
    import net.retrocade.retrocamel.interfaces.IRetrocamelUpdatable;
    import net.retrocade.utils.UtilsMd5;

    import submuncher.ingame.StateIngame;
    import submuncher.ingame.core.Game;
    import submuncher.ingame.core.GameCommunication;
    import submuncher.ingame.core.Level;
    import submuncher.ingame.gameObjects.GameObject;
    import submuncher.ingame.gameObjects.ObjectPlayer;
    import submuncher.ingame.ghost.GhostData;

    public class AnalyticsCollector implements IRetrocamelUpdatable{
        private static var _instance:AnalyticsCollector;

        public static function init():void {
            _instance = new AnalyticsCollector();

            RetrocamelCore.groupAfter.add(_instance);
        }


        private var _playerId:String;
        // private var _file:File;
        private var _isIngameState:Boolean = false;
        private var _game:Game;
        private var _gameCommunication:GameCommunication;

        private var _currentRow:AnalyticsRow;

        public function AnalyticsCollector() {
            // _playerId = File.userDirectory.name + "-" + UtilsMd5.encrypt(Capabilities.serverString).substr(0, 8);
            // _file = new File(File.applicationDirectory.resolvePath("analytics/").nativePath);
            // if (!_file.exists){
                // _file.createDirectory()
            // }
            // _file = _file.resolvePath(_playerId + ".txt");
        }

        public function update():void {
            if (_isIngameState){

            } else {
                if (RetrocamelCore.currentState is StateIngame){
                    hookToIngameState(RetrocamelCore.currentState as StateIngame);
                }
            }
        }

        private function hookToIngameState(state:StateIngame):void{
            _game = state.game;
            _gameCommunication = _game.gameCommunication;
            _isIngameState = true;

            _gameCommunication.afterLevelLoaded.add(afterLevelLoadedHandler);
            _gameCommunication.onLevelCompleted.add(levelCompletedHandler);
            _gameCommunication.onLevelLoaded.add(levelLoadedHandler);
            _gameCommunication.onLevelStarted.add(levelStartedHandler);
            _gameCommunication.onLevelFailed.add(levelFailedHandler);
            _gameCommunication.onGhostDataCommited.add(ghostDataCommitedHandler);
            _gameCommunication.onPlayerDamagedBy.add(playerDamagedByHandler);
        }

        private function afterLevelLoadedHandler(level:Level):void {

        }

        private function levelCompletedHandler(level:Level):void {
            _currentRow.setCompletionStatus(
                true,
                level.score.secretDnaStrandsLeft === 0,
                level.score.isDocumentCollected,
                level.score.currentTime <= level.metadata.parTime
            );
            _currentRow.time = level.score.currentTime;
            commitRow();
        }

        private function levelLoadedHandler(level:Level):void {

        }

        private function levelStartedHandler(level:Level):void {
            startNewRow(level);
        }

        private function levelFailedHandler(level:Level):void {
            if (_currentRow){
                _currentRow.setCompletionStatus(
                    false,
                    level.score.secretDnaStrandsLeft === 0,
                    level.score.isDocumentCollected,
                    level.score.currentTime <= level.metadata.parTime
                );
                _currentRow.time = level.score.currentTime;
                commitRow();
            }
        }

        private function ghostDataCommitedHandler(ghostData:GhostData):void {
            _currentRow.setGhostReplay(ghostData);
            commitRow();
        }

        private function playerDamagedByHandler(player:ObjectPlayer, hazard:GameObject):void {
            if (_currentRow){
                _currentRow.setPlayerKiller(hazard);
            }
        }

        private function startNewRow(level:Level):void{
            if (_currentRow){
                commitRow();
            }

            _currentRow = new AnalyticsRow(_playerId, level.metadata);
        }

        private function commitRow():void{
            if (_currentRow && _currentRow.isCommitable){
                var rowData:String = _currentRow.asString;
                // var stream:FileStream = new FileStream();
                // stream.open(_file, FileMode.APPEND);
                // stream.writeUTFBytes(rowData);
                // stream.writeUTFBytes("\n");
                // stream.close();
                _currentRow.dispose();
                _currentRow = null;
            }
        }
    }
}
