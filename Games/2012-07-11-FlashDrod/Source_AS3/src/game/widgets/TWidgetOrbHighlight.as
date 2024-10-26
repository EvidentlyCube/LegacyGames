package game.widgets {
    import flash.display.BitmapData;
    import game.global.Game;
    import game.global.Room;
    import game.managers.VOOrb;
    import game.managers.VOOrbAgent;
    import net.retrocade.utils.UBitmapData;
	/**
     * ...
     * @author Maurycy Zarzycki
     */
    public class TWidgetOrbHighlight {

        private static const COLORS:Array = [0, 0x88FF8800, 0x8800FFFF, 0x88FF0040];

        private static var room      :Room;
        public  static var isActive  :Boolean = false;

        private static var bitmapData:BitmapData;

        {init();}
        private static function init():void {
            bitmapData = new BitmapData(S.LEVEL_WIDTH_PIXELS, S.LEVEL_HEIGHT_PIXELS, true, 0);
        }

        public static function drawOrbHighlights(orbX:uint, orbY:uint):void {
            room     = Game.room;
            isActive = true;

            var orb:VOOrb = room.orbs[orbX + orbY * S.LEVEL_WIDTH];

            UBitmapData.blitRectangle(bitmapData, 0, 0, S.LEVEL_WIDTH_PIXELS, S.LEVEL_HEIGHT_PIXELS, 0);

            if (!orb)
                return;

            for each(var agent:VOOrbAgent in orb.agents) {
                var array:Array = room.getConnectedTiles(agent.tX, agent.tY, [C.T_DOOR_Y, C.T_DOOR_YO], false);
                drawArray(array, COLORS[agent.type]);
            }
        }

        public static function update():void {
            if (isActive)
                room.layerActive.draw(bitmapData, 0, 0, 1);
        }

        private static function drawArray(array:Array, color:uint):void {
            for each (var pos:uint in array) {
                var x:uint = pos % S.LEVEL_WIDTH;
                var y:uint = (pos / S.LEVEL_WIDTH) | 0;

                UBitmapData.blitRectangle(bitmapData,
                                          x * S.LEVEL_TILE_WIDTH,
                                          y * S.LEVEL_TILE_HEIGHT,
                                          S.LEVEL_TILE_WIDTH,
                                          S.LEVEL_TILE_HEIGHT,
                                          color);
            }
        }
    }

}