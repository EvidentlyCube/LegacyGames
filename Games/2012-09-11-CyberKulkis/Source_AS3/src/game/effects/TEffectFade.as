package game.effects{
    import flash.display.BitmapData;
    
    import game.global.Game;
    
    public class TEffectFade extends TEffects{
        private var alpha:uint = 100;
        private var fadeSpeed:uint;
        
        public function TEffectFade(gfx:BitmapData, x:uint, y:uint, mx:int, my:int, fadeSpeed:uint = 8){
            super(gfx, x, y, mx, my);
            
            this.fadeSpeed = fadeSpeed;
        }
        
        override public function draw():void{
            alpha -= fadeSpeed;
            
            if (alpha < 0)
                kill();
            else
                Game.lGame.drawAdvanced(_gfx, preciseX, preciseY, 0, 1, 1, null, false, alpha / 100);
        }
    }
}