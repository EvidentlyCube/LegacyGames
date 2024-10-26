package game.windows{
    import net.retrocade.camel.core.rWindow;
    import net.retrocade.utils.UGraphic;
    import net.retrocade.standalone.Text;

    public class TWinRedefiningKey extends rWindow{
        private static var _instance:TWinRedefiningKey = new TWinRedefiningKey();
        public static function get instance():TWinRedefiningKey{
            return _instance;
        }

        private var _text1:Text;
        private var _text2:Text;
        private var _text3:Text;

        public function TWinRedefiningKey(){
            UGraphic.draw(this).rectFill(0, 0, S().gameWidth, S().gameHeight, 0, 0.85);

            _text1 = new Text("", "font", 15);
            _text2 = new Text("", "font", 15);
            _text3 = new Text("", "font", 15);

            _text1.setShadow();
            _text2.setShadow();
            _text3.setShadow();

            addChild(_text1);
            addChild(_text2);
            addChild(_text3);

            _text1.text = _("redefining");
            _text3.text = _("hitNew");
        }

        public function set(key:String):void{
            _text2.text = _(key + "Desc");

            _text3.x = (S().gameWidth - _text3.width) / 2;
            _text1.x = (S().gameWidth - _text1.width) / 2;
            _text2.x = (S().gameWidth - _text2.width) / 2;
            _text2.y = (S().gameHeight - _text2.height) / 2;

            _text1.y = _text2.y - _text1.height - 8;
            _text3.y = _text2.y + _text2.height + 8;

            show();
        }
    }
}