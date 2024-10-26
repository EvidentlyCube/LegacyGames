package game.global{
    import flash.display.BitmapData;
    import flash.geom.Point;

    import game.managers.VOCheckpoints;
    import game.objects.actives.TMonster;

    import net.retrocade.utils.UBitmapData;

    public class Renderer {
        public var tilesOpaque          :Array;
        public var tilesTransparent     :Array;
        public var tilesTransparentParam:Array;
        public var tilesFloor           :Array;

        public var checkpoints          :VOCheckpoints;

        public var opaqueData        :Array = [];
        public var transparentData   :Array = [];

        private var drawTo        :DrodLayer;

        public var bdTiles         :BitmapData;
        public var bdFloor         :BitmapData;
        public var bdFloorAlt      :BitmapData;
        public var bdFloorDirt     :BitmapData;
        public var bdFloorGrass    :BitmapData;
        public var bdFloorMosaic   :BitmapData;
        public var bdFloorRoad     :BitmapData;
        public var bdPit           :BitmapData;
        public var bdPitside       :BitmapData;
        public var bdPitsideSmall  :BitmapData;
        public var bdWall          :BitmapData;

        public var styleName       :String;

        public function prepareRoom(styleName:String, layO:Array, layT:Array, layTParams:Array, layF:Array,
                                    layCheckpoints:VOCheckpoints, output:DrodLayer):void {

            CF::lib {
                if (SpiderMain.noGfx)
                    return;
            }

            this.styleName = styleName;

            bdTiles        = Gfx.STYLES[styleName][T.TILES];
            bdFloor        = Gfx.STYLES[styleName][T.TILES_FLOOR];
            bdFloorAlt     = Gfx.STYLES[styleName][T.TILES_FLOOR_ALT];
            bdFloorDirt    = Gfx.STYLES[styleName][T.TILES_FLOOR_DIRT];
            bdFloorGrass   = Gfx.STYLES[styleName][T.TILES_FLOOR_GRASS];
            bdFloorMosaic  = Gfx.STYLES[styleName][T.TILES_FLOOR_MOSAIC];
            bdFloorRoad    = Gfx.STYLES[styleName][T.TILES_FLOOR_ROAD];
            bdPit          = Gfx.STYLES[styleName][T.TILES_PIT];
            bdPitside      = Gfx.STYLES[styleName][T.TILES_PITSIDE];
            bdPitsideSmall = Gfx.STYLES[styleName][T.TILES_PITSIDE_SMALL];
            bdWall         = Gfx.STYLES[styleName][T.TILES_WALL];

            drawTo                = output;
            tilesOpaque           = layO;
            tilesTransparent      = layT;
            tilesTransparentParam = layTParams;
            tilesFloor            = layF;
            checkpoints           = layCheckpoints;

            prepareAllRoomTiles();
        }


        public function clear():void {
            CF::lib {
                if (SpiderMain.noGfx)
                    return;
            }

            checkpoints.clear();

            tilesOpaque             = null;
            tilesTransparent        = null;
            tilesTransparentParam   = null;
            tilesFloor              = null;
            checkpoints             = null;
            opaqueData              = null;
            transparentData         = null;
            drawTo                  = null;
        }



        /****************************************************************************************************************/
        /**                                                                                               PREPARATIONS  */
        /****************************************************************************************************************/

        private function prepareAllRoomTiles():void {
            CF::lib {
                if (SpiderMain.noGfx)
                    return;
            }

            var arrayIndex:uint = x + y * S.LEVEL_WIDTH;

            for(var y:uint = 0; y < S.LEVEL_HEIGHT; y++){
                for (var x:uint = 0; x < S.LEVEL_WIDTH; x++){
                    opaqueData     [arrayIndex] = 0;
                    transparentData[arrayIndex] = 0;

                    prepareOpaque     (x, y);
                    prepareTransparent(x, y);
                    //prepareFloor      (x, y);
                }
            }
        }

        private function prepareOpaque(x:uint, y:uint):void{
            switch(tilesOpaque[x + y * S.LEVEL_WIDTH]){
                case(C.T_WALL):
                case(C.T_WALL2):
                case(C.T_WALL_BROKEN):
                case(C.T_WALL_HIDDEN):
                    opaqueData[x + y * S.LEVEL_WIDTH] &= ~C.REND_WALL_TEXTURE;
                    setWallFillingData(x, y);
                    break;

                case(C.T_TRAPDOOR):
                case(C.T_PIT):
                    setPitData(x, y);
                    break;

                case(C.T_STAIRS):
                    setStairsData(x, y);
                    break;

                case(C.T_STAIRS_UP):
                    setStairsUpData(x, y);
                    break;

                default:
                    opaqueData[x + y * S.LEVEL_WIDTH] = 0;
                    break;
            }
        }

        private function prepareTransparent(x:uint, y:uint):void{
            switch (tilesTransparent[x + y * S.LEVEL_WIDTH]){
                case(C.T_OBSTACLE):
                    setObstacleData(x, y);
                    break;

                default:
                    transparentData[x + y * S.LEVEL_WIDTH] = 0;
                    break;
            }
        }

        /*private function prepareFloor(x:uint, y:uint):void{

        }*/



        /****************************************************************************************************************/
        /**                                                                                             ACTUAL DRAWING  */
        /****************************************************************************************************************/

        public function drawAll():void {
            CF::lib {
                if (SpiderMain.noGfx)
                    return;
            }

            var arrayIndex:uint = x + y * S.LEVEL_WIDTH;

            for(var y:uint = 0; y < S.LEVEL_HEIGHT; y++){
                for (var x:uint = 0; x < S.LEVEL_WIDTH; x++){
                    var index:uint = x + y * S.LEVEL_WIDTH;

                    _drawTile(tilesOpaque     [index], x, y);
                    checkpoints.drawIfHas(x, y, drawTo);
                    _drawTile(tilesFloor      [index], x, y);
                    _drawTile(tilesTransparent[index], x, y);
                    drawShadow(x, y);
                    if (tilesTransparent[x + y * S.LEVEL_WIDTH] == C.T_TAR)
                        drawTarstuff(x, y, C.T_TAR);
                }
            }
        }

        public function redrawTile(x:uint, y:uint):void {
            CF::lib {
                if (SpiderMain.noGfx)
                    return;
            }

            var index:uint = x + y * S.LEVEL_WIDTH;

            drawTo.clearBlock(x, y);
            _drawTile(tilesOpaque     [index], x, y);
            checkpoints.drawIfHas(x, y, drawTo);
            _drawTile(tilesFloor      [index], x, y);
            _drawTile(tilesTransparent[index], x, y);
            drawShadow(x, y);
            if (tilesTransparent[x + y * S.LEVEL_WIDTH] == C.T_TAR)
                drawTarstuff(x, y, C.T_TAR);

        }

        public function drawTile(x:uint, y:uint):void {
            CF::lib {
                if (SpiderMain.noGfx)
                    return;
            }

            var index:uint = x + y * S.LEVEL_WIDTH;

            _drawTile(tilesOpaque     [index], x, y);
            checkpoints.drawIfHas(x, y, drawTo);
            _drawTile(tilesFloor      [index], x, y);
            _drawTile(tilesTransparent[index], x, y);
            drawShadow(x, y);
            if (tilesTransparent[x + y * S.LEVEL_WIDTH] == C.T_TAR)
                drawTarstuff(x, y, C.T_TAR);
        }

        public function recheckAroundTile(x:uint, y:uint, plots:Array = null):void {
            CF::lib {
                return;
            }

            for (var ix:int = x - 2; ix <= x+2; ix++){
                for (var iy:int = y - 2; iy <= y+2; iy++){
                    if (uint(ix) >= S.LEVEL_WIDTH || uint(y) >= S.LEVEL_HEIGHT)
                        continue;

                    prepareOpaque(ix, iy);
                    prepareTransparent(ix, iy);
                    //prepareFloor(ix, iy);

                    if (plots)
                        plots[ix + iy * S.LEVEL_WIDTH] = 1;
                }
            }
        }

        /** Performs the draw operation of a given tile **/
        private function _drawTile(tile:uint, x:uint, y:uint):void {
            CF::lib {
                if (SpiderMain.noGfx)
                    return;
            }


            if (tile == C.T_EMPTY)
                return;

            var temp:uint;
            switch(tile) {
                case(C.T_FLOOR):
                    drawFloor(x, y, tile, bdFloor);
                    break;

                case(C.T_FLOOR_ALT):
                    drawFloor(x, y, tile, bdFloorAlt);
                    break;

                case(C.T_FLOOR_DIRT):
                    drawFloor(x, y, tile, bdFloorDirt);
                    break;

                case(C.T_FLOOR_GRASS):
                    drawFloor(x, y, tile, bdFloorGrass);
                    break;

                case(C.T_FLOOR_MOSAIC):
                    drawFloor(x, y, tile, bdFloorMosaic);
                    break;

                case(C.T_FLOOR_ROAD):
                    drawFloor(x, y, tile, bdFloorRoad);
                    break;


                case(C.T_WALL2):
                    drawWallGraphic(x, y, 0);
                    break;

                case(C.T_WALL):
                    drawTo.blitComplex(bdWall,
                        x * S.LEVEL_TILE_WIDTH + drawTo.offsetX,
                        y * S.LEVEL_TILE_HEIGHT + drawTo.offsetY,
                        x * S.LEVEL_TILE_WIDTH % bdWall.width,
                        y * S.LEVEL_TILE_HEIGHT % bdWall.height,
                        S.LEVEL_TILE_WIDTH,
                        S.LEVEL_TILE_HEIGHT);
                    break;

                case(C.T_WALL_BROKEN):
                    drawWallGraphic(x, y, 2);
                    break;

                case(C.T_WALL_HIDDEN):
                    drawWallGraphic(x, y, 1);
                    break;

                case(C.T_TRAPDOOR):
                    drawTo.blitTileRect(bdTiles, T.TI_TRAPDOOR, x, y);
                    break;

                case(C.T_DOOR_Y):
                    temp = T.DOOR_Y[getOrthogonalByte(x,y, C.T_DOOR_Y, tilesOpaque)];
                    drawTo.blitTileRect(Gfx.GENERAL_TILES, temp, x, y);
                    break;

                case(C.T_DOOR_YO):
                    temp = T.DOOR_YO[getOrthogonalByte(x,y, C.T_DOOR_YO, tilesOpaque)];
                    drawTo.blitTileRect(Gfx.GENERAL_TILES, temp, x, y);
                    break;

                case(C.T_DOOR_R):
                    temp = T.DOOR_R[getOrthogonalByte(x,y, C.T_DOOR_R, tilesOpaque)];
                    drawTo.blitTileRect(Gfx.GENERAL_TILES, temp, x, y);
                    break;

                case(C.T_DOOR_RO):
                    temp = T.DOOR_RO[getOrthogonalByte(x,y, C.T_DOOR_RO, tilesOpaque)];
                    drawTo.blitTileRect(Gfx.GENERAL_TILES, temp, x, y);
                    break;

                case(C.T_DOOR_G):
                    temp = T.DOOR_G[getOrthogonalByte(x,y, C.T_DOOR_G, tilesOpaque)];
                    drawTo.blitTileRect(Gfx.GENERAL_TILES, temp, x, y);
                    break;

                case(C.T_DOOR_GO):
                    temp = T.DOOR_GO[getOrthogonalByte(x,y, C.T_DOOR_GO, tilesOpaque)];
                    drawTo.blitTileRect(Gfx.GENERAL_TILES, temp, x, y);
                    break;

                case(C.T_DOOR_C):
                    temp = T.DOOR_C[getOrthogonalByte(x,y, C.T_DOOR_C, tilesOpaque)];
                    drawTo.blitTileRect(Gfx.GENERAL_TILES, temp, x, y);
                    break;

                case(C.T_DOOR_CO):
                    temp = T.DOOR_CO[getOrthogonalByte(x,y, C.T_DOOR_CO, tilesOpaque)];
                    drawTo.blitTileRect(Gfx.GENERAL_TILES, temp, x, y);
                    break;

                case(C.T_DOOR_B):
                    temp = T.DOOR_B[getOrthogonalByte(x,y, C.T_DOOR_B, tilesOpaque)];
                    drawTo.blitTileRect(Gfx.GENERAL_TILES, temp, x, y);
                    break;

                case(C.T_DOOR_BO):
                    temp = T.DOOR_BO[getOrthogonalByte(x,y, C.T_DOOR_BO, tilesOpaque)];
                    drawTo.blitTileRect(Gfx.GENERAL_TILES, temp, x, y);
                    break;

                case(C.T_PIT):
                    drawPit(x, y);
                    break;

                case(C.T_ARROW_N):
                    drawTo.blitTileRect(bdTiles, T.TI_ARROW_N, x, y);
                    break;

                case(C.T_ARROW_NE):
                    drawTo.blitTileRect(bdTiles, T.TI_ARROW_NE, x, y);
                    break;

                case(C.T_ARROW_E):
                    drawTo.blitTileRect(bdTiles, T.TI_ARROW_E, x, y);
                    break;

                case(C.T_ARROW_SE):
                    drawTo.blitTileRect(bdTiles, T.TI_ARROW_SE, x, y);
                    break;

                case(C.T_ARROW_S):
                    drawTo.blitTileRect(bdTiles, T.TI_ARROW_S, x, y);
                    break;

                case(C.T_ARROW_SW):
                    drawTo.blitTileRect(bdTiles, T.TI_ARROW_SW, x, y);
                    break;

                case(C.T_ARROW_W):
                    drawTo.blitTileRect(bdTiles, T.TI_ARROW_W, x, y);
                    break;

                case(C.T_ARROW_NW):
                    drawTo.blitTileRect(bdTiles, T.TI_ARROW_NW, x, y);
                    break;

                case(C.T_ORB):
                    drawTo.blitTileRect(Gfx.GENERAL_TILES, T.TI_ORB, x, y);
                    break;

                case(C.T_SCROLL):
                    drawTo.blitTileRect(Gfx.GENERAL_TILES, T.TI_SCROLL, x, y);
                    break;

                case(C.T_POTION_M):
                    drawTo.blitTileRect(Gfx.GENERAL_TILES, T.TI_POTION_M, x, y);
                    break;

                case(C.T_STAIRS):
                case(C.T_STAIRS_UP):
                    drawTo.blitTileRect(bdTiles, opaqueData[x + y * S.LEVEL_WIDTH], x, y);
                    break;

                case(C.T_POTION_I):
                    drawTo.blitTileRect(Gfx.GENERAL_TILES, T.TI_POTION_I, x, y);
                    break;

                case(C.T_OBSTACLE):
                    drawTo.blitTileRect(bdTiles, transparentData[x + y * S.LEVEL_WIDTH], x, y);
                    break;

                case(C.T_WALL_MASTER):
                    if (Progress.isGameMastered) {
                        _drawTile(getNeighbourFloor(x, y), x, y);
                        drawTo.drawTileRect(Gfx.GENERAL_TILES, T.TI_MASTER_WALL, x, y, 0.5);
                    } else
                        drawTo.drawTileRect(Gfx.GENERAL_TILES, T.TI_MASTER_WALL, x, y, 1);
                    break;

                default:

                    trace("Not drawn: " + tile)
            }
        }

        private function drawFloor(x:uint, y:uint, floorType:uint, bitmap:BitmapData):void{
            drawTo.blitComplex(bitmap,
                x * S.LEVEL_TILE_WIDTH + drawTo.offsetX,
                y * S.LEVEL_TILE_HEIGHT + drawTo.offsetY,
                x * S.LEVEL_TILE_WIDTH % bitmap.width,
                y * S.LEVEL_TILE_HEIGHT % bitmap.height,
                S.LEVEL_TILE_WIDTH,
                S.LEVEL_TILE_HEIGHT);

            var tile:uint;

            if (x > 0){
                tile = tilesOpaque[x - 1 + y * S.LEVEL_WIDTH];
                if (F.isPlainFloor(tile) && tile != floorType)
                    drawTo.blitRect(x * S.LEVEL_TILE_WIDTH, y * S.LEVEL_TILE_WIDTH, 1, S.LEVEL_TILE_WIDTH, 0xFF606060);
            }

            if (y > 0){
                tile = tilesOpaque[x + (y - 1) * S.LEVEL_WIDTH];
                if (F.isPlainFloor(tile) && tile != floorType)
                    drawTo.blitRect(x * S.LEVEL_TILE_WIDTH, y * S.LEVEL_TILE_WIDTH, S.LEVEL_TILE_HEIGHT, 1, 0xFF606060);
            }

            if (x > 0 && y > 0){
                tile = tilesOpaque[x - 1 + (y - 1) * S.LEVEL_WIDTH];
                if (F.isPlainFloor(tile) && tile != floorType)
                    drawTo.blitRect(x * S.LEVEL_TILE_WIDTH, y * S.LEVEL_TILE_WIDTH, 1, 1, 0xFF606060);
            }

        }

        // Type: 0=Normal, 1=Hidden, 2=Broken
        private function drawWallGraphic(x:uint, y:uint, type:uint = 0):void {
            var bytes:uint = getSurroundingByte(x, y, C.T_WALL2, tilesOpaque, true) |
                getSurroundingByte(x, y, C.T_WALL_BROKEN, tilesOpaque, true) |
                getSurroundingByte(x, y, C.T_WALL_HIDDEN, tilesOpaque, true) |
                getSurroundingByte(x, y, C.T_WALL_IMAGE, tilesOpaque, true);

            type = type == 1 ? T.WALL_SECRET_OFFSET : type == 2 ? T.WALL_BROKEN_OFFSET : 0;

            // Completely surrounded
            if ( bytes         == 0xFF)  {drawTo.blitTileRect(bdTiles, T.TI_WALL_NSEW1234 + type, x, y); return;}

            // Single block
            if ((bytes & 0xAA) == 0x00) {drawTo.blitTileRect(bdTiles, T.TI_WALL + type, x, y); return;}

            // Single Dead ends
            if ((bytes & 0xAA) == 0x20) {drawTo.blitTileRect(bdTiles, T.TI_WALL_S + type, x, y); return;}
            if ((bytes & 0xAA) == 0x08) {
                drawTo.blitTileRect(bdTiles, T.TI_WALL_W + type, x, y);
                if (opaqueData[x + y * S.LEVEL_WIDTH] & C.REND_WALL_TEXTURE)
                    drawWallTexture(x, y);
                return;
            }
            if ((bytes & 0xAA) == 0x02) {
                drawTo.blitTileRect(bdTiles, T.TI_WALL_N + type, x, y);
                if (opaqueData[x + y * S.LEVEL_WIDTH] & C.REND_WALL_TEXTURE)
                    drawWallTexture(x, y);
                return;
            }
            if ((bytes & 0xAA) == 0x80) {
                drawTo.blitTileRect(bdTiles, T.TI_WALL_E + type, x, y);
                if (opaqueData[x + y * S.LEVEL_WIDTH] & C.REND_WALL_TEXTURE)
                    drawWallTexture(x, y);
                return;
            }

            // Single turns
            if ((bytes & 0xEA) == 0xA0) {
                drawTo.blitTileRect(bdTiles, T.TI_WALL_SE + type, x, y);
                if (F.isValidColRow(x + 1, y) && opaqueData[x + 1 + y * S.LEVEL_WIDTH] & C.REND_WALL_TEXTURE){
                    drawTo.blitRectDirect(
                        (x + 1) * S.LEVEL_TILE_WIDTH + S.LEVEL_OFFSET_X - 1,
                        y * S.LEVEL_TILE_HEIGHT + S.LEVEL_OFFSET_Y + S.LEVEL_TILE_HEIGHT_HALF,
                        1,
                        S.LEVEL_TILE_HEIGHT_HALF,
                        0xFF000000);
                }
                return;

            }
            if ((bytes & 0xBA) == 0x28) {
                drawTo.blitTileRect(bdTiles, T.TI_WALL_SW + type, x, y);
                if (F.isValidColRow(x - 1, y) && opaqueData[x - 1 + y * S.LEVEL_WIDTH] & C.REND_WALL_TEXTURE){
                    drawTo.blitRectDirect(
                        x * S.LEVEL_TILE_WIDTH + S.LEVEL_OFFSET_X,
                        y * S.LEVEL_TILE_HEIGHT + S.LEVEL_OFFSET_Y + S.LEVEL_TILE_HEIGHT_HALF,
                        1,
                        S.LEVEL_TILE_HEIGHT_HALF,
                        0xFF000000);
                }
                return;
            }

            if ((bytes & 0xAE) == 0x0A) {
                drawTo.blitTileRect(bdTiles, T.TI_WALL_NW + type, x, y);
                if (opaqueData[x + y * S.LEVEL_WIDTH] & C.REND_WALL_TEXTURE)
                    drawWallTexture(x, y);
                return;
            }
            if ((bytes & 0xAB) == 0x82) {
                drawTo.blitTileRect(bdTiles, T.TI_WALL_NE + type, x, y);
                if (opaqueData[x + y * S.LEVEL_WIDTH] & C.REND_WALL_TEXTURE)
                    drawWallTexture(x, y);
                return;
            }

            // Single corridors
            if ((bytes & 0xAA) == 0x88) {
                drawTo.blitTileRect(bdTiles, T.TI_WALL_EW + type, x, y);
                if (opaqueData[x + y * S.LEVEL_WIDTH] & C.REND_WALL_TEXTURE)
                    drawWallTexture(x, y);
                return;
            }
            if ((bytes & 0xAA) == 0x22) {drawTo.blitTileRect(bdTiles, T.TI_WALL_NS + type, x, y); return;}

            // Single triple conjunction
            if ((bytes & 0xEB) == 0xA2) {drawTo.blitTileRect(bdTiles, T.TI_WALL_NSE + type, x, y); return;}
            if ((bytes & 0xFA) == 0xA8) {
                drawTo.blitTileRect(bdTiles, T.TI_WALL_SEW + type, x, y);
                if (F.isValidColRow(x + 1, y) && opaqueData[x + 1 + y * S.LEVEL_WIDTH] & C.REND_WALL_TEXTURE){
                    drawTo.blitRectDirect(
                        (x + 1) * S.LEVEL_TILE_WIDTH + S.LEVEL_OFFSET_X - 1,
                        y * S.LEVEL_TILE_HEIGHT + S.LEVEL_OFFSET_Y + S.LEVEL_TILE_HEIGHT_HALF,
                        1,
                        S.LEVEL_TILE_HEIGHT_HALF,
                        0xFF000000);
                }
                if (F.isValidColRow(x - 1, y) && opaqueData[x - 1 + y * S.LEVEL_WIDTH] & C.REND_WALL_TEXTURE){
                    drawTo.blitRectDirect(
                        x * S.LEVEL_TILE_WIDTH + S.LEVEL_OFFSET_X,
                        y * S.LEVEL_TILE_HEIGHT + S.LEVEL_OFFSET_Y + S.LEVEL_TILE_HEIGHT_HALF,
                        1,
                        S.LEVEL_TILE_HEIGHT_HALF,
                        0xFF000000);
                }
                return;
            }
            if ((bytes & 0xBE) == 0x2A) {drawTo.blitTileRect(bdTiles, T.TI_WALL_NSW + type, x, y); return;}
            if ((bytes & 0xAF) == 0x8A) {
                drawTo.blitTileRect(bdTiles, T.TI_WALL_NEW + type, x, y);
                if (opaqueData[x + y * S.LEVEL_WIDTH] & C.REND_WALL_TEXTURE)
                    drawWallTexture(x, y);
                return;
            }

            // Four way crossroad
            if ( bytes         == 0xAA) {
                drawTo.blitTileRect(bdTiles, T.TI_WALL_NSEW + type, x, y);
                if (F.isValidColRow(x + 1, y) && opaqueData[x + 1 + y * S.LEVEL_WIDTH] & C.REND_WALL_TEXTURE){
                    drawTo.blitRectDirect(
                        (x + 1) * S.LEVEL_TILE_WIDTH + S.LEVEL_OFFSET_X - 1,
                        y * S.LEVEL_TILE_HEIGHT + S.LEVEL_OFFSET_Y + S.LEVEL_TILE_HEIGHT_HALF,
                        1,
                        S.LEVEL_TILE_HEIGHT_HALF,
                        0xFF000000);
                }
                if (F.isValidColRow(x - 1, y) && opaqueData[x - 1 + y * S.LEVEL_WIDTH] & C.REND_WALL_TEXTURE){
                    drawTo.blitRectDirect(
                        x * S.LEVEL_TILE_WIDTH + S.LEVEL_OFFSET_X,
                        y * S.LEVEL_TILE_HEIGHT + S.LEVEL_OFFSET_Y + S.LEVEL_TILE_HEIGHT_HALF,
                        1,
                        S.LEVEL_TILE_HEIGHT_HALF,
                        0xFF000000);
                }
                return;
            }

            // Corners
            if ((bytes & 0xEA) == 0xE0) {drawTo.blitTileRect(bdTiles, T.TI_WALL_SE4 + type, x, y); return;}
            if ((bytes & 0xBA) == 0x38) {drawTo.blitTileRect(bdTiles, T.TI_WALL_SW3 + type, x, y); return;}
            if ((bytes & 0xAE) == 0x0E) {
                drawTo.blitTileRect(bdTiles, T.TI_WALL_NW1 + type, x, y);
                if (opaqueData[x + y * S.LEVEL_WIDTH] & C.REND_WALL_TEXTURE)
                    drawWallTexture(x, y);
                return;
            }
            if ((bytes & 0xAB) == 0x83) {
                drawTo.blitTileRect(bdTiles, T.TI_WALL_NE2 + type, x, y);
                if (opaqueData[x + y * S.LEVEL_WIDTH] & C.REND_WALL_TEXTURE)
                    drawWallTexture(x, y);
                return;
            }

            // Sides
            if ((bytes & 0xEB) == 0xE3) {drawTo.blitTileRect(bdTiles, T.TI_WALL_NSE24 + type, x, y); return;}
            if ((bytes & 0xFA) == 0xF8) {drawTo.blitTileRect(bdTiles, T.TI_WALL_SEW34 + type, x, y); return;}
            if ((bytes & 0xBE) == 0x3E) {drawTo.blitTileRect(bdTiles, T.TI_WALL_NSW13 + type, x, y); return;}
            if ((bytes & 0xAF) == 0x8F) {
                drawTo.blitTileRect(bdTiles, T.TI_WALL_NEW12 + type, x, y);
                if (opaqueData[x + y * S.LEVEL_WIDTH] & C.REND_WALL_TEXTURE)
                    drawWallTexture(x, y);
                return;
            }

            // (Lots of) Inner corners
            if ( bytes         == 0xFB) {drawTo.blitTileRect(bdTiles, T.TI_WALL_NSEW234 + type, x, y); return;}
            if ( bytes         == 0xFE) {drawTo.blitTileRect(bdTiles, T.TI_WALL_NSEW134 + type, x, y); return;}
            if ( bytes         == 0xBF) {drawTo.blitTileRect(bdTiles, T.TI_WALL_NSEW123 + type, x, y); return;}
            if ( bytes         == 0xEF) {drawTo.blitTileRect(bdTiles, T.TI_WALL_NSEW124 + type, x, y); return;}
            if ( bytes         == 0xFA) {drawTo.blitTileRect(bdTiles, T.TI_WALL_NSEW34 + type, x, y); return;}
            if ( bytes         == 0xBB) {drawTo.blitTileRect(bdTiles, T.TI_WALL_NSEW23 + type, x, y); return;}
            if ( bytes         == 0xEB) {drawTo.blitTileRect(bdTiles, T.TI_WALL_NSEW24 + type, x, y); return;}
            if ( bytes         == 0xBE) {drawTo.blitTileRect(bdTiles, T.TI_WALL_NSEW13 + type, x, y); return;}
            if ( bytes         == 0xEE) {drawTo.blitTileRect(bdTiles, T.TI_WALL_NSEW14 + type, x, y); return;}
            if ( bytes         == 0xAF) {drawTo.blitTileRect(bdTiles, T.TI_WALL_NSEW12 + type, x, y); return;}
            if ( bytes         == 0xBA) {drawTo.blitTileRect(bdTiles, T.TI_WALL_NSEW3 + type, x, y); return;}
            if ( bytes         == 0xEA) {drawTo.blitTileRect(bdTiles, T.TI_WALL_NSEW4 + type, x, y); return;}
            if ( bytes         == 0xAB) {drawTo.blitTileRect(bdTiles, T.TI_WALL_NSEW2 + type, x, y); return;}
            if ( bytes         == 0xAE) {drawTo.blitTileRect(bdTiles, T.TI_WALL_NSEW1 + type, x, y); return;}

            // Sides
            if ((bytes & 0xFA) == 0xE8) {
                drawTo.blitTileRect(bdTiles, T.TI_WALL_SEW4 + type, x, y);
                if (F.isValidColRow(x - 1, y) && opaqueData[x - 1 + y * S.LEVEL_WIDTH] & C.REND_WALL_TEXTURE){
                    drawTo.blitRectDirect(
                        x * S.LEVEL_TILE_WIDTH + S.LEVEL_OFFSET_X,
                        y * S.LEVEL_TILE_HEIGHT + S.LEVEL_OFFSET_Y + S.LEVEL_TILE_HEIGHT_HALF,
                        1,
                        S.LEVEL_TILE_HEIGHT_HALF,
                        0xFF000000);
                }
                return;
            }
            if ((bytes & 0xFA) == 0xB8) {
                drawTo.blitTileRect(bdTiles, T.TI_WALL_SEW3 + type, x, y);
                if (F.isValidColRow(x + 1, y) && opaqueData[x + 1 + y * S.LEVEL_WIDTH] & C.REND_WALL_TEXTURE){
                    drawTo.blitRectDirect(
                        (x + 1) * S.LEVEL_TILE_WIDTH + S.LEVEL_OFFSET_X - 1,
                        y * S.LEVEL_TILE_HEIGHT + S.LEVEL_OFFSET_Y + S.LEVEL_TILE_HEIGHT_HALF,
                        1,
                        S.LEVEL_TILE_HEIGHT_HALF,
                        0xFF000000);
                }
                return;
            }
            if ((bytes & 0xBE) == 0x3A) {drawTo.blitTileRect(bdTiles, T.TI_WALL_NSW3 + type, x, y); return;}
            if ((bytes & 0xBE) == 0x2E) {
                drawTo.blitTileRect(bdTiles, T.TI_WALL_NSW1 + type, x, y);
                if (F.isValidColRow(x - 1, y) && opaqueData[x - 1 + y * S.LEVEL_WIDTH] & C.REND_WALL_TEXTURE){
                    drawTo.blitRectDirect(
                        x * S.LEVEL_TILE_WIDTH + S.LEVEL_OFFSET_X,
                        y * S.LEVEL_TILE_HEIGHT + S.LEVEL_OFFSET_Y + S.LEVEL_TILE_HEIGHT_HALF,
                        1,
                        S.LEVEL_TILE_HEIGHT_HALF,
                        0xFF000000);
                }
                return;
            }
            if ((bytes & 0xAF) == 0x8B) {
                drawTo.blitTileRect(bdTiles, T.TI_WALL_NEW2 + type, x, y);
                if (opaqueData[x + y * S.LEVEL_WIDTH] & C.REND_WALL_TEXTURE)
                    drawWallTexture(x, y);
                return;
            }

            if ((bytes & 0xAF) == 0x8E) {
                drawTo.blitTileRect(bdTiles, T.TI_WALL_NEW1 + type, x, y);
                if (opaqueData[x + y * S.LEVEL_WIDTH] & C.REND_WALL_TEXTURE)
                    drawWallTexture(x, y);
                return;
            }
            if ((bytes & 0xEB) == 0xE2) {drawTo.blitTileRect(bdTiles, T.TI_WALL_NSE4 + type, x, y); return;}
            if ((bytes & 0xEB) == 0xA3) {
                drawTo.blitTileRect(bdTiles, T.TI_WALL_NSE2 + type, x, y);
                if (F.isValidColRow(x + 1, y) && opaqueData[x + 1 + y * S.LEVEL_WIDTH] & C.REND_WALL_TEXTURE){
                    drawTo.blitRectDirect(
                        (x + 1) * S.LEVEL_TILE_WIDTH + S.LEVEL_OFFSET_X - 1,
                        y * S.LEVEL_TILE_HEIGHT + S.LEVEL_OFFSET_Y + S.LEVEL_TILE_HEIGHT_HALF,
                        1,
                        S.LEVEL_TILE_HEIGHT_HALF,
                        0xFF000000);
                }
                return;
            }
        }

        private function drawWallTexture(x:int, y:int):void {
            drawTo.drawComplexDirect(bdWall,
                x * S.LEVEL_TILE_WIDTH + S.LEVEL_OFFSET_X,
                y * S.LEVEL_TILE_HEIGHT + S.LEVEL_OFFSET_Y + S.LEVEL_TILE_HEIGHT_HALF,
                1,
                x * S.LEVEL_TILE_WIDTH % bdWall.width,
                (y * S.LEVEL_TILE_HEIGHT + S.LEVEL_TILE_HEIGHT_HALF) % bdWall.height,
                S.LEVEL_TILE_WIDTH,
                S.LEVEL_TILE_HEIGHT_HALF);
            drawTo.blitRectDirect(
                x * S.LEVEL_TILE_WIDTH + S.LEVEL_OFFSET_X,
                y * S.LEVEL_TILE_HEIGHT + S.LEVEL_OFFSET_Y + S.LEVEL_TILE_HEIGHT_HALF,
                S.LEVEL_TILE_WIDTH,
                1,
                0xFF000000);
        }

        private function drawPit(x:uint, y:uint):void{
            var data:uint = opaqueData[x + y * S.LEVEL_WIDTH];
            var dataX:uint = (data & C.REND_PIT_COORDS_MASK) % C.REND_PIT_COORD_MULTIP;
            var dataY:uint = (data & C.REND_PIT_COORDS_MASK) / C.REND_PIT_COORD_MULTIP | 0;

            drawTo.drawComplexDirect(bdPit,
                x * S.LEVEL_TILE_WIDTH + S.LEVEL_OFFSET_X,
                y * S.LEVEL_TILE_HEIGHT + S.LEVEL_OFFSET_Y,
                1,
                x * S.LEVEL_TILE_WIDTH % bdPit.width,
                y * S.LEVEL_TILE_HEIGHT % bdPit.height,
                S.LEVEL_TILE_WIDTH,
                S.LEVEL_TILE_HEIGHT);

            if (data & C.REND_PIT_IS_SIDE_SMALL)
                drawTo.drawComplexDirect(bdPitsideSmall,
                    x * S.LEVEL_TILE_WIDTH + S.LEVEL_OFFSET_X,
                    y * S.LEVEL_TILE_HEIGHT + S.LEVEL_OFFSET_Y,
                    1,
                    (dataX * S.LEVEL_TILE_WIDTH) % bdPitsideSmall.width,
                    dataY * S.LEVEL_TILE_HEIGHT,
                    S.LEVEL_TILE_WIDTH,
                    S.LEVEL_TILE_HEIGHT);

            else if (data & C.REND_PIT_IS_SIDE)
                drawTo.drawComplexDirect(bdPitside,
                    x * S.LEVEL_TILE_WIDTH + S.LEVEL_OFFSET_X,
                    y * S.LEVEL_TILE_HEIGHT + S.LEVEL_OFFSET_Y,
                    1,
                    (dataX * S.LEVEL_TILE_WIDTH) % bdPitside.width,
                    dataY * S.LEVEL_TILE_HEIGHT,
                    S.LEVEL_TILE_WIDTH,
                    S.LEVEL_TILE_HEIGHT);

            if (x > 0 && F.isFloor(tilesOpaque[x - 1 + y * S.LEVEL_WIDTH]))
                drawTo.blitRect(x * S.LEVEL_TILE_WIDTH, y * S.LEVEL_TILE_WIDTH, 1, S.LEVEL_TILE_WIDTH, 0xFF000000);

            if (y > 0 && F.isFloor(tilesOpaque[x + (y - 1) * S.LEVEL_WIDTH]))
                drawTo.blitRect(x * S.LEVEL_TILE_WIDTH, y * S.LEVEL_TILE_WIDTH, S.LEVEL_TILE_HEIGHT, 1, 0xFF000000);

            if (x < S.LEVEL_WIDTH - 1 && F.isFloor(tilesOpaque[x + 1 + y * S.LEVEL_WIDTH]))
                drawTo.blitRect((x + 1) * S.LEVEL_TILE_WIDTH - 1, y * S.LEVEL_TILE_WIDTH, 1, S.LEVEL_TILE_WIDTH, 0xFF000000);

            if (y < S.LEVEL_HEIGHT - 1 && F.isFloor(tilesOpaque[x + (y + 1) * S.LEVEL_WIDTH]))
                drawTo.blitRect(x * S.LEVEL_TILE_WIDTH, (y + 1) * S.LEVEL_TILE_WIDTH - 1, S.LEVEL_TILE_HEIGHT, 1, 0xFF000000);

            if (x > 0 && y > 0 && F.isFloor(tilesOpaque[x - 1 + (y - 1) * S.LEVEL_WIDTH]))
                drawTo.blitRect(x * S.LEVEL_TILE_WIDTH, y * S.LEVEL_TILE_WIDTH, 1, 1, 0xFF000000);

            if (x < S.LEVEL_WIDTH - 1 && y > 0 && F.isFloor(tilesOpaque[x + 1 + (y - 1) * S.LEVEL_WIDTH]))
                drawTo.blitRect((x + 1) * S.LEVEL_TILE_WIDTH - 1, y * S.LEVEL_TILE_WIDTH, 1, 1, 0xFF000000);

            if (x > 0 && y < S.LEVEL_HEIGHT - 1 && F.isFloor(tilesOpaque[x - 1 + (y + 1) * S.LEVEL_WIDTH]))
                drawTo.blitRect(x * S.LEVEL_TILE_WIDTH, (y + 1) * S.LEVEL_TILE_WIDTH - 1, 1, 1, 0xFF000000);

            if (x < S.LEVEL_WIDTH - 1 && y < S.LEVEL_HEIGHT - 1 && F.isFloor(tilesOpaque[x + 1 + (y + 1) * S.LEVEL_WIDTH]))
                drawTo.blitRect((x + 1) * S.LEVEL_TILE_WIDTH - 1, (y + 1) * S.LEVEL_TILE_WIDTH - 1, 1, 1, 0xFF000000);


        }

        private function drawTarstuff(x:uint, y:uint, tarType:uint):void {
            var bytes:uint = getSurroundingByte(x, y, tarType, tilesTransparent);

            // INNER CORNERS
            if (bytes         == 0xBF) {drawTo.drawTileRect(Gfx.GENERAL_TILES, T.TI_TAR_ISE, x, y, 0.75); return;}
            if (bytes         == 0xEF) {drawTo.drawTileRect(Gfx.GENERAL_TILES, T.TI_TAR_ISW, x, y, 0.75); return;}
            if (bytes         == 0xFB) {drawTo.drawTileRect(Gfx.GENERAL_TILES, T.TI_TAR_INW, x, y, 0.75); return;}
            if (bytes         == 0xFE) {drawTo.drawTileRect(Gfx.GENERAL_TILES, T.TI_TAR_INE, x, y, 0.75); return;}

            // DOUBLE CORNERS
            if (bytes         == 0xBB) {drawTo.drawTileRect(Gfx.GENERAL_TILES, T.TI_TAR_INWSE, x, y, 0.75); return;}
            if (bytes         == 0xEE) {drawTo.drawTileRect(Gfx.GENERAL_TILES, T.TI_TAR_INESW, x, y, 0.75); return;}

            // INSIDE
            if (bytes         == 0xFF) {drawTo.drawTileRect(Gfx.GENERAL_TILES, T.TI_TAR_NSEW, x, y, 0.75); return;}

            // FLAT SIDES
            if ((bytes & 0x3E) == 0x3E) {drawTo.drawTileRect(Gfx.GENERAL_TILES, T.TI_TAR_NSW, x, y, 0.75); return;}
            if ((bytes & 0x8F) == 0x8F) {drawTo.drawTileRect(Gfx.GENERAL_TILES, T.TI_TAR_NEW, x, y, 0.75); return;}
            if ((bytes & 0xE3) == 0xE3) {drawTo.drawTileRect(Gfx.GENERAL_TILES, T.TI_TAR_NSE, x, y, 0.75); return;}
            if ((bytes & 0xF8) == 0xF8) {drawTo.drawTileRect(Gfx.GENERAL_TILES, T.TI_TAR_SEW, x, y, 0.75); return;}

            // CORNERS
            if ((bytes & 0x0E) == 0x0E) {drawTo.drawTileRect(Gfx.GENERAL_TILES, T.TI_TAR_NW, x, y, 0.75); return;}
            if ((bytes & 0x83) == 0x83) {drawTo.drawTileRect(Gfx.GENERAL_TILES, T.TI_TAR_NE, x, y, 0.75); return;}
            if ((bytes & 0xE0) == 0xE0) {drawTo.drawTileRect(Gfx.GENERAL_TILES, T.TI_TAR_SE, x, y, 0.75); return;}
            if ((bytes & 0x38) == 0x38) {drawTo.drawTileRect(Gfx.GENERAL_TILES, T.TI_TAR_SW, x, y, 0.75); return;}

            drawTo.drawTileRect(Gfx.GENERAL_TILES, T.TI_TAR_NSEW, x, y, 0.75);
        }

        private function drawShadow(x:uint, y:uint):void {
            var tileN:Boolean = false;
            var tileW:Boolean = false;
            var tile1:Boolean = false;
            var tile:uint;

            // Check this tile
            tile = tilesOpaque[x + y * S.LEVEL_WIDTH];
            if (tile == C.T_WALL || tile == C.T_WALL_BROKEN || tile == C.T_WALL_HIDDEN || tile == C.T_WALL_IMAGE ||
                    tile == C.T_WALL_MASTER || tile == C.T_DOOR_B || tile == C.T_DOOR_C || tile == C.T_DOOR_G ||
                    tile == C.T_DOOR_R || tile == C.T_DOOR_Y || tile == C.T_PIT || tile == C.T_WALL2)
                return;

            // Check N
            tile = tilesOpaque[x + (y - 1) * S.LEVEL_WIDTH];
            tileN = (y > 0 && (tile == C.T_WALL || tile == C.T_WALL_BROKEN || tile == C.T_WALL_HIDDEN || tile == C.T_WALL_IMAGE ||
                tile == C.T_WALL_MASTER || tile == C.T_DOOR_B || tile == C.T_DOOR_C || tile == C.T_DOOR_G ||
                tile == C.T_DOOR_R || tile == C.T_DOOR_Y || tile == C.T_WALL2));

            // Check W
            tile = tilesOpaque[x - 1 + y * S.LEVEL_WIDTH];
            tileW = (x > 0 && (tile == C.T_WALL || tile == C.T_WALL_BROKEN || tile == C.T_WALL_HIDDEN || tile == C.T_WALL_IMAGE ||
                tile == C.T_WALL_MASTER || tile == C.T_DOOR_B || tile == C.T_DOOR_C || tile == C.T_DOOR_G ||
                tile == C.T_DOOR_R || tile == C.T_DOOR_Y || tile == C.T_WALL2));

            // Check 1
            tile = tilesOpaque[x - 1 + (y - 1) * S.LEVEL_WIDTH];
            tile1 = (((x == 0 || y == 0) && (tileN || tileW)) || (x > 0 && y > 0 && (tile == C.T_WALL || tile == C.T_WALL_BROKEN ||
                tile == C.T_WALL_HIDDEN || tile == C.T_WALL_IMAGE || tile == C.T_WALL_MASTER || tile == C.T_DOOR_B || tile == C.T_DOOR_C ||
                tile == C.T_DOOR_G || tile == C.T_DOOR_R || tile == C.T_DOOR_Y || tile == C.T_WALL2)));

            if (tileN) {
                if (tileW) {
                    if (tile1)
                        drawTo.drawTileRect(Gfx.GENERAL_TILES, T.TI_SHADOW_NW1, x, y, 0.25);
                    else
                        drawTo.drawTileRect(Gfx.GENERAL_TILES, T.TI_SHADOW_NW, x, y, 0.25);
                } else if (tile1)
                    drawTo.drawTileRect(Gfx.GENERAL_TILES, T.TI_SHADOW_N1, x, y, 0.25);
                else
                    drawTo.drawTileRect(Gfx.GENERAL_TILES, T.TI_SHADOW_N, x, y, 0.25);
            } else if (tileW) {
                if (tile1)
                    drawTo.drawTileRect(Gfx.GENERAL_TILES, T.TI_SHADOW_W1, x, y, 0.25);
                else
                    drawTo.drawTileRect(Gfx.GENERAL_TILES, T.TI_SHADOW_W, x, y, 0.25);
            } else if (tile1)
                drawTo.drawTileRect(Gfx.GENERAL_TILES, T.TI_SHADOW_1, x, y, 0.25);
        }


        /****************************************************************************************************************/
        /**                                                                                           HELPER FUNCTIONS  */
        /****************************************************************************************************************/

        public function getNeighbourFloor(x:uint, y:uint):uint {
            if (y > 0 && F.isPlainFloor(tilesOpaque[x + (y - 1) * S.LEVEL_WIDTH]))
                return tilesOpaque[x + (y - 1) * S.LEVEL_WIDTH];

            if (x > 0 && F.isPlainFloor(tilesOpaque[x - 1 + y * S.LEVEL_WIDTH]))
                return tilesOpaque[x - 1 + y * S.LEVEL_WIDTH];

            if (x < S.LEVEL_WIDTH - 1 && F.isPlainFloor(tilesOpaque[x + 1 + y * S.LEVEL_WIDTH]))
                return tilesOpaque[x + 1 + y * S.LEVEL_WIDTH];

            if (y < S.LEVEL_HEIGHT - 1 && F.isPlainFloor(tilesOpaque[x + (y + 1) * S.LEVEL_WIDTH]))
                return tilesOpaque[x + (y + 1) * S.LEVEL_WIDTH];


            if (y > 0 && x > 0 && F.isPlainFloor(tilesOpaque[x - 1 + (y - 1) * S.LEVEL_WIDTH]))
                return tilesOpaque[x - 1 + (y - 1) * S.LEVEL_WIDTH];

            if (x > 0 && y < S.LEVEL_HEIGHT - 1 && F.isPlainFloor(tilesOpaque[x - 1 + (y + 1) * S.LEVEL_WIDTH]))
                return tilesOpaque[x - 1 + (y + 1) * S.LEVEL_WIDTH];

            if (x < S.LEVEL_WIDTH - 1 && y > 0 && F.isPlainFloor(tilesOpaque[x + 1 + (y - 1) * S.LEVEL_WIDTH]))
                return tilesOpaque[x + 1 + (y - 1) * S.LEVEL_WIDTH];

            if (y < S.LEVEL_HEIGHT - 1 && x < S.LEVEL_WIDTH - 1 && F.isPlainFloor(tilesOpaque[x + 1 + (y + 1) * S.LEVEL_WIDTH]))
                return tilesOpaque[x + 1 + (y + 1) * S.LEVEL_WIDTH];

            return C.T_FLOOR;
        }

        /** Checks 4 surrounding neighbours, used for determining Door type **/
        private function getOrthogonalByte(x:uint, y:uint, type:uint, layer:Array):uint{
            var data:uint = 0;

            if (y > 0 && layer[x + (y - 1) * S.LEVEL_WIDTH] == type)
                data |= 8;

            if (x > 0 && layer[x - 1 + y * S.LEVEL_WIDTH]   == type)
                data |= 1;

            if (x < S.LEVEL_WIDTH - 1 && layer[x + 1 + y * S.LEVEL_WIDTH] == type)
                data |= 4;

            if (y < S.LEVEL_HEIGHT - 1 && layer[x + (y + 1) * S.LEVEL_WIDTH] == type)
                data |= 2;

            return data;
        }

        /** Checks 8 surrounding neighbours, used for determining Tar graphic, the order is:
         *   E, SE, S, SW, W, NW, N, NE **/
        private function getSurroundingByte(x:uint, y:uint, type:uint, layer:Array, borderObstacle:Boolean = false):uint{
            var data:uint = 0;

            if ((y > 0 && layer[x + (y - 1) * S.LEVEL_WIDTH] == type) || (borderObstacle && y <= 0))
                data |= 2;

            if ((x > 0 && layer[x - 1 + y * S.LEVEL_WIDTH] == type) || (borderObstacle && x <= 0))
                data |= 8;

            if ((x < S.LEVEL_WIDTH - 1 && layer[x + 1 + y * S.LEVEL_WIDTH] == type) || (borderObstacle && x >= S.LEVEL_WIDTH - 1))
                data |= 128;

            if ((y < S.LEVEL_HEIGHT - 1 && layer[x + (y + 1) * S.LEVEL_WIDTH] == type) ||
                (borderObstacle && y >= S.LEVEL_HEIGHT - 1))
                data |= 32;


            if ((y > 0 && x > 0 && layer[x - 1 + (y - 1) * S.LEVEL_WIDTH] == type) ||
                (borderObstacle && (y <= 0 || x <= 0)))
                data |= 4;

            if ((x > 0 && y < S.LEVEL_HEIGHT - 1 && layer[x - 1 + (y + 1) * S.LEVEL_WIDTH]   == type) ||
                (borderObstacle && (y >= S.LEVEL_HEIGHT - 1 || x <= 0)))
                data |= 16;

            if ((x < S.LEVEL_WIDTH - 1 && y > 0 && layer[x + 1 + (y - 1) * S.LEVEL_WIDTH] == type) ||
                (borderObstacle && (y <= 0 || x >= S.LEVEL_WIDTH - 1)))
                data |= 1;

            if ((y < S.LEVEL_HEIGHT - 1 && x < S.LEVEL_WIDTH - 1 && layer[x + 1 + (y + 1) * S.LEVEL_WIDTH] == type) ||
                (borderObstacle && (y >= S.LEVEL_HEIGHT - 1 || x >= S.LEVEL_WIDTH - 1)))
                data |= 64;

            return data;
        }

        private function setWallFillingData(x:uint, y:uint):void {
            var index:uint = x + y * S.LEVEL_WIDTH;

            if (opaqueData[index] & C.REND_WALL_HIDDEN_SECRET) {
                    opaqueData[index] ^= C.REND_WALL_HIDDEN_SECRET;

                tilesOpaque[index] = C.T_WALL_HIDDEN;
            }

            var bytes:uint = getSurroundingByte(x, y, C.T_WALL, tilesOpaque, true) |
                getSurroundingByte(x, y, C.T_WALL2, tilesOpaque, true) |
                getSurroundingByte(x, y, C.T_WALL_HIDDEN, tilesOpaque, true) |
                getSurroundingByte(x, y, C.T_WALL_BROKEN, tilesOpaque, true);

            if (bytes == 0xFF && tilesOpaque[index] == C.T_WALL){
                opaqueData[index] = C.REND_WALL_TEXTURE;
                return;

            } else if (bytes == 0xFF && tilesOpaque[index] == C.T_WALL_HIDDEN) {
                tilesOpaque[index] = C.T_WALL;
                opaqueData[index] = C.REND_WALL_TEXTURE | C.REND_WALL_HIDDEN_SECRET;
                return;
            }

            if (tilesOpaque[index] == C.T_WALL)
                tilesOpaque[index] = C.T_WALL2;

            if (bytes == 0xFF){
                if ((getSurroundingByte(x, y + 1, C.T_WALL, tilesOpaque, true) |
                    getSurroundingByte(x, y + 1, C.T_WALL2, tilesOpaque, true) |
                    getSurroundingByte(x, y + 1, C.T_WALL_HIDDEN, tilesOpaque, true) |
                    getSurroundingByte(x, y + 1, C.T_WALL_BROKEN, tilesOpaque, true))){
                    opaqueData[index] = C.REND_WALL_TEXTURE;
                    return;
                }
            }

            // Wall SEW34
            if ((bytes & 0xFA) == 0xF8) {
                if ((getSurroundingByte(x, y + 1, C.T_WALL, tilesOpaque, true) |
                        getSurroundingByte(x, y + 1, C.T_WALL2, tilesOpaque, true) |
                        getSurroundingByte(x, y + 1, C.T_WALL_HIDDEN, tilesOpaque, true) |
                        getSurroundingByte(x, y + 1, C.T_WALL_BROKEN, tilesOpaque, true))){
                    opaqueData[index] = C.REND_WALL_TEXTURE;
                    return;
                }
            }

            // NSEW234, NSEW134, NSEW34
            if ( bytes         == 0xFB) {
                if ((getSurroundingByte(x, y + 1, C.T_WALL, tilesOpaque, true) |
                        getSurroundingByte(x, y + 1, C.T_WALL2, tilesOpaque, true) |
                        getSurroundingByte(x, y + 1, C.T_WALL_HIDDEN, tilesOpaque, true) |
                        getSurroundingByte(x, y + 1, C.T_WALL_BROKEN, tilesOpaque, true))){
                    opaqueData[index] = C.REND_WALL_TEXTURE;
                    return;
                }
            }
            if ( bytes         == 0xFE) {
                if ((getSurroundingByte(x, y + 1, C.T_WALL, tilesOpaque, true) |
                        getSurroundingByte(x, y + 1, C.T_WALL2, tilesOpaque, true) |
                        getSurroundingByte(x, y + 1, C.T_WALL_HIDDEN, tilesOpaque, true) |
                        getSurroundingByte(x, y + 1, C.T_WALL_BROKEN, tilesOpaque, true))){
                    opaqueData[index] = C.REND_WALL_TEXTURE;
                    return;
                }
            }
            if ( bytes         == 0xFA) {
                if ((getSurroundingByte(x, y + 1, C.T_WALL, tilesOpaque, true) |
                        getSurroundingByte(x, y + 1, C.T_WALL2, tilesOpaque, true) |
                        getSurroundingByte(x, y + 1, C.T_WALL_HIDDEN, tilesOpaque, true) |
                        getSurroundingByte(x, y + 1, C.T_WALL_BROKEN, tilesOpaque, true))){
                    opaqueData[index] = C.REND_WALL_TEXTURE;
                    return;
                }
            }
        }

        private function setPitData(roomX:uint, roomY:uint):void{
            var x:uint     = roomX;
            var y:uint     = roomY;
            var width:uint = 0;

            var posX:uint = 0;
            var posY:uint = 0;

            var tileAboveEdge:uint;
            var tileUnderEdge:uint;

            // Retrieve Y position in relation to top-left corner
            tileAboveEdge = tilesOpaque[x + y * S.LEVEL_WIDTH];
            while (y != uint.MAX_VALUE &&
                    (tileAboveEdge == C.T_PIT || tileAboveEdge == C.T_TRAPDOOR)){
                y--;
                tileAboveEdge = tilesOpaque[x + y * S.LEVEL_WIDTH];
            }

            posY = (y == uint.MAX_VALUE ? uint.MAX_VALUE : roomY - y - 1);

            // Retrieve X position in relation to top-left corner
            tileAboveEdge = tilesOpaque[x + y * S.LEVEL_WIDTH];
            tileUnderEdge = tilesOpaque[x + (y + 1) * S.LEVEL_WIDTH];
            while (x != uint.MAX_VALUE &&
                    (y == uint.MAX_VALUE || (tileAboveEdge != C.T_PIT && tileAboveEdge != C.T_TRAPDOOR)) &&
                    (tileUnderEdge == C.T_PIT || tileUnderEdge == C.T_TRAPDOOR)){
                x--;
                tileAboveEdge  = tilesOpaque[x + y * S.LEVEL_WIDTH];
                tileUnderEdge = tilesOpaque[x + (y + 1) * S.LEVEL_WIDTH];

            }

            var leftEdge:uint = x;
            posX = (x == uint.MAX_VALUE ? roomX : roomX - x - 1);

            // Retrieve width of the flat pit chunk
            x = roomX;
            tileAboveEdge  = tilesOpaque[x + y * S.LEVEL_WIDTH]; // Tile above edge
            tileUnderEdge = tilesOpaque[x + (y + 1) * S.LEVEL_WIDTH]; // Tile under edge

            while (x < S.LEVEL_WIDTH &&
                    (y == uint.MAX_VALUE || (tileAboveEdge != C.T_PIT && tileAboveEdge != C.T_TRAPDOOR)) &&
                    (tileUnderEdge == C.T_PIT || tileUnderEdge == C.T_TRAPDOOR)){
                x++;
                tileAboveEdge  = tilesOpaque[x + y * S.LEVEL_WIDTH];
                tileUnderEdge = tilesOpaque[x + (y + 1) * S.LEVEL_WIDTH];
            }

            width = x - leftEdge - 1;

            var data:uint = 0;

            // Touches the top edge, assume it  is not displayed
            if (posY == uint.MAX_VALUE)
                data = 0;

            // Not wide enough to display the wide pit
            else if (width < bdPitside.width / S.LEVEL_TILE_WIDTH &&
                    posY < bdPitsideSmall.height / S.LEVEL_TILE_HEIGHT)
                data = C.REND_PIT_IS_SIDE_SMALL | (posX + posY * C.REND_PIT_COORD_MULTIP);

            // Wide enough to display the wide pit
            else if (posY < bdPitside.height / S.LEVEL_TILE_HEIGHT) {
                // Wide, but the remainder is not wide enough to fit the whole "wide" so use small-pit
                if (width - posX <= width % (bdPitside.width / S.LEVEL_TILE_WIDTH)) {
                    posX = (posX - width + (width % (bdPitside.width / S.LEVEL_TILE_WIDTH)));
                    data = C.REND_PIT_IS_SIDE_SMALL | (posX + posY * C.REND_PIT_COORD_MULTIP);
                } else
                    data = C.REND_PIT_IS_SIDE | (posX + posY * C.REND_PIT_COORD_MULTIP);
            }

            opaqueData[roomX + roomY * S.LEVEL_WIDTH] = data;
        }

        private function setObstacleData(roomX:uint, roomY:uint):void{
            var obstacleType:uint = (tilesTransparentParam[roomX + roomY * S.LEVEL_WIDTH] & (T.OBSTACLE_LEFT - 1));

            ASSERT(obstacleType);

            var index:uint;
            var xPos :uint = 0;
            var yPos :uint = 0;

            // Find obstacle edges:
            var x:uint = roomX;
            var y:uint = roomY;

            while (x > 0){
                if (tilesTransparentParam[x + roomY * S.LEVEL_WIDTH] & T.OBSTACLE_LEFT)  break;
                if (tilesTransparent[x - 1 + roomY * S.LEVEL_WIDTH] != C.T_OBSTACLE)     break;
                if ((tilesTransparentParam[x - 1 + roomY * S.LEVEL_WIDTH] & (T.OBSTACLE_LEFT - 1)) != obstacleType) break;
                xPos++;
                --x;
            }

            if (xPos >= T.OBSTACLE_MAX_SIZE){
                ASSERT(false, "Invalid obstacle x position");
                xPos = 0;
                x = 1;

            } else {
                x = roomX + 1;
                while (x < S.LEVEL_WIDTH){
                    if (tilesTransparentParam[x + roomY * S.LEVEL_WIDTH] & T.OBSTACLE_LEFT)  break;
                    if (tilesTransparent[x + roomY * S.LEVEL_WIDTH] != C.T_OBSTACLE)         break;
                    if ((tilesTransparentParam[x + roomY * S.LEVEL_WIDTH] & (T.OBSTACLE_LEFT - 1)) != obstacleType) break;
                    x++;
                }
                x -= roomX - xPos;
                if (x > T.OBSTACLE_MAX_SIZE)
                    x = T.OBSTACLE_MAX_SIZE;
            }

            ASSERT(xPos < x);

            while (y > 0){
                if (tilesTransparentParam[roomX + y * S.LEVEL_WIDTH] & T.OBSTACLE_TOP)  break;
                if (tilesTransparent[roomX + (y - 1) * S.LEVEL_WIDTH] != C.T_OBSTACLE)     break;
                if ((tilesTransparentParam[roomX + (y - 1) * S.LEVEL_WIDTH] & (T.OBSTACLE_LEFT - 1)) != obstacleType) break;
                yPos++;
                --y;
            }

            if (yPos >= T.OBSTACLE_MAX_SIZE){
                ASSERT(false, "Invalid obstacle y position");
                yPos = 0;
                y = 1;

            } else {
                y = roomY + 1;
                while (y < S.LEVEL_HEIGHT){
                    if (tilesTransparentParam[roomX + y * S.LEVEL_WIDTH] & T.OBSTACLE_TOP)  break;
                    if (tilesTransparent[roomX + y * S.LEVEL_WIDTH] != C.T_OBSTACLE)         break;
                    if ((tilesTransparentParam[roomX + y * S.LEVEL_WIDTH] & (T.OBSTACLE_LEFT - 1)) != obstacleType) break;
                    y++;
                }
                y -= roomY - yPos;
                if (y > T.OBSTACLE_MAX_SIZE)
                    y = T.OBSTACLE_MAX_SIZE;
            }

            ASSERT(yPos < y);

            for (var i:uint = 0; i < T.OBSTACLE_MAX_SIZE; i++){
                index = T.OBSTACLE_INDICES[obstacleType][i];

                if (!index){
                    ASSERT(false, "Invalid obstacle size");
                    index = 0;
                    xPos = 0;
                    yPos = 0;
                    break;
                }

                if (x == T.OBSTACLE_DIMENSIONS[index][0] && y == T.OBSTACLE_DIMENSIONS[index][1])
                    break;
            }

            transparentData[roomX + roomY * S.LEVEL_WIDTH] = T.OBSTACLE_TILES[index][yPos][xPos];
        }

        private function setStairsData(x:uint, y:uint):void{
            var stairs:Point = calculateStairPosition(x, y);

            var lastShadedTile:uint = (stairs.x * 3) - 2;

            var data:uint;

            if      (stairs.y >  lastShadedTile) data = T.TI_STAIRS_5;
            else if (stairs.y == lastShadedTile) data = T.TI_STAIRS_4;
            else if (stairs.y + 1 == lastShadedTile) data = T.TI_STAIRS_3;
            else if (stairs.y + 2 == lastShadedTile) data = T.TI_STAIRS_2;
            else data = T.TI_STAIRS_1;

            opaqueData[x + y * S.LEVEL_WIDTH] = data;
        }

        private function setStairsUpData(x:uint, y:uint):void{
            var stairs:Point = calculateStairUpPosition(x, y);

            var lastShadedTile:uint = (stairs.x * 3) - 2;

            var data:uint = T.TI_STAIRS_UP_1;

            if (stairs.x == 1 && x > 0){
                if (stairs.y == 1) data = T.TI_STAIRS_UP_3;
                if (stairs.y == 2) data = T.TI_STAIRS_UP_2;
            }

            opaqueData[x + y * S.LEVEL_WIDTH] = data;
        }

        private function calculateStairPosition(x:uint, y:uint):Point{
            var stairs:uint = tilesOpaque[x + y * S.LEVEL_WIDTH];

            var tx:uint = 0;
            var ty:uint = 0;

            var prevTile:uint;

            if (x == 0)
                tx = 1;
            else {
                prevTile = stairs;
                while (prevTile == stairs){
                    tx++;
                    prevTile = (x - tx > 0 ? tilesOpaque[x - tx + y * S.LEVEL_WIDTH] : C.T_WALL);
                }
            }

            if (y == 0)
                ty = 1;
            else {
                prevTile = stairs;
                while (prevTile == stairs){
                    ty++;
                    prevTile = (y - ty > 0 ? tilesOpaque[x + (y - ty) * S.LEVEL_WIDTH] : C.T_WALL);
                }
            }

            return new Point(tx, ty);
        }

        private function calculateStairUpPosition(x:uint, y:uint):Point{
            var stairs:uint = tilesOpaque[x + y * S.LEVEL_WIDTH];

            var tx:uint = 0;
            var ty:uint = 0;

            var prevTile:uint;

            if (x == 0)
                tx = 1;
            else {
                prevTile = stairs;
                while (prevTile == stairs){
                    tx++;
                    prevTile = (x - tx > 0 ? tilesOpaque[x - tx + y * S.LEVEL_WIDTH] : C.T_WALL);
                }
            }

            if (y == S.LEVEL_HEIGHT - 1)
                ty = 1;
            else {
                prevTile = stairs;
                while (prevTile == stairs){
                    ty++;
                    prevTile = (y + ty < S.LEVEL_HEIGHT - 1 ? tilesOpaque[x + (y + ty) * S.LEVEL_WIDTH] : C.T_WALL);
                }
            }

            return new Point(tx, ty);
        }
    }
}