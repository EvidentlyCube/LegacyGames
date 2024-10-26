package src.tiles{
    import src.PlatformerEngine.ObjInteractive;
    import src.PlatformerEngine.Settings;
    
    public class TSliderTopLeft extends TWall{
        public function TSliderTopLeft(x:uint, y:uint){
            super(x, y);
        }
        
        override public function pokedLeft(x:Number, y:Number, top:Boolean, o:ObjInteractive):Boolean{
            var modX:Number = x - _x;
            var modY:Number = y - _y;
            
            if (top){
                if (y + o.height > _y + Settings.TILE_HEIGHT){
                    return super.pokedLeft(x, y, top, o);
                    
                } else {
                    return false;
                }
            }
            
            if (modY > Settings.TILE_HEIGHT - 2 - modX){
                o.yRight = _y + Settings.TILE_HEIGHT - modX - 2;
                o.modifySpeedH(0, 1, 0, 0.5);
                if (o.speedh > 0){
                    o.climb(-45)
                } else {
                    o.slide(-45);
                }
            }
            
            return false;
        }
        
        override public function stomp(x:Number, y:Number, left:Boolean, o:ObjInteractive):Boolean{
            var modX:Number = x - _x;
            var modY:Number = y - _y;
            
            if (left){
                if (x + o.width > _x + Settings.TILE_WIDTH){
                    return super.stomp(x, y, left, o);
                    
                } else {
                    return false;
                }
            }
            
            if (modY > Settings.TILE_HEIGHT - 2 - modX - (o.speedv > 0 ? 2 : 0)){
                o.yRight = _y + Settings.TILE_HEIGHT - modX - 2;
                if (o.speedh <= 0){
                    o.slide(-45);
                } else if (o.speedh < 0){
                    o.climb(-45);
                }
                return true;
            }
            
            return false    
        }
        
        override public function pokedRight(x:Number, y:Number, top:Boolean, o:ObjInteractive):Boolean{
            if (x + o.width > _x + Settings.TILE_WIDTH){
                return super.pokedRight(x, y, top, o);
            }
            
            return false;
        }
        
        override public function headbutt(x:Number, y:Number, left:Boolean, o:ObjInteractive):Boolean{
            if (y + o.height > _y + Settings.TILE_HEIGHT){
                return super.headbutt(x, y, left, o);
            }
            
            return false;
        }
    }
}