package src{
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    
    public class GFX{
        private static var gfx:Array = new Array;
        public function GFX(){}
        public static function B(c:Class):Bitmap{
            if (!gfx[c]){
                gfx[c] = new c;
            }
            
            return new Bitmap(gfx[c]);
        }
        public static function BD(c:Class):BitmapData{
            if (!gfx[c]){
                gfx[c] = new c(c.width, c.height);
            }

            return gfx[c];
        }
    }
}