package submuncher.ingame.core {
    public class Tiles {
        public static const EMPTY:uint = 0;
        public static const ARROW_UP:uint = 1;
        public static const ARROW_RIGHT:uint = 2;
        public static const ARROW_DOWN:uint = 3;
        public static const ARROW_LEFT:uint = 4;
        public static const PIPE_AUOTILE:uint = 63;

        private static var Y:uint;
        private static var Y2:uint;
        private static var Y3:uint;
        private static var Y4:uint;

        {
            Y = S.tilesetWidthInTiles;
            Y2 = S.tilesetWidthInTiles * 2;
            Y3 = S.tilesetWidthInTiles * 3;
            Y4 = S.tilesetWidthInTiles * 4;
        }

        [Inline]
        public static function isFourWayAutoTile(tile:uint):Boolean {
            return false;
//            return (tile >= Y && tile <= Y + 6) || (tile >= Y2 && tile <= Y2 + 6) || tile === Y3 +4 || tile === Y4 + 4;
        }

        public static function isEightWayAutoTile(tile:uint):Boolean {
            return tile >= Y && tile <= Y + 2;
        }

        [Inline]
        public static function isSameType(tileLeft:uint, tileRight:uint):Boolean{
            return tileLeft === tileRight;
        }
    }
}
