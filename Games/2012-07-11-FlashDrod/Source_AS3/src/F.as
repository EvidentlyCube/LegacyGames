package{
    import game.global.DrodLayer;
    import game.global.Game;
    import game.global.Room;

    public class F{
		/** Checks if given command is a movement command **/
        public static function isMovementCommand(command:uint):Boolean{
            switch(command){
                case C.CMD_N: case C.CMD_NE: case C.CMD_W: case C.CMD_E:
                case C.CMD_SW: case C.CMD_S: case C.CMD_SE: case C.CMD_NW:
                    return true;
                default:
                    return false;
            }
        }

		/** Next clockwise orientation **/
        public static function nextCO(o:uint):uint{
            switch (o){
                case C.NW: case C.N:  return o+1;
                case C.NE: case C.E:  return o+3;
                case C.S:  case C.SE: return o-1;
                case C.W:  case C.SW: return o-3;
                default: return C.NO_ORIENTATION;
            }
        }

		/** Next counter clockwise orientation **/
        public static function nextCCO(o:uint):uint{
            switch (o){
                case C.NW: case C.W:  return o+3;
                case C.E:  case C.SE: return o-3;
                case C.SW: case C.S:  return o+1;
                case C.N:  case C.NE: return o-1;
                default: return C.NO_ORIENTATION;
            }
        }

		/** Orientation from x and y **/
        public static function getO(ox:int, oy:int):uint{
            return ((oy + 1) * 3) + (ox + 1);
        }

		/** X from orientation **/
        public static function getOX(o:int):int{
            return (o % 3) - 1;
        }

		/** Y from orientation **/
        public static function getOY(o:int):int{
            return ((o / 3) | 0) - 1;
        }

        public static function invertDir(o:uint):uint{
            return 8 - o;
        }

        public static function reverseCommand(command:uint):uint {
            switch(command) {
                case(C.CMD_C):  return C.CMD_CC;
                case(C.CMD_CC): return C.CMD_C;
                case(C.CMD_NW): return C.CMD_SW;
                case(C.CMD_N):  return C.CMD_S;
                case(C.CMD_NE): return C.CMD_SE;
                case(C.CMD_W):  return C.CMD_E;
                case(C.CMD_E):  return C.CMD_W;
                case(C.CMD_SW): return C.CMD_NE;
                case(C.CMD_S):  return C.CMD_N;
                case(C.CMD_SE): return C.CMD_NW;
                default: return C.CMD_UNSPECIFIED;
            }
        }

        public static function distanceInTiles(x1:uint, y1:uint, x2:uint, y2:uint):uint{
            if (x1 > x2){
                if (y1 > y2)
                    return x1 - x2 > y1 - y2 ? x1 - x2 : y1 - y2;
                else
                    return x1 - x2 > y2 - y1 ? x1 - x2 : y2 - y1;
            } else
                if (y1 > y2)
                    return x2 - x1 > y1 - y2 ? x2 - x1 : y1 - y2;
                else
                    return x2 - x1 > y2 - y1 ? x2 - x1 : y2 - y1;
        }

        public static function distanceInPixels(x1:uint, y1:uint, x2:uint, y2:uint):Number {
            x1 -= x2;
            y1 -= y2;

            var index:uint = x1 * x1 + y1 * y1;

            if (!_calculatedDistances[index])
                _calculatedDistances[index] = Math.sqrt(index);

            return _calculatedDistances[index];

        }

        public static function orthogonalizeDirection(o:uint, vertical:Boolean):uint{
            if (vertical){
                switch(o){
                    case (0): case (2): return 1;
                    case (6): case (8): return 7;
                }

            } else {
                switch(o){
                    case (0): case (6): return 3;
                    case (2): case (8): return 5;
                }
            }

            return o;
        }

        public static function isArrowObstacle(arrowTile:uint, direction:uint):Boolean {
            switch(arrowTile) {
                case(C.T_ARROW_N):
                    return direction == C.S || direction == C.SW || direction == C.SE;
                case(C.T_ARROW_S):
                    return direction == C.N || direction == C.NW || direction == C.NE;
                case(C.T_ARROW_E):
                    return direction == C.W || direction == C.NW || direction == C.SW;
                case(C.T_ARROW_W):
                    return direction == C.E || direction == C.SE || direction == C.NE;
                case(C.T_ARROW_NE):
                    return direction == C.S || direction == C.SW || direction == C.W;
                case(C.T_ARROW_NW):
                    return direction == C.S || direction == C.E  || direction == C.SE;
                case(C.T_ARROW_SE):
                    return direction == C.N || direction == C.W  || direction == C.NW;
                case(C.T_ARROW_SW):
                    return direction == C.N || direction == C.E  || direction == C.NE;
                default:
                    return false;

            }
        }

        public static function isValidColRow(x:uint, y:uint):Boolean {
            return x < S.LEVEL_WIDTH && y < S.LEVEL_HEIGHT;
        }

        public static function isValidOrientation(o:uint):Boolean{
            return o < C.ORIENTATION_COUNT;
        }

        public static function isValidMonsterType(type:uint):Boolean{ return type < C.MONSTER_TYPES; }

        public static function tilesArrayFromLayerID(layer:uint, room:Room):Array{
            switch(layer){
                case(0): return room.tilesOpaque;
                case(1): return room.tilesTransparent;
                case(2): return room.tilesActive;
                case(3): return room.tilesFloor;
                default: throw new Error("Trying to access invalid layer ID (" + layer + ").");
            }
        }
        CF::play
        public static function layerFromLayerID(layer:uint, room:Room):DrodLayer{
            switch(layer){
                case(0): case(1): case(3): return room.layerUnder;
                case(2): return room.layerActive;
                default: throw new Error("Trying to access invalid layer ID (" + layer + ").");
            }
        }

        public static function tileToX(tile:uint):uint{
            return (tile % 18) * S.LEVEL_TILE_WIDTH;
        }

        public static function tileToY(tile:uint):uint{
            return (tile / 18 | 0) * S.LEVEL_TILE_HEIGHT;
        }



        public static function isArrow(t:uint):Boolean { return t >= C.T_ARROW_N && t <= C.T_ARROW_NW; }
        public static function isBeethroDouble(t:uint):Boolean { return t == C.M_MIMIC || t == C.M_BEETHRO; }
        public static function isBlackDoor(t:uint):Boolean { return t == C.T_DOOR_B || t == C.T_DOOR_BO; }
        public static function isBlueDoor(t:uint):Boolean { return t == C.T_DOOR_C || t == C.T_DOOR_CO; }
        public static function isBriar(t:uint):Boolean { return t >= C.T_FLOW_SOURCE && t <= C.T_FLOW_EDGE; }
        public static function isBridge(t:uint):Boolean { return t == C.T_BRIDGE || t == C.T_BRIDGE_H || t == C.T_BRIDGE_V; }
        public static function isComplexCommand(command:uint):Boolean{ return command == C.CMD_CLONE || command == C.CMD_DOUBLE || command == C.CMD_ANSWER; }
        public static function isCrumblyWall(t:uint):Boolean { return t == C.T_WALL_BROKEN || t == C.T_WALL_HIDDEN; }
        public static function isCustomImageTile(t:uint):Boolean { return t == C.T_FLOOR_IMAGE || t == C.T_PIT_IMAGE || t == C.T_WALL_IMAGE; }
        public static function isDoor(t:uint):Boolean { return (t >= C.T_DOOR_C && t <= C.T_DOOR_Y) || t == C.T_DOOR_B; }
        public static function isFloor(t:uint):Boolean { return isPlainFloor(t) || isTrapdoor(t) || isBridge(t) || t == C.T_HOT || t == C.T_GOO || t == C.T_PRESSPLATE; }
        public static function isGreenDoor(t:uint):Boolean { return t == C.T_DOOR_G || t == C.T_DOOR_GO; }
        public static function isLight(t:uint):Boolean { return t == C.T_LIGHT; }
        public static function isMother(t:uint):Boolean { return t == C.M_TARMOTHER || t == C.M_MUDMOTHER || t == C.M_GELMOTHER; }
        public static function isOpenDoor(t:uint):Boolean { return t == C.T_DOOR_YO || (t >= C.T_DOOR_GO && t <= C.T_DOOR_BO); }
        public static function isPit(t:uint):Boolean { return t == C.T_PIT || t == C.T_PIT_IMAGE; }
        public static function isPlainFloor(t:uint):Boolean { return t == C.T_FLOOR || (t >= C.T_FLOOR_MOSAIC && t <= C.T_FLOOR_ALT) || t == C.T_FLOOR_IMAGE; }
        public static function isPlatform(t:uint):Boolean { return t == C.T_PLATFORM_P || t == C.T_PLATFORM_W; }
        public static function isPotion(t:uint):Boolean { return t == C.T_POTION_I || t == C.T_POTION_M || t == C.T_POTION_C || t == C.T_POTION_D || t == C.T_POTION_SP; }
        public static function isRedDoor(t:uint):Boolean { return t == C.T_DOOR_R || t == C.T_DOOR_RO; }
        public static function isSerpentTile(t:uint):Boolean { return t >= C.T_SNK_EW && t <= C.T_SNKT_E; }
        public static function isStairs(t:uint):Boolean { return t == C.T_STAIRS || t == C.T_STAIRS_UP; }
        public static function isTar(t:uint):Boolean { return t == C.T_TAR || t == C.T_MUD || t == C.T_GEL; }
        public static function isTrapdoor(t:uint):Boolean { return t == C.T_TRAPDOOR || t == C.T_TRAPDOOR_WATER; }
        public static function isTunnel(t:uint):Boolean { return t == C.T_TUNNEL_E || t == C.T_TUNNEL_N || t == C.T_TUNNEL_S || C.T_TUNNEL_W; }
        public static function isWall(t:uint):Boolean { return t == C.T_WALL || t == C.T_WALL_MASTER || t == C.T_WALL2 || t == C.T_WALL_IMAGE; }
        public static function isWater(t:uint):Boolean { return t == C.T_WATER; }
        public static function isYellowDoor(t:uint):Boolean { return t == C.T_DOOR_Y || t == C.T_DOOR_YO; }

        public static function getSpeakerType(t:uint):uint {
            switch (t){
                case (C.M_BEETHRO): return C.SPEAK_Beethro;
                case (C.M_BEETHRO_IN_DISGUISE): return C.SPEAK_BeethroInDisguise;
                case (C.M_NEGOTIATOR): return C.SPEAK_Negotiator;
                case (C.M_NEATHER):
                case (C.M_CITIZEN1): return C.SPEAK_Citizen1;
                case (C.M_CITIZEN2): return C.SPEAK_Citizen2;
                case (C.M_CITIZEN3): return C.SPEAK_Citizen3;
                case (C.M_CITIZEN4): return C.SPEAK_Citizen4;
                case (C.M_GOBLINKING): return C.SPEAK_GoblinKing;
                case (C.M_INSTRUCTOR): return C.SPEAK_Instructor;
                case (C.M_MUDCOORDINATOR): return C.SPEAK_MudCoordinator;
                case (C.M_TARTECHNICIAN): return C.SPEAK_TarTechnician;
                case (C.M_EYE_ACTIVE): return C.SPEAK_EyeActive;

                //Monster types.
                case (C.M_ROACH):           return C.SPEAK_Roach;
                case (C.M_QROACH):          return C.SPEAK_QRoach;
                case (C.M_REGG):            return C.SPEAK_RoachEgg;
                case (C.M_GOBLIN):          return C.SPEAK_Goblin;
                case (C.M_WWING):           return C.SPEAK_WWing;
                case (C.M_EYE):             return C.SPEAK_Eye;
                case (C.M_SERPENT):         return C.SPEAK_Serpent;
                case (C.M_TARMOTHER):       return C.SPEAK_TarMother;
                case (C.M_TARBABY):         return C.SPEAK_TarBaby;
                case (C.M_BRAIN):           return C.SPEAK_Brain;
                case (C.M_MIMIC):           return C.SPEAK_Mimic;
                case (C.M_SPIDER):          return C.SPEAK_Spider;
                case (C.M_SERPENTG):        return C.SPEAK_SerpentG;
                case (C.M_SERPENTB):        return C.SPEAK_SerpentB;
                case (C.M_ROCKGOLEM):       return C.SPEAK_RockGolem;
                case (C.M_WATERSKIPPER):    return C.SPEAK_WaterSkipper;
                case (C.M_SKIPPERNEST):     return C.SPEAK_WaterSkipperNest;
                case (C.M_AUMTLICH):        return C.SPEAK_Aumtlich;
                case (C.M_CLONE):           return C.SPEAK_Clone;
                case (C.M_DECOY):           return C.SPEAK_Decoy;
                case (C.M_WUBBA):           return C.SPEAK_Wubba;
                case (C.M_SEEP):            return C.SPEAK_Seep;
                case (C.M_STALWART):        return C.SPEAK_Stalwart;
                case (C.M_HALPH):           return C.SPEAK_Halph;
                case (C.M_HALPH2):          return C.SPEAK_Halph2;
                case (C.M_SLAYER):          return C.SPEAK_Slayer;
                case (C.M_SLAYER2):         return C.SPEAK_Slayer2;
                case (C.M_FEGUNDO):         return C.SPEAK_Fegundo;
                case (C.M_FEGUNDOASHES):    return C.SPEAK_FegundoAshes;
                case (C.M_GUARD):           return C.SPEAK_Guard;
                case (C.M_MUDMOTHER):       return C.SPEAK_MudMother;
                case (C.M_MUDBABY):         return C.SPEAK_MudBaby;
                case (C.M_GELMOTHER):       return C.SPEAK_GelMother;
                case (C.M_GELBABY):         return C.SPEAK_GelBaby;
                case (C.M_CITIZEN):         return C.SPEAK_Citizen;
                case (C.M_ROCKGIANT):       return C.SPEAK_RockGiant;

                default:                    return C.SPEAK_None;
            }
        }

        /******************************************************************************************************/
        /**                                                                                         INTERNAL  */
        /******************************************************************************************************/

        { init(); }

        private static var _calculatedDistances:Array = [];

        private static function init():void {
            var index:uint;

            for (var i:uint = 0; i < S.LEVEL_WIDTH; i++) {
                for (var j:uint = 0; j < S.LEVEL_HEIGHT; j++ ) {
                    index = i * i + j * j;
                    if (!_calculatedDistances[index])
                        _calculatedDistances[index] = Math.sqrt(index);
                }
            }
        }


    }
}