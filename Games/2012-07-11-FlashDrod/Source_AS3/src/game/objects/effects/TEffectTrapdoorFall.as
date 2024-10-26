package game.objects.effects{
    import flash.display.BitmapData;
    import flash.geom.Matrix;
    import flash.geom.Rectangle;
    
    import game.global.Gfx;
    import game.global.Room;
    import game.states.TStateGame;
    
    import net.retrocade.camel.core.rGfx;

    public class TEffectTrapdoorFall extends TEffect{
        private static var DURATION:uint = S.LEVEL_TILE_HEIGHT;
        
        private var x:uint;
        private var y:Number;
        
        private var tileX:uint;
        private var tileY:uint;
        
        private var fall:uint = 0;
        
        public function TEffectTrapdoorFall(x:uint, y:uint){
            super();
            
            this.tileX = x;
            this.tileY = y;
            
            this.x = x * S.LEVEL_TILE_WIDTH;
            this.y = y * S.LEVEL_TILE_HEIGHT;
            
            TStateGame.effectsUnder.add(this);
        }
        
        override public function update():void{
            if (fall++ == DURATION){
                TStateGame.effectsUnder.nullify(this);
                return;
            }
            
            y += 1.5;
            tileY = (y / S.LEVEL_TILE_HEIGHT | 0);
            
            if (room.tilesOpaque[tileX + tileY * S.LEVEL_WIDTH] != C.T_PIT){
                TStateGame.effectsUnder.nullify(this);
                return;
            }
            
            tileY++;
            
            draw(room.tilesOpaque[tileX + tileY * S.LEVEL_WIDTH] != C.T_PIT);
            
        }
        
        private function draw(cutAway:Boolean = false):void{
            if (cutAway){
                var height:uint = (y / S.LEVEL_TILE_HEIGHT + 1 | 0) * S.LEVEL_TILE_HEIGHT - y;
                
                room.layerActive.drawComplexDirect(room.renderer.bdTiles, 
                    x, y, (DURATION - fall) / DURATION, 176, 242, S.LEVEL_TILE_WIDTH, height); 
                
            } else 
                room.layerActive.drawComplexDirect(room.renderer.bdTiles, 
                    x, y, (DURATION - fall) / DURATION, 176, 242, S.LEVEL_TILE_WIDTH, S.LEVEL_TILE_HEIGHT); 
        }
    }
}