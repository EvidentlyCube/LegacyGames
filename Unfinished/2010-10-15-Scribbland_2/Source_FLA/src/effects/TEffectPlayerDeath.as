package src.effects{
    import src.PlatformerEngine.Gfx;
    import src.PlatformerEngine.ObjDisplay;
    import src.PlatformerEngine.Obs;
    import src.PlatformerEngine.Scrolling;
    import src.PlatformerEngine.Settings;
    
    public class TEffectPlayerDeath extends ObjDisplay{
        private var speedh:Number;
        private var speedv:Number;
        
        public function TEffectPlayerDeath(x:int, y:int, speedh:int){
            _gfx = new _MC_PLAYER_KILL();
            
            _gfx.x      = x;
            _gfx.y      = y;
            this.speedh = speedh;
            this.speedv = - 4;
            
            Gfx.frontAdd(_gfx);
            
            Obs.effectAdd(this);
        }
        
        override public function update():void{
            _gfx.x        += speedh;
            _gfx.y        += speedv;
            _gfx.rotation += speedh
            
            speedv += 0.2;
            
            if (_gfx.y >= Scrolling.edgeBottom + Settings.SCREEN_HEIGHT + 30){
                
            }
        }

    }
}