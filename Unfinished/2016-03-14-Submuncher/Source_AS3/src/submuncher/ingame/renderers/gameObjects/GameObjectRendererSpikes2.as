package submuncher.ingame.renderers.gameObjects {
    import starling.textures.Texture;
    import starling.utils.Color;

    import submuncher.core.constants.SpriteTextureCollections;
    import submuncher.ingame.gameObjects.EnemySpikes;
    import submuncher.ingame.renderers.core.LevelFrontend;

    public class GameObjectRendererSpikes2 extends GameObjectRendererAnimated {
        private var _shake:Number;

        public function get spikes():EnemySpikes {
            return gameObject as EnemySpikes;
        }

        public function GameObjectRendererSpikes2(spikes:EnemySpikes, levelFrontend:LevelFrontend) {
            super(spikes, 0.01, levelFrontend);

            setTextures(SpriteTextureCollections.mine);
            pivotX = 8;
            pivotY = 8;

            if (!spikes.areSpikesUp) {
                scaleX = scaleY = 0.75;
                updateColor();
            }
        }

        override public function dispose():void {
            super.dispose();
        }

        override public function update():void {
            if (spikes.areSpikesUp) {
                scaleX = scaleY = 1;
                color = 0xFFFFFF;
            } else if (currentFrame > 0) {
                if (scaleX > 0.6){
                    scaleY = scaleX -= 0.05;
                    updateColor();
                }
            }

            super.update();

            if (_shake) {
                _shake--;

//                if (_random.getChance(50 + _shake * 10)) {
                x += Math.sin(_shake * Math.PI / 2);
//                    y += _random.getNumberRange(-1, 1);
//                }
            }
        }

        private function updateColor():void {
            color = Color.getMeanColor(0x00061b, 0xFFFFFF, scaleX);
        }
    }
}
