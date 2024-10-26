package  {
    import flash.utils.ByteArray;
	/**
     * ...
     * @author Maurycy Zarzycki
     */
    public interface IMainSpider {
        /**
         * Tries to load a hold into the memory
         * @param	hold ByteArray of the hold to be loaded
         * @return True if the operation was successful
         */
        function loadHold(hold:ByteArray):Boolean;

        /**8
         * Retrieves the hold's XML after it has been loaded into the library
         * @return Hold's XML or null.
         */
        function getHoldXML():XML;

        /**
         * Tests if a given demo is valid
         * @param	demo ByteArray of the demo to be tested
         * @return  >0 - If demo ended with player conquering a room and leaving through room edge, script exit
         *         or stairs. Room is set as conqured if CID_ROOM_CONQUER_PENDING event was set and monster
         *         count is 0. The returned variable is the number of moves made.
         *          0 - If demo was not valid
         *         -1 - If demo was not for this hold
         *         -2 - If demo was corrupted/unreadable
         *         -3 - Internal problem
         *         -4 - If data was corrupted/unreadable
         */
        function testDemo(demoData:String):int;

        /**
         * Renders a room of a given ID and returns its BitmapData representation
         * @param	roomID ID of the room to be rendered
         * @return BitmapData on success.
         *          0 - If operation failed
         *         -1 - If room ID was invalid
         *         -3 - Internal problem
         */
        function renderRoom(roomID:uint):*;

        /**
         * Renders a level of a given ID and returns its BitmapData representation
         * @param	levelID ID of the level to be rendered
         * @return BitmapData on success.
         *          0 - If operation failed
         *         -3 - Internal problem
         */
        function renderLevel(levelID:uint):*;

        /**
         * If any errors have occured, this function will return an array of Error instances
         * @return An array of Error instances or an empty array;
         */
        function getErrors():Array;
    }
}