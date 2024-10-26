package src.PlatformerEngine{
    public class Geometry{
        public static function RectRect(x1:Number, y1:Number, w1:Number, h1:Number, x2:Number, y2:Number, w2:Number, h2:Number):Boolean{
            x1 -= x2;
            y1 -= y2;
            if (x1 < w2 && x1 > -w1 && y1 < h2 && y1 > -h1){
                return true;
            } else {
                return false;
            }
        }
    }
}