package game.widgets {
    import flash.filters.GlowFilter;
    import game.global.Game;
    import game.global.Make;
    import net.retrocade.camel.core.rSave;
    import net.retrocade.standalone.Text;
	/**
     * ...
     * @author Maurycy Zarzycki
     */
    public class TWidgetMoveCounter {

        private static var text   :Text;
        private static var display:Boolean = false;

        { init(); }

        private static function init():void {
            text         = Make.text(40);
            text.color   = 0xFFFF00;
            text.filters = [ new GlowFilter(0, 1, 2, 2, 100)];

			rSave.setStorage(S.SAVE_OPTIONS_STORAGE);
            display = rSave.read(C.SETTING_MOVE_COUNTER, false);
			rSave.setStorage(S.SAVE_STORAGE_NAME);
        }

        public static function toggle():void {
            display = !display;

			rSave.setStorage(S.SAVE_OPTIONS_STORAGE);
            rSave.save(C.SETTING_MOVE_COUNTER, display);
            rSave.flush(C.SETTINGS_SAVE_SIZE);
			rSave.setStorage(S.SAVE_STORAGE_NAME);
        }

        public static function draw():void {
            if (display) {
                text.text = Game.turnNo.toString();
                Game.room.layerActive.drawPrecise(text, 5, -4, 1);
            }
        }
    }

}