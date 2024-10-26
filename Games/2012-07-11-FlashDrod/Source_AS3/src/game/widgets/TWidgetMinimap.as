package game.widgets{
    import flash.display.BitmapData;
    import flash.geom.Point;
    import flash.utils.ByteArray;
    import net.retrocade.utils.Base64;

    import game.global.Game;
    import game.global.Gfx;
    import game.global.Level;
    import game.global.Progress;
    import game.global.Room;
    import game.managers.VOMinimapRoom;
    import game.managers.progress.VORoomEntryState;
    import game.states.TStateGame;

    import net.retrocade.utils.UBitmapData;
    import net.retrocade.utils.UDisplay;

    public class TWidgetMinimap {
        public static const MODE_IN_GAME:uint = 0;
        public static const MODE_RESTORE:uint = 1;

        private static var roomImages:Array = [];

        private static var lastRoom:uint;
        private static var lastX   :uint;
        private static var lastY   :uint;

        private static const x     :Array = [14,  0];
        private static const y     :Array = [448, 0];
        private static const width :Array = [130, 200];
        private static const height:Array = [138, 200];

        private static const centerX:Array = [
            x[0] + (width[0] - S.LEVEL_WIDTH)  / 2 | 0,
            x[1] + (width[1] - S.LEVEL_WIDTH)  / 2 | 0
        ];
        private static const centerY:Array = [
            y[0] + (height[0] - S.LEVEL_HEIGHT) / 2 | 0,
            y[1] + (height[1] - S.LEVEL_HEIGHT) / 2 | 0
        ];

        public static function changedLevel(newLevelID:uint):void{
            roomImages = [];

            var rooms:Array = Progress.getExploredRoomsByLevel(newLevelID);

            var roomData:VOMinimapRoom;
            for each(var room:XML in rooms){
                if (Progress.isRoomExplored(room.@RoomID)){
                    roomData = new VOMinimapRoom();
                    roomData.data = room;
                    roomData.bitmapData = new BitmapData(S.LEVEL_WIDTH, S.LEVEL_HEIGHT, false);
                    roomData.completed = Progress.isRoomConquered(room.@RoomID);
                    roomImages[room.@RoomID.toString()] = roomData;
                }
            }

            redrawAllRooms();
        }

        public static function addRoom(roomID:uint):void{
            if (roomImages[roomID])
                return;

            var roomData:VOMinimapRoom = new VOMinimapRoom();
            roomData.data = Level.getRoom(roomID);
            roomData.bitmapData = new BitmapData(S.LEVEL_WIDTH, S.LEVEL_HEIGHT, false);
            roomData.completed  = Progress.isRoomConquered(roomID);
            roomImages[roomID] = roomData;

            drawRoom(roomData, false);
        }

        public static function plotWidget(roomID:uint, mode:uint, drawTo:BitmapData = null):void{
            drawTo = drawTo || Game.room.layerUnder.bitmapData;

            drawTo.lock();

            clearUnder(drawTo, mode);

            var currentRoom:XML = Level.getRoom(roomID);

            var currentX:uint = parseInt(currentRoom.@RoomX);
            var currentY:uint = parseInt(currentRoom.@RoomY);

            for each (var room:VOMinimapRoom in roomImages){
                plotRoomImage(room, currentX, currentY, mode, drawTo);
            }

            lastRoom = roomID;
            lastX    = currentX;
            lastY    = currentY;

            // Evil orange border of doom
            UBitmapData.blitRectangle(drawTo, centerX[mode] - 2, centerY[mode] - 2, S.LEVEL_WIDTH + 4, 2, 0xFFFF8800)
            UBitmapData.blitRectangle(drawTo, centerX[mode] - 2, centerY[mode] + S.LEVEL_HEIGHT, S.LEVEL_WIDTH + 4, 2, 0xFFFF8800);
            UBitmapData.blitRectangle(drawTo, centerX[mode] - 2, centerY[mode], 2, S.LEVEL_HEIGHT, 0xFFFF8800);
            UBitmapData.blitRectangle(drawTo, centerX[mode] + S.LEVEL_WIDTH, centerY[mode], 2, S.LEVEL_HEIGHT, 0xFFFF8800);

            drawTo.unlock();
        }

        public static function updateRoomState(roomID:uint, isConquerPending:Boolean):void {
            if (!roomImages[roomID])
                return;

            ASSERT(roomImages[roomID]);

            roomImages[roomID].completed = Progress.isRoomConquered(roomID);

            drawRoom(roomImages[roomID], isConquerPending);
        }

        private static function plotRoomImage(room:VOMinimapRoom, currentX:int, currentY:int, mode:uint, drawTo:BitmapData):void{
            var offX:int = parseInt(room.data.@RoomX) - currentX;
            var offY:int = parseInt(room.data.@RoomY) - currentY;

            offX = centerX[mode] + offX * S.LEVEL_WIDTH;
            offY = centerY[mode] + offY * S.LEVEL_HEIGHT;

            var sourceX     :uint = 0;
            var sourceY     :uint = 0;
            var sourceWidth :uint = S.LEVEL_WIDTH;
            var sourceHeight:uint = S.LEVEL_HEIGHT;

            if (offX < x[mode]){
                sourceX = (x[mode] - offX);
                sourceWidth -= sourceX;
                offX = x[mode];

            } else if (offX + sourceWidth >= x[mode] + width[mode]){
                sourceWidth -= sourceWidth + offX - x[mode] - width[mode];
            }

            if (offY < y[mode]){
                sourceY = (y[mode] - offY);
                sourceHeight -= sourceY;
                offY = y[mode];

            } else if (offY + sourceHeight >= y[mode] + height[mode]){
                sourceHeight -= sourceHeight + offY - y[mode] - height[mode];
            }

            if (sourceWidth > S.LEVEL_WIDTH || sourceHeight > S.LEVEL_HEIGHT ||
                sourceX > width[mode] || sourceY > height[mode])
                return;

            UBitmapData.blitPart(room.bitmapData, drawTo, offX, offY, sourceX, sourceY, sourceWidth, sourceHeight);
        }

        private static function clearUnder(drawTo:BitmapData, size:uint):void {
            if (size == MODE_IN_GAME)
                UBitmapData.blitPart(Gfx.IN_GAME_SCREEN, drawTo,
                    x[size], y[size], x[size], y[size], width[size], height[size]);
            else
                UBitmapData.blitRectangle(drawTo, x[size], y[size], width[size], height[size], 0);
        }

        private static function redrawAllRooms():void{
            for each(var i:VOMinimapRoom in roomImages){
                drawRoom(i, false);
            }
        }

        private static function drawRoom(room:VOMinimapRoom, isExitPending:Boolean = false):void {
            var isRoomDarkened :Boolean = !room.wasVisited;
            var isRoomRequired :Boolean = room.data.@IsRequired.toString() == "1";
            var isRoomCompleted:Boolean = room.completed;
            var isRoomSecret   :Boolean = (room.data.@IsSecret == 1);

            var squaresBA:ByteArray;

            var tile :uint;
            var i    :uint;
            var count:uint;

            var square:uint;

            squaresBA = Base64.decodeByteArray(room.data.@Squares);

            if (squaresBA.readUnsignedByte() != 5)
                throw new ArgumentError("Invalid data format version, should be 5 was: " + squaresBA[0]);

            // CHECKING OPAQUE LAYER
            for(i = 0; i < S.LEVEL_TOTAL; i++){
                if (!count){
                    count = squaresBA.readUnsignedByte();
                    tile  = squaresBA.readUnsignedByte();
                }

                switch(tile){
                    case(C.T_WALL): case(C.T_WALL2): case(C.T_WALL_BROKEN): case(C.T_WALL_HIDDEN):
                        plot(i, isRoomDarkened ? 0x004040 : 0);
                        break;
                    case(C.T_STAIRS):  plot(i, 0xD2D264); break;
                    case(C.T_DOOR_Y):  plot(i, 0xFFFF00); break;
                    case(C.T_DOOR_YO): plot(i, 0xFFFFA4); break;
                    case(C.T_DOOR_B):  plot(i, 0x444444); break;
                    case(C.T_DOOR_BO): plot(i, 0xC8C8C8); break;
                    case(C.T_DOOR_G):
                        plot(i, isRoomDarkened ? 0xB8B8B8 : 0x00FF00);
                        break;
                    case(C.T_DOOR_GO):
                        plot(i, isRoomDarkened ? 0xB8B8B8 : 0x80FF80);
                        break;
                    case(C.T_DOOR_C):
                        plot(i, isRoomDarkened ? 0xB8B8B8 : 0x00FFFF);
                        break;
                    case(C.T_DOOR_CO):
                        plot(i, isRoomDarkened ? 0xB8B8B8 : 0xA4FFFF);
                        break;
                    case(C.T_TRAPDOOR): plot(i, 0xFF8080); break;
                    case(C.T_DOOR_R):   plot(i, 0xFF0000); break;
                    case(C.T_DOOR_RO):  plot(i, 0xFF4040); break;
                    case(C.T_PIT):      plot(i, 0x000080); break;
                    default:
                        if (isRoomDarkened){
                            plot(i, 0x664646);
                        } else if (isRoomCompleted){
                            plot(i, 0xE5E5E5);
                        } else if (isExitPending){
                            plot(i, 0x80FF80);
                        } else if (isRoomRequired){
                            plot(i, 0xFF0000);
                        } else
                            plot(i, 0xFF00FF);
                }

                count--;
            }

            // SKIPPING FLOOR LAYER
            for(i = 0; i < S.LEVEL_WIDTH * S.LEVEL_HEIGHT; i++){
                if (!count){
                    count = squaresBA.readUnsignedByte();
                    tile  = squaresBA.readUnsignedByte();
                }

                count--;
            }

            // Transparent Layer with Parameter (ignored)
            for(i = 0; i <  S.LEVEL_WIDTH * S.LEVEL_HEIGHT; i++){
                if (!count){
                    count = squaresBA.readUnsignedByte();
                    tile  = squaresBA.readUnsignedByte();
                    squaresBA.readUnsignedByte();
                }

                switch(tile){
                    case(C.T_OBSTACLE):
                        plot(i, 0x808080);
                        break;
                    case(C.T_TAR):
                        plot(i, 0x0000C0);
                        break;
                }
                count--;
            }

            function plot(index:uint, color:uint):void {
                room.bitmapData.setPixel(index % S.LEVEL_WIDTH, index / S.LEVEL_WIDTH | 0, color);
            }
        }


        CF::lib
        public static function drawLevel(levelID:uint):BitmapData {
            var rooms:Array = Level.getRoomsByLevel(levelID);

            var minX:int = 0, maxX:int = 0;
            var minY:int = 0, maxY:int = 0;
            var roomX:int, roomY:int;
            var pos:Point;

            var i:XML;

            for each(i in rooms) {
                pos =  Level.getRoomOffsetInLevel(i.@RoomID);

                minX = Math.min(minX, pos.x);
                maxX = Math.max(maxX, pos.x + 1);
                minY = Math.min(minY, pos.y);
                maxY = Math.max(maxY, pos.y + 1);
            }

            var bd:BitmapData = new BitmapData((maxX - minX) * S.LEVEL_WIDTH, (maxY - minY) * S.LEVEL_HEIGHT, false, 0xFF663333);

            for each(i in rooms) {
                pos = Level.getRoomOffsetInLevel(i.@RoomID);

                var room:VOMinimapRoom = new VOMinimapRoom();
                room.bitmapData = new BitmapData(S.LEVEL_WIDTH, S.LEVEL_HEIGHT, false, 0xFF663333);
                room.completed  = true;
                room.data       = i;
                room.wasVisited = true;

                roomX = (pos.x - minX) * S.LEVEL_WIDTH;
                roomY = (pos.y - minY) * S.LEVEL_HEIGHT;


                drawRoomForLevel(room, bd, roomX, roomY);
            }

            return bd;
        }

        CF::lib
        private static function drawRoomForLevel(room:VOMinimapRoom, bitmapData:BitmapData, x:uint, y:uint):void {
            drawRoom(room, false);

            UBitmapData.blit(room.bitmapData, bitmapData, x, y);

            room.bitmapData.dispose();
        }

        /****************************************************************************************************************/
        /**                                                                                             RESTORE SCREEN  */
        /****************************************************************************************************************/

        public static function setRestoreScreenRoom(roomID:uint):void {
            var roomState:VORoomEntryState = Progress.getRoomEntranceState(roomID);

            if (roomState == null)
                return;

            var conquered  :Array = roomState.conqueredRoomIDs.concat();
            var explored   :Array = roomState.exploredRoomIDs .concat();

            var levelID  :uint  = Level.getLevelIDByRoom(roomID);
            var rooms    : Array = Level.getRoomsByLevel(levelID);

            var roomID  :uint;
            var roomData:VOMinimapRoom;
            roomImages.length = 0;

            for each (var room:XML in rooms) {
                roomID = room.@RoomID;

                if (Progress.wasRoomEverVisited(roomID)){
                    roomData = new VOMinimapRoom();
                    roomData.data       = room;
                    roomData.bitmapData = new BitmapData(S.LEVEL_WIDTH, S.LEVEL_HEIGHT);
                    roomData.wasVisited = explored.indexOf(roomID) != -1 || roomState.roomID == roomID;
                    roomData.completed  = (conquered.indexOf(roomID) != -1 ||
                        roomData.wasVisited == false ||
                        !Level.roomHasMonsters(roomID));

                    roomImages.push(roomData);

                    drawRoom(roomData, false);
                }
            }
        }

        public static function getRoomOnClick(mouseX:int, mouseY:int, mode:uint):XML {
            if (mouseX <  x[mode]               ||
                mouseY <  y[mode]               ||
                mouseX >= x[mode] + width[mode] ||
                mouseY >= y[mode] + height[mode])
                return null;

            mouseX = Math.floor((mouseX - centerX[mode]) / S.LEVEL_WIDTH);
            mouseY = Math.floor((mouseY - centerY[mode]) / S.LEVEL_HEIGHT);


            return Level.getRoomByPosition(lastX + mouseX, lastY + mouseY);
        }
    }
}