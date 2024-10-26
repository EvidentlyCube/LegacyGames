package submuncher.ingame.vfx {
    import starling.textures.Texture;

    import submuncher.ingame.core.Level;
    import submuncher.ingame.renderers.core.LevelFrontend;
    import submuncher.ingame.renderers.core.LevelFrontend;

    public class EffectPlayerDeath extends EffectBase {
        private static const EXPLOSION_WAIT:uint = 8;

        private var _extLevel:Level;
        private var _extFrontend:LevelFrontend;
        private var _explosionWait:int;
        private var _totalDuration:int;


        public function EffectPlayerDeath(level:Level, frontend:LevelFrontend, texture:Texture, x:int, y:int) {
            super(texture);

            _extLevel = level;
            _extFrontend = frontend;
            _explosionWait = 0;
            _totalDuration = 40;

            this.x = x;
            this.y = y;
        }

        override public function dispose():void {
            removeFromParent();
        }

        override public function update():void {
            if (_totalDuration > 0) {
                _totalDuration--;
                if (_totalDuration === 0) {
                    _extLevel.gameCommunication.onEffectCreated.call(new EffectRestartTransition(_extFrontend));
                }
            }

            if (_explosionWait > 0) {
                _explosionWait--;
            } else {
                _explosionWait = EXPLOSION_WAIT;
                _extLevel.gameCommunication.onEffectCreated.call(new EffectExplosion(_extLevel, x + _random.getNumberRange(-5, 26), y + _random.getNumberRange(-5, 26)));
            }

            alpha = _totalDuration / 40.0;
        }

        override public function get isFinished():Boolean {
            return _totalDuration === 0;
        }

        override public function get objectClass():Class {
            return EffectPlayerDeath;
        }
    }
}
