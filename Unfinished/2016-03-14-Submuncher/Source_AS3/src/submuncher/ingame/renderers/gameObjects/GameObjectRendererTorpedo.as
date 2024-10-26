package submuncher.ingame.renderers.gameObjects {
    import net.retrocade.enums.Direction4;

    import submuncher.core.constants.Gfx;
    import submuncher.core.constants.SpriteNames;
    import submuncher.ingame.gameObjects.BulletTorpedo;

    import submuncher.ingame.renderers.core.LevelFrontend;

    import submuncher.ingame.gameObjects.GameObject;
    import submuncher.ingame.vfx.EffectBubble;

    public class GameObjectRendererTorpedo extends GameObjectRendererUnanimatedDirectional{
        private var _tailOffsetX:Number;
        private var _tailOffsetY:Number;

        public function get torpedo():BulletTorpedo {
            return gameObject as BulletTorpedo;
        }

        public function GameObjectRendererTorpedo(gameObject:GameObject, levelRenderer:LevelFrontend) {
            super(gameObject, levelRenderer);

            setTextures(
                Gfx.spritesAtlas.getTexture(SpriteNames.TORPEDO_UP),
                Gfx.spritesAtlas.getTexture(SpriteNames.TORPEDO_RIGHT),
                Gfx.spritesAtlas.getTexture(SpriteNames.TORPEDO_DOWN),
                Gfx.spritesAtlas.getTexture(SpriteNames.TORPEDO_LEFT)
            );

            switch(torpedo.direction){
                case(Direction4.LEFT):
                    _tailOffsetX = 13;
                    _tailOffsetY = 7;
                    break;
                case(Direction4.UP):
                    _tailOffsetX = 7;
                    _tailOffsetY = 13;
                    break;
                case(Direction4.RIGHT):
                    _tailOffsetX = 2;
                    _tailOffsetY = 7;
                    break;
                case(Direction4.DOWN):
                    _tailOffsetX = 7;
                    _tailOffsetY = 2;
                    break;

            }
        }

        override public function dispose():void {
            super.dispose();
        }

        override public function update():void {
            super.update();

            gameCommunication.onEffectCreated.call(EffectBubble.getBubble(
                    gameObject.preciseX + _tailOffsetX,
                    gameObject.preciseY + _tailOffsetY,
                torpedo.direction.opposite.radians
            ));
        }

    }
}
