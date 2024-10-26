package src.Objects{
    import src.PlatformerEngine.ObjInteractive;
    import src.PlatformerEngine.Settings;
    
    public class TGraphicCollider extends ObjInteractive{
        public var forceHigher:Boolean = false;
        
        public function set(x:int, y:int, height:int, o:ObjInteractive):void{
            forceHigher = false;
            
            _x = x;
            _y = y;
            
            _width = 1;
            _height = 1;
            
            _speedh = 0;
            _speedv = height;
            
            push();
            
            if (_y >= y + height){
                if (o.isSliding || o.isClimbing)
                    _y = y + height;
                else
                    _y = y;
            }
            
            Debug.circle(_x, _y, 3);
        }
    }
}