package game.global {
    import flash.debugger.enterDebugger;

    import net.retrocade.camel.core.rSave;

	/**
     * ...
     * @author
     */
    public class Save {
        private static var allVisitedRooms:Array = [];

        private static var exploredRooms  :Array = [];
        private static var conqueredRooms :Array = [];
        private static var packedVars     :PackedVars;

        private static var holdMastered   :Boolean = false;

        /**
         * An array of progress when entering room for the first time
         */
        private static var roomEntranceStates:Array = [];

        private static function saveRoomEntranceState(roomID:uint, x:uint, y:uint, o:uint):void {
            for (var index:uint = 0, l:uint = roomEntranceStates.length; index < l; index++) {
                if (roomEntranceStates[index].playerRoom == roomID)
                    break;
            }

            var data:Object = {};

            data.playerX        = x;
            data.playerY        = y;
            data.playerO        = o;
            data.playerRoom     = roomID;
            data.exploredRooms  = exploredRooms.concat();
            data.conqueredRooms = conqueredRooms.concat();

            if (index == l)
                roomEntranceStates.push(data);
            else
                roomEntranceStates[index] = data;
        }

        private static function exportForSave_Progress():String{
            var data:Object = {};

            data.allVisitedRooms    = allVisitedRooms;
            data.exploredRooms      = exploredRooms;
            data.conqueredRooms     = conqueredRooms;
            data.roomEntranceStates = roomEntranceStates;
            data.holdMastered       = holdMastered;

            return JSON.stringify(data);
        }

        private static function exportForSave_Location():String{
            var data:Object = {};

            data.playerX            = savePlayerX;
            data.playerY            = savePlayerY;
            data.playerO            = savePlayerO;
            data.playerRoom         = savePlayerRoom;

            return JSON.stringify(data);
        }

        private static function importFromSave_Progress(data:Object):void{
            allVisitedRooms    = data.allVisitedRooms;
            exploredRooms      = data.exploredRooms;
            conqueredRooms     = data.conqueredRooms;
            roomEntranceStates = data.roomEntranceStates;
            holdMastered       = data.holdMastered;
        }

        private static function importFromSave_Location(data:Object):void{
            savePlayerX            = data.playerX;
            savePlayerY            = data.playerY;
            savePlayerO            = data.playerO;
            savePlayerRoom         = data.playerRoom;
        }

        public static function resetProgress():void{
            savePlayerX    = uint.MAX_VALUE;
            savePlayerY    = uint.MAX_VALUE;
            savePlayerO    = uint.MAX_VALUE;
            savePlayerRoom = uint.MAX_VALUE;

            allVisitedRooms   .length = 0;
            conqueredRooms    .length = 0;
            exploredRooms     .length = 0;
            roomEntranceStates.length = 0;

            holdMastered = false;

            rSave.save("progress", null);
            rSave.save("currentLocation", null);
        }

        private static function saveProgress(full:Boolean):void{
            if (full)
                rSave.save("progress", exportForSave_Progress());

            rSave.save("currentLocation", exportForSave_Location());

            rSave.flush();
        }

        /**
         * Loads progress from Shared Object, should only be called once on start of the app!
         */
        public static function loadProgress():void {
            var data:String;
            var uncompressed:Object;

            if ((data = rSave.load("progress", null)))
                importFromSave_Progress(JSON.parse(data));

            if ((data = rSave.load("currentLocation", null)))
                importFromSave_Location(JSON.parse(data));
        }





        /****************************************************************************************************************/
        /**                                                                                                SAVING GAME  */
        /****************************************************************************************************************/

        private static var savePlayerX   :uint = uint.MAX_VALUE;
        private static var savePlayerY   :uint = uint.MAX_VALUE;
        private static var savePlayerO   :uint = uint.MAX_VALUE;
        private static var savePlayerRoom:uint = uint.MAX_VALUE;

        private static var forceFullSave :Boolean = false;

        public static function get savedPlayerX   ():uint { return savePlayerX; }
        public static function get savedPlayerY   ():uint { return savePlayerY; }
        public static function get savedPlayerO   ():uint { return savePlayerO; }
        public static function get savedPlayerRoom():uint { return savePlayerRoom; }

        public static function hasSaveGame():Boolean{
            return savePlayerX != uint.MAX_VALUE && savePlayerY != uint.MAX_VALUE &&
                savePlayerO != uint.MAX_VALUE && savePlayerRoom != uint.MAX_VALUE &&
                Level.getRoom(savePlayerRoom);
        }

        public static function hasRestoreProgress():Boolean{
            for each(var i:Object in roomEntranceStates){
                if (Level.getRoom(i.playerRoom))
                    return true;
            }

            return false;
        }

        public static function restoreTo(roomID:uint):void{
            var state:Object = getRoomState(roomID);

            savePlayerX    = state.playerX;
            savePlayerY    = state.playerY;
            savePlayerO    = state.playerO;
            savePlayerRoom = state.playerRoom;

            exploredRooms  = state.exploredRooms.concat();
            conqueredRooms = state.conqueredRooms.concat();
        }

        public static function restoreToStartHold():void{
            savePlayerX = uint.MAX_VALUE;
            savePlayerY = uint.MAX_VALUE;
            savePlayerO = uint.MAX_VALUE;

            exploredRooms  = [];
            conqueredRooms = [];
        }
    }
}