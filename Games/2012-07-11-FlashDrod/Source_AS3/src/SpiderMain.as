package{
    import flash.display.BitmapData;
    import flash.display.MovieClip;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.geom.Point;
    import flash.utils.ByteArray;
    import game.global.Commands;
	import game.global.Core;
    import game.global.CueEvents;
    import game.global.Game;
    import game.global.Level;
    import game.global.Room;
    import game.managers.VODemoRecord;
    import game.widgets.TWidgetMinimap;
    import net.retrocade.camel.core.rCore;
    import net.retrocade.utils.Base64;


    CF::lib
    public class SpiderMain extends MovieClip implements IMainSpider {
        public static var noGfx:Boolean;

        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Layers
        // ::::::::::::::::::::::::::::::::::::::::::::::

        private var _errors:Array = [];

        public function SpiderMain():void {
            if (stage)
                init();
            else
                addEventListener(Event.ADDED_TO_STAGE, init);
        }

        private function init(e:Event = null):void{
            removeEventListener(Event.ADDED_TO_STAGE, init);

            rCore.init(stage, this, S);
        }

        /**
         * Tries to load a hold into the memory
         * @param	hold ByteArray of the hold to be loaded
         * @return True if the operation was successful
         */
        public function loadHold(hold:ByteArray):Boolean {
            try {
                Core.unpackHold(hold);

            } catch (e:Error) {
                _errors.push(e);
                return false;
            }

            return true;
        }

        /**
         * Retrieves the hold's XML after it has been loaded into the library
         * @return Hold's XML or null.
         */
        public function getHoldXML():XML {
            return Level.getHold();
        }

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
        public function testDemo(demoData:String):int {
            noGfx = true;

            try {
                var demo:VODemoRecord = new VODemoRecord(roomID, demoData);

            } catch (e:*) {
                _errors.push(e);
                return -4;
            }

            var roomID:uint = demo.roomID;
            var px    :uint = demo.startX;
            var py    :uint = demo.startY;
            var po    :uint = demo.startO;

            try {
                trace(roomID, px, py, po);
                Game.loadFromRoom(roomID, px, py, po);

            } catch (e:*) {
                _errors.push(e);
                return -1;
            }

            try {
                Commands.loadBuffer(demo.demoBuffer);

            } catch (e:*) {
                _errors.push(e);
                return -2;
            }

            var roomConquered:Boolean = false;
            var roomExited   :Boolean = false;

            var ii:uint = 0;

            try {
                Commands.freeze();

                var nextMove:uint = Commands.getFirst();

                do {
                    if (F.isComplexCommand(nextMove))
                        Game.processCommand(nextMove, Commands.getComplexX(), Commands.getComplexY());
                    else
                        Game.processCommand(nextMove);

                    if (CueEvents.hasAnyOccured(C.CIDA_PLAYER_DIED))
                        return 0;

                    roomConquered = roomConquered || CueEvents.hasOccured(C.CID_ROOM_CONQUER_PENDING);
                    roomExited    = roomExited    || CueEvents.hasOccured(C.CID_EXIT_ROOM);

                    if (roomExited) {
                        if (roomConquered && Game.room.monsterCount == 0)
                            return Game.turnNo;
                        else
                            return 0;
                    }

                    nextMove = Commands.getNext();

                } while (nextMove != uint.MAX_VALUE);
            } catch (e:*) {
                _errors.push(e);

                return -3;
            }

            return 0;
        }

        /**
         * Renders a room of a given ID and returns its BitmapData representation
         * @param	roomID ID of the room to be rendered
         * @return BitmapData on success.
         *          0 - If operation failed
         *         -1 - If room ID was invalid
         *         -3 - Internal problem
         */
        public function renderRoom(roomID:uint):*{
            noGfx = false;

            var room:Room = new Room();

            try{
                room.loadRoom(roomID);
            } catch (e:*) {
                _errors.push(e);
                return -1;
            }

            try{
                room.drawRoom();

                room.monsters.update();

                var newBD:BitmapData = new BitmapData(S.LEVEL_WIDTH_PIXELS, S.LEVEL_HEIGHT_PIXELS);
                newBD.copyPixels(room.layerUnder.bitmapData, room.layerUnder.bitmapData.rect,
                    new Point(-S.LEVEL_OFFSET_X, -S.LEVEL_OFFSET_Y), null, null, false);
                newBD.copyPixels(room.layerActive.bitmapData, room.layerActive.bitmapData.rect,
                    new Point(), null, null, true);

                room.clear();

            } catch (e:*) {
                _errors.push(e);
                return -3;
            }

            return newBD;
        }

        /**
         * Renders a level of a given ID and returns its BitmapData representation
         * @param	levelID ID of the level to be rendered
         * @return BitmapData on success.
         *          0 - If operation failed
         *         -3 - Internal problem
         */
        public function renderLevel(levelID:uint):*{
            try {
                var bd:BitmapData = TWidgetMinimap.drawLevel(levelID);

            } catch (e:*) {
                _errors.push(e);
                return -3;
            }

            return bd;
        }

        /**
         * If any errors have occured, this function will return an array of Error instances
         * @return An array of Error instances or an empty array;
         */
        public function getErrors():Array {
            var errors:Array = _errors;

            _errors = [];

            return errors;
        }
    }
}