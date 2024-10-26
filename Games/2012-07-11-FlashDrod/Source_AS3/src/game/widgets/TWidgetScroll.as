package game.widgets{
	import flash.desktop.Clipboard;
	import flash.desktop.ClipboardFormats;
    import flash.display.BitmapData;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
    import flash.geom.Point;
    import flash.text.StyleSheet;
    import flash.text.TextField;
    import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import game.global.Core;
	import net.retrocade.camel.core.rInput;
	import net.retrocade.utils.Base64;
	import net.retrocade.utils.Key;

    import game.global.Game;
    import game.global.Gfx;
    import game.global.Level;
    import game.global.Room;
    import game.states.TStateGame;

    import net.retrocade.camel.core.rGfx;
    import net.retrocade.standalone.Text;

    public class TWidgetScroll{
        private static var x     :uint = 5;
        private static var y     :uint = 189;
        private static var width :uint = 145;
        private static var height:uint = 249;

        private static var text:Text;

        private static var wasDrawn:Boolean = false;

        {
            init();
        }



        private static function init():void{
            text = new Text();
            text.embedFonts = true;
            text.wordWrap   = true;
            text.width      = 126;
            text.height     = 200;
            text.autoSizeNone();

            setText("");
        }

        public static function update(doDraw:Boolean, text:String = ""):void{
            if (doDraw){
                setText(text);
                draw();

            } else if (wasDrawn)
                clearUnder();
        }

        private static function setText(txt:String):void{
            text.htmlText = "<font size='16' color='#000000' face='" + C.FONT_FAMILY + "'>"
                + "<textformat leading='-5'>"
                + txt
                + '</textformat>'
                + "</font>";
        }

        private static function clearUnder():void{
            Game.room.layerUnder.drawComplexDirect(Gfx.IN_GAME_SCREEN,
                x, y, 1, x, y, width, height);

            wasDrawn = false;
        }

        private static function draw():void{
            Game.room.layerUnder.drawComplexDirect(Gfx.SCROLLS,
                x, y, 1, 8, 3, width, height);

            Game.room.layerUnder.drawDirect(text, x + 5, y + 24);

            wasDrawn = true;
        }
    }
}