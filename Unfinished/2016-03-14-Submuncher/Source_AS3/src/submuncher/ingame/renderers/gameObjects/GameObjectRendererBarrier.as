package submuncher.ingame.renderers.gameObjects {
    import net.retrocade.enums.Axis;

    import starling.textures.Texture;

    import submuncher.core.constants.SpriteTextureCollections;
    import submuncher.ingame.gameObjects.ObjectBarrier;

    import submuncher.ingame.renderers.core.LevelFrontend;

    public class GameObjectRendererBarrier extends GameObjectRendererBase{
        private var _extTextures:Vector.<Texture>;

        private var _frame:uint;
        private var _frameWait:uint;

        private function get barrier():ObjectBarrier {
            return gameObject as ObjectBarrier;
        }

        public function GameObjectRendererBarrier(gameObject:ObjectBarrier, levelRenderer:LevelFrontend) {
            super(gameObject, levelRenderer);

            _frame = 0;
            _frameWait = 0;
            _extTextures = SpriteTextureCollections.getBarrier(barrier.color, barrier.axis);
            texture = _extTextures[0];

            readjustSize();

            x = gameObject.x;
            y = gameObject.y;

            if (barrier.axis === Axis.HORIZONTAL){
                y -= 4;
            } else {
                x -= 4;
            }
        }


        override public function update():void{
            texture = _extTextures[barrier.openState * (_extTextures.length - 1) | 0];
        }

        override public function dispose():void {
            super.dispose();
        }
    }
}
