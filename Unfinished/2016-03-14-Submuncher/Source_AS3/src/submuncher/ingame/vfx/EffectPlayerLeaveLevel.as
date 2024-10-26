package submuncher.ingame.vfx {
    import net.retrocade.enums.Direction4;
    import net.retrocade.retrocamel.effects.RetrocamelEasings;
    import net.retrocade.utils.UtilsNumber;

    import starling.display.Image;
    import starling.textures.Texture;

    import submuncher.core.constants.Gfx;
    import S;
    import submuncher.core.constants.SpriteNames;
    import submuncher.ingame.gameObjects.ObjectPlayer;

    import submuncher.ingame.renderers.core.LevelFrontend;
    import submuncher.ingame.renderers.gameObjects.GameObjectRendererPlayer;

    public class EffectPlayerLeaveLevel extends Image implements IEffect{
        private var _player:ObjectPlayer;
        private var _levelRenderer:LevelFrontend;
        private var _textures:Vector.<Texture>;
        private var _frame:Number = 4;
        private var _direction:Direction4;
        private var _speedX:Number;
        private var _speedY:Number;
        private var _targetSpeedX:Number;
        private var _framesIn:Number;

        public function EffectPlayerLeaveLevel(player:ObjectPlayer, playerRenderer:GameObjectRendererPlayer, levelRenderer:LevelFrontend) {
            super(Gfx.spritesAtlas.getTexture(SpriteNames.PLAYER_4));
            _textures = new <Texture>[
                Gfx.spritesAtlas.getTexture(SpriteNames.PLAYER_0),
                Gfx.spritesAtlas.getTexture(SpriteNames.PLAYER_1),
                Gfx.spritesAtlas.getTexture(SpriteNames.PLAYER_2),
                Gfx.spritesAtlas.getTexture(SpriteNames.PLAYER_3),
                Gfx.spritesAtlas.getTexture(SpriteNames.PLAYER_4)
            ];

            x = player.preciseX + 8;
            y = player.preciseY + 8;

            pivotX = 8;
            pivotY = 8;

            _framesIn = 0;
            _direction = player.movementDirection;
            _levelRenderer = levelRenderer;
            _frame = playerRenderer.frame;
            _speedX = _direction.dX / player.getSpeed();
            _speedY = _direction.dY / player.getSpeed();
            _targetSpeedX = (_speedX > 0 ? -18 : 18) * (_frame === 0 || _frame >= 4 ? 1 : -1);

            texture = _textures[_frame | 0];
        }

        public function update():void {
            x += _speedX;
            y += _speedY;

            _speedX = UtilsNumber.approachStep(_speedX, _targetSpeedX, 0.1);
            if (Math.abs(_speedX) > 2){
                _speedX = UtilsNumber.approachStep(_speedX, _targetSpeedX, 0.2);
            }
            _speedY *= 0.98;

            if (_framesIn < 40){
                _framesIn++;
                scaleY = scaleX = 1 + RetrocamelEasings.quadraticInOut(_framesIn / 40) * 2;
            }


            if (_frame < 2){
                _levelRenderer.gameCommunication.onEffectCreated.call(EffectBubble.getBubble(
                    x + width / 2,
                    y,
                    0
                ));

            } else {
                _levelRenderer.gameCommunication.onEffectCreated.call(EffectBubble.getBubble(
                    x - width / 2,
                    y,
                    Math.PI
                ));
            }

            updateFrame();
        }

        private function updateFrame():void {
            if (_targetSpeedX < 0){
                if (_frame > 0){
                    _frame -= 0.1;
                    if (_frame <= 0){
                        _frame = 0;
                    }
                }
            } else if (_targetSpeedX > 0){
                _frame += 0.1;
                if (_frame >= 5){
                    _frame = 5;
                }
            }

            texture = _textures[Math.min(4, _frame | 0)];
        }

        public function get isFinished():Boolean {
            return x < -width || x > S.gameWidth + width;
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
            return EffectBubbleBlack;
        }

        public function get blocksOtherEffects():Boolean {
            return false;
        }
    }
}
