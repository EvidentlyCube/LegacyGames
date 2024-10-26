package submuncher.ingame.windows.levels {
    import net.retrocade.retrocamel.core.RetrocamelWindowsManager;
    import net.retrocade.retrocamel.display.starling.RetrocamelWindowStarling;
    import net.retrocade.retrocamel.effects.RetrocamelEasings;
    import net.retrocade.retrocamel.effects.RetrocamelEffectBase;
    import net.retrocade.retrocamel.effects.RetrocamelEffectMoveStarling;
    import net.retrocade.signal.Signal;

    import starling.display.Image;

    import submuncher.core.constants.Gfx;
    import submuncher.core.constants.GuiNames;
    import S;

    public class BackgroundWindow extends RetrocamelWindowStarling{
        private static var _instance:BackgroundWindow;

        public static function get instance():BackgroundWindow {
            if (!_instance){
                _instance = new BackgroundWindow();
            }

            return _instance;
        }

        private var _backgroundImage:Image;
        private var _isHiding:Boolean;
        private var _isShowing:Boolean;
        private var _isHidden:Boolean;

        private var _effect:RetrocamelEffectBase;
        private var _onPositionChanged:Signal;

        public function BackgroundWindow() {
            _backgroundImage = new Image(Gfx.guiAtlas.getTexture(GuiNames.SCREEN_BACKGROUND));
            _backgroundImage.y = S.gameHeight - _backgroundImage.height;

            addChild(_backgroundImage);
            _isHidden = true;
            _isHiding = false;
            _isShowing = false;
            _blockUnder = true;
            _onPositionChanged = new Signal();
        }

        override public function show():void {
            if (_isHidden){
                super.show();
                _isShowing = true;
                _effect = new RetrocamelEffectMoveStarling(this)
                        .initialY(_backgroundImage.height)
                        .targetY(0)
                        .easing(RetrocamelEasings.cubicOut)
                        .duration(300)
                        .callback(showingFinishedHandler)
                        .runManually();
            }
        }

        override public function hide():void {
            if (!_isHidden){
                _isHiding = true;
                _effect = new RetrocamelEffectMoveStarling(this)
                        .targetY(_backgroundImage.height)
                        .initialY(0)
                        .easing(RetrocamelEasings.cubicOut)
                        .duration(300)
                        .callback(hidingFinishedHandler)
                        .runManually();
            } else {
                super.hide();
            }
        }

        override public function update():void {
            if (_effect){
                _effect.update();
            }
        }

        private function hidingFinishedHandler():void {
            _isHidden = true;
            _isHiding = false;
            _isShowing = false;

            _effect = null;
            RetrocamelWindowsManager.clearWindows();
        }

        private function showingFinishedHandler():void {
            _isHidden = false;
            _isHiding = false;
            _isShowing = false;

            _effect = null;
        }

        public function get isBusy():Boolean {
            return _isHiding || _isShowing;
        }

        public function get onPositionChanged():Signal {
            return _onPositionChanged;
        }

        override public function set y(value:Number):void {
            super.y = value;
            _onPositionChanged.call(value);
        }
    }
}
