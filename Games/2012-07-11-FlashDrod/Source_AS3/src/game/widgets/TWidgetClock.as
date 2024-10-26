package game.widgets{
    import flash.display.BitmapData;
    import flash.geom.Point;
    import flash.text.StyleSheet;
    import flash.text.TextField;

    import game.global.Game;
    import game.global.Gfx;
    import game.global.Level;
    import game.global.Room;
    import game.states.TStateGame;

    import net.retrocade.camel.core.rGfx;
    import net.retrocade.standalone.Text;

    public class TWidgetClock{
        private static const SNAKE_MOVE_NAME:Array = [
                [_("clcHo"), _("clcRiz"), _("clcOn"), _("clcTal")],
                [_("clcVe"), _("clcRt"), _("clcIc"), _("clcAl")]
            ];

        private static var x     :uint = 15;
        private static var y     :uint = 224;
        private static var width :uint = 132;
        private static var height:uint = 162;

        private static var text:TextField;
        private static var css :StyleSheet;

        private static var wasDrawn:Boolean = false;

        {
            init();
        }

        private static function init():void{
            text = new TextField();
            text.embedFonts = true;
            text.width  = 120;
            text.height = 162;

            css = new StyleSheet();

            css.setStyle("body",   {fontFamily: C.FONT_FAMILY, textAlign: "center", leading: -2, textAlign: "center"});
            css.setStyle(".desc",   {fontSize:15});
            css.setStyle(".snakes", {fontSize:16});

            setText(0);
        }

        public static function update(doDraw:Boolean, turnNo:uint = 0):void{
            if (doDraw){
                setText(turnNo);
                draw();

            } else if (wasDrawn)
                clearUnder();
        }

        private static function setText(turnNo:uint):void{
            turnNo %= 30;
			
			turnNo = 30 - turnNo;

            var newText:String;

            var turn:String = (turnNo.toString());

            css.setStyle(".timer",  {fontSize:30, color: (turnNo == 1 ? "#BB0000" : "#000000")});

            css.setStyle(".snakes1", {color: (turnNo % 5 == 0 ? "#000000" : "#BB0000")});
            css.setStyle(".snakes2", {color: (turnNo % 5 <  2 ? "#000000" : "#BB0000")});
            css.setStyle(".snakes3", {color: (turnNo % 5 <  3 ? "#000000" : "#BB0000")});
            css.setStyle(".snakes4", {color: (turnNo % 5 <  4 ? "#000000" : "#BB0000")});

            text.styleSheet = css;

            newText =
                "<body>" +
                "<p class='desc'>"+_("spawnCycle")+"</p>\n" +
                "<p class='timer'>" + turn + "</p>";

            if (Game.room.getMonsterOfType(C.M_SERPENT))
                newText += "\n" +
                "<p class='desc'>"+_("snakesPrefer")+"</p>\n" +
                "<p class='snakes'>" +
                "<p class='snakes1'>"+SNAKE_MOVE_NAME[turnNo % 10 < 5 ? 0 : 1][0]+"</p>" +
                "<p class='snakes2'>"+SNAKE_MOVE_NAME[turnNo % 10 < 5 ? 0 : 1][1]+"</p>" +
                "<p class='snakes3'>"+SNAKE_MOVE_NAME[turnNo % 10 < 5 ? 0 : 1][2]+"</p>" +
                "<p class='snakes4'>"+SNAKE_MOVE_NAME[turnNo % 10 < 5 ? 0 : 1][3]+"</p>" +
                "</p>";

            newText += "</body>";

            text.htmlText = newText;
        }

        private static function clearUnder():void{
            Game.room.layerUnder.drawComplexDirect(Gfx.IN_GAME_SCREEN,
                x, y, 1, x, y, width, height);

            wasDrawn = false;
        }

        private static function draw():void{
            Game.room.layerUnder.drawComplexDirect(Gfx.SCROLLS,
                x, y, 1, 164, 7, width, height);

            Game.room.layerUnder.drawDirect(
                text,
                x,
                y + (height - text.textHeight - 7) / 2);

            wasDrawn = true;
        }
    }
}