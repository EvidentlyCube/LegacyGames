package game.objects.actives{
    import game.global.CueEvents;
    import game.global.Game;
    import game.global.Pathmap;
    import game.global.PathmapTile;
    import game.global.Room;
    import game.objects.TActiveObject;

    import net.retrocade.camel.core.rGfx;

    public class TSerpent extends TMonster{
        public static const dxDirBrain:Array = [0,  -1,  1, 0];
        public static const dyDirBrain:Array = [-1,  0,  0, 1];

        public static const dxDirNoMove:Array = [0,  1,  0, -1];
        public static const dyDirNoMove:Array = [-1, 0,  1,  0];

        public var tailX:uint;
        public var tailY:uint;
        public var tailO:uint;

        public var oldTailX:uint = uint.MAX_VALUE;
        public var oldTailY:uint = uint.MAX_VALUE;

        override public function initialize(xml:XML = null):void {
            importPieces(xml.Pieces);

            getTail();
        }

        protected function importPieces(xml:XMLList):void{
            pieces = [];

            for each(var pieceXML:XML in xml){
                var piece:TMonsterPiece = new TMonsterPiece(pieceXML.@X, pieceXML.@Y, 0, this, pieceXML.@Type);
                piece.room = room;

                piece.initialize();
                piece.setGfx();

                pieces.push(piece);
            }
        }

        override public function process(lastCommand:uint):void{

        }

        override public function update():void{
            super.update();

            for each(var piece:TMonsterPiece in pieces)
                piece.update();
        }

        public function getSerpentMovement():Boolean{
            if (Game.doesBrainSensePlayer && getBrainMovement(room.pathmapGround)) {
                return true;

            } else if (!Game.isInvisible || F.distanceInTiles(x, y, Game.player.x, Game.player.y) <= C.DEFAULT_SMELL_RANGE || Game.doesBrainSensePlayer) {
                getNormalMovement(Game.player.x, Game.player.y);
                return true;

            } else
                return false;
        }

        public function lengthenHead(ox:int, oy:int):Boolean{
            if (dx || dy){
                ASSERT((dx == 0) != (dy == 0));

                var tile:uint = C.T_EMPTY;
                if (dx != 0)
                    switch(F.getO(dx, oy)){
                        case(C.E): case(C.W): tile = C.T_SNK_EW; break;
                        case(C.NE): tile = C.T_SNK_NW; break;
                        case(C.SE): tile = C.T_SNK_SW; break;
                        case(C.NW): tile = C.T_SNK_NE; break;
                        case(C.SW): tile = C.T_SNK_SE; break;
                        default:
                            ASSERT(false);
                    }
                else
                    switch(F.getO(ox, dy)){
                        case(C.N): case(C.S): tile = C.T_SNK_NS; break;
                        case(C.NE): tile = C.T_SNK_SE; break;
                        case(C.SE): tile = C.T_SNK_NE; break;
                        case(C.NW): tile = C.T_SNK_SW; break;
                        case(C.SW): tile = C.T_SNK_NW; break;
                        default:
                            ASSERT(false);
                    }

                makeStandardMove();

                var piece:TMonsterPiece = new TMonsterPiece(prevX, prevY, 0, this, tile);

                piece.room = room;
                piece.setGfx();
                piece.initialize();

                prevX = x;
                prevY = y;

                o = F.getO(dx, dy);

                pieces.push(piece);
                return true;
            }

            prevX = x;
            prevY = y;
            return false;
        }

        public function shortenTail():Boolean{
            var dx:int = F.getOX(tailO);
            var dy:int = F.getOY(tailO);

            ASSERT((dx == 0) != (dy == 0));

            if (tailX == x && tailY == y)
                return false;

            findAndRemoveTailPiece();
            oldTailX = tailX;
            oldTailY = tailY;
            tailX += dx;
            tailY += dy;
            if (tailX == x && tailY == y){
                kill();
                return true;
            }

            var piece:TMonsterPiece = room.tilesActive[tailX + tailY * S.LEVEL_WIDTH];
            ASSERT(piece);
            if (!piece){
                kill();
                return true;
            }

            var tile:uint = piece.tileNo;
            var t   :uint;
            switch(tile){
                case(C.T_SNK_NS): case(C.T_SNK_EW): break;
                case(C.T_SNK_NW): case(C.T_SNK_SE): t = dx; dx = -dy; dy = -t; break;
                case(C.T_SNK_NE): case(C.T_SNK_SW): t = dx; dx =  dy; dy =  t; break
                default:
                    ASSERT(false);
            }

            switch(F.getO(dx, dy)){
                case(C.N): tile = C.T_SNKT_S; tailO = C.N; break;
                case(C.S): tile = C.T_SNKT_N; tailO = C.S; break;
                case(C.E): tile = C.T_SNKT_W; tailO = C.E; break;
                case(C.W): tile = C.T_SNKT_E; tailO = C.W; break;
                default:
                    ASSERT(false);
            }
            piece.tileNo = tile;
            piece.setGfx();

            return false;
        }

        protected function kill():void{
            CueEvents.add(C.CID_SNAKE_DIED_FROM_TRUNCATION, this);
            room.killMonster(this);
        }

        override public function isTileObstacle(tile:uint):Boolean{
            return !(
                F.isFloor(tile) ||
                F.isOpenDoor(tile) ||
                F.isPlatform(tile) ||
                tile == C.T_EMPTY ||
                tile == C.T_NODIAGONAL ||
                tile == C.T_FUSE ||
                tile == C.T_TOKEN);
        }

        override public function getBrainMovement(pathmap:Pathmap):Boolean{
            pathmap.calculate();

            var tile     :PathmapTile;
            var tileCheck:PathmapTile;
            var wx :uint, wy :uint;
            var tdx:int,  tdy:int;

            dx = 0;
            dy = 0;

            for(var i:uint = 0; i < 4; i++){
                wx = x + (tdx = dxDirBrain[i]);
                wy = y + (tdy = dyDirBrain[i]);

                if (wx >= S.LEVEL_WIDTH || wy >= S.LEVEL_HEIGHT) continue;

                tileCheck = pathmap.tiles[wx + wy * S.LEVEL_WIDTH];

                if (!doesSquareContainObstacle(wx, wy) && !doesArrowPreventMovement(tdx, tdy) && (!tile || tileCheck.targetDistance < tile.targetDistance)){
                    dxFirst = dx = tdx;
                    dyFirst = dy = tdy;

                    tile = tileCheck;
                }
            }

            if (tile && tile.targetDistance < uint.MAX_VALUE && (dx || dy))
                return true;

            return false;
        }

        override public function doesSquareContainObstacle(x:uint, y:uint):Boolean{
            ASSERT(x != this.x || y != this.y);

            var index:uint = x + y * S.LEVEL_WIDTH;

            var tile:uint = room.tilesTransparent[index];
            if (isTileObstacle(tile) || isTileObstacle(room.tilesFloor[index]))
                return true;

            tile = room.tilesOpaque[index];

            if (isTileObstacle(tile))
                return true;

            var monster:TMonster = room.tilesActive[index];
            if (monster)
                return true;

            return false;
        }

        public function getTail():void{
            for each(var piece:TMonsterPiece in pieces){
                switch(piece.tileNo){
                    case(C.T_SNKT_S): tailO = C.N; break;
                    case(C.T_SNKT_N): tailO = C.S; break;
                    case(C.T_SNKT_E): tailO = C.W; break;
                    case(C.T_SNKT_W): tailO = C.E; break;
                    default: continue;
                }

                tailX = piece.x;
                tailY = piece.y;

                if (oldTailX == uint.MAX_VALUE){
                    oldTailX = tailX;
                    oldTailY = tailY;
                }

                return;
            }
        }

        protected function getNormalMovement(tx:uint, ty:uint):void{
            var ox:int = F.getOX(o);
            var oy:int = F.getOY(o);

            if (!Game.isInvisible || F.distanceInTiles(x, y, tx, ty) < C.DEFAULT_SMELL_RANGE){
                if (!ox){
                    if (tx == x){
                        dy = oy;
                        dx = 0;
                        if (canMoveTo(x, y + dy))
                            return;
                    }
                } else {
                    if (ty == y){
                        dx = ox;
                        dy = 0;
                        if (canMoveTo(x + dx, y))
                            return;
                    }
                }

                var horizontal:Boolean = ((Game.spawnCycleCount % 10) + 1 <= 5);
                if (horizontal){
                    dx = (tx < x ? -1 : tx > x ? 1 : 0);
                    if (dx == 0)
                        dy = (ty < y ? -1 : ty > y ? 1 : 0);
                    else
                        dy = 0;
                } else {
                    dy = (ty < y ? -1 : ty > y ? 1 : 0);
                    if (dy == 0)
                        dx = (tx < x ? -1 : tx > x ? 1 : 0);
                    else
                        dx = 0;
                }

                if (canMoveTo(x + dx, y + dy))
                    return;
            } // END Can See Player?

            var found:Boolean = false;
            for(var i:uint = 0; i < 4; i++){
                dx = dxDirNoMove[i];
                dy = dyDirNoMove[i];
                if (dx == -ox && dy == -oy)
                    continue;
                if (canMoveTo(x + dx, y + dy)){
                    found = true;
                    break;
                }
            }

            if (!found)
                dx = dy = 0;
        }

        protected function canMoveTo(x:uint, y:uint):Boolean{
            var canMove:Boolean = !(
                x >= S.LEVEL_WIDTH || y >= S.LEVEL_HEIGHT ||
                doesSquareContainObstacle(x, y));

            if (canMove)
                return !doesArrowPreventMovement(x - this.x, y - this.y);

            return false;
        }

        private function findAndRemoveTailPiece():void{
            for(var i:uint = 0, k:uint = pieces.length, piece:TMonsterPiece; i < k; i++){
                piece = pieces[i];
                if (piece.x == tailX && piece.y == tailY){
                    piece.quickRemove();
                    pieces.splice(i, 1);
                    return;
                }
            }

            ASSERT("Shouldn't have happened");
        }

        override public function setGfx():void{
            var openMouth:Boolean = (Game.player.x == x + F.getOX(o) && Game.player.y == y + F.getOY(o));

            gfx = T.SERPENT[openMouth ? 1 : 0][o];
        }

        override public function onStabbed(sX:uint, sY:uint):Boolean{
            return false;
        }

        override public function getSnapshot():Object {
            var object:Object = super.getSnapshot();

            object.tailX = tailX;
            object.tailY = tailY;
            object.tailO = tailO;

            return object;
        }
    }
}