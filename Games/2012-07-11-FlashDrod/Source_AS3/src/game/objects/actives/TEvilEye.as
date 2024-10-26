package game.objects.actives
{
    import flash.display.BitmapData;

    import game.global.CueEvents;
    import game.global.Game;
    import game.global.Gfx;
    import game.global.Room;
    import game.managers.VOCoord;

    import net.retrocade.camel.core.rGfx;

    public class TEvilEye extends TMonster{
        override public function getType():uint { return C.M_EYE; }
        override public function isAggresive():Boolean { return isAwake; }

        public var isAwake:Boolean = false;

        override public function process(lastCommand:uint):void{
            if (!(isAwake || wakeupCheck()))
                return;

            if (Game.doesBrainSensePlayer && getBrainMovement(room.pathmapGround)) {

            } else if (!Game.isInvisible || F.distanceInTiles(x, y, Game.player.x, Game.player.y) <= C.DEFAULT_SMELL_RANGE || Game.doesBrainSensePlayer) {
                getBeelineMovement(Game.player.x, Game.player.y);

            } else
                return;

            makeStandardMove();
            setOrientation(dxFirst, dyFirst);
        }

        /** Returns true if the eye wakes up during call **/
        public function wakeupCheck():Boolean{
            var playerX:uint = Game.player.x;
            var playerY:uint = Game.player.y;

            if ((Game.isInvisible && F.distanceInTiles(x, y, playerX, playerY) > 5) ||
                !((o == C.N  && playerY <  y && playerX == x) ||
                (o == C.E   && playerY == y && playerX >  x) ||
                (o == C.W   && playerY == y && playerX <  x) ||
                (o == C.S   && playerY >  y && playerX == x) ||
                (o == C.NE  && playerX-x + playerY-y == 0)   ||
                (o == C.SE  && playerX-x + playerY-y > 0)    ||
                (o == C.NW  && playerX-x + playerY-y < 0)   ||
                (o == C.SW  && playerX-x + playerY-y == 0))){
                return false;
            }
            var ox:int = F.getOX(o);
            var oy:int = F.getOY(o);
            var tx:uint = x;
            var ty:uint = y;

            var reflected:Boolean = false;

            var isPlayer:Boolean = false;
            var isTarget:Boolean = false;

            var continueGaze:Boolean = false;

            do{
                continueGaze = getNextGaze();
                isPlayer = tx == playerX && ty == playerY;
                if (isPlayer)
                    isTarget = true;

                if (isTarget){
                    isAwake = true;
                    CueEvents.add(C.CID_EVIL_EYE_WOKE, new VOCoord(x, y, o));
                    return true;
                }

            } while (continueGaze);

            return false;

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

                        tx = x;
                        ty = y;

                        reflected = true; //only reflect one time
                        return true;
                    default: break;
                }

                return true;
            }
        }

        override public function setGfx():void{
            gfx = T.EEYE[isAwake ? 2 : animationFrame][o];
        }

        override public function getSnapshot():Object {
            var object:Object = super.getSnapshot();

            object.isAwake = isAwake;

            return object;
        }
    }
}
