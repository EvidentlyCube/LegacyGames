package game.objects.effects{
    import flash.utils.getTimer;
    
    import game.global.Game;
    import game.states.TStateGame;
    import game.widgets.TWidgetFace;
    
    import net.retrocade.camel.effects.rEffFadeScreen;
    import net.retrocade.utils.Rand;

    public class TEffectPlayerDeath extends TEffect{
        public static const FRAME_RATE_MSEC:uint = 100;
        
        private var lastFrameTime:uint = 0;
        
        public function TEffectPlayerDeath(){
            super();
            
            TWidgetFace.setMood(TWidgetFace.MOOD_DYING);
            
            TStateGame.effectsUnder.add(this);
        }
        
        override public function update():void{
            if (lastFrameTime + FRAME_RATE_MSEC < getTimer()){
                lastFrameTime = getTimer();
                
                rotatePlayer();
            }
        }
        
        private function rotatePlayer():void{
            Game.player.o = (Rand.om < 0.5 ? F.nextCO(Game.player.o) : F.nextCCO(Game.player.o));
            Game.player.setSwordCoords();
            Game.player.setGfx();
        }
    }
}