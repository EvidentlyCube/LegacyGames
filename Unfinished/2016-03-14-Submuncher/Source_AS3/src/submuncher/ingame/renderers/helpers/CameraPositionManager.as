package submuncher.ingame.renderers.helpers {
    import S;
    import submuncher.ingame.core.Game;
    import submuncher.ingame.core.Level;

    public class CameraPositionManager {
        private var _extGame:Game;

        private var _levelWidthPx:Number;
        private var _levelHeightPx:Number;

        private var _currentCameraCenterX:Number;
        private var _currentCameraCenterY:Number;

        private var _layers:Array;

        public function CameraPositionManager(game:Game) {
            _extGame = game;

            _levelWidthPx = S.tileEdge;
            _levelHeightPx = S.tileEdge;

            _currentCameraCenterX = 0;
            _currentCameraCenterY = 0;

            _layers = [];

            _extGame.gameCommunication.onStageResized.add(refreshPosition);
            _extGame.gameCommunication.onLevelLoaded.add(refreshPosition);
        }

        public function dispose():void {
            _extGame.gameCommunication.onStageResized.remove(refreshPosition);
            _extGame.gameCommunication.onLevelLoaded.remove(refreshPosition);

            _layers = null;
        }

        public function setLevel(level:Level):void {
            _levelWidthPx = level.tileWidth * S.tileEdge;
            _levelHeightPx = level.tileHeight * S.tileEdge;

            refreshPosition();
        }

        public function setDisplayObjects(...rest:Array):void{
            _layers = rest;
        }

        public function setCenter(x:Number, y:Number):void {
            _currentCameraCenterX = x;
            _currentCameraCenterY = y;

            refreshPosition();
        }

        private function refreshPosition():void {
            var targetX:int;
            var targetY:int;

            if (S.gameWidth > _levelWidthPx){
                targetX = S.gameWidth / 2 - _levelWidthPx / 2;
            } else {
                targetX = Math.min(
                    0,
                    Math.max(
                            S.gameWidth - _levelWidthPx,
                            -_currentCameraCenterX + S.gameWidth / 2
                    )
                );
            }

            if (S.gameHeight > _levelHeightPx){
                targetY = S.gameHeight / 2 - _levelHeightPx / 2;
            } else {
                targetY = Math.min(
                    0,
                    Math.max(
                            -_levelHeightPx + S.gameHeight,
                            -_currentCameraCenterY + S.gameHeight / 2
                    )
                );

            }

            for each (var layer:* in _layers) {
                layer.x = targetX;
                layer.y = targetY;
            }
        }
    }
}
