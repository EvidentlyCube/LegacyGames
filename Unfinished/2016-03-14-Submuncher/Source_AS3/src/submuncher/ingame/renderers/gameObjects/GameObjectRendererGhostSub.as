package submuncher.ingame.renderers.gameObjects {
    import submuncher.ingame.gameObjects.EnemyGhostSub;
    import net.retrocade.enums.Direction4;

    import starling.textures.Texture;

    import submuncher.core.constants.Gfx;
    import submuncher.core.constants.SpriteNames;

    import submuncher.ingame.renderers.core.LevelFrontend;
    import submuncher.ingame.vfx.EffectBubbleBlack;

    public class GameObjectRendererGhostSub extends GameObjectRendererBase {
        private var _levelRenderer:LevelFrontend;
        private var _textures:Vector.<Texture>;
        private var _frame:Number = 4;
        private var _direction:Direction4;

        public function get ghostSub():EnemyGhostSub {
            return gameObject as EnemyGhostSub;
        }

        public function GameObjectRendererGhostSub(ghostSub:EnemyGhostSub, levelRenderer:LevelFrontend) {
            super(ghostSub, levelRenderer);
            _textures = new <Texture>[
                Gfx.spritesAtlas.getTexture(SpriteNames.GHOST_SUB_0),
                Gfx.spritesAtlas.getTexture(SpriteNames.GHOST_SUB_1),
                Gfx.spritesAtlas.getTexture(SpriteNames.GHOST_SUB_2),
                Gfx.spritesAtlas.getTexture(SpriteNames.GHOST_SUB_3),
                Gfx.spritesAtlas.getTexture(SpriteNames.GHOST_SUB_4)
            ];

            _levelRenderer = levelRenderer;
            _frame = 4;
            _direction = Direction4.RIGHT;
            texture = _textures[_frame];
            visible = false;

            x = gameObject.preciseX;
            y = gameObject.preciseY;
        }

        override public function update():void {
            if (ghostSub.isActive){
                visible = true;
                var lastX:Number = x;
                x = gameObject.preciseX;
                y = gameObject.preciseY;

                if (lastX < x) {
                    _direction = Direction4.RIGHT;
                } else if (lastX > x) {
                    _direction = Direction4.LEFT;
                }


                if (_direction === Direction4.LEFT){
                    gameCommunication.onEffectCreated.call(EffectBubbleBlack.getBubble(
                        gameObject.preciseX + gameObject.width,
                        gameObject.preciseY + _random.getUintRange(7, 16),
                        0
                    ));

                } else {
                    gameCommunication.onEffectCreated.call(EffectBubbleBlack.getBubble(
                        gameObject.preciseX,
                        gameObject.preciseY + _random.getUintRange(7, 16),
                        Math.PI
                    ));
                }

                updateFrame();

            } else {
                gameCommunication.onEffectCreated.call(EffectBubbleBlack.getBubble(_random.getNumberRange(center - 3, center + 3), _random.getNumberRange(middle - 3, middle + 3), _random.getNumberRange(-Math.PI, Math.PI)));
                gameCommunication.onEffectCreated.call(EffectBubbleBlack.getBubble(_random.getNumberRange(center - 3, center + 3), _random.getNumberRange(middle - 3, middle + 3), _random.getNumberRange(-Math.PI, Math.PI)));
                gameCommunication.onEffectCreated.call(EffectBubbleBlack.getBubble(_random.getNumberRange(center - 3, center + 3), _random.getNumberRange(middle - 3, middle + 3), _random.getNumberRange(-Math.PI, Math.PI)));
            }
        }


        private function updateFrame():void {
            if (_direction === Direction4.LEFT) {
                if (_frame > 0) {
                    _frame -= 0.4;
                    if (_frame <= 0) {
                        _frame = 0;
                    }
                }
            } else if (_frame < 4) {
                _frame += 0.4;
                if (_frame >= 5) {
                    _frame = 5;
                }
            }

            texture = _textures[Math.min(4, _frame | 0)];
        }
    }
}
