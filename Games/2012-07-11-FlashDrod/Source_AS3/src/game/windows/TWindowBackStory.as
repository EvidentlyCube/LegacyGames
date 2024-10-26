package game.windows{
    import game.global.Make;
    import net.retrocade.camel.core.rInput;
    import net.retrocade.camel.core.rWindow;
    import net.retrocade.camel.effects.rEffFade;
    import net.retrocade.standalone.Button;
    import net.retrocade.standalone.Grid9;
    import net.retrocade.standalone.Text;
    import net.retrocade.utils.Key;

    public class TWindowBackStory extends rWindow{
        private static var _instance:TWindowBackStory = new TWindowBackStory;

        public static function show():void{
            _instance.show();
        }



        private var _bg   :Grid9;
        private var _text :Text;
        private var _close:Button;
        private var _next :Button;
        private var _prev :Button;
        private var _pageText:Text;

        private var _page :uint = 0;

        public function TWindowBackStory(){
            super();

            _bg       = Grid9.getGrid("window", true);
            _text     = Make.text(16);
            _pageText = Make.text(16);
            _close    = Make.buttonColor(onClose, _("Close"));
            _next     = Make.buttonColor(onNext,  _("backstoryNext"));
            _prev     = Make.buttonColor(onPrev,  _("backstoryPrev"));

            _text.autoSizeNone();
            _text.multiline = true;
            _text.wordWrap  = true;
            _text.textAlignJustify();

            addChild(_bg);
            addChild(_text);
            addChild(_pageText);
            addChild(_close);
            addChild(_next);
            addChild(_prev);

            cacheAsBitmap = true;
        }

        override public function show():void {
            super.show();

            mouseChildren = false;

            new rEffFade(this, 0, 1, 400, onFadedIn);

            showPage(0);
        }

        override public function update():void {
            if (mouseChildren && rInput.isKeyHit(Key.ESCAPE))
                onClose();
        }

        private function showText(message:String, textWidth:uint):void {
			graphics.clear();
			
            setText(message, textWidth);

            _close.alignCenterParent(5, _text.textWidth + 20);
            _close.y = _text.textHeight + _text.y + 10;

            _next.y = _prev.y = _close.y;
            _next.x = _close.right + 10;
            _prev.right = _close.x - 10;

            _bg.setSizePosition(0, 0, _text.textWidth + 30, _close.bottom + 15);

            _text.x = _text.y = 5;

            _pageText.text = (_page + 1).toString() + " / 4";
            _pageText.right = _bg.right - 18;
            _pageText.bottom = _bg.bottom - 14;

            center();
			
			graphics.beginFill(0, 0.6);
			graphics.drawRect( -x, -y, S.SIZE_SWF_WIDTH, S.SIZE_SWF_HEIGHT);

            _text.selectable = _text.mouseChildren = _text.mouseEnabled = false;

            if (_page == 0) {
                _prev.disable();
                _prev.alpha = 0.5;
            } else {
                _prev.enable();
                _prev.alpha = 1;
            }

            if (_page == 3) {
                _next.disable();
                _next.alpha = 0.5;
            } else {
                _next.enable();
                _next.alpha = 1;
            }
        }

        private function setText(message:String, textWidth:uint):void {
            _text.text = message;

            _text.width = textWidth;
            _text.height = S.SIZE_SWF_HEIGHT - 80;

            while (_text.textHeight > S.SIZE_SWF_HEIGHT - 40) {
                _text.width += 50;
            }

            _text.height = _text.textHeight + 10;
        }

        private function onNext():void {
            showPage(_page + 1);
        }

        private function onPrev():void {
            showPage(_page - 1);
        }

        private function showPage(page:uint):void {
            _page = page;

            switch(_page) {
                case(0): showText(_("backstory1"), _n("backstory1width")); break;
                case(1): showText(_("backstory2"), _n("backstory2width")); break;
                case(2): showText(_("backstory3"), _n("backstory3width")); break;
				case(3): showText(_("backstory4"), _n("backstory4width")); break;
            }
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