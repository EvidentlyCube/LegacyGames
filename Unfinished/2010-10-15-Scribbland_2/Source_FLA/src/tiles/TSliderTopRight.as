package src.tiles{
    import src.PlatformerEngine.ObjInteractive;
    import src.PlatformerEngine.Settings;
    
    public class TSliderTopRight extends TWall{
        public function TSliderTopRight(x:uint, y:uint){
            super(x, y);
        }
        
        override public function pokedRight(x:Number, y:Number, top:Boolean, o:ObjInteractive):Boolean{
            var modX:Number = x - _x;
            var modY:Number = y - _y;
            
            if (top){
                if (y + o.height > _y + Settings.TILE_HEIGHT){
                    return super.pokedLeft(x, y, top, o)
                    
                } else {
                    return false;    
                }
            }
            
            if (modY > modX - 1){
                o.yRight = _y + modX - 1;
                o.modifySpeedH(0, 1, 0, 0.5);
                if (o.speedh < 0){
                    o.climb(45)
                } else {
                    o.slide(45);
                }
            }
            
            return false;
        }
        
        override public function stomp(x:Number, y:Number, left:Boolean, o:ObjInteractive):Boolean{
            var modX:Number = x - _x;
            var modY:Number = y - _y;
            
            if (!left){
                if (x - o.width < _x){
                    return super.stomp(x, y, left, o)
                    
                } else {
                    return false;
                }
            }
            
            if (modY > modX - 1 - (o.speedv > 0 ? 2 : 0)){
                o.yRight = _y + modX - 1;
                if (o.speedh >= 0){
                    o.slide(45);
                    
                } else if (o.speedh < 0){
                    o.climb(45);
                }
                return true;
            }
            
            return false;
        }
        
        override public function pokedLeft(x:Number, y:Number, top:Boolean, o:ObjInteractive):Boolean{
            if (x < _x){
                return super.pokedLeft(x, y, top, o);
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