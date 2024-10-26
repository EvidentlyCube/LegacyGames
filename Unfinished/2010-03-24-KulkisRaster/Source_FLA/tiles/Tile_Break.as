package tiles{
    import flash.display.MovieClip;
    
    import objects.Interactiver;
    import objects.TileFadeEffect;

    public class Tile_Break extends Tile{
    	public static const C_WHI:int =  1;
    	public static const C_GRN:int =  2;
    	public static const C_GRA:int =  4;
        public static const C_RED:int =  8;
        public static const C_ORN:int = 16;
        public static const C_TRQ:int = 32;
        public static const C_BLE:int = 64;
        
    	public var color:int;
    	
    	private var x:Number;
    	private var y:Number;
    	private var gfx:MovieClip
    	
    	private var dead:Boolean = false;
    	
        public function Tile_Break(x:Number, y:Number, color:int, gfx:MovieClip){
            super(x, y);
            
            this.color = color;
            this.gfx   = gfx;
            this.x     = x;
            this.y     = y;
            
            Level.addGFX(gfx);
        }
        
        override public function hitH(o:Interactiver):void{
            super.hitH(o);
        }
        override public function hitV(o:Interactiver):void{
        	if (dead){ return; }
        	if (o.color & color){
        		Level.setTile(x/24, y/24, null);
        		new TileFadeEffect(gfx);
        		dead = true;
        	}
            super.hitV(o);
        }
    }
}