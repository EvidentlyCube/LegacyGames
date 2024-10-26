package game.tiles{
    import flash.display.BitmapData;
    import flash.geom.Rectangle;
    
    import game.global.Game;
    import game.global.Level;
    import game.objects.TGameObject;
    
    public class TTilePit extends TGameObject{
        private static var _frames:Array;
        private static var _bitmap:BitmapData
        
        { staticInit(); }
        
        private static function staticInit():void{
            _frames = [];
            
            for (var i:uint = 0; i < 47; i++){
                _frames[i] = new Rectangle((i % 12) * S().tileWidth, (i / 12 | 0) * S().tileHeight, S().tileWidth, S().tileHeight);
            }
            
           // _bitmap = rGfx.getBD(_pit);
        }
       
        
        private var frame:int = -1;
        
        public function TTilePit(x:uint, y:uint){
            super(null, x, y);
            
            this.x = x;
            this.y = y;
            
            Level.level.set(x, y, this);
            
            addDefault();
        }
        
    }
}