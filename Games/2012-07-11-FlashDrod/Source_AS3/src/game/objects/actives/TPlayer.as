package game.objects.actives{
    import flash.display.BitmapData;
    import flash.utils.getTimer;
    import game.global.Progress;
    import game.managers.VOSwordDraw;

    import game.global.Core;
    import game.global.CueEvents;
    import game.global.Game;
    import game.global.Gfx;
    import game.global.Level;
    import game.global.Room;
    import game.managers.VOCoord;
    import game.managers.VOScroll;
    import game.objects.TActiveObject;
    import game.objects.TGameObject;
    import game.states.TStateGame;

    import net.retrocade.camel.core.rGfx;
    import net.retrocade.camel.core.rInput;
    import net.retrocade.utils.Key;
    import net.retrocade.utils.UNumber;

    public class TPlayer extends TGameObject{
		public var swordX:uint;
		public var swordY:uint;
        public var swordMovement:uint;

        public var placingDoubleType:uint = 0;
        public var doubleCursorX    :uint;
        public var doubleCursorY    :uint;

        public var swordVO  :VOSwordDraw = new VOSwordDraw();

        public var hidePlayer:Boolean = false;

        public function setGfx():void{
            if (Game.isInvisible){
                gfx = T.DECOY[o];
                swordVO.gfxTile = T.DECOY_SWORD[o];
            } else {
                swordVO.gfxTile = T.SWORD[o];
                gfx = T.BEETHRO[o];
            }
        }

        override public function update():void {
            if (hidePlayer)
                return;


            super.update();

            swordVO.x = swordX * S.LEVEL_TILE_WIDTH  + (prevX - x) * TStateGame.offset * S.LEVEL_TILE_WIDTH;
            swordVO.y = swordY * S.LEVEL_TILE_HEIGHT + (prevY - y) * TStateGame.offset * S.LEVEL_TILE_HEIGHT;
            TStateGame.addSwordDraw(swordVO);
        }

        public function drawTo(x:uint, y:uint, o:uint, room:Room):void{
            room.layerActive.blitTileRect(Gfx.GENERAL_TILES, T.BEETHRO[o], x,              y);
            room.layerActive.blitTileRect(Gfx.GENERAL_TILES, T.SWORD  [o], x + F.getOX(o), y + F.getOY(o));
        }

        public function process(command:uint):void{
            var dx:int = 0;
            var dy:int = 0;

            switch(command) {
                case(C.CMD_C):
                    CueEvents.add(C.CID_SWING_SWORD, new VOCoord(x, y, o));
                    rotateClockwise();
                    break;
                case(C.CMD_CC):
                    rotateCounterClockwise();
                    CueEvents.add(C.CID_SWING_SWORD, new VOCoord(x, y, o));
                    break;
                case(C.CMD_NW): dx = -1; dy = -1; break;
                case(C.CMD_N):  dy = -1; break;
                case(C.CMD_NE): dx =  1; dy = -1; break;
                case(C.CMD_W):  dx = -1; break;
                case(C.CMD_E):  dx =  1; break;
                case(C.CMD_SW): dx = -1; dy =  1; break;
                case(C.CMD_S):  dy =  1; break;
                case(C.CMD_SE): dx =  1; dy =  1; break;
                case(C.CMD_WAIT): break;

                default:
                    return;
            }

            const direction:uint = F.getO(dx, dy);

            swordMovement = getSwordMovement(command, o);

            const arrayPos:uint = x + y * S.LEVEL_WIDTH;

            const oldTileO:uint = room.tilesOpaque[arrayPos];
            const oldTileF:uint = room.tilesFloor[arrayPos];
            const oldTileT:uint = room.tilesTransparent[arrayPos];

            if (!dx && !dy){
                makeMove();
                return;
            }

            // Check for arrows
            if (F.isArrowObstacle(oldTileF, direction)) {
                CueEvents.add(C.CID_HIT_OBSTACLE);

                dx = dy = 0;
                makeMove();
                return;
            }

            //Check for leaving the room
            if (!F.isValidColRow(x + dx, y + dy)) {
                if (Game.isRoomLocked) {
                    CueEvents.add(C.CID_ROOM_EXIT_LOCKED);
                    return;
                }

                if (Game.handleLeaveRoom(direction))
                    return;

                CueEvents.add(C.CID_HIT_OBSTACLE);
                dx = dy = 0;
                makeMove();
                return;
            }

            if (doesSquareContainPlayerObstacle(x + dx, y + dy, direction)) {
                const newArrayPos:uint = x + dx + (y + dy) * S.LEVEL_WIDTH;

                const newTileO:uint = room.tilesOpaque[newArrayPos];
                const newTileF:uint = room.tilesFloor[newArrayPos];
                const newTileT:uint = room.tilesTransparent[newArrayPos];

                if (newTileO == C.T_PIT) {
                    CueEvents.add(C.CID_SCARED);
                    dx = dy = 0;
                    makeMove();
                    return;
                }

                // F-Layer checking
                if (F.isArrowObstacle(newTileF, direction)) {
                    CueEvents.add(C.CID_HIT_OBSTACLE, new VOCoord(x + dx, y + dy, direction));
                    dx = dy = 0;
                    makeMove();
                    return;
                }

                // T-Layer checking is not present in 1.0

                // Monster checking is not present in 1.0

                // If here then handle as per default
                CueEvents.add(C.CID_HIT_OBSTACLE, new VOCoord(x + dx, y + dy, direction));
                dx = dy = 0;
            }

            makeMove();
            return;

            function makeMove():void {
                var moved              :Boolean = dx != 0 || dy != 0;
                var readyToDropTrapdoor:Boolean = F.isTrapdoor(oldTileO);
                var wasOnSameScroll    :Boolean = (oldTileT == C.T_SCROLL) && !moved && Game.turnNo;

                if (command != C.CMD_C && command != C.CMD_CC)
                    setPosition(x + dx, y + dy);

                if (readyToDropTrapdoor && moved)
                    room.destroyTrapdoor(x - dx, y - dy);

                var arrayIndex         :uint    = x + y * S.LEVEL_WIDTH;

                var newTSquare:uint = room.tilesTransparent[arrayIndex];
                if (newTSquare == C.T_SCROLL && !wasOnSameScroll) {
                    var scroll:VOScroll = room.scrolls[arrayIndex];

                    ASSERT(scroll);

                    CueEvents.add(C.CID_STEP_ON_SCROLL, scroll.text);
                }

                // Handle different T-Squares
                switch(newTSquare) {
                    case C.T_POTION_M:
                        Game.drankPotion(C.M_MIMIC);
                        break;

                    case C.T_POTION_I:
                        Game.isInvisible = !Game.isInvisible;
                        room.plot(x, y, C.T_EMPTY);
                        setGfx();
                        CueEvents.add(C.CID_DRANK_POTION);
                        break;

                    default:
                        if (moved)
                            CueEvents.add(C.CID_STEP);
                }


                Game.processSwordHit(swordX, swordY);

                var newOSquare:uint = room.tilesOpaque[arrayIndex];
                switch(newOSquare) {
                    case(C.T_STAIRS):
					case(C.T_STAIRS_UP):
						Game.handleLeaveLevel();
						break;

                    case(C.T_WALL_MASTER):
                        if (!Progress.isGameMastered) {
                            //Player hit "master wall" and couldn't go through.
					        //Don't allow this move to be made.
                            CueEvents.add(C.CID_BUMPED_MASTER_WALL);
                            return;
                        }
                        break;
                }
				
            }
        }

        public function setPosition(newX:uint, newY:uint, ignoreSwordCount:Boolean = false):Boolean {
			const moved:Boolean = (x != newX || y != newY);

            prevX = x;
			prevY = y;
			prevO = o;

			x = newX;
			y = newY;

			setSwordCoords(ignoreSwordCount);

			return moved;
        }
		
		public function setSwordCoords(ignoreSwordCount:Boolean = false):void{
            if (Game.turnNo && !ignoreSwordCount)
                room.tilesSwords[swordX + swordY * S.LEVEL_WIDTH]--;

			swordX = x + F.getOX(o);
			swordY = y + F.getOY(o);

            if (!ignoreSwordCount)
                room.tilesSwords[swordX + swordY * S.LEVEL_WIDTH]++;

            setGfx();
		}

        private function rotateClockwise():void {
			prevX = x;
			prevY = y;
			prevO = o;
			o = F.nextCO(o);
			
            setGfx();

			setSwordCoords();
        }

        private function rotateCounterClockwise():void {
			prevX = x;
			prevY = y;
			prevO = o;
			o = F.nextCCO(o);

            setGfx();
			
			setSwordCoords();
        }

        private function doesSquareContainPlayerObstacle(x:uint, y:uint, dir:uint):Boolean {
            const tilePos:uint = x + y * S.LEVEL_WIDTH;
            var tile:uint = room.tilesTransparent[tilePos];
            if (!(tile == C.T_EMPTY || tile == C.T_SCROLL || F.isPotion(tile)))
                return true;

            if (F.isArrowObstacle(room.tilesFloor[tilePos], dir))
                return true;

            tile = room.tilesOpaque[tilePos];
            if (!canPlayerMoveOnThisElement(tile))
                return true;

            if (room.tilesActive[tilePos])
                return true;

            var swordCount:uint = room.tilesSwords[tilePos];
            if (swordCount > 1 || (swordCount == 1 && dir != o))
                return true;

            return false;
        }

        private function canPlayerMoveOnThisElement(tile:uint):Boolean {
            return F.isFloor(tile) || F.isOpenDoor(tile) || F.isStairs(tile) ||
                   (tile == C.T_WALL_MASTER && Progress.isGameMastered);
        }

        public static function getSwordMovement(command:uint, orientation:uint):uint{
            switch(command){
                case(C.CMD_C):
                    switch(orientation){
                        case(C.NW): return C.NE;
                        case(C.N):  return C.E;
                        case(C.NE): return C.SE;
                        case(C.W):  return C.N;
                        case(C.E):  return C.S;
                        case(C.SW): return C.NW;
                        case(C.S):  return C.W;
                        case(C.SE): return C.SW;
                    }
                    break;

                case(C.CMD_CC):
                    switch(orientation){
                        case(C.NW): return C.SW;
                        case(C.N):  return C.W;
                        case(C.NE): return C.NW;
                        case(C.W):  return C.S;
                        case(C.E):  return C.N;
                        case(C.SW): return C.SE;
                        case(C.S):  return C.E;
                        case(C.SE): return C.SE;
                    }
                    break;

                case(C.CMD_NW): return C.NW;
                case(C.CMD_N):  return C.N;
                case(C.CMD_NE): return C.NE;
                case(C.CMD_W):  return C.W;
                case(C.CMD_E):  return C.E;
                case(C.CMD_SW): return C.SW;
                case(C.CMD_S):  return C.S;
                case(C.CMD_SE): return C.SE;
            }

            return C.NO_ORIENTATION;
        }

        public function getPathmappedMove(targetX:uint, targetY:uint):uint {
            var squares:Vector.<VOMapTile> = new Vector.<VOMapTile>(200, false);
            var map    :Array = [];

            var squareNow  :uint = 0;
            var squareLimit:uint = 1;

            var tile:VOMapTile = new VOMapTile;
            tile.x     = targetX;
            tile.y     = targetY;
            tile.score = 0;
            tile.moves = 0;

            squares.push(tile);

            return C.NO_ORIENTATION;
        }
    }
}

class VOMapTile {
    public var x:uint;
    public var y:uint;
    public var score:uint;
    public var moves:uint;
}