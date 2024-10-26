package game.windows{
    import game.global.Make;
    import net.retrocade.camel.core.rInput;
    import net.retrocade.camel.core.rWindow;
    import net.retrocade.camel.effects.rEffFade;
    import net.retrocade.standalone.Button;
    import net.retrocade.standalone.Grid9;
    import net.retrocade.standalone.Text;
    import net.retrocade.utils.Key;

    public class TWindowMessage extends rWindow{
        private static var _instance:TWindowMessage = new TWindowMessage;

        public static function show(message:String, textWidth:uint, selectable:Boolean, html:Boolean = false):void{
            _instance.showText(__(message), textWidth, selectable, html);
        }



        private var _bg   :Grid9;
        private var _text :Text;
        private var _close:Button;

        public function TWindowMessage(){
            super();

            _bg    = Grid9.getGrid("window", true);
            _text  = Make.text(16);
            _close = Make.buttonColor(onClose, _("close"));

            _text.autoSizeNone();
            _text.textAlignJustify();
            _text.multiline = true;
            _text.wordWrap  = true;

            addChild(_bg);
            addChild(_text);
            addChild(_close);


            cacheAsBitmap = true;
        }

        public function showText(message:String, textWidth:uint, selectable:Boolean, html:Boolean = false):void {
			graphics.clear();
            setText(message, textWidth, html);

            _close.alignCenterParent(5, _text.textWidth + 30);
            _close.y = _text.textHeight + _text.y + 9;

            _bg.setSizePosition(0, 0, _text.textWidth + 30, _close.bottom + 15);

            _text.x = _text.y = 5;

            this.show();

            center();
			
			graphics.beginFill(0, 0.6);
			graphics.drawRect( -x, -y, S.SIZE_SWF_WIDTH, S.SIZE_SWF_HEIGHT);

            _text.selectable = _text.mouseChildren = _text.mouseEnabled = selectable;
            mouseChildren = false;

            new rEffFade(this, 0, 1, 400, onFadedIn);
        }

        override public function update():void {
            if (mouseChildren && rInput.isKeyHit(Key.ESCAPE))
                onClose();
        }

        private function setText(message:String, textWidth:uint, html:Boolean):void {
			if (html)
				_text.htmlText = message;
			else
				_text.text = message;

            _text.width = textWidth;
            _text.height = S.SIZE_SWF_HEIGHT - 80;

            while (_text.textHeight > S.SIZE_SWF_HEIGHT - 80 && _text.width < S.SIZE_GAME_WIDTH - 80) {
                _text.width += 50;
            }

            _text.height = _text.textHeight + 10;
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