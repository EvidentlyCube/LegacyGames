package submuncher.ingame.renderers.gameObjects {
    import net.retrocade.utils.UtilsAngle;

    import submuncher.core.constants.SpriteTextureCollections;
    import submuncher.ingame.gameObjects.EnemyJellyfishSegment;
    import submuncher.ingame.gameObjects.ObjectPlayer;
    import submuncher.ingame.renderers.core.LevelFrontend;

    public class GameObjectRendererJellyfishSegment extends GameObjectRendererAnimated {
        private var _angle:Number;
        private var _rotationSpeed:Number;
        private var _distance:Number;
        private var _xMultiplier:Number;

        private function get jellyfish():EnemyJellyfishSegment {
            return gameObject as EnemyJellyfishSegment;
        }

        public function GameObjectRendererJellyfishSegment(gameObject:EnemyJellyfishSegment, levelRenderer:LevelFrontend) {
            super(gameObject, 0.022, levelRenderer);

            x = gameObject.x;
            y = gameObject.y;

            setTextures(SpriteTextureCollections.jellyfishBaby);

            pivotX = 12;
            pivotY = 4;

            _angle = _random.getNumberRange(0, Math.PI * 2);
            _rotationSpeed = _random.getNumberRange(Math.PI / 600, Math.PI * 10 / 600) * (_random.getBool() ? 1 : -1);
            _distance = _random.getNumberRange(0, 3);
            _xMultiplier = _random.getNumberRange(0.3, 2);

            z += jellyfish.segmentIndex * 0.001;
            rotation = jellyfish.direction.radians;
        }

        override public function dispose():void {
            super.dispose();
        }

        override public function update():void {
            if (jellyfish.isMoving) {
                _animationSpeed = 0.03;
            } else {
                _animationSpeed = 0.018
            }

            if (!jellyfish.head.isStopped) {
                rotation = UtilsAngle.easeTwoRadiansByStep(rotation, jellyfish.direction.radians, Math.PI / 40);
            }

            super.update();

            this.x = gameObject.preciseX + 8 + Math.cos(_angle * _xMultiplier) * _distance;
            this.y = gameObject.preciseY + 8 + Math.sin(_angle) * _distance;

            _angle += _rotationSpeed;
        }

        private function get player():ObjectPlayer {
            return jellyfish.player;
        }
    }
}
