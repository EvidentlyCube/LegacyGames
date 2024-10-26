package game.objects.actives{
    import flash.display.BitmapData;

    import game.global.Game;
    import game.global.Gfx;
    import game.global.Room;
    import game.states.TStateGame;

    import net.retrocade.camel.core.rGfx;

    public class TMimic extends TPlayerDouble{
        public var gfxSword :uint;

        override public function getType():uint{ return C.M_MIMIC; }
        override public function getProcessSequence():uint{ return 100; }

        override public function initialize(xml:XML = null):void {
            swordX = x + F.getOX(o);
            swordY = y + F.getOY(o);

            if (swordX < S.LEVEL_WIDTH && swordY < S.LEVEL_HEIGHT)
                room.tilesSwords[swordX + swordY * S.LEVEL_WIDTH]++;
        }

        override public function setGfx():void{
            gfx             = T.MIMIC[o];
            swordVO.gfxTile = T.MIMIC_SWORD[o];
        }

        override public function update():void {
            super.update();

            swordVO.x = swordX * S.LEVEL_TILE_WIDTH  + (prevX - x) * TStateGame.offset * S.LEVEL_TILE_WIDTH;
            swordVO.y = swordY * S.LEVEL_TILE_HEIGHT + (prevY - y) * TStateGame.offset * S.LEVEL_TILE_HEIGHT;
            TStateGame.addSwordDraw(swordVO);
        }

        override public function doesSquareContainObstacle(x:uint, y:uint):Boolean{
            ASSERT(this.x != x || this.y != y);

            if (!F.isValidColRow(x, y))
                return true;

            var index:uint = x + y * S.LEVEL_WIDTH;
            var tile:uint = room.tilesOpaque[index];
            if (isTileObstacle(room.tilesOpaque[index])){
                return true;
            }

            if (isTileObstacle(room.tilesTransparent[index])){
                return true;
            }

            if (isTileObstacle(room.tilesFloor[index]))
                return true;

            if (Game.player.x == x && Game.player.y == y)
                return true;

            if (room.tilesActive[index] || room.tilesSwords[index])
                return true;

            return false;
        }

        override public function process(lastCommand:uint):void{
            dx = dy = 0;
            switch(lastCommand){
                case(C.CMD_C):  o = F.nextCO(o);  break;
                case(C.CMD_CC): o = F.nextCCO(o); break;
                case(C.CMD_N):  dy = -1;          break;
                case(C.CMD_S):  dy =  1;          break;
                case(C.CMD_W):  dx = -1;          break;
                case(C.CMD_E):  dx =  1;          break;
                case(C.CMD_NW): dy = -1; dx = -1; break;
                case(C.CMD_NE): dy = -1; dx =  1; break;
                case(C.CMD_SW): dy =  1; dx = -1; break;
                case(C.CMD_SE): dy =  1; dx =  1; break;
            }

            room.tilesSwords[swordX + swordY * S.LEVEL_WIDTH]--;

            var moveO:uint = F.getO(dx, dy);
            // Player didn't move
            if (Game.player.x == Game.player.prevX && Game.player.y == Game.player.prevY){
                dx = dy = 0;

                prevX = x;
                prevY = y;

                swordMovement = TPlayer.getSwordMovement(lastCommand, o);

                if (lastCommand != C.CMD_C && lastCommand != C.CMD_CC && swordMovement != o)
                    swordMovement = C.NO_ORIENTATION;

            } else {
                getBestMove();
                swordMovement = F.getO(dx, dy);

                if (dx || dy){
                    ASSERT(lastCommand != C.CMD_C && lastCommand != C.CMD_CC && lastCommand != C.CMD_WAIT);

                    var tileO        :uint    = room.tilesOpaque[x + y * S.LEVEL_WIDTH];
                    var wasOnTrapdoor:Boolean = F.isTrapdoor(tileO);

                    move(x + dx, y + dy);

                    ASSERT(dx || dy);
                    if (wasOnTrapdoor)
                        room.destroyTrapdoor(x - dx, y - dy);

                    Game.queryCheckpoint(x, y);
                } else {
                    prevX = x;
                    prevY = y;
                }
            }

            swordX = x + F.getOX(o);
            swordY = y + F.getOY(o);
            room.tilesSwords[swordX + swordY * S.LEVEL_WIDTH]++;

            setGfx();
            Game.processSwordHit(swordX, swordY, this);
        }
    }
}