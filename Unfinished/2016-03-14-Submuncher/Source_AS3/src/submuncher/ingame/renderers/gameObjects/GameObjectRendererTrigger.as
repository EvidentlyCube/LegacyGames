package submuncher.ingame.renderers.gameObjects {
    import starling.textures.Texture;

    import submuncher.core.constants.SpriteTextureCollections;
    import submuncher.ingame.gameObjects.ObjectFloorTrigger;
    import submuncher.ingame.renderers.core.LevelFrontend;

    public class GameObjectRendererTrigger extends GameObjectRendererBase {
        private var _textures:Vector.<Texture>;
        private var _frame:Number = 0;

        public function get trigger():ObjectFloorTrigger {
            return gameObject as ObjectFloorTrigger;
        }

        public function GameObjectRendererTrigger(gameObject:ObjectFloorTrigger, levelRenderer:LevelFrontend) {
            super(gameObject, levelRenderer);

            _textures = SpriteTextureCollections.getTrigger(trigger.color);
            texture = _textures[0];
        }

        override public function update():void {
            if (_frame < _textures.length - 1 && trigger.isHeldDown){
                _frame += 0.25;
            } else if (_frame > 0 && !trigger.isHeldDown){
                _frame -= 0.25;
            }

            texture = _textures[_frame | 0];

            super.update();
        }
    }
}
