package game.managers.progress {
    import game.managers.VODemoRecord;
    import net.retrocade.utils.UByteArray;

    import flash.utils.ByteArray;

    import game.global.Level;
    import game.global.PackedVars;

    import net.retrocade.utils.Base64;
    import net.retrocade.utils.USecure;

	/**
     * ...
     * @author
     */
    public class VORoomEntryState {
        public var x     :uint;
        public var y     :uint;
        public var o     :uint;
        public var roomID:uint;

        public var gameVars        :PackedVars;
        public var exploredRoomIDs :Array;
        public var conqueredRoomIDs:Array;
        public var endedScripts :Array;

        public function VORoomEntryState(isClone:Boolean = false) {
            if (!isClone){
                x                = uint.MAX_VALUE;
                y                = uint.MAX_VALUE;
                o                = uint.MAX_VALUE;
                roomID           = uint.MAX_VALUE;

                gameVars         = new PackedVars;
                exploredRoomIDs  = [];
                conqueredRoomIDs = [];
                endedScripts     = [];
            }
        }



        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Actions
        // ::::::::::::::::::::::::::::::::::::::::::::::

        public function serialize():String {
            // FORMAT:
            // BYTE(x) . BYTE(y) . BYTE(o) . UINT(roomID) .
            // UINT(gameVars.length) . BYTE_ARRAY(gameVars) .
            // UTF_STRING(exploredRoomIDs) . UTF_STRING(completedRoomIDs) .
            // UTF_STRING(finishedScripts)

            var b:ByteArray = new ByteArray();

            b.writeByte(x);
            b.writeByte(y);
            b.writeByte(o);
            b.writeUnsignedInt(roomID);

            var vars:ByteArray = gameVars.pack();

            b.writeUnsignedInt(vars.length);
            b.writeBytes(vars);

            b.writeUTF(JSON.stringify(exploredRoomIDs));
            b.writeUTF(JSON.stringify(conqueredRoomIDs));
            b.writeUTF(JSON.stringify(endedScripts));

            b.position = 0;

            return Base64.encodeByteArray(b);
        }

        public function unserialize(data:ByteArray):void {
            x      = data.readByte();
            y      = data.readByte();
            o      = data.readByte();
            roomID = data.readUnsignedInt();

            var varsLength:uint      = data.readUnsignedInt();
            var ba        :ByteArray = new ByteArray();

            data    .readBytes(ba, 0, varsLength);
            gameVars.unpack   (ba);

            var json:String;

            json             = data.readUTF();
            exploredRoomIDs  = JSON.parse(json) as Array;

            json             = data.readUTF();
            conqueredRoomIDs = JSON.parse(json) as Array;

            json             = data.readUTF();
            endedScripts     = JSON.parse(json) as Array;

            if (endedScripts == null) {
                throw new Error("Invalid save");
            }
        }

        public function clear():void{
            x      = uint.MAX_VALUE;
            y      = uint.MAX_VALUE;
            o      = uint.MAX_VALUE;
            roomID = uint.MAX_VALUE;

            gameVars.clear();
            exploredRoomIDs .length = 0;
            conqueredRoomIDs.length = 0;
            endedScripts    .length = 0;
        }

        public function setFrom(state:VORoomEntryState):void{
            x                = state.x;
            y                = state.y;
            o                = state.o;
            roomID           = state.roomID;

            exploredRoomIDs  = state.exploredRoomIDs .concat();
            conqueredRoomIDs = state.conqueredRoomIDs.concat();
            endedScripts     = state.endedScripts    .concat();
            gameVars         = state.gameVars        .clone ();
        }

        public function setFromDemo(demo:VODemoRecord):void {
            x = demo.startX;
            y = demo.startY;
            o = demo.startO;
            roomID = demo.roomID;

            endedScripts = demo.endedScripts.concat();
            gameVars     = demo.gameVars    .clone();
        }


        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Checkers
        // ::::::::::::::::::::::::::::::::::::::::::::::

        public function hasSaveGame():Boolean{
            return (
                x      != uint.MAX_VALUE &&
                y      != uint.MAX_VALUE &&
                o      != uint.MAX_VALUE &&
                roomID != uint.MAX_VALUE &&
                Level.getRoom(roomID));
        }





        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Setters
        // ::::::::::::::::::::::::::::::::::::::::::::::

        /**
         * Returns true if full save should be forced
         */
        public function setRoomExplored(id:uint, isExplored:Boolean):Boolean {
            var index:int = exploredRoomIDs.indexOf(id);

            if (index == -1 && isExplored) {
                exploredRoomIDs.push(id);
                return true;

            } else if (index != -1 && !isExplored) {
                delete exploredRoomIDs[index];
                return true;
            }

            return false;
        }

        /**
         * Returns true if full save should be forced
         */
        public function setRoomConquered(id:uint, isConquered:Boolean):Boolean {
            var index:int = conqueredRoomIDs.indexOf(id);

            if (index == -1 && isConquered) {
                conqueredRoomIDs.push(id);
                return true;

            } else if (index != -1 && !isConquered) {
                delete conqueredRoomIDs[index];
                return true;
            }

            return false;
        }

        /**
         * Returns true if full save should be forced
         */
        public function setScriptEnded(id:uint, isEnded:Boolean):Boolean {
            var index:int = endedScripts.indexOf(id);

            if (index == -1 && isEnded) {
                endedScripts.push(id);
                return true;

            } else if (index != -1 && !isEnded) {
                delete endedScripts[index];
                return true;
            }

            return false;
        }




        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Getters
        // ::::::::::::::::::::::::::::::::::::::::::::::

        public function isLevelCompleted(id:uint):Boolean {
            var rooms:Array = Level.getRoomsByLevel(id);

            if (!rooms)
                throw new Error("Level has no Rooms");

            for each(var room:XML in rooms){
                if (room.@IsRequired == 1 && !isRoomConquered(room.@RoomID))
                    return false;
            }

            return true;
        }

        public function isLevelVisited(id:uint):Boolean {
            var rooms:Array = Level.getRoomIDsByLevel(id);

            if (!rooms)
                throw new Error("Level has no Rooms");

            for each(var room:uint in rooms){
                if (isRoomExplored(room))
                    return true;
            }

            return false;
        }

        public function isRoomConquered(id:uint):Boolean {
            return conqueredRoomIDs.indexOf(id) !== -1;
        }

        public function isRoomExplored(id:uint):Boolean {
            return exploredRoomIDs.indexOf(id) !== -1;
        }

        public function isScriptEnded(id:uint):Boolean{
            return endedScripts.indexOf(id) !== -1;
        }




        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Retrievers
        // ::::::::::::::::::::::::::::::::::::::::::::::

        public function getExploredRoomsByLevel(levelID:uint):Array {
            var results:Array = [];

            var rooms:Array = Level.getRoomsByLevel(levelID);

            for each(var room:XML in rooms){
                if (isRoomExplored(room.@RoomID))
                    results.push(room);
            }

            return results;
        }

        public function clone():VORoomEntryState {
            var c:VORoomEntryState = new VORoomEntryState(true);
            c.x      = x;
            c.y      = y;
            c.o      = o;
            c.roomID = roomID;

            c.gameVars         = gameVars.clone();
            c.exploredRoomIDs  = exploredRoomIDs.concat();
            c.conqueredRoomIDs = conqueredRoomIDs.concat();
            c.endedScripts     = endedScripts.concat();

            return c;
        }
    }
}