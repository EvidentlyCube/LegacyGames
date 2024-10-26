package src.PlatformerEngine{
    import flash.errors.*;
    public class Tile{
        
        public static function __stomp(_x:Number, _y:Number, _left:Boolean, _o:ObjInteractive):Boolean{
            var t:Tile = Level.tileGetFree(_x, _y);
            if (t){
                return t.stomp(_x, _y, _left, _o);
                
            }
            return false;
        }
        
        public static function __headbutt(_x:Number, _y:Number, _left:Boolean, _o:ObjInteractive):Boolean{
            var t:Tile = Level.tileGetFree(_x, _y);
            if (t){
                return t.headbutt(_x, _y, _left, _o);
                
            }
            return false;
        }
        
        public static function __pokedLeft(_x:Number, _y:Number, _top:Boolean, _o:ObjInteractive):Boolean{
            var t:Tile = Level.tileGetFree(_x, _y);
            if (t){
                return t.pokedLeft(_x, _y, _top, _o);
                
            }
            return false;
        }
        
        public static function __pokedRight(_x:Number, _y:Number, _top:Boolean, _o:ObjInteractive):Boolean{
            var t:Tile = Level.tileGetFree(_x, _y);
            if (t){
                return t.pokedRight(_x, _y, _top, _o);
                
            }
            return false;
        }
        
        public function get friction()     :Number{ return 1; }
        public function get maxSpeed()     :Number{ return 1; }
        public function get maxJump()      :Number{ return 1; }
        public function get gravity()      :Number{ return 1; }
        
        protected var _x:uint
        protected var _y:uint
        
        public function Tile(x:uint, y:uint){
            _x = x * Settings.TILE_WIDTH;
            _y = y * Settings.TILE_HEIGHT;
            
            Level.tileColliderSet(x, y, this)
        }
        
        public function stomp(x:Number, y:Number, left:Boolean, o:ObjInteractive):Boolean{
            o.stomp();
            return true;
        }
        
        public function headbutt(x:Number, y:Number, left:Boolean, o:ObjInteractive):Boolean{
            o.headButt();
            return true;
        }
        
        public function pokedLeft(x:Number, y:Number, top:Boolean, o:ObjInteractive):Boolean{
            o.hitLeft();
            return true;
        }
        
        public function pokedRight(x:Number, y:Number, top:Boolean, o:ObjInteractive):Boolean{
            o.hitRight();
            return true;
        }
    }
}