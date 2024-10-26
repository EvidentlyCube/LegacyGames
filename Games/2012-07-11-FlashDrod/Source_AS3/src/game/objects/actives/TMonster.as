package game.objects.actives {
    import flash.display.BitmapData;

    import game.global.CueEvents;
    import game.global.Game;
    import game.global.Level;
    import game.global.PackedVars;
    import game.global.Pathmap;
    import game.global.PathmapTile;
    import game.global.Room;
    import game.objects.TActiveObject;

    import net.retrocade.utils.Rand;

    /**
     * ...
     * @author
     */
    public class TMonster extends TActiveObject {
        public static const dxDirBrain:Array = [0,  -1,  1, 0, 0, -1,  1, -1, 1];
        public static const dyDirBrain:Array = [-1,  0,  0, 1, 0, -1, -1,  1, 1];

        public static const dxDirStandard:Array = [-1,  0,   1, -1, 0, 1, -1, 0, 1];
        public static const dyDirStandard:Array = [-1, -1,  -1,  0, 0, 0,  1, 1, 1];

        public var dx:int;
        public var dy:int;

        public var dxFirst:int;
        public var dyFirst:int;

        public var isAlive:Boolean = true;

        public var pieces:Array;

        public var killDirection:uint;

        // Frame of the animation
        public var animationFrame:uint = 0;

        public function isFlying():Boolean { return false; }
        public function isPiece() :Boolean { return false; }

        public function getType():uint { return 0; }
        public function getIdentity():uint { return getType(); }
        public function isAggresive():Boolean { return true; }
        public function isVisible  ():Boolean { return true; }

        public function getMovementType():uint{ return C.MOVEMENT_GROUND; }

        public function getProcessSequence():uint{ return 1000; }

        public function initialize(pieces:XML = null):void{}

        public function TMonster(){
            animationFrame = Rand.om < 0.5 ? 1 : 0;
        }

        /**
         * Processes the monster movements
         */
        override public function process(lastCommand:uint):void { }

        public function setGfx():void{}

        public function setOrientation(dx:int, dy:int):void{
            prevO = o;
            var newO:uint = F.getO(dx, dy);

            if (newO != C.NO_ORIENTATION)
                o = newO;

            setGfx();
        }

        public function makeStandardMove():void{
            if ((!dx && !dy) || !F.isValidColRow(x + dx, y + dy))
                return;

            move(x + dx, y + dy);

            if (x == Game.player.x && y == Game.player.y)
                CueEvents.add(C.CID_MONSTER_KILLED_PLAYER, this);
        }

        public function move(newX:uint, newY:uint):void{
            prevX = x;
            prevY = y;

            x = newX;
            y = newY;

            room.tilesActive[prevX + prevY * S.LEVEL_WIDTH] = null;
            room.tilesActive[newX + newY * S.LEVEL_WIDTH] = this;
        }

        public function getBeelineMovement(targetX:uint, targetY:uint):void {
            dx = dxFirst = targetX > x ? 1 : targetX < x ? -1 : 0;
            dy = dyFirst = targetY > y ? 1 : targetY < y ? -1 : 0;

            getBestMove();
        }

        public function getBeelineMovementSmart(targetX:uint, targetY:uint, smartAxial:Boolean, smartFlanking:Boolean = false):void {
            dx = dxFirst = targetX > x ? 1 : targetX < x ? -1 : 0;
            dy = dyFirst = targetY > y ? 1 : targetY < y ? -1 : 0;

            if (x + dx >= S.LEVEL_WIDTH)
                dx = 0;
            if (y + dy >= S.LEVEL_HEIGHT)
                dy = 0;

            if (!dx && !dy)
                return;

            var diagonal       :Boolean = Boolean(dx && dy);
            var triedHorizontal:Boolean = false;

            if (diagonal){
                if (isOpenMove(dx, dy))
                    return;

                // Can't move diagonally. Check if Horizontal or Vertical movement
                // will bring the monster closer to the targer
                // Try it first and use if works
                if (F.distanceInTiles(x + dx, y,      targetX, targetY) <
                        F.distanceInTiles(x,      y + dy, targetX, targetY)){
                    // Horizontal is closer than vertical, try it:
                    if (isOpenMove(dx, 0)){
                        dy = 0;
                        return;
                    }

                    // Did not work, so let's not repeat it later
                    triedHorizontal = true;
                }
            }

            if (dy && isOpenMove(0, dy)){
                dx = 0;
                return;
            }

            if (dx && !triedHorizontal && isOpenMove(dx, 0)){
                dy = 0;
                return;
            }

            if (!diagonal && smartAxial){
                //If moving in the desired axial direction doesn't work, then try
                //the analog of the "best possible movement" for diagonal beelining, i.e.
                //Try taking a diagonal step toward the target instead of a straight step
                //(analogous to trying a straight step when a diagonal is desired).

                //If the target is one tile away and the monster can't move to the
                //target square, then this may cause oscillation.  However, it may also
                //allow the monster to reach the player from another side (e.g.
                //when a force arrow doesn't allow access from one side, but does from another),
                //so allow this movement to be considered if requested.

                if (F.distanceInTiles(x, y, targetX, targetY) > 1 || smartFlanking){
                    if (dx){
                        ASSERT(!dy);

                        dy = -1;
                        if (isOpenMove(dx, dy))
                            return;

                        dy = 1;
                        if (isOpenMove(dx, dy))
                            return;
                    } else if (dy){
                        ASSERT(!dx);

                        dx = -1;
                        if (isOpenMove(dx, dy))
                            return;

                        dx = 1;
                        if (isOpenMove(dx, dy))
                            return;
                    }
                }
            }

            dx = dy = 0;
        }

        public function getBrainMovement(pathmap:Pathmap):Boolean {
            ASSERT(pathmap);

            pathmap.calculate();

            var tile     :PathmapTile;
            var tileCheck:PathmapTile;
            var wx :uint, wy :uint;
            var tdx:int,  tdy:int;
            var px:uint = Game.player.x;
            var py:uint = Game.player.y;

            dx = 0;
            dy = 0;

            for(var i:uint = 0; i < 9; i++){
                wx = x + (tdx = dxDirBrain[i]);
                wy = y + (tdy = dyDirBrain[i]);

                if (wx >= S.LEVEL_WIDTH || wy >= S.LEVEL_HEIGHT) continue;

                tileCheck = pathmap.tiles[wx + wy * S.LEVEL_WIDTH];

                if (wx == px && wy == py && isOpenMove(tdx, tdy)) {
                    tile = tileCheck;

                    dxFirst = dx = tdx;
                    dyFirst = dy = tdy;
                    break;
                }

                if (!tileCheck.isObstacle && (!tile || tileCheck.targetDistance < tile.targetDistance) && (!(tdx || tdy) || isOpenMove(tdx, tdy))){
                    dxFirst = dx = tdx;
                    dyFirst = dy = tdy;

                    tile = tileCheck;
                }
            }

            if (tile && tile.targetDistance < uint.MAX_VALUE && (dx || dy)){
                return true;
            }

            return false;
        }

        public function getAvoidSwordMovement(tx:uint, ty:uint):void{
            var sx:uint = Game.player.swordX, sy:uint = Game.player.swordY;

            var score:uint;
            var ndx:int;
            var ndy:int;
            var nx:uint;
            var ny:uint;
            var dist:Number;
            var bestScore:uint = 1;
            for (var i:uint = 0; i < 9; i++){
                nx = x + (ndx = dxDirStandard[i]);
                ny = y + (ndy = dyDirStandard[i]);

                if ((nx == x && ny == y) || isOpenMove(ndx, ndy)){
                    if (nx == tx && ny == ty)
                        score = 90000;
                    else if ((nx < sx ? sx - nx : nx - sx) <= 1 &&
                        (ny < sy ? sy - ny : ny - sy) <= 1)
                        score = 5000;
                    else{
                        dist = distanceToTarget(tx, ty, nx, ny);
                        score = (dist > 900 ? 0 : 90000 - 100 * dist);
                    }
                }

                if (score > bestScore){
                    bestScore = score;
                    dx = ndx;
                    dy = ndy;
                }
            }

            if (dx || dy){
                dxFirst = dx;
                dyFirst = dy;
            }
        }

        public function distanceToTarget(tx:uint, ty:uint, x:uint, y:uint, useBrain:Boolean = true):Number{
            if (useBrain && Game.doesBrainSensePlayer){
                var square:PathmapTile = room.pathmapGround.tiles[tx + ty * S.LEVEL_WIDTH];
                if (square.isObstacle != false && square.targetDistance > 2 && square.targetDistance != uint.MAX_VALUE){
                    var square2:PathmapTile = room.pathmapGround.tiles[x + y * S.LEVEL_WIDTH];

                    return square2.targetDistance + ((this.x - x) && (this.y - y) ? 0.5 : 0);
                }
            }

            return F.distanceInPixels(x, y, tx, ty);

            /*
            var xd:int = x - tx;
            var yd:int = y - ty;
            return Math.sqrt(xd * xd + yd * yd);
            */
        }

        public function getBestMove():void {
            if (x + dx < 0 || x + dx >= S.LEVEL_WIDTH)
                dx = 0;
            if (y + dy < 0 || y + dy >= S.LEVEL_HEIGHT)
                dy = 0;

            if (!dx && !dy)
                return;

            if (dx && dy && isOpenMove(dx, dy))
                return;

            if (dy && isOpenMove(0, dy)) {
                dx = 0;
                return;
            }

            if (dx && isOpenMove(dx, 0)) {
                dy = 0;
                return;
            }

            dx = dy = 0;
        }

        public function isOpenMove(dx:int, dy:int):Boolean{
            return !(doesSquareContainObstacle(x + dx, y + dy) ||
                doesArrowPreventMovement(dx, dy));
        }

        public function doesSquareContainObstacle(x:uint, y:uint):Boolean {
            const arrayIndex:uint = x  + y * S.LEVEL_WIDTH;

            var tile:uint = room.tilesTransparent[arrayIndex];
            if (isTileObstacle(tile))
                return true;

            tile = room.tilesFloor[arrayIndex];
            if (isTileObstacle(tile))
                return true;

            tile = room.tilesOpaque[x + y * S.LEVEL_WIDTH];
            if (isTileObstacle(tile))
                return true;

            return room.tilesActive[x + y * S.LEVEL_WIDTH] != null || room.tilesSwords[x + y * S.LEVEL_WIDTH] != 0;
        }

        public function doesArrowPreventMovement(dx:int, dy:int):Boolean {
            var dir :uint = F.getO(dx, dy);
            var tile:uint = room.tilesFloor[x + y * S.LEVEL_WIDTH];

            if (F.isArrow(tile) && F.isArrowObstacle(tile, dir))
                return true;

            tile = room.tilesFloor[x + dx + (y + dy) * S.LEVEL_WIDTH];

            return F.isArrow(tile) && F.isArrowObstacle(tile, dir);
        }

        public function isTileObstacle(tile:uint):Boolean {
            switch(getMovementType()){
                case(C.MOVEMENT_WALL):
                    return !(tile == C.T_EMPTY || F.isWall(tile) || F.isCrumblyWall(tile) || F.isDoor(tile) ||
                        tile == C.T_NODIAGONAL || tile == C.T_SCROLL || tile == C.T_FUSE || tile == C.T_TOKEN || F.isArrow(tile));

                case(C.MOVEMENT_WATER):
                    return !(tile == C.T_EMPTY || F.isWater(tile) || F.isArrow(tile) || tile == C.T_NODIAGONAL ||
                        tile == C.T_FUSE || tile == C.T_TOKEN);

                default:
                    return !(tile == C.T_EMPTY || F.isFloor(tile) || F.isOpenDoor(tile) || F.isArrow(tile) ||
                        F.isPlatform(tile) || tile == C.T_NODIAGONAL || tile == C.T_FUSE || tile == C.T_SCROLL || tile == C.T_TOKEN ||
                        (isFlying() && (F.isPit(tile) || F.isWater(tile))));
            }
        }

        public function onStabbed(sX:uint, sY:uint):Boolean{
            CueEvents.add(C.CID_MONSTER_DIED_FROM_STAB, this);
            return true;
        }

        public function killPieces():void{
            if (pieces){
                for each(var i:TMonsterPiece in pieces){
                    i.quickRemove();
                }
            }
        }

        public function setMembersFromExtraVars(extra:PackedVars):void { }

        public function getSnapshot():Object {
            var object:Object = new Object();

            object.x        = x;
            object.y        = y;
            object.o        = o;
            object.isAlive  = isAlive;
            object.animationFrame = animationFrame;

            if (pieces && pieces.length) {
                object.pieces = [];
                for each(var i:TMonsterPiece in pieces) {
                    if (i)
                        object.pieces.push(i.getSnapshot());
                }
            }

            return object;
        }
    }
}