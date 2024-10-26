package game.objects{
    import flash.display.BitmapData;

    import game.global.Game;


    import net.retrocade.camel.core.rGfx;
    import net.retrocade.camel.core.rInput;
    import net.retrocade.camel.core.rSave;

    public class TEscButton extends TGameObject{
        [Embed(source="/../assets/sprites/esc_00.png")] public static var _key_0_:Class;
        [Embed(source="/../assets/sprites/esc_01.png")] public static var _key_1_:Class;

        private static var _instance:TEscButton = new TEscButton();

        public static function set():void{
            _instance.set();
        }

        public static function unset():void{
            _instance.unset();
        }

        /****************************************************************************************************************/
        /**                                                                                                  VARIABLES  */
        /****************************************************************************************************************/

        private var _frames:Array = []
        private var _frame:uint = 0;
        private var _timer:uint = 0;

        public function TEscButton(){
            _frames[0] = rGfx.getBD(_key_0_);
            _frames[1] = rGfx.getBD(_key_1_);
        }

        private function set():void{
            // (!rSave.read('hitEscape', false))
                addDefault();
        }

        private function unset():void{
            nullifyDefault();
            rSave.write('hitEscape', true);
        }

        override public function update():void{
            _timer++;

            if (_timer == 25){
                _timer = 0;
                _frame = 1 - _frame;
            }

            Game.lGame.draw(_frames[_frame], S().levelWidth + S().playfieldOffsetX / 2 - width - 5, 5);
        }
    }
}