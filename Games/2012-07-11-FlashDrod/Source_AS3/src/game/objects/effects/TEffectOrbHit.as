package game.objects.effects{
    import flash.display.BitmapData;
    
    import game.global.Gfx;
    import game.global.Room;
    import game.managers.VOCoord;
    import game.managers.VOOrb;
    import game.managers.VOOrbAgent;
    import game.states.TStateGame;
    
    import net.retrocade.camel.core.rGfx;

    public class TEffectOrbHit extends TEffect{
        private static const _gfx:BitmapData = rGfx.getBDExt(Gfx.CLASS_EFFECTS, 22, 22, 22, 22);
        
        private static const DURATION:uint = 7;
        
        private var x:uint;
        private var y:uint;
        
        private var duration:uint = 0;
        
        public function TEffectOrbHit(_orbData:*, _drawOrb:Boolean){
            x = _orbData.x;
            y = _orbData.y;
            
            if (_orbData is VOOrb && _orbData.agents.length)
                new TEffectOrbBolts(_orbData);
            
            if (_drawOrb)
                TStateGame.effectsUnder.add(this);
        }
        
        override public function update():void{
            if (duration++ == DURATION){
                TStateGame.effectsUnder.nullify(this);
                return;
            }
            
            room.layerActive.blit(_gfx, x, y);
        }
    }
}