package submuncher.ingame.vfx {
    import net.retrocade.enums.Direction4;

    import starling.display.Image;
    import starling.textures.Texture;

    import submuncher.core.constants.Gfx;
    import submuncher.core.constants.SpriteNames;

    import submuncher.ingame.ghost.GhostData;

    import submuncher.ingame.renderers.core.LevelFrontend;

    public class EffectPlayerGhost extends Image implements IEffect{
        private var _ghostData:GhostData;
        private var _levelRenderer:LevelFrontend;
        private var _textures:Vector.<Texture>;
        private var _frame:Number = 4;
        private var _direction:Direction4;

        public function EffectPlayerGhost(ghostData:GhostData, levelRenderer:LevelFrontend) {
            super(Gfx.spritesAtlas.getTexture(SpriteNames.PLAYER_4));
            _textures = new <Texture>[
                Gfx.spritesAtlas.getTexture(SpriteNames.PLAYER_0),
                Gfx.spritesAtlas.getTexture(SpriteNames.PLAYER_1),
                Gfx.spritesAtlas.getTexture(SpriteNames.PLAYER_2),
                Gfx.spritesAtlas.getTexture(SpriteNames.PLAYER_3),
                Gfx.spritesAtlas.getTexture(SpriteNames.PLAYER_4)
            ];

            _levelRenderer = levelRenderer;
            _ghostData = ghostData;
            _ghostData.resetPlaybackPosition();
            _frame = 4;
            _direction = Direction4.RIGHT;
            texture = _textures[_frame];

            alpha = 0;
        }

        public function update():void {
            if (!_levelRenderer.isLevelStarted){
                return;
            }

            if (!_ghostData.isFinished){
                var lastX:Number = x;
                x = _ghostData.getNextData();
                y = _ghostData.getNextData();

                if (lastX < x){
                    _direction = Direction4.RIGHT;
                } else if (lastX > x){
                    _direction = Direction4.LEFT;
                }
            } else {
                alpha -= 0.002;
            }

            updateFrame();
        }

        private function updateFrame():void {
            if (_direction === Direction4.LEFT){
                if (_frame > 0){
                    _frame -= 0.4;
                    if (_frame <= 0){
                        _frame = 0;
                    }
                }
            } else if (_frame < 4){
                _frame += 0.4;
                if (_frame >= 5){
                    _frame = 5;
                }
            }

            texture = _textures[Math.min(4, _frame | 0)];
        }

        public function get isFinished():Boolean {
            return alpha <= 0;
        }

        public function get isDisplayEffect():Boolean {
            return true;
        }

        public function get isPersistent():Boolean {
            return false;
        }

        public function get blocksGameplay():Boolean {
            return false;
        }

        public function get isOnGameObjectLayer():Boolean {
            return false;
        }

        public function get objectClass():Class {
            return EffectPlayerGhost;
        }

        public function get blocksOtherEffects():Boolean {
            return false;
        }
    }
}
