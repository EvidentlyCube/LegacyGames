package src.Objects{
    import flash.display.MovieClip;
    
    import src.PlatformerEngine.Geometry;
    import src.PlatformerEngine.Gfx;
    import src.PlatformerEngine.Level;
    import src.PlatformerEngine.ObjDisplay;
    import src.PlatformerEngine.Obs;

    public class SignCheckpoint extends ObjDisplay{
        private var hooked:Boolean = false;
        
        private var x:int;
        private var y:int;
        
        public function SignCheckpoint(x:int, y:int, gfx:MovieClip, name:String){
            this.x       = x;
            this.y       = y;
            this._gfx    = gfx;
            
            Gfx.frontAdd(_gfx);
            Obs.objectAdd(this);
        }
        
        
        override public function update():void{
            if (Geometry.RectRect(x, y - 100, 45, 130, Obs.player.x, Obs.player.y, Obs.player.width, Obs.player.height)){
                if (!hooked){
                    Level.stateCheckpoint()
                    hooked = true;
                }
                
            } else if (hooked){
                hooked = false;
            }
        }
    }
}