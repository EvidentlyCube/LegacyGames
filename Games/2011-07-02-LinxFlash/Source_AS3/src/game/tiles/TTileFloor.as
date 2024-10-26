package game.tiles{
    import flash.display.BitmapData;

    import game.global.Game;

    import net.retrocade.camel.core.rGfx;

    public class TTileFloor{
        [Embed(source="/../assets/gfx/by_cage/tiles/bg_tile00.png")] public static var _floor_0:Class;
        [Embed(source="/../assets/gfx/by_cage/tiles/bg_tile01.png")] public static var _floor_1:Class;
        [Embed(source="/../assets/gfx/by_cage/tiles/bg_tile02.png")] public static var _floor_2:Class;
        [Embed(source="/../assets/gfx/by_cage/tiles/bg_tile03.png")] public static var _floor_3:Class;

        private static var _bmp:Array;

        public static function drawFloor(x:uint, y:uint):void{
            if (!_bmp){
                _bmp = [];
                _bmp[0] = rGfx.getBD(_floor_0);
                _bmp[1] = rGfx.getBD(_floor_1);
                _bmp[2] = rGfx.getBD(_floor_2);
                _bmp[3] = rGfx.getBD(_floor_3);
            }

            Game.lBG.draw(_bmp[Math.random() * 4 | 0], x + S().playfieldOffsetX, y + S().playfieldOffsetY);
        }
    }
}