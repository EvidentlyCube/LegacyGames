package game.interfaces {
    import flash.events.MouseEvent;
    import flash.filters.GlowFilter;
    import flash.net.navigateToURL;
    import flash.net.URLRequest;
    import flash.utils.getTimer;
    import game.global.CaravelConnect;
    import game.global.Make;
	import net.retrocade.camel.core.rSprite;
    import net.retrocade.standalone.Text;

	/**
     * ...
     * @author Maurycy Zarzycki
     */
    public class TNewsString extends rSprite {

        private static const STATE_WAIT:uint = 0;
        private static const STATE_HIDE:uint = 1;
        private static const STATE_SHOW:uint = 2;

        private var _newsID:uint = 0;
        private var _text:Text;

        private var _state :uint = STATE_WAIT;
        private var _waiter:uint;

        private var _isActive:Boolean = false;

        public function TNewsString() {

        }

        private function activate():void {
            if (CaravelConnect.isDataLoaded()){
                _newsID   = CaravelConnect.news.length;
                _isActive = true;
                _waiter   = getTimer() + 1500;

                _text = Make.text(18, 0xFFFFFF);
                _text.filters = [ new GlowFilter(0, 1, 3, 3, 15)];

                _text.apply();

                addChild(_text);

                update();

                addEventListener(MouseEvent.ROLL_OVER, rollOver)
                addEventListener(MouseEvent.ROLL_OUT, rollOut)
                addEventListener(MouseEvent.CLICK, click)

                buttonMode = true;

                _text.text = "Latest Caravel news:";
            }
        }

        protected function click(e:MouseEvent):void {
            navigateToURL(new URLRequest(CaravelConnect.news[_newsID].url), "_blank");
        }

        protected function rollOut(e:MouseEvent):void {
            _text.color = 0xFFFFFF;
        }

        protected function rollOver(e:MouseEvent):void {
            _text.color = 0x8888FF;
        }

        public function update():void {
            if (!_isActive) {
                activate();
                return;
            }

            bottom = S.SIZE_SWF_HEIGHT;
            center = S.SIZE_GAME_WIDTH / 2;

            switch(_state) {
                case(STATE_WAIT):
                    if (getTimer() > _waiter)
                        _state = STATE_HIDE;
                    break;

                case(STATE_HIDE):
                    alpha -= 0.0625;

                    if (alpha <= 0){
                        nextText();
                        _state = STATE_SHOW;
                    }
                    break;

                case(STATE_SHOW):
                    alpha += 0.0625;

                    if (alpha >= 1){
                        _state = STATE_WAIT;
                        _waiter = getTimer() + 1000 + _text.text.length * 50;
                    }
                    break;
            }
        }

        private function nextText():void {
            var news:Object = CaravelConnect.news[--_newsID];

            if (news == null)
                news = CaravelConnect.news[_newsID = CaravelConnect.news.length - 1];

            if (!news) {
                return;
            }

            var date:Date = new Date(news.timestamp * 1000);
            var text:String = date.getDate() + "/" + date.getMonth() + "/" + date.getFullYear();
            text +=  ": " + news.text

            _text.text = text;
            _text.textAlignCenter();
            _text.multiline = true;
            _text.wordWrap  = true;
            _text.width     = S.SIZE_GAME_WIDTH - 280;
            _text.apply();
        }
    }
}