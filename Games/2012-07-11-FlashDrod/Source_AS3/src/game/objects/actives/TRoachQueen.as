package game.objects.actives {
    import game.global.Game;
    import game.global.Pathmap;
    import game.global.PathmapTile;
    import game.global.Room;
    import game.objects.TGameObject;

    import net.retrocade.camel.core.rGfx;
	
	/**
     * ...
     * @author
     */
    public class TRoachQueen extends TMonster {
        override public function getType():uint{ return C.M_QROACH; }
        override public function isAggresive():Boolean { return false; }

        override public function process(lastCommand:uint):void {
            if (Game.doesBrainSensePlayer)
                getBrainMovement(room.pathmapGround);

            else if (!Game.isInvisible || F.distanceInTiles(x, y, Game.player.x, Game.player.y) <= C.DEFAULT_SMELL_RANGE) {
                var targetX:uint = Game.player.x;
                var targetY:uint = Game.player.y;

                dx = dxFirst = targetX > x ? -1 : targetX < x ? 1 : 0;
                dy = dyFirst = targetY > y ? -1 : targetY < y ? 1 : 0;

                setOrientation(dx, dy);

                getBestMove();
            } else
                return;

            makeStandardMove();

            if (Game.spawnCycleCount % 30 == 0 &&
               (Game.doesBrainSensePlayer || !Game.isInvisible || F.distanceInTiles(x, y, Game.player.x, Game.player.y) <= C.DEFAULT_SMELL_RANGE)) {
                for (var j:int = -1; j <= 1; j++) {
                    for (var i:int = -1; i <= 1; i++ ) {
                        if (F.isValidColRow(x + i, y + j)) {
                            var ex:uint = x + i;
                            var ey:uint = y + j;
                            if (room.tilesActive) {
                                var tileIndex:uint = ex + ey * S.LEVEL_WIDTH;

                                var oSquare:uint = room.tilesOpaque     [tileIndex];
                                var tSquare:uint = room.tilesTransparent[tileIndex];
                                var monster:TMonster = room.tilesActive [tileIndex];
                                if (
                                        !(ex == x && ey == y) &&
                                        !(ex == prevX && ey == prevY) &&
                                        !monster && !doesSquareContainObstacle(ex, ey) &&
                                        (tSquare == C.T_EMPTY) &&
                                        !F.isArrow(room.tilesFloor[tileIndex]) &&
                                        (Game.player.x != ex ||Game.player.y != ey) &&
                                        (F.isPlainFloor(oSquare) ||
                                            (F.isOpenDoor(oSquare) && oSquare != C.T_DOOR_YO))){
                                    var egg:TMonster = room.addNewMonster(C.M_REGG, ex, ey, 0);
                                }
                            }
                        }
                    }
                }

            }
        }

        override public function setGfx():void{
            gfx = T.RQUEEN[animationFrame][o];
        }

        override public function getBrainMovement(pathmap:Pathmap):Boolean {
            var paths:Array;
            var brained:Boolean = false;
            switch(room.tilesTransparent[x + y * S.LEVEL_WIDTH]) {
                case(C.T_POTION_I):
                case(C.T_POTION_M):
                case(C.T_SCROLL):
                    break;

                default:
                    if (F.isArrow(room.tilesTransparent[x + y * S.LEVEL_WIDTH]))
                        break;

                    brained = setBrainTileFirst(room.pathmapGround);
                    break;
            }

            if (!brained) {
                var targetX:uint = Game.player.x;
                var targetY:uint = Game.player.y;

                dx = dxFirst = targetX > x ? -1 : targetX < x ? 1 : 0;
                dy = dyFirst = targetY > y ? -1 : targetY < y ? 1 : 0;

            } else {
                if (dx == 0)
                    dxFirst = dx = (x < (S.SIZE_GAME_WIDTH / 2)) ? 1 : -1;
                else if (dy == 0)
                    dyFirst = dy = (y < (S.SIZE_GAME_HEIGHT / 2)) ? 1 : -1;
            }

            setOrientation(dx, dy);
            getBestMove();

            return false;
        }

        public function setBrainTileFirst(pathmap:Pathmap):Boolean{
            pathmap.calculate();

            var tile     :PathmapTile;
            var tileCheck:PathmapTile;
            var wx :uint, wy :uint;
            var tdx:int,  tdy:int;

            dx = 0;
            dy = 0;

            for(var i:uint = 0; i < 9; i++){
                wx = x + (tdx = dxDirBrain[i]);
                wy = y + (tdy = dyDirBrain[i]);

                if (wx >= S.LEVEL_WIDTH || wy >= S.LEVEL_HEIGHT) continue;

                tileCheck = pathmap.tiles[wx + wy * S.LEVEL_WIDTH];

                if (!tileCheck.isObstacle && (!tile || tileCheck.targetDistance < tile.targetDistance)){
                    dxFirst = dx = -tdx;
                    dyFirst = dy = -tdy;

                    tile = tileCheck;
                }
            }

            if (tile && tile.targetDistance < uint.MAX_VALUE && (dx || dy)){
                return true;
            }

            return false;
        }
    }
}