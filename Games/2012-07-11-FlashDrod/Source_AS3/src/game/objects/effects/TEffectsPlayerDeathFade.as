package game.objects.effects{
    import flash.display.Shape;
    import flash.utils.getTimer;
    
    import game.states.TStateGame;
    
    import net.retrocade.utils.UGraphic;

    public class TEffectsPlayerDeathFade extends TEffect{
        private var shape:Shape = new Shape;
        private var timeFrom:Number;
        private var timeTo  :Number;
        
        public function TEffectsPlayerDeathFade(){
            super();
            
            TStateGame.effectsAbove.add(this);
            
            timeFrom = getTimer();
            timeTo   = timeFrom + 2500;
        }
        
        override public function update():void{
            UGraphic.clear(shape)
                .rectFill(0, 0, S.LEVEL_WIDTH_PIXELS, S.LEVEL_HEIGHT_PIXELS, 0);
            
            room.layerActive.drawDirect(shape, 0, 0, 1 - (timeTo - getTimer()) / (timeTo - timeFrom));
            
            if (getTimer() > timeTo){
                TStateGame.instance.restartCommand();
            }
        }
    }
}