package game.windows {
    import game.global.Core;
    import game.global.Make;
    import net.retrocade.camel.core.rInput;
	import net.retrocade.camel.core.rWindow;
    import net.retrocade.standalone.Text;
    import net.retrocade.utils.Key;
    import net.retrocade.utils.UGraphic;
	
	/**
     * ...
     * @author Maurycy Zarzycki
     */
    public class TWindowRedefineWait extends rWindow {
        private static var _instance:TWindowRedefineWait = new TWindowRedefineWait();

        public static function show(keyName:String, callback:Function):void {
            _instance.showWindow(keyName, callback);
        }


        private var _text:Text;

        private var _currentKey:String;
        private var _callback:Function;

        public function TWindowRedefineWait() {
            _text = Make.text(18, 0xFFFFFF);

            _text.multiline = true;
            _text.wordWrap  = true;

            _text.textAlignCenter();
			_text.setShadow();
			
            UGraphic.clear(this).rectFill(0, 0, S.SIZE_SWF_WIDTH, S.SIZE_SWF_HEIGHT, 0, 0.7);

            addChild(_text);
        }

        public function showWindow(keyName:String, callback:Function):void {
            _callback   = callback;
            _currentKey = keyName;

            _text.width = S.SIZE_GAME_WIDTH;

            _text.text = _("redefineScreen", _(keyName), _("key" + Core.getKey(keyName)));

            _text.width = _text.textWidth + 5;
            _text.height = _text.textHeight + 5;

            _text.alignCenter();
            _text.alignMiddle();

            this.show();
        }

        override public function update():void {
            if (rInput.isAnyKeyHit()) {
                switch(rInput.lastKeyDown) {
                    case(Key.ENTER): case(Key.SPACE): case(Key.TAB):
                    case(Key.F1): case(Key.F2): case(Key.F3): case(Key.F4): case(Key.F5): case(Key.F6):
                    case(Key.F7): case(Key.F8): case(Key.F9): case(Key.F10): case(Key.F11): case(Key.F12):
                    case(Key.CAPS_LOCK): case(Key.SHIFT): case(Key.CONTROL): case(Key.WINDOWS_LEFT):
                    case(Key.WINDOWS_RIGHT): case(Key.WINDOWS_MENU): case(Key.OPTION):
                        _text.text = _("redefineInvalidKey", _("key" + rInput.lastKeyDown));

                        _text.width = _text.textWidth + 5;
                        _text.height = _text.textHeight + 5;

                        _text.alignCenter();
                        _text.alignMiddle();
                        break;

                    case(Key.NUMPAD_1):  case(Key.NUMPAD_2): case(Key.NUMPAD_3):
                    case(Key.NUMPAD_4):  case(Key.NUMPAD_5):  case(Key.NUMPAD_6): case(Key.NUMPAD_7):
                    case(Key.NUMPAD_8):  case(Key.NUMPAD_9):  case(Key.END):      case(Key.HOME):
                    case(Key.PAGE_UP): case(Key.PAGE_DOWN): case(Key.DELETE):   case(Key.INSERT):
                        _text.text = _("redefineReservedKey", _("key" + rInput.lastKeyDown));

                        _text.width = _text.textWidth + 5;
                        _text.height = _text.textHeight + 5;

                        _text.alignCenter();
                        _text.alignMiddle();
                        break;

                    case(Key.ESCAPE):
                        close();
                        break;

                    default:
                        _callback(_currentKey, rInput.lastKeyDown);
                        close();
                        break;
                }
            }
        }
    }
}