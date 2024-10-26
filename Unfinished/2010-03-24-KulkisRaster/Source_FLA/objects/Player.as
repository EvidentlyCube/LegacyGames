package objects{
    import com.mauft.Control;
    
    import flash.display.MovieClip;
    
    import tiles.Tile;
    
    public class Player extends Interactiver{
    	private var inverted:Boolean = false;
    	
        public function Player(x:Number, y:Number, gfx:MovieClip){
        	super(x, y, gfx);
        	
            hSpeed = 0;
            vSpeed = 4;
            
            width  = 18;
            height = 18;
            
            color  = 1;
        }
        override public function update():void{
        	inverted = false;
        	
            if (Control.isKeyDown(Control.KEY_LEFT)){
                hSpeed = -3;
            } else if (Control.isKeyDown(Control.KEY_RIGHT)){
                hSpeed = 3;
            } else {
                hSpeed = 0;
            }
            
            if (Control.isKeyDown(Control.KEY_DOWN)){
            	if (vSpeed > 1.3){
            		vSpeed -= 0.1;
            	} else if (vSpeed < -1.3){
            		vSpeed += 0.1;
            	}
            } else if (Control.isKeyDown(Control.KEY_UP)){
            	if (vSpeed < 8.0 && vSpeed > 0){
                    vSpeed += 0.1;
                } else if (vSpeed > - 8.0 && vSpeed < 0){
                    vSpeed -= 0.1;
                }
            }
            
            pushH();
            pushV();
            
            gfx.x = x - 3;
            gfx.y = y - 3;
        }
        
        override protected function pushV():void{
            var tile1:Tile = Level.getTile(x, y + (vSpeed <= 0 ? vSpeed : vSpeed + height - 1));
            var tile2:Tile = Level.getTile(x + width - 1, y + (vSpeed <= 0 ? vSpeed : vSpeed + height - 1));
             if (tile1){
                tile1.hitV(this);
            }
            if (tile2){
                tile2.hitV(this);
            }
            if (!inverted){
                y += vSpeed;
            }
        }
        
        override public function hitH():void{
        	super.hitH();
        	hSpeed = 0;
        }
        
        override public function hitV():void{
        	super.hitV();
        	if (!inverted){
        	   vSpeed   = -vSpeed;
        	   inverted = true;
        	}
        }
    }
}