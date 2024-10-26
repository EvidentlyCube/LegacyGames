package objects{
    import flash.display.MovieClip;
    
    import tiles.Tile;
    
    public class Interactiver extends Updaters{
        protected var x:Number;
        protected var y:Number;
        
        protected var width:Number;
        protected var height:Number;
        
        protected var hSpeed:Number = 0;
        protected var vSpeed:Number = 0;
        
        protected var gfx:MovieClip;
        
        public var color:Number = 0;
        
        public function Interactiver(x:Number, y:Number, gfx:MovieClip){
        	this.x   = x;
        	this.y   = y;
            this.gfx = gfx;
            
            Level.addGFX(gfx);
            Level.addObj(this);
        }

        protected function pushH():void{
            var tile1:Tile = Level.getTile(x + (hSpeed <= 0 ? hSpeed : hSpeed + width - 1), y);
            var tile2:Tile = Level.getTile(x + (hSpeed <= 0 ? hSpeed : hSpeed + width - 1), y + height - 1);
            if (tile1){
                tile1.hitH(this);
            }
            if (tile2){
            	tile2.hitH(this);
            }
            x += hSpeed;
        }
        
        protected function pushV():void{
            var tile1:Tile = Level.getTile(x, y + (vSpeed <= 0 ? vSpeed : vSpeed + height - 1));
            var tile2:Tile = Level.getTile(x + width - 1, y + (vSpeed <= 0 ? vSpeed : vSpeed + height - 1));
             if (tile1){
                tile1.hitV(this);
            }
            if (tile2){
                tile2.hitV(this);
            }
            y += vSpeed;
        }
        
        public function hitH():void{
            if (hSpeed <= 0){
                x = Math.floor(x / 24) * 24;
            } else {
                x = Math.floor(x / 24) * 24 + 24 - width;
            }
        }
        
        public function hitV():void{
            if (vSpeed <= 0){
                y = Math.floor(y / 24) * 24;
            } else {
                y = Math.floor(y / 24) * 24 + 24 - height;
            }
        }
        
        public function kill():void{
            Level.remGFX(gfx);
            Level.remObj(this);
        }
    }
}