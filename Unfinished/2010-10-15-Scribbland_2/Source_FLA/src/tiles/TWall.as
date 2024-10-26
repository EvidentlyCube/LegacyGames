package src.tiles{
    import src.PlatformerEngine.ObjInteractive;
    import src.PlatformerEngine.Settings;
    import src.PlatformerEngine.Tile;

    public class TWall extends Tile{
        public function TWall(x:uint, y:uint){
            super(x, y);
        }
        
        override public function stomp(x:Number, y:Number, left:Boolean, o:ObjInteractive):Boolean{
            o.yRight = _y - 1;
            o.stomp();
            
            return true;
        }
        
        override public function headbutt(x:Number, y:Number, left:Boolean, o:ObjInteractive):Boolean{
            o.y = _y + Settings.TILE_HEIGHT;
            o.headButt();
            
            return true;
        }
        
        override public function pokedLeft(x:Number, y:Number, top:Boolean, o:ObjInteractive):Boolean{
            o.xRight = _x - 1;
            o.hitRight();
            
            return true;
        }
        
        override public function pokedRight(x:Number, y:Number, top:Boolean, o:ObjInteractive):Boolean{
            o.x = _x + Settings.TILE_WIDTH;
            o.hitLeft();
            
            return true;
        }
    }
}