package submuncher.ingame.windows.levels {
    import flash.geom.Rectangle;

    import net.retrocade.retrocamel.core.RetrocamelInputManager;
    import net.retrocade.retrocamel.display.starling.RetrocamelWindowStarling;
    import net.retrocade.utils.UtilsNumber;

    import starling.display.BlendMode;

    import starling.display.DisplayObject;
    import starling.display.Image;

    import starling.display.Sprite;
    import starling.utils.HAlign;
    import starling.utils.VAlign;

    import submuncher.core.constants.Gfx;
    import submuncher.core.constants.GuiNames;

    import submuncher.core.display.SubmuncherTextField;
    import submuncher.core.repositories.LevelMetadata;
    import submuncher.core.save.Save;

    import submuncher.ingame.core.Game;

    public class ScreenWindowBase extends RetrocamelWindowStarling implements ITerminal {
        private static const SMALL_SCREEN_X:int = 139;
        private static const SMALL_SCREEN_Y:int = 35;

        private static const BIG_SCREEN_X:int = 127;
        private static const BIG_SCREEN_Y:int = 85;
        private static const BIG_SCREEN_EDGE:int = 226;

        private var _isHidden:Boolean;
        private var _isHiding:Boolean;
        private var _killAfterHide:Boolean;
        private var _aboveWindow:ScreenWindowBase;

        private var _extGame:Game;
        private var _header:SubmuncherTextField;

        protected var _bigWindowContainer:Sprite;

        public function ScreenWindowBase(headerText:String, extGame:Game) {
            _extGame = extGame;
            _blockUnder = false;

            _header = new SubmuncherTextField(headerText, 1, 0xFFFFFF, 202, 11, S.FONT_ORANGE_BOLD);
            _bigWindowContainer = new Sprite();

            _header.hAlign = HAlign.CENTER;
            _header.vAlign = VAlign.CENTER;
            _header.x = SMALL_SCREEN_X;
            _header.y = SMALL_SCREEN_Y;

            _bigWindowContainer.x = BIG_SCREEN_X;
            _bigWindowContainer.y = BIG_SCREEN_Y;

            addChild(_header);
            addChild(_bigWindowContainer);

            _isHiding = false;
            BackgroundWindow.instance.onPositionChanged.add(reposition);
            reposition(BackgroundWindow.instance.y);

            blendMode = BlendMode.ADD;
            alpha = 0;
        }

        override public function dispose():void {
            BackgroundWindow.instance.onPositionChanged.remove(reposition);

            _header.dispose();
            _bigWindowContainer.dispose();

            _header = null;
            _bigWindowContainer = null;

            super.dispose();
        }

        override public function hide():void {
            _isHidden = true;

            super.hide();
        }

        override public function update():void {
            if (_isHiding) {
                alpha -= 0.15;
                if (alpha <= 0) {
                    _isHiding = false;
                    if (_killAfterHide) {
                        hide();
                    }
                }
                return;

            } else if (TerminalManager.isActive(this)) {
                if (alpha < 1){
                    alpha += 0.15;
                    return;
                }
            } else {
                return;
            }


            if (_aboveWindow) {
                if (_aboveWindow.isHidden) {
                    _aboveWindow = null;
                    visible = true;
                } else {
                    return;
                }
            }

            if (BackgroundWindow.instance.isBusy){
                return;
            }

            updateInternal();
        }

        protected function addToBigWindow(...rest:Array):void{
            for each (var object:DisplayObject in rest) {
                _bigWindowContainer.addChild(object);
            }
        }

        protected function removeFromBigWindow(...rest:Array):void{
            for each (var object:DisplayObject in rest) {
                _bigWindowContainer.removeChild(object);
            }
        }

        protected function updateInternal():void{}

        protected function openWindowAbove(window:*):void{
            _aboveWindow = window;
        }

        public function startHiding(killAfterHide:Boolean):void {
            _isHiding = true;
            _killAfterHide = killAfterHide;
        }

        public function closeAll():void {
            RetrocamelInputManager.flushKeys();
            startHiding(true);
            BackgroundWindow.instance.hide();
        }

        public function get game():Game {
            return _extGame;
        }

        public function get levelMetadata():LevelMetadata {
            return _extGame.currentLevelMetadata;
        }

        public function get save():Save {
            return _extGame.save;
        }

        public function get isHidden():Boolean {
            return _isHidden;
        }

        public function get isDisabled():Boolean {
            return isHidden || _isHiding;
        }

        private function reposition(y:Number):void {
            this.y = y;
        }

        protected function offsetAllChildren(x:int, y:int):void {
            for each (var object:DisplayObject in _bigWindowContainer.getAllChildren()) {
                object.x += x;
                object.y += y;
            }
        }
    }
}
