package src.Objects{
    import flash.display.MovieClip;
    
    import src.IResetable;
    import src.PlatformerEngine.Geometry;
    import src.PlatformerEngine.Gfx;
    import src.PlatformerEngine.ObjDisplay;
    import src.PlatformerEngine.Obs;

    public class SignLeft extends ObjDisplay{
        private var x:int;
        private var y:int;
        
        public function SignLeft(x:int, y:int, gfx:MovieClip){
            this.x       = x;
            this.y       = y;
            this._gfx    = gfx;
            
            Gfx.frontAdd(_gfx);
            Obs.objectAdd(this);
        }
        
        override public function update():void{
            if (Geometry.RectRect(x, y, 45, 30, Obs.player.x, Obs.player.y, Obs.player.width, Obs.player.height)){
                Obs.player.direction = -1;
            }
        }
    }
}