package game.windows{
    import flash.geom.Point;
    import flash.utils.setTimeout;
    import game.global.CaravelConnect;
    import game.global.Level;
    import game.global.Make;
    import game.global.Progress;
    import game.managers.VODemoRecord;
    import net.retrocade.camel.core.rInput;
    import net.retrocade.camel.core.rWindow;
    import net.retrocade.camel.core.rWindows;
    import net.retrocade.camel.effects.rEffFade;
    import net.retrocade.standalone.Button;
    import net.retrocade.standalone.Grid9;
    import net.retrocade.standalone.Text;
    import net.retrocade.utils.Key;
    import net.retrocade.utils.Rand;
    import net.retrocade.utils.UString;

    public class TWindowLogin extends rWindow{
        private static var _instance:TWindowLogin = new TWindowLogin;

        public static function show():void{
            _instance.show();
        }



        private var _bg   :Grid9;
        private var _header:Text;
        private var _text :Text;
        private var _close:Button;

        public function TWindowLogin(){
            super();

            _bg     = Grid9.getGrid("window", true);
            _header = Make.text(22);
            _text   = Make.text(16);
            _close  = Make.buttonColor(onClose, "Close");

            _header.text = "Connecting to CaravelNet";
            _header.fitSize();

            _text.autoSizeNone();
            _text.multiline = true;
            _text.wordWrap  = true;

            addChild(_bg);
            addChild(_header);
            addChild(_text);
            addChild(_close);

            _header.y    = 5;

            _text.width  = 400;
            _text.height = 300;
            _text.x      = 5;
            _text.y      = _header.bottom;

            _close.y = _text.bottom + 10;

            _bg.width  = 410;
            _bg.height = _close.bottom + 10;

            _header.alignCenterParent();
            _close .alignCenterParent();

            cacheAsBitmap = true;
        }

        override public function show():void {
			graphics.clear();
			
            super.show();

            new rEffFade(this, 0, 1, 400, onFadedIn);

            _text.text   = "  Connecting...\n\n";

            _close.disable();
            _close.alpha = 0.5;

            center();
			
			graphics.beginFill(0, 0.6);
			graphics.drawRect( -x, -y, S.SIZE_SWF_WIDTH, S.SIZE_SWF_HEIGHT);

            CaravelConnect.login(onLogin);
        }

        override public function update():void {
            if (mouseChildren && rInput.isKeyHit(Key.ESCAPE) && _close.enabled)
                onClose();
        }

        private function onLogin(result:Boolean):void {
            if (result) {
                if (CaravelConnect.cnetName && CaravelConnect.cnetPass) {
                    _text.text += _("loginConnected");
                } else {
                    _text.text += _("loginConnectedAnonymous");
                }

            } else {
                _text.text += _("loginFailed");
                if (CaravelConnect.cnetPass && CaravelConnect.cnetName)
                    _text.text += _("loginFailedBadCredentials");
                else if (CaravelConnect.cnetName || CaravelConnect.cnetPass)
                    _text.text += _("loginFailedMissingCrentials");

                rWindows.removeLastWindow();
            }

            _close.enable();
            _close.alpha = 1;
        }

        private function onClose():void {
            mouseChildren = false;

            new rEffFade(this, 1, 0, 400, onFadedOut);
        }

        private function onFadedIn():void {
            mouseChildren = true;
        }

        private function onFadedOut():void {
            close();
        }
    }
}