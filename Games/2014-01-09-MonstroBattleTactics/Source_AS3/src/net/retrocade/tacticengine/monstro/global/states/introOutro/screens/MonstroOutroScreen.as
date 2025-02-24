
package net.retrocade.tacticengine.monstro.global.states.introOutro.screens {

    import net.retrocade.random.Random;
    import net.retrocade.retrocamel.interfaces.IRetrocamelSound;
    import net.retrocade.tacticengine.monstro.global.core.MonstroConsts;
    import net.retrocade.functions.printf;

    import starling.display.Image;

    public class MonstroOutroScreen extends MonstroIntroScreen {
        private var _texts:Vector.<String>;
        private var _dubbings:Vector.<IRetrocamelSound>;

        private var _currentSubscreen:uint = 0;
        private var _imagePositionAngle:Number;
        private var _imagePositionDirection:int;

        public function MonstroOutroScreen(image:Image, texts:Vector.<String>, dubbings:Vector.<IRetrocamelSound>) {
            super(image, texts[0], dubbings[0]);

            _texts = texts;
            _dubbings = dubbings;

            _imagePositionAngle = Random.defaultEngine.getNumberRange(-Math.PI, Math.PI);
            _imagePositionDirection = Random.defaultEngine.getBool() ? 1 : -1;

            if (_texts.length != _dubbings.length) {
                throw new ArgumentError(
                    printf(
                        "Text showers number (%%) is different from dubbings number (%%).",
                        _texts.length,
                        _dubbings.length
                    )
                );
            }

            if (_texts.length == 0){
                throw new ArgumentError("You need to pass one or more text showers and dubbings.");
            }
        }


        override public function dispose():void {
            _texts = null;

            for each(var dubbing:IRetrocamelSound in _dubbings){
                if (dubbing !== _dubbing){
                    dubbing.dispose();
                }
            }

            super.dispose();
        }

        override protected function update_hiding():void {
            if (_currentSubscreen + 1 < subscreensCount()){
                _textField.alpha -= 0.02;
                _textBackground.alpha -= 0.02;
				_textField.alpha = _textBackground.alpha / 0.75;

                if (_textField.alpha <= 0 && _textBackground.alpha <= 0){
                    switchToNextScreen();
                }

            } else {
                super.update_hiding();
            }
        }

        override protected function skipStateHiding():void {
            if (_currentSubscreen + 1 < subscreensCount()){
                _textField.alpha = 0;
                _textBackground.alpha = 0;
                switchToNextScreen();

            } else {
                super.skipStateHiding();
            }
        }

        private function switchToNextScreen():void{
            _dubbing.stop();

            _isSkippingDubbing = false;

            _currentSubscreen++;

            _textToShow = _texts[_currentSubscreen];
            _dubbing = _dubbings[_currentSubscreen];

            _textField.text = _textToShow;
            _textField.alpha = 0;

            _currentState = STATE_SHOWING;

            resize();
        }

        private function subscreensCount():uint{
            return _texts.length;
        }

        override protected function updateBackgroundPosition():void {
            _imagePositionAngle += Math.PI * 0.0005 * _imagePositionDirection;

            _image.x = -(_image.width - MonstroConsts.gameWidth) * (Math.cos(_imagePositionAngle) * 0.5 + 0.5);
            _image.y = -(_image.height - MonstroConsts.gameHeight) * (Math.sin(_imagePositionAngle) * 0.5 + 0.5);
        }
    }
}
