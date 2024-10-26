package src.Objects{
    import flash.display.MovieClip;
    
    import src.PlatformerEngine.Geometry;
    import src.PlatformerEngine.Gfx;
    import src.PlatformerEngine.ObjDisplay;
    import src.PlatformerEngine.Obs;

    public class SignHelp extends ObjDisplay{
        private var message:MessageField;
        
        private var x:int;
        private var y:int;
        
        public function SignHelp(x:int, y:int, gfx:MovieClip, name:String){
            this.x       = x;
            this.y       = y;
            this._gfx    = gfx;
            this.message = new MessageField(name);
            
            Gfx.frontAdd(_gfx);
            Obs.objectAdd(this);
        }
        
        
        override public function update():void{
            if (Geometry.RectRect(x, y - 100, 45, 130, Obs.player.x, Obs.player.y, Obs.player.width, Obs.player.height)){
                message.show = true;
            } else {
                message.show = false;
            }
            
            message.update();
        }
    }
}