package game.widgets{
    import flash.display.BitmapData;
    import flash.geom.Point;
    import game.global.Make;

    import game.global.Game;
    import game.global.Gfx;
    import game.global.Level;
    import game.global.Room;
    import game.states.TStateGame;

    import net.retrocade.camel.core.rGfx;
    import net.retrocade.standalone.Text;

    public class TWidgetLevelName{
        private static var x:uint;
        private static var y:uint;
        private static var width:uint;
        private static var height:uint;

        private static var text:Text;

        {
            init();
        }

        private static function init():void{
            text = Make.text(26);
        }

        public static function update(roomID:uint, levelID:uint):void{
            var name  :String = _(Level.getLevelName(levelID));
            var offset:Point  = Level.getRoomOffsetInLevel(roomID);

            text.text = name + ": " + nameFromPosition(offset.x, offset.y);

            clearUnder();
            calculate();
            draw();
        }

        private static function clearUnder():void{
            Game.room.layerUnder.drawComplexDirect(Gfx.IN_GAME_SCREEN,
                x, y, 1, x, y, width, height);
        }

        private static function calculate():void{
            width  = text.textWidth + 100;
            height = 38;

            x = (596 - width) / 2 + 158;
            y = 3;
        }

        private static function draw():void{
            Game.room.layerUnder.drawComplexDirect(Gfx.SCROLLS,
                x, y, 1, 2, 385, 65, 36);

            //65 + x + 67
            var wid   :uint = width - 65 - 67;
            var xNow  :uint = x + 65;
            var toDraw:uint = 0;

            while (wid > 0){
                toDraw = Math.min(wid, 48);
                wid -= toDraw;

                Game.room.layerUnder.drawComplexDirect(Gfx.SCROLLS, xNow, y, 1, 69, 385, toDraw, 36);

                xNow += toDraw;
            }

            Game.room.layerUnder.drawComplexDirect(Gfx.SCROLLS,
                xNow, y, 1, 118, 385, 67, 36);

            Game.room.layerUnder.drawDirect(text, x + 50, y - 4, 1);
        }

        public static function nameFromPosition(x:int, y:int):String{
            if (x == 0 && y == 0)
                return _("roomEntrance");

            var h:String = (x > 0 ? " "+_("roomEast")  : x < 0 ? " "+_("roomWest")  : "");
            var v:String = (y > 0 ? " "+_("roomSouth") : y < 0 ? " "+_("roomNorth") : "");

            x = x < 0 ? -x : x;
            y = y < 0 ? -y : y;

            if (x == 0)
                return numberToName(y) + v;

            else if (y == 0)
                return numberToName(x) + h;

            else
                return numberToName(y) + v + ", " + numberToName(x) + h;
        }

        private static function numberToName(i:uint):String{
            if (i >= 20)
                return _("roomMore", i);
            else
                return _("room" + i);
        }
    }
}