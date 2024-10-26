package game.objects.effects{
    import game.global.Gfx;
    import game.global.Room;
    import game.managers.VOCoord;
    import game.managers.effects.VOParticle;
    import game.states.TStateGame;
    
    import net.retrocade.camel.core.rGfx;
    
    public class TEffectTarSplatter extends TEffectParticles{
        private static var _frames:Array = [
                rGfx.getBDExt(Gfx.CLASS_EFFECTS, 132, 44, 6, 6),
                rGfx.getBDExt(Gfx.CLASS_EFFECTS, 154, 44, 8, 8)
            ];
        
        public function TEffectTarSplatter(origin:VOCoord, duration:uint, speed:uint){
            super(origin, 8, 8, 2, 25, duration, speed);
            
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