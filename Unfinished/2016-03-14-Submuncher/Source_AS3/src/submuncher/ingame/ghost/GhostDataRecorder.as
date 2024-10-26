package submuncher.ingame.ghost {
    import submuncher.ingame.core.Game;
    import submuncher.core.repositories.GhostRepository;
    import submuncher.ingame.core.Level;
    import submuncher.ingame.gameObjects.ObjectPlayer;

    public class GhostDataRecorder {
        private var _extGame:Game;
        private var _ghostData:GhostData;
        private var _player:ObjectPlayer;

        public function GhostDataRecorder(game:Game) {
            _extGame = game;

            _extGame.gameCommunication.onLevelStarted.add(levelStartedHandler);
            _extGame.gameCommunication.onLevelFailed.add(levelEndHandler);
            _extGame.gameCommunication.onLevelCompleted.add(levelEndHandler);
        }

        public function dispose():void {
            _extGame.gameCommunication.onLevelStarted.remove(levelStartedHandler);
            _extGame.gameCommunication.onLevelFailed.remove(levelEndHandler);
            _extGame.gameCommunication.onLevelCompleted.remove(levelEndHandler);

            _ghostData = null;
            _player = null;
        }

        public function update():void {
            if (_ghostData && _player.isAlive) {
                _ghostData.addPosition(_player.preciseX, _player.preciseY);
            }
        }

        private function levelStartedHandler(level:Level):void {
            _ghostData = new GhostData();
            _player = level.player;
            _ghostData.addPosition(_player.preciseX, _player.preciseY);
        }

        private function levelEndHandler():void {
            if (_ghostData){
                _ghostData.commitData();
                _extGame.gameCommunication.onGhostDataCommited.call(_ghostData);
                GhostRepository.addGhost(_extGame.currentLevelMetadata, _ghostData);
                _ghostData = null;
            }
        }
    }
}
