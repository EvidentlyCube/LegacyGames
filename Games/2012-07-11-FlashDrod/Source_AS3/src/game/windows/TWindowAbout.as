package game.windows{
    import game.global.Make;
    import game.global.Sfx;
    import net.retrocade.camel.core.rInput;
    import net.retrocade.camel.core.rWindow;
    import net.retrocade.camel.effects.rEffFade;
    import net.retrocade.standalone.Button;
    import net.retrocade.standalone.Grid9;
    import net.retrocade.standalone.Text;
    import net.retrocade.utils.Key;

    public class TWindowAbout extends rWindow{
        private static var _instance:TWindowAbout = new TWindowAbout;

        public static function show():void{
            _instance.show();
        }



        private var _bg   :Grid9;
        private var _text :Text;

        private var _cnet     :Button;
        private var _howToPlay:Button;
        private var _history  :Button;
        private var _backstory:Button;
        private var _credits  :Button;
        private var _close    :Button;


        public function TWindowAbout(){
            super();

            _bg        = Grid9.getGrid("window", true);
            _text      = Make.text(16);
            _cnet      = Make.buttonColor(onCnet, _("abButCnet"));
            _howToPlay = Make.buttonColor(onHowToPlay, _("abButHowto"));
            _history   = Make.buttonColor(onHistory,   _("abButHistory"));
            _backstory = Make.buttonColor(onBackstory, _("abButBackstory"));
            _credits   = Make.buttonColor(onCredits,   _("abButCredits"));
            _close     = Make.buttonColor(onClose,     _("close"));

            _text.autoSizeNone();
            _text.multiline = true;
            _text.wordWrap  = true;

            _text.text = _("h&bText");

            _text.width = _n("h&bTextWidth");

            _cnet     .alignCenterParent(0, _text.textWidth + 20);
            _howToPlay.alignCenterParent(0, _text.textWidth + 20);
            _history  .alignCenterParent(0, _text.textWidth + 20);
            _backstory.alignCenterParent(0, _text.textWidth + 20);
            _credits  .alignCenterParent(0, _text.textWidth + 20);
            _close    .alignCenterParent(0, _text.textWidth + 20);

            _backstory.y = _text.textHeight + _text.y + 15;
            _howToPlay.y = _backstory.bottom + 10;
            _cnet     .y = _howToPlay.bottom + 10;
            _history  .y = _cnet.bottom + 10;
            _credits  .y = _history.bottom + 10;
            _close    .y = _credits.bottom + 10;

            _text.x = _text.y = 5;
            _text.height = _text.textHeight + 10;

            _bg.setSizePosition(0, 0, _text.textWidth + 10, _close.bottom + 10);

            addChild(_bg);
            addChild(_text);
            addChild(_history);
            addChild(_howToPlay);
            addChild(_cnet);
            addChild(_backstory);
            addChild(_credits);
            addChild(_close);

            center();
			
			graphics.beginFill(0, 0.6);
			graphics.drawRect( -x, -y, S.SIZE_SWF_WIDTH, S.SIZE_SWF_HEIGHT);
        }

        override public function show():void {
            super.show();

            mouseChildren = false;

            new rEffFade(this, 0, 1, 400, onFadedIn);
        }

        override public function update():void {
            if (mouseChildren && rInput.isKeyHit(Key.ESCAPE))
                onClose();
        }

        private function onClose():void {
            mouseChildren = false;

            Sfx.buttonClick();

            new rEffFade(this, 1, 0, 400, onFadedOut);
        }

        private function onCnet():void {
            Sfx.buttonClick();

            TWindowMessage.show(_("cnetInfo"), _n("cnetInfoWidth"), false);
        }

        private function onHowToPlay():void {
            Sfx.buttonClick();

            TWindowMessage.show(_('controlsWindow'), _n("controlsWindowWidth"), false, true);
        }

        private function onHistory():void {
            Sfx.buttonClick();

            TWindowMessage.show(_('drodHistory'), _n("drodHistoryWidth"), false);
        }

        private function onCredits():void {
            Sfx.buttonClick();

            TWindowMessage.show(_("credits"), _n("creditsWidth"), false, true);
        }

        private function onBackstory():void {
            TWindowBackStory.show();
        }

        private function onFadedIn():void {
            mouseChildren = true;
        }

        private function onFadedOut():void {
            close();
        }
    }
}