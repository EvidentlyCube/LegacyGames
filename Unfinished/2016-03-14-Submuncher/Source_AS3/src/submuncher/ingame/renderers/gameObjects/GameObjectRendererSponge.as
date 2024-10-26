package submuncher.ingame.renderers.gameObjects {
    import net.retrocade.retrocamel.effects.RetrocamelEasings;
    import net.retrocade.utils.UtilsNumber;

    import submuncher.core.constants.SpriteTextureCollections;
    import submuncher.ingame.gameObjects.ObjectSponge;

    import submuncher.ingame.renderers.core.LevelFrontend;

    public class GameObjectRendererSponge extends GameObjectRendererAnimated{
        private var _isFrozen:Boolean;
        private var _timer:Number;

        private function get sponge():ObjectSponge {
            return gameObject as ObjectSponge;
        }

        public function GameObjectRendererSponge(gameObject:ObjectSponge, levelRenderer:LevelFrontend) {
            super(gameObject, 0.02, levelRenderer);

            setTextures(SpriteTextureCollections.sponge);
            pivotX = 8;
            pivotY = 8;
            _isFrozen = false;
            _timer = 0;
        }


        override public function update():void{
            if (sponge.hasConsumed && _timer < 1){
                _timer += 0.015;
                scaleX = scaleY = 1 - RetrocamelEasings.easeInBack(_timer);

                if (_timer > 1){
                    _timer = 1;
                    visible = false;
                }
            }

            if (sponge.isFrozen && !_isFrozen){
                _isFrozen = true;
                setTextures(SpriteTextureCollections.spongeDead);
            } else if (_isFrozen && _animationSpeed > 0){
                _animationSpeed = UtilsNumber.approachStep(_animationSpeed, 0, 0.001);
            }

            super.update();
        }

        override public function dispose():void {
            super.dispose();
        }
    }
}
