package submuncher.ingame.renderers.gameObjects {
    import starling.textures.Texture;

    import submuncher.core.constants.SpriteTextureCollections;
    import submuncher.ingame.gameObjects.EnemySpikes;
    import submuncher.ingame.renderers.core.LevelFrontend;

    public class GameObjectRendererSpikes extends GameObjectRendererBase {
        private var _textures:Vector.<Texture>;
        private var _spikesUpFrameIndex:int;
        private var _spikesCurrentFrame:int;

        public function get spikes():EnemySpikes {
            return gameObject as EnemySpikes;
        }

        public function GameObjectRendererSpikes(spikes:EnemySpikes, levelFrontend:LevelFrontend) {
            super(spikes, levelFrontend);

            _textures = SpriteTextureCollections.spikes;
            _spikesUpFrameIndex = _textures.length - 1;
            _spikesCurrentFrame = -1;

            if (spikes.areSpikesUp) {
                currentFrame = _spikesUpFrameIndex;
            } else {
                currentFrame = 0;
            }
        }

        override public function dispose():void {
            super.dispose();
        }

        override public function update():void {
            if (spikes.areSpikesUp) {
                currentFrame = _spikesUpFrameIndex;
            } else if (currentFrame > 0) {
                currentFrame--;
            }

            super.update();
        }

        private function set currentFrame(value:int):void {
            if (value !== _spikesCurrentFrame) {
                _spikesCurrentFrame = value;
                texture = _textures[value];
            }
        }

        private function get currentFrame():int {
            return _spikesCurrentFrame;
        }
    }
}
