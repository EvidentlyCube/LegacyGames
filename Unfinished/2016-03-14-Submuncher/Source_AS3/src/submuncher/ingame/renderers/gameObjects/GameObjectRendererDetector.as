package submuncher.ingame.renderers.gameObjects {
    import submuncher.core.constants.SpriteTextureCollections;
    import submuncher.ingame.gameObjects.ObjectDetector;
    import submuncher.ingame.renderers.core.LevelFrontend;
    import submuncher.ingame.vfx.EffectDetectorRay;

    public class GameObjectRendererDetector extends GameObjectRendererAnimated {
        private var _rayEffects:Vector.<EffectDetectorRay>;

        public function get detector():ObjectDetector {
            return gameObject as ObjectDetector;
        }

        public function GameObjectRendererDetector(gameObject:ObjectDetector, levelRenderer:LevelFrontend) {
            super(gameObject, 0.03, levelRenderer);

            setTextures(SpriteTextureCollections.getDetector(detector.color));

            _rayEffects = new <EffectDetectorRay>[
                new EffectDetectorRay(detector, detector.rays[0]),
                new EffectDetectorRay(detector, detector.rays[1]),
                new EffectDetectorRay(detector, detector.rays[2]),
                new EffectDetectorRay(detector, detector.rays[3])
            ];

            gameCommunication.onEffectCreated.call(_rayEffects[0]);
            gameCommunication.onEffectCreated.call(_rayEffects[1]);
            gameCommunication.onEffectCreated.call(_rayEffects[2]);
            gameCommunication.onEffectCreated.call(_rayEffects[3]);
        }

        override public function update():void {
            if (_rayEffects && detector.isTriggered){
                _rayEffects[0].finish();
                _rayEffects[1].finish();
                _rayEffects[2].finish();
                _rayEffects[3].finish();
                _rayEffects = null;
            }

            if (detector.isTriggered){
                if (_animationSpeed > 0.005){
                    _animationSpeed -= 0.0001;
                } else if (currentFrame === 0){
                    return;
                }
            }

            for each (var ray:EffectDetectorRay in _rayEffects) {
                ray.baseAlpha = 1 - Math.abs(frameFactor - 0.5);
            }

            super.update();
        }
    }
}
