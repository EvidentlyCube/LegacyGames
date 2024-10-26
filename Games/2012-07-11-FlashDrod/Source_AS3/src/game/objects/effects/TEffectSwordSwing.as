package game.objects.effects{
    import game.global.Gfx;
    import game.global.Room;
    import game.states.TStateGame;
    
    import net.retrocade.camel.core.rGfx;

    public class TEffectSwordSwing extends TEffect{
        private static const frames:Array = [
                rGfx.getBDExt(Gfx.CLASS_EFFECTS, 0,   0, 22, 22),
                rGfx.getBDExt(Gfx.CLASS_EFFECTS, 22,  0, 22, 22),
                rGfx.getBDExt(Gfx.CLASS_EFFECTS, 44,  0, 22, 22),
                rGfx.getBDExt(Gfx.CLASS_EFFECTS, 66,  0, 22, 22),
                null,
                rGfx.getBDExt(Gfx.CLASS_EFFECTS, 88,  0, 22, 22),
                rGfx.getBDExt(Gfx.CLASS_EFFECTS, 110, 0, 22, 22),
                rGfx.getBDExt(Gfx.CLASS_EFFECTS, 132, 0, 22, 22),
                rGfx.getBDExt(Gfx.CLASS_EFFECTS, 154, 0, 22, 22),
            ];
        
        private static const EFFECT_DURATION:uint = 20;
        
        private var x:uint;
        private var y:uint;
        private var o:uint;
        private var alpha:uint = EFFECT_DURATION;
        
        public function TEffectSwordSwing(x:uint, y:uint, o:uint){
            this.x = x * S.LEVEL_TILE_WIDTH;
            this.y = y * S.LEVEL_TILE_HEIGHT;
            this.o = o;
            
            switch(o){
                case(C.NW): this.x -= S.LEVEL_TILE_WIDTH / 2; this.y -= S.LEVEL_TILE_HEIGHT;     break;
                case(C.N):  this.x += S.LEVEL_TILE_WIDTH / 2; this.y -= S.LEVEL_TILE_HEIGHT;     break;
                case(C.NE): this.x += S.LEVEL_TILE_WIDTH;     this.y -= S.LEVEL_TILE_HEIGHT / 2; break;
                case(C.E):  this.x += S.LEVEL_TILE_WIDTH;     this.y += S.LEVEL_TILE_HEIGHT / 2; break;
                case(C.SE): this.x += S.LEVEL_TILE_WIDTH / 2; this.y += S.LEVEL_TILE_HEIGHT;     break;
                case(C.S):  this.x -= S.LEVEL_TILE_WIDTH / 2; this.y += S.LEVEL_TILE_HEIGHT;     break;
                case(C.SW): this.x -= S.LEVEL_TILE_WIDTH;     this.y += S.LEVEL_TILE_HEIGHT / 2; break;
                case(C.W):  this.x -= S.LEVEL_TILE_WIDTH;     this.y -= S.LEVEL_TILE_HEIGHT / 2; break;
            }
            
            TStateGame.effectsAbove.add(this);
        }
        
        override public function update():void{
            if (--alpha == 0){
                TStateGame.effectsAbove.nullify(this);
                return;
            }
            
            room.layerActive.drawDirect(frames[o], x, y, alpha / EFFECT_DURATION);
        }
    }
}