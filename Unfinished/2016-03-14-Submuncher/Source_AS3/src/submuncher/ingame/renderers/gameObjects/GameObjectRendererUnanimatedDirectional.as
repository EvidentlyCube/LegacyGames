package submuncher.ingame.renderers.gameObjects {
    import net.retrocade.enums.Direction4;

    import starling.textures.Texture;

    import submuncher.ingame.renderers.core.LevelFrontend;

    import submuncher.ingame.gameObjects.GameObject;
    import submuncher.ingame.gameObjects.GameObjectMoving;
    import submuncher.ingame.vfx.EffectBubble;

    public class GameObjectRendererUnanimatedDirectional extends GameObjectRendererBase{
        private var _textures:Vector.<Texture>;

        public function GameObjectRendererUnanimatedDirectional(gameObject:GameObject, levelRenderer:LevelFrontend) {
            super(gameObject, levelRenderer);
        }

        override public function dispose():void {
            super.dispose();

            _textures = null;
        }

        override public function update():void {
            super.update();

            if (mTexture !== textureForCurrentDirection){
                texture = textureForCurrentDirection;
            }
        }

        public function setTextures(up:Texture, right:Texture, down:Texture, left:Texture):void {
            _textures = new Vector.<Texture>(4, true);
            _textures[Direction4.UP.id] = up;
            _textures[Direction4.RIGHT.id] = right;
            _textures[Direction4.DOWN.id] = down;
            _textures[Direction4.LEFT.id] = left;
        }

        private function get textureForCurrentDirection():Texture {
            return _textures[gameObject.direction.id];
        }
    }
}
