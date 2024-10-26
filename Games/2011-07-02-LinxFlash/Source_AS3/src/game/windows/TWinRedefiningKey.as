package game.windows{
    import net.retrocade.camel.core.rWindow;
    import net.retrocade.standalone.Bitext;
    import net.retrocade.utils.UGraphic;

    public class TWinRedefiningKey extends rWindow{
        private static var _instance:TWinRedefiningKey = new TWinRedefiningKey();
        public static function get instance():TWinRedefiningKey{
            return _instance;
        }

        private var _text1:Bitext;
        private var _text2:Bitext;
        private var _text3:Bitext;

        public function TWinRedefiningKey(){
            UGraphic.draw(this).rectFill(0, 0, S().gameWidth, S().gameHeight, 0, 0.85);

            _text1 = new Bitext();
            _text2 = new Bitext();
            _text3 = new Bitext();

            _text1.addShadow();
            _text2.addShadow();
            _text3.addShadow();

            _text1.setScale(2);
            _text2.setScale(1);
            _text3.setScale(2);

            addChild(_text1);
            addChild(_text2);
            addChild(_text3);

            _text1.text = _("redefining");
            _text3.text = _("hitNew");
        }

        public function set(key:String):void{
            _text2.text = _(key + "Desc");

            _text2.positionToCenterScreen();
            _text2.positionToMiddleScreen();

            _text1.positionToCenterScreen();
            _text3.positionToCenterScreen();

            _text1.y = _text2.y - _text1.height - 8;
            _text3.y = _text2.y + _text2.height + 8;

            show();
        }
    }
}