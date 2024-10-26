package submuncher.ingame.vfx {
    import submuncher.core.constants.Gfx;
    import submuncher.core.constants.SpriteNames;
    import submuncher.ingame.core.Game;
    import submuncher.ingame.renderers.core.LevelFrontend;

    public class EffectRestartTransition extends EffectBase  {
        private var _extGame:Game;
        private var _extFrontend:LevelFrontend;

        private var _didRestart:Boolean;

        public function EffectRestartTransition(frontend:LevelFrontend) {
            super(Gfx.spritesAtlas.getTexture(SpriteNames.TRANSITION_BACKGROUND));

            _extGame = frontend.game;
            _extFrontend = frontend;
            _didRestart = false;

            x = -width;
        }

        override public function dispose():void {
            _extGame = null;

            super.dispose();
        }

        override public function update():void {
            x += 30;
            if (x > -50 && !_didRestart){
                _didRestart = true;
                x = -50;
                _extGame.restartLevel();
            }

            moveToFront();
        }

        override public function get isFinished():Boolean {
            return x > S.gameWidth;
        }

        override public function get isPersistent():Boolean {
            return true;
        }

        override public function get objectClass():Class {
            return EffectRestartTransition;
        }
    }
}
