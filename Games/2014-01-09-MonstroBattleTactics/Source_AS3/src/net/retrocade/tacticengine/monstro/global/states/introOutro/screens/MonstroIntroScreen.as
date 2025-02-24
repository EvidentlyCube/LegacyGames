
package net.retrocade.tacticengine.monstro.global.states.introOutro.screens {

	import net.retrocade.random.Random;
	import net.retrocade.retrocamel.interfaces.IRetrocamelSound;
    import net.retrocade.tacticengine.core.IDisposable;
    import net.retrocade.tacticengine.monstro.global.core.MonstroConsts;
	import net.retrocade.tacticengine.monstro.global.core.MonstroData;
	import net.retrocade.tacticengine.monstro.global.core.MonstroGfx;
    import net.retrocade.utils.UtilsDisplay;

    import starling.display.Image;
    import starling.display.Sprite;
    import starling.events.Event;
    import starling.events.Touch;
    import starling.events.TouchEvent;
    import starling.events.TouchPhase;
    import starling.text.TextField;

    public class MonstroIntroScreen extends Sprite implements IDisposable {
        protected static const STATE_SHOWING:int = 0;
        protected static const STATE_ACTIVE:int = 1;
        protected static const STATE_HIDING:int = 2;
        protected static const STATE_FINISHED:int = 3;
        protected var _image:Image;
        protected var _dubbing:IRetrocamelSound;
        protected var _textToShow:String;
        protected var _textField:TextField;
        protected var _currentState:int;
        protected var _textBackground:Image;
        protected var _sleepTimer:int = 0;
        protected var _isSkippingDubbing:Boolean = false;

		private var _backgroundPosition:Number;

        public function MonstroIntroScreen(image:Image, text:String, dubbing:IRetrocamelSound) {
            _image = image;
            _dubbing = dubbing;
            _textToShow = text;

            _textField = new TextField(MonstroConsts.gameWidth * 0.95, MonstroConsts.gameHeight, text, MonstroConsts.FONT_EBORACUM_48, 48, 0xFFFFFF);
			_textField.alpha = 0;

			_textBackground = MonstroGfx.getBlackColor();

            _textBackground.alpha = 0;

            _currentState = STATE_SHOWING;

            addChild(_image);
            addChild(_textBackground);
            addChild(_textField);

            alpha = 0;

            resize();

            addEventListener(TouchEvent.TOUCH, onTouch);

			_backgroundPosition = Random.defaultEngine.getNumberRange(0, Math.PI * 2);
        }

        public function resize():void {
            UtilsDisplay.calculateScale(
                _image.realWidth,
                _image.realHeight,
                MonstroConsts.gameWidth * 1.1,
                MonstroConsts.gameHeight * 1.1,
                UtilsDisplay.NO_BORDER
            );

            _image.scaleX = UtilsDisplay.lastScaleX;
            _image.scaleY = UtilsDisplay.lastScaleY;
            _textField.width = MonstroConsts.gameWidth * 0.95;
            _textField.height = MonstroConsts.gameHeight;

			_textField.alignCenter();

            _textBackground.x = 0;
            _textBackground.y = _textField.textBounds.y - 15;
            _textBackground.width = MonstroConsts.gameWidth;
            _textBackground.height = _textField.textHeight + 30;
        }

        public function update():void {
            switch (_currentState) {
                case(STATE_SHOWING):
                    update_showing();
                    break;
                case(STATE_ACTIVE):
                    update_active();
                    break;
                case(STATE_HIDING):
                    update_hiding();
                    break;
            }

			updateBackgroundPosition();
        }

        override public function dispose():void {
            removeEventListener(TouchEvent.TOUCH, onTouch);

            removeChildren();

			if (_image){
				_image.dispose();
			}

            if (_dubbing){
                _dubbing.dispose();
            }

			if (_textField){
				_textField.dispose();
			}

            _image = null;
            _dubbing = null;
            _textField = null;
            _textToShow = null;

            super.dispose();
        }

        protected function update_showing():void {
            alpha += 0.01;

            if (alpha >= 1) {
                alpha = 1;

                _sleepTimer += 1;
                if (_sleepTimer > 100) {

                    _textBackground.alpha += 0.04;
					_textField.alpha = _textBackground.alpha / 0.75;
                    if (_textBackground.alpha >= 0.75) {
                        _sleepTimer = 0;

                        _textBackground.alpha = 0.75;
						_textField.alpha = 1;
                        _currentState = STATE_ACTIVE;

                        _dubbing.play(0, MonstroData.getVoicesVolume());
					}
                }
            }
        }

        protected function update_active():void {
            if (!_dubbing.isPlaying || _isSkippingDubbing) {
                _sleepTimer += 1;
                if (_sleepTimer > 80) {
                    _currentState = STATE_HIDING;
                }
            }
        }

		protected function update_hiding():void {
			alpha -= 0.02;
			_dubbing.volume = alpha * MonstroData.getVoicesVolume();

			if (alpha <= 0) {
				alpha = 0;
				_currentState = STATE_FINISHED;
				dispatchEvent(new Event(Event.COMPLETE));
			}
		}

        protected function updateBackgroundPosition():void{
            _image.x = -(_image.width - MonstroConsts.gameWidth) * Math.max(0, Math.min(1, (0.5 + Math.cos(_backgroundPosition) * 0.5)));
            _image.y = -(_image.height - MonstroConsts.gameHeight) * Math.max(0, Math.min(1, (0.5 + Math.sin(_backgroundPosition) * 0.5)));

			_backgroundPosition += Math.PI * 0.0008;
        }

        protected function onTouch(e:TouchEvent):void {
            var touch:Touch = e.getTouch(this, TouchPhase.BEGAN);

            if (touch) {
                switch (_currentState) {
                    case(STATE_SHOWING):
                        skipStateShowing();
                        break;
                    case(STATE_ACTIVE):
                        skipStateActive();
                        break;
                    case(STATE_HIDING):
                        skipStateHiding();
                        break;
                }
            }
        }

        protected function skipStateShowing():void {
            alpha = 1;
            _image.alpha = 1;
            _textBackground.alpha = 0.75;
            _sleepTimer = 9999;
        }

        protected function skipStateActive():void {
            if (_sleepTimer == 0) {
				_isSkippingDubbing = true;
				_sleepTimer = 9999;
            }
        }

        protected function skipStateHiding():void {
            alpha = 0;
            _image.alpha = 0;
            _textBackground.alpha = 0;
            _textField.alpha = 0;
            _sleepTimer = 9999;
            if (_dubbing.isPlaying) {
                _dubbing.stop();
            }
        }
    }
}
