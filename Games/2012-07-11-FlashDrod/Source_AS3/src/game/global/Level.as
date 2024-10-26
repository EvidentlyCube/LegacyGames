package game.global {
    import flash.events.MouseEvent;
    import flash.geom.Point;
    import flash.utils.ByteArray;
    import flash.utils.Dictionary;
    import flash.utils.setTimeout;

    import game.managers.VOCoord;
    import game.standalone.HelpMessage;

    import net.retrocade.camel.core.rCore;
    import net.retrocade.camel.core.rGfx;
    import net.retrocade.camel.core.rInput;
    import net.retrocade.camel.core.rSave;
    import net.retrocade.camel.core.rSound;
    import net.retrocade.camel.effects.rEffFadeScreen;
    import net.retrocade.camel.effects.rEffQuake;
    import net.retrocade.camel.effects.rEffVolumeFade;
    import net.retrocade.camel.engines.tilegrid.rTileGrid;
    import net.retrocade.standalone.Bitext;
    import net.retrocade.standalone.Text;
    import net.retrocade.utils.Base64;
    import net.retrocade.vault.Safe;

	/**
     * ...
     * @author
     */
    public class Level {
        private static var hold:XML;

        public static var currentRoom :uint;
        public static var currentLevel:uint;

        private static var variableNames:Array = [];

        public static function restoreTo(roomID:uint, x:uint, y:uint, o:uint):void{
            Game.loadFromRoom(roomID, x, y, o);
        }


        public static function getHoldName():String{
            return Base64.decodeWChar(hold.Holds[0].@NameMessage);
        }

        public static function getHoldTimestamp():Number{
            return parseFloat(hold.Holds[0].@LastUpdated);
        }

        public static function getHold():XML {
            return hold.copy();
        }

        public static function getHoldTag():XML {
            return hold.Holds[0];
        }



        /****************************************************************************************************************/
        /**                                                                                                      LEVEL  */
        /****************************************************************************************************************/

        public static function getLevelByID(levelID:uint):XML{
            return hold.Levels.(@LevelID == levelID)[0];
        }

        /**
         * Counts from 1
         */
        public static function getLevelNthID(orderIndex:uint):uint{
            return hold.Levels.(@OrderIndex == orderIndex)[0].@LevelID;
        }

        public static function getLevelIndex(id:uint):uint {
            return hold.Levels.(@LevelID == id)[0].@GID_LevelIndex;
        }

        public static function getLevelIDByRoom(roomID:uint):uint{
            return getRoom(roomID).@LevelID;
        }

        public static function getLevelName(levelID:uint):String{
            var level:XML = getLevelByID(levelID);

            return Base64.decodeWChar(level.@NameMessage);
        }

        public static function getAllLevels():Array {
            var array:Array = [];

            for each(var level:XML in hold.Levels) {
                array.push(level);
            }

            return array;
        }

        public static function getAllLevelIDs():Array {
            var array:Array = [];

            for each(var level:XML in hold.Levels) {
                array.push(level.@LevelID);
            }

            return array;
        }



        /****************************************************************************************************************/
        /**                                                                                                       ROOM  */
        /****************************************************************************************************************/

        public static function getAllRooms():Array {
            var array:Array = [];

            for each(var room:XML in hold.Rooms) {
                array.push(room);
            }

            return array;
        }

        public static function getRoom(roomID:uint):XML{
            return hold.Rooms.(@RoomID == roomID)[0];
        }

        public static function getRoomByPosition(x:uint, y:uint):XML{
            var room:XMLList = hold.Rooms.(@RoomX == x).(@RoomY == y);

            return (room && room.length() ? room[0] : null);
        }

        public static function getRoomIDByNeighbourID(id:uint, orientation:uint):uint{
            var room:XML = getRoom(id);

            var lvlX:uint = parseInt(room.@RoomX) + F.getOX(orientation);
            var lvlY:uint = parseInt(room.@RoomY) + F.getOY(orientation);

            room = getRoomByPosition(lvlX, lvlY);

            return (room ? room.@RoomID : uint.MAX_VALUE);
        }

        public static function getRoomIDsByLevel(levelID:uint):Array{
            var rooms:Array = [];

            for each(var room:XML in hold.Rooms.(@LevelID == levelID)){
                rooms.push(parseInt(room.@RoomID));
            }

            return (rooms.length ? rooms : null);
        }

        public static function getRoomsByLevel(levelID:uint):Array{
            var rooms:Array = [];

            for each(var room:XML in hold.Rooms.(@LevelID == levelID)){
                rooms.push(room);
            }

            return (rooms.length ? rooms : null);
        }

        public static function getRoomOffsetInLevel(roomID:uint):Point{
            var room   :XML  = getRoom(roomID);
            var levelID:uint = getLevelIDByRoom(roomID);

            var mainEntrance:XML = getEntranceMainByLevelID(levelID);
            var mainRoom:XML = getRoom(mainEntrance.@RoomID);

            var point:Point = new Point();
            point.x = parseInt(room.@RoomX) - parseInt(mainRoom.@RoomX);
            point.y = parseInt(room.@RoomY) - parseInt(mainRoom.@RoomY);

            return point;
        }

        public static function getFirstRoomInHold():XML {
            return getRoom(getFirstHoldEntrance().@RoomID);
        }

        public static function roomHasMonsters(roomID:uint):Boolean {
            var a:* = getRoom(roomID).Monsters;
            return getRoom(roomID).Monsters;
        }

        public static function getAnyVisitedRoomInLevel(levelID:uint):XML {
            for each(var i:XML in hold.Rooms.(@LevelID == levelID)) {
                if (Progress.getRoomEntranceState(i.@RoomID))
                    return i;
            }

            return null;
        }

        public static function getAllSecretRooms():Array {
            var rooms  :Array = getAllRooms();
            var secrets:Array = [];

            for each(var i:XML in rooms) {
                if (i.@IsSecret == 1)
                    secrets.push(i);
            }

            return secrets;
        }




        /****************************************************************************************************************/
        /**                                                                                                      OTHER  */
        /****************************************************************************************************************/

        public static function getEntrance(entranceID:uint):XML{
            return hold.Holds.Entrances.(@EntranceID == entranceID)[0];
        }

        public static function getEntrancesByRoomID(roomID:uint):Array{
            var entrances:Array = [];

            for each (var entrance:XML in hold.Holds.Entrances.(@RoomID == roomID)){
                entrances.push(entrance);
            }

            return entrances;
        }

        public static function getFirstHoldEntrance():XML {
            return hold.*.Entrances.(@IsMainEntrance == 1)[0];
        }

        public static function getVarIDByName(name:String):String{
            return variableNames[name] || "";
        }

        public static function getEntranceMainByLevelID(levelID:uint):XML{
            var rooms:Array = getRoomIDsByLevel(levelID);
            var entrances:Array;

            for each(var roomID:uint in rooms){
                entrances = getEntrancesByRoomID(roomID);

                for each(var entrance:XML in entrances){
                    if (parseInt(entrance.@IsMainEntrance) == 1)
                        return entrance;
                }
            }

            throw new Error("It should never happen - each level has main entrance!");
        }

        public static function getEntranceDescription(entranceID:uint):String{
            return Base64.decodeWChar(getEntrance(entranceID).@DescriptionMessage);
        }

        public static function getSecretRoomsByLevelID(levelID:uint):Array {
            var rooms  :Array = getRoomsByLevel(levelID);
            var secrets:Array = [];

            for each(var i:XML in rooms) {
                if (i.@IsSecret == 1)
                    secrets.push(i);
            }

            return secrets;
        }





        public static function canEnterRoom(roomID:uint, playerX:uint, playerY:uint):Boolean{
            var room:XML = getRoom(roomID);
            var squaresBA:ByteArray;

            var positionOffset:uint = playerX + playerY * S.LEVEL_WIDTH;
            var tile :uint;
            var i    :uint;
            var count:uint;
            var offsetTemp:uint;

            var square:uint;

            squaresBA          = Base64.decodeByteArray(room.@Squares);

            if (squaresBA.readUnsignedByte() != 5)
                throw new ArgumentError("Invalid data format version, should be 5 was: " + squaresBA[0]);

            // CHECKING OPAQUE LAYER
            offsetTemp = 0;
            for(i = 0; i < S.LEVEL_WIDTH * S.LEVEL_HEIGHT; i++){
                if (!count){
                    count = squaresBA.readUnsignedByte();
                    tile  = squaresBA.readUnsignedByte();
                }

                if (offsetTemp++ == positionOffset)
                    square = tile;

                count--;
            }



            switch(square){
                case(C.T_WALL_MASTER):
                    return Progress.isGameMastered;

                case(C.T_WALL): case(C.T_WALL2): case(C.T_WALL_IMAGE):
                case(C.T_PIT): case(C.T_PIT_IMAGE): case(C.T_WATER):
                    return false;
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
            offsetTemp = 0;
            for(i = 0; i <  S.LEVEL_WIDTH * S.LEVEL_HEIGHT; i++){
                if (!count){
                    count = squaresBA.readUnsignedByte();
                    tile  = squaresBA.readUnsignedByte();
                    squaresBA.readUnsignedByte();
                }

                if (offsetTemp++ == positionOffset)
                    square = tile;

                count--;
            }

            switch(square){
                case(C.T_ORB): case(C.T_TAR): case(C.T_MUD): case(C.T_GEL):
                case(C.T_BOMB): case(C.T_FLOW_EDGE): case(C.T_FLOW_INNER):
                case(C.T_FLOW_SOURCE): case (C.T_OBSTACLE):
                    return false;
            }

            for each(var piece:XML in room.descendants("Pieces")){
                if (piece.@X == playerX && piece.@Y == playerY)
                    return false;
            }

            return true;
        }

        public static function prepareHold(holdXML:XML):void{
            var x:XML;

            hold = holdXML;

            // Retrieve data
            for each(x in hold.Data){
                switch(parseInt(x.@DataFormat)){
                    case(40):
                    case(41):
                    case(42):
                        DB.queueSound(x.@DataID, x.@RawData);
                        break;

                    case(1):
                    case(2):
                    case(3):
                        DB.queueImage(x.@DataID, x.@RawData);
                        break;
                }
            }
            delete hold.Data;

            // Retrieve variable names
            for each(x in hold.Vars){
                variableNames[Base64.decodeWChar(x.@VarNameText)] = parseInt(x.@VarID);
            }

            delete hold.Vars;

            // Retrieve Speech
            for each(x in hold.Speech){
                DB.queueSpeech(x.@SpeechID, x);
            }
            delete hold.Speech;

            //trace(hold);
        }
    }
}