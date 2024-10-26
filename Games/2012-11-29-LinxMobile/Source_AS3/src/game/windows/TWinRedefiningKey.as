package game.windows{
    import game.global.Make;

    import net.retrocade.camel.global.rWindow;
    import net.retrocade.standalone.Text;
    import net.retrocade.utils.UGraphic;

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

            _text1 = Make().text();
            _text2 = Make().text();
            _text3 = Make().text();

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

            _text2.alignCenter();
            _text2.alignMiddle();

            _text1.alignCenter();
            _text3.alignCenter();

            _text1.y = _text2.y - _text1.height - 8;
            _text3.y = _text2.y + _text2.height + 8;

            show();
        }
    }
}