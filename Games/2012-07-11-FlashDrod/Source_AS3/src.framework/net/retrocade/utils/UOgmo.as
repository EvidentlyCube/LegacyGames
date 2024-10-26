package net.retrocade.utils{
    public class UOgmo{
        public static function toCode(tx:uint, ty:uint, tileSize:uint = 16, rowSize:uint = 16):uint{
            return (tx / tileSize | 0) + (ty / (rowSize * tileSize) | 0) * rowSize;
        }
    }
}