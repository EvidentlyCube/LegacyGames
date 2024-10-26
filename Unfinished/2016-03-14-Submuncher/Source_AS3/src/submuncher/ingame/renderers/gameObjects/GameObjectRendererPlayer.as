package submuncher.ingame.renderers.gameObjects {
    import net.retrocade.enums.Direction4;

    import starling.textures.Texture;

    import submuncher.core.constants.Gfx;
    import submuncher.core.constants.SpriteNames;

    import submuncher.ingame.renderers.core.LevelFrontend;

    import submuncher.ingame.gameObjects.ObjectPlayer;
    import submuncher.ingame.vfx.EffectBubble;

    public class GameObjectRendererPlayer extends GameObjectRendererBase{
        private var _bubbleTimer:int = 0;
        private var _textures:Vector.<Texture>;
        private var _frame:Number = 4;

        private function get player():ObjectPlayer{
            return gameObject as ObjectPlayer;
        }

        public function GameObjectRendererPlayer(player:ObjectPlayer, levelRenderer:LevelFrontend) {
            super(player, levelRenderer);
            _textures = new <Texture>[
                Gfx.spritesAtlas.getTexture(SpriteNames.PLAYER_0),
                Gfx.spritesAtlas.getTexture(SpriteNames.PLAYER_1),
                Gfx.spritesAtlas.getTexture(SpriteNames.PLAYER_2),
                Gfx.spritesAtlas.getTexture(SpriteNames.PLAYER_3),
                Gfx.spritesAtlas.getTexture(SpriteNames.PLAYER_4)
            ];
            _frame = 4;
            texture = _textures[_frame];
        }

        override public function dispose():void {
            _textures = null;
            super.dispose();
        }

        override public function update():void {
            super.update();

            if (player.isFrozen){
                visible = false;
            }

            updateFrame();

            _bubbleTimer -= (player.isMoving ? 6 : 1);

            if (_bubbleTimer <= 0){
                if (player.direction === Direction4.LEFT){
                    gameCommunication.onEffectCreated.call(EffectBubble.getBubble(
                        gameObject.preciseX + gameObject.width,
                        gameObject.preciseY + _random.getUintRange(7, 16),
                        0
                    ));

                } else {
                    gameCommunication.onEffectCreated.call(EffectBubble.getBubble(
                        gameObject.preciseX,
                        gameObject.preciseY + _random.getUintRange(7, 16),
                        Math.PI
                    ));
                }

                _bubbleTimer += _random.getUintRange(8, 22);
            }

            levelFrontend.centerDisplayOn(gameObject.preciseX + 8 | 0, gameObject.preciseY + 8 | 0);
        }

        private function updateFrame():void {
            if (player.direction === Direction4.LEFT){
                if (_frame > 0){
                    _frame -= 0.2;
                    if (_frame <= 0){
                        _frame = 0;
                    }
                }
            } else if (_frame < 4){
                _frame += 0.2;
                if (_frame >= 5){
                    _frame = 5;
                }
            }

            texture = _textures[Math.min(4, _frame | 0)];
        }

        public function get frame():Number {
            return _frame;
        }
    }
}
