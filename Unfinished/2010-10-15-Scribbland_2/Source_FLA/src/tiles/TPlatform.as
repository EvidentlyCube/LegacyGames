package src.tiles{
    import src.PlatformerEngine.ObjInteractive;
    import src.PlatformerEngine.Tile;

    public class TPlatform extends Tile{
        public function TPlatform(x:uint, y:uint){
            super(x, y);
        }
        
        override public function stomp(_x:Number, _y:Number, _left:Boolean, o:ObjInteractive):Boolean{
            if (o.yRight < this._y){
                o.yRight = this._y - 1;
                super.stomp(_x, _y, _left, o); 
                return true;
            }
            return false;
        }
        
        override public function headbutt(_x:Number, _y:Number, _left:Boolean, o:ObjInteractive):Boolean{
            return false;
        }
        
        override public function pokedLeft(_x:Number, _y:Number, _top:Boolean, o:ObjInteractive):Boolean{
            return false;
        }
        
        override public function pokedRight(_x:Number, _y:Number, _top:Boolean, o:ObjInteractive):Boolean{
            return false;
        }
    }
}