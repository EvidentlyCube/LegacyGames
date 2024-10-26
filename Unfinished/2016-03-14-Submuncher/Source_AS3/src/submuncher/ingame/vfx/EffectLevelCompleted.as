package submuncher.ingame.vfx {
    import net.retrocade.retrocamel.display.layers.RetrocamelLayerStarling;

    import starling.display.Image;

    import submuncher.core.constants.Gfx;
    import S;
    import submuncher.core.constants.SpriteNames;
    import submuncher.ingame.core.Game;
    import submuncher.ingame.core.Level;

    public class EffectLevelCompleted implements IEffect {
        private var _extGame:Game;
        private var _layer:RetrocamelLayerStarling;
        private var _image:Image;

        private var _isSecondFade:Boolean;

        public function get isFinished():Boolean {
            return _isSecondFade && _image.alpha >= 1;
        }

        public function get isDisplayEffect():Boolean {
            return false;
        }

        public function EffectLevelCompleted(level:Level) {
            _extGame = level.game;
            _isSecondFade = false;
            _layer = new RetrocamelLayerStarling();
            _image = new Image(Gfx.spritesAtlas.getTexture(SpriteNames.WHITE_SQUARE));

            _layer.add(_image);

            _extGame.gameCommunication.onStageResized.add(resize);

            _image.alpha = 0.5;

            resize();
        }

        public function dispose():void {
            _extGame.gameCommunication.onStageResized.remove(resize);

            _image.dispose();
            _layer.dispose();

            _image = null;
            _layer = null;
        }

        public function update():void {
            _layer.moveToFront();


            if (_isSecondFade){
                _image.alpha += 0.02;

            } else {
                _image.alpha -= 0.01;
                if (_image.alpha <= 0) {
                    _isSecondFade = true;
                    _image.color = S.backgroundColor;
                }
            }

        }

        private function resize():void {
            _image.width = S.gameWidth;
            _image.height = S.gameHeight;
        }

        public function get isPersistent():Boolean {
            return true;
        }

        public function get blocksGameplay():Boolean {
            return true;
        }

        public function get isOnGameObjectLayer():Boolean {
            return false;
        }

        public function get objectClass():Class {
            return EffectLevelCompleted;
        }

        public function get blocksOtherEffects():Boolean {
            return false;
        }
    }
}
