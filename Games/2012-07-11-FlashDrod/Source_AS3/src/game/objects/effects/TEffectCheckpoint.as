package game.objects.effects{
    import flash.display.BitmapData;
    
    import game.global.Gfx;
    import game.global.Room;
    import game.managers.VOCoord;
    import game.managers.VOOrb;
    import game.managers.VOOrbAgent;
    import game.states.TStateGame;
    
    import net.retrocade.camel.core.rGfx;

    public class TEffectCheckpoint extends TEffect{
        private static const _gfx:BitmapData = rGfx.getBDExt(Gfx.CLASS_EFFECTS, 0, 22, 22, 22);
        
        private static const DURATION:uint = 120;
        
        private var drawOrb:Boolean;
        
        private var x:uint;
        private var y:uint;
        
        private var duration:uint = 0;
        
        public function TEffectCheckpoint(position:VOCoord){
            x = position.x;
            y = position.y;
            
            TStateGame.effectsUnder.add(this);
        }
        
        override public function update():void{
            if (duration++ == DURATION){
                TStateGame.effectsUnder.nullify(this);
                return;
            }
            
            room.layerActive.draw(_gfx, x, y, (DURATION - duration) / DURATION);
        }
    }
}