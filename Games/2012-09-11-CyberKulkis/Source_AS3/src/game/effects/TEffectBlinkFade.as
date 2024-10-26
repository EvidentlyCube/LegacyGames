package game.effects{
    import flash.display.BitmapData;
    
    import game.global.Game;
    
    public class TEffectBlinkFade extends TEffects{
        private var alpha:int = 150;
        private var fadeSpeed:uint;
        
        private var blink:uint = 0;
        
        public function TEffectBlinkFade(gfx:BitmapData, x:uint, y:uint, mx:int, my:int, fadeSpeed:uint = 8){
            super(gfx, x, y, mx, my);
            
            this.fadeSpeed = fadeSpeed;
        }
        
        override public function draw():void{
            if (blink < 255)
                blink = Math.min(blink + 35, 255);
            else
                alpha -= fadeSpeed;
            
            if (alpha < 0)
                kill();
            else
                Game.lGame.drawSpecial(gfx, x, y, 0, 1, 1, Math.min(alpha / 100, 1), null, true, 1, 1, 1, blink, blink, blink);
        }
    }
}