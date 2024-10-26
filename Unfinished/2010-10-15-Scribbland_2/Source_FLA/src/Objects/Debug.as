package src.Objects{
    import flash.display.Graphics;
    import flash.display.Shape;
    
    import src.PlatformerEngine.Gfx;

    public class Debug{
        private static var layer:Shape;
        
        public static function init():void{
            layer = Gfx.layerDebug;
        }
        
        public static function update():void{
            layer.graphics.clear();
        }
        
        public static function circle(x:int, y:int, r:int):void{
            layer.graphics.beginFill(0xFF0000);
            layer.graphics.drawCircle(x, y, r);
            layer.graphics.endFill();
        }
    }
}