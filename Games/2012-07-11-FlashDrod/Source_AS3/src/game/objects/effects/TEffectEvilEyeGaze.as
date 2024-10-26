package game.objects.effects{
    import game.global.Gfx;
    import game.global.Room;
    import game.managers.VOCoord;
    import game.states.TStateGame;
    
    import net.retrocade.camel.core.rGfx;

    public class TEffectEvilEyeGaze extends TEffect{
        private static var _frames:Array = [
                rGfx.getBDExt(Gfx.CLASS_EFFECTS, 44, 22, 22, 22),
                rGfx.getBDExt(Gfx.CLASS_EFFECTS, 66, 22, 22, 22),
                rGfx.getBDExt(Gfx.CLASS_EFFECTS, 88, 22, 22, 22),
                rGfx.getBDExt(Gfx.CLASS_EFFECTS, 110, 22, 22, 22)
            ];
        
        private static const DURATION:uint = 30;
        
        private var gazes:Array;
        private var type :uint;
        
        private var duration:uint;
        
        public function TEffectEvilEyeGaze(origin:VOCoord){
            gazes = [];
            
            switch(origin.o){
                case(C.E):  case(C.W):  type = 0; break;
                case(C.NW): case(C.SE): type = 1; break;
                case(C.N):  case(C.S):  type = 2; break;
                case(C.NE): case(C.SW): type = 3; break;
            }
            
            populateGazes(origin);
            
            TStateGame.effectsAbove.add(this);
        }
        
        override public function update():void{
            if (duration++ == DURATION){
                TStateGame.effectsAbove.nullify(this);
                return;
            }
            
            for each(var i:uint in gazes){
                room.layerActive.draw(_frames[type], i % S.LEVEL_WIDTH, i / S.LEVEL_WIDTH | 0, (DURATION - duration) / DURATION);
            }
        }
        
        private function populateGazes(origin:VOCoord):void{
            var ox:int = F.getOX(origin.o);
            var oy:int = F.getOY(origin.o);
            var tx:uint = origin.x;
            var ty:uint = origin.y;
            
            var index:uint;
            
            var reflected:Boolean = false;
            
            while (getNextGaze()){
                index = tx + ty * S.LEVEL_WIDTH;
                
                gazes.push(tx + ty * S.LEVEL_WIDTH);
            }
            
            return;
            
            function getNextGaze():Boolean{
                tx += ox;
                ty += oy;
                
                if (!F.isValidColRow(tx, ty))
                    return false;
                
                var arrayIndex:uint = tx + ty * S.LEVEL_WIDTH;
                
                switch (room.tilesOpaque[arrayIndex])
                {
                    case C.T_BRIDGE: case C.T_BRIDGE_H: case C.T_BRIDGE_V:
                    case C.T_FLOOR: case C.T_FLOOR_MOSAIC:	case C.T_FLOOR_ROAD: case C.T_FLOOR_GRASS:
                    case C.T_FLOOR_DIRT: case C.T_FLOOR_ALT: case C.T_FLOOR_IMAGE:
                    case C.T_TUNNEL_E: case C.T_TUNNEL_W: case C.T_TUNNEL_N: case C.T_TUNNEL_S:
                    case C.T_PIT:	case C.T_PIT_IMAGE: case C.T_WATER:
                    case C.T_HOT: case C.T_GOO:
                    case C.T_DOOR_YO: case C.T_DOOR_GO: case C.T_DOOR_CO: case C.T_DOOR_RO: case C.T_DOOR_BO:
                    case C.T_PLATFORM_P: case C.T_PLATFORM_W:
                    case C.T_TRAPDOOR: case C.T_TRAPDOOR_WATER: case C.T_PRESSPLATE:
                        break;  //these do not block gaze -- examine next layer
                    default:
                        return false;
                }
                
                //Nothing on f-layer blocks gaze.
                
                switch (room.tilesTransparent[arrayIndex])
                {
                    case C.T_ORB: case C.T_OBSTACLE:
                        return false;  //these block gaze
                    case C.T_MIRROR:
                        //Look in opposite direction.
                        if (reflected)
                            return false; //closed loop
                        ox = -ox;
                        oy = -oy;
                        
                        tx = origin.x;
                        ty = origin.y;
                        
                        reflected = true; //only reflect one time
                        return true;
                    default: break;
                }
                
                return true;
            }
        }
    }
}