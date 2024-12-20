package game.objects {
import game.global.Game;

import net.retrocade.retrocamel.core.RetrocamelBitmapManager;
import net.retrocade.retrocamel.global.RetrocamelSimpleSave;

public class TEscButton extends TGameObject {
    [Embed(source="../../../assets/gfx/by_maurycy/esc_00.png")]
    public static var _key_0_:Class;
    [Embed(source="../../../assets/gfx/by_maurycy/esc_01.png")]
    public static var _key_1_:Class;

    private static var _instance:TEscButton = new TEscButton();

    public static function activate():void {
        _instance.set();
    }

    public static function disactivate():void {
        _instance.unset();
    }

    /****************************************************************************************************************/
    /**                                                                                                  VARIABLES  */
    /****************************************************************************************************************/

    private var _frames:Array = [];
    private var _frame:uint = 0;
    private var _timer:uint = 0;

    public function TEscButton() {
        _frames[0] = RetrocamelBitmapManager.getBD(_key_0_);
        _frames[1] = RetrocamelBitmapManager.getBD(_key_1_);
    }

    private function set():void {
        if (!RetrocamelSimpleSave.read('hitEscape', false))
            addDefault();
    }

    private function unset():void {
        nullifyDefault();
        RetrocamelSimpleSave.write('hitEscape', true);
    }

    override public function update():void {
        _timer++;

        if (_timer == 25) {
            _timer = 0;
            _frame = 1 - _frame;
        }

        Game.lGame.draw(_frames[_frame], 5, S().levelHeight - 43);
    }
}
}