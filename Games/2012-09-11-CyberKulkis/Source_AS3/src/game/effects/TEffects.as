package game.effects{
    import flash.display.BitmapData;
    
    import game.global.Level;
    import game.objects.TGameObject;
    
    import net.retrocade.camel.core.rGroup;
    
    public class TEffects extends TGameObject{
        public function TEffects(gfx:BitmapData, x:uint, y:uint, mx:int, my:int){
            _gfx = gfx;
            _x   = x;
            _y   = y;
            
            this.mx = mx * (24 / gameSpeed);
            this.my = my * (24 / gameSpeed);
            
            addDefault();
        }
        
        override public function update():void{
            x += (mx *= 0.95);
            y += (my *= 0.95);
            
            draw();
        }
        
        override public function get defaultGroup():rGroup{
            return Level.effects;
        }
        
        override public function kill():void{
            nullifyDefault();
        }
        
        override public function stop():void{
            if (movementWait == 0)
                mx = my = 0;
            else
                stopNow = true;
        }
    }
}