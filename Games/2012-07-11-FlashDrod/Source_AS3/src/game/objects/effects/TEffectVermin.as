package game.objects.effects{
    import game.global.Gfx;
    import game.global.Room;
    import game.managers.VOCoord;
    import game.managers.effects.VOParticle;
    import game.managers.effects.VOVermin;
    import game.states.TStateGame;
    
    import net.retrocade.camel.core.rGfx;
    import net.retrocade.utils.Rand;
    
    public class TEffectVermin extends TEffect{
        private static const MARKOV:Array = [
                [
                    [55, 25,  5, 10,  5],
                    [15, 55,  5, 15, 10],
                    [ 0, 30, 40, 30,  0],
                    [10, 15,  5, 55, 15],
                    [ 5, 10,  5, 25, 55]
                ],
                [
                    [30, 40,  5, 15, 10],
                    [15, 45,  5, 25, 10],
                    [ 0, 30, 40, 30,  0],
                    [10, 25,  5, 45, 15],
                    [10, 15,  5, 40, 30]
                ]
            ];
        
        
        private static var _frames:Array = [
                rGfx.getBDExt(Gfx.CLASS_EFFECTS, 88,  44, 3, 3),
                rGfx.getBDExt(Gfx.CLASS_EFFECTS, 110, 44, 2, 2)
            ];
        
        private var isSlayer:Boolean;
        private var vermins:Array;
        
        public function TEffectVermin(origin:VOCoord, particles:uint = 5, isFromSlayer:Boolean = false){
            isSlayer = isFromSlayer;
            
            vermins = [];
            
            var x:uint = origin.x * S.LEVEL_TILE_WIDTH  + S.LEVEL_TILE_WIDTH_HALF;
            var y:uint = origin.y * S.LEVEL_TILE_HEIGHT + S.LEVEL_TILE_HEIGHT_HALF;
            
            while (particles--){
                var vermin:VOVermin = new VOVermin();
                
                vermin.x = x;
                vermin.y = y;
                vermin.angle = Rand.om * Math.PI * 2;
                vermin.acceleration = Rand.om * VOVermin.ACC_COUNT | 0;
                vermin.type = Rand.om * 2 | 0;
                vermin.size = vermin.type == 0 ? 3 : 2;
                
                vermins.push(vermin);
            }
            
            TStateGame.effectsUnder.add(this);
        }
        
        override public function update():void{
            var anyAlive:Boolean = false;
            
            for each(var v:VOVermin in vermins){
                if (!v.active)
                    continue;
                
                v.x += Math.cos(v.angle);
                v.y += Math.sin(v.angle);
                
                if (hitsObstacle(v)){
                    v.active = false;
                    continue;
                }
                
                updateDirection(v);
                
                room.layerActive.blitDirectly(_frames[v.type], v.x, v.y);
                
                anyAlive = true;
            }
            
            if (!anyAlive)
                TStateGame.effectsUnder.nullify(this);
        }
        
        private function hitsObstacle(v:VOVermin):Boolean{
            var index:uint = (v.x / S.LEVEL_TILE_WIDTH | 0) + (v.y / S.LEVEL_TILE_HEIGHT | 0) * S.LEVEL_WIDTH;
            
            switch(room.tilesOpaque[index]){
                case C.T_FLOOR: case C.T_FLOOR_MOSAIC: case C.T_FLOOR_ROAD: case C.T_FLOOR_GRASS:
                case C.T_FLOOR_DIRT: case C.T_FLOOR_ALT: case C.T_FLOOR_IMAGE:
                case C.T_DOOR_YO: case C.T_DOOR_GO: case C.T_DOOR_CO:	case C.T_DOOR_RO: case C.T_DOOR_BO:
                case C.T_TRAPDOOR: case C.T_TRAPDOOR_WATER:
                case C.T_BRIDGE: case C.T_BRIDGE_H: case C.T_BRIDGE_V:
                case C.T_GOO:
                case C.T_PRESSPLATE: case C.T_PLATFORM_P: case C.T_PLATFORM_W:
                    break;  //vermin can move on these things
                
                case C.T_HOT: //slayer particles may move on hot tiles and closed doors
                case C.T_DOOR_Y: case C.T_DOOR_G: case C.T_DOOR_C: case C.T_DOOR_R: case C.T_DOOR_B:
                    if (isSlayer)
                        return true;
                    break;
                default:
                    return true;
            }
            
            switch (room.tilesTransparent[index]){
                case C.T_OBSTACLE:
                case C.T_TAR:	case C.T_MUD: case C.T_GEL:
                    return true;
                    
                default:
                    return false;
            }
        }
        
        private function updateDirection(v:VOVermin):void{
            switch(v.acceleration){
                case VOVermin.ACC_HARD_LEFT:  v.angle -= 0.2; break;
                case VOVermin.ACC_LEFT:       v.angle -= 0.1; break;
                case VOVermin.ACC_RIGHT:      v.angle += 0.1; break;
                case VOVermin.ACC_HARD_RIGHT: v.angle += 0.2; break;
            }
            
            var rand     :uint = Rand.om * 100 | 0;
            var probSum  :uint = MARKOV[0][v.acceleration][0];
            var probIndex:uint = 0;
            
            while (probSum < rand)
                probSum += MARKOV[0][v.acceleration][++probIndex];
            
            ASSERT(probIndex < VOVermin.ACC_COUNT);
            
            v.acceleration = probIndex;
        }
    }
}