package game.objects.effects{
    import game.global.Gfx;
    import game.global.Room;
    import game.managers.VOCoord;
    import game.managers.effects.VOParticle;
    import game.states.TStateGame;
    
    import net.retrocade.camel.core.rGfx;
    
    public class TEffectBlood extends TEffectParticles{
        private static var _frames:Array = [
                rGfx.getBDExt(Gfx.CLASS_EFFECTS, 0,  44, 4, 4),
                rGfx.getBDExt(Gfx.CLASS_EFFECTS, 22, 44, 6, 6)
            ];
        
        public function TEffectBlood(origin:VOCoord, particles:uint, duration:uint, speed:uint){
            super(origin, 6, 6, 2, particles, duration, speed);
            
            TStateGame.effectsAbove.add(this);
        }
        
        override public function update():void{
            if (!moveParticles()){
                TStateGame.effectsAbove.nullify(this);
                return;
            }
            
            for each(var p:VOParticle in particles){
                if (p.active)
                    room.layerActive.blitDirectly(_frames[p.type], p.x, p.y);
            }
        }
    }
}