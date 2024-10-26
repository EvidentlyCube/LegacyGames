package game.global {
    import game.managers.VODemoRecord;

    import flash.utils.ByteArray;

    import game.managers.progress.VORoomEntryState;

    import net.retrocade.camel.core.rSave;
    import net.retrocade.utils.Base64;
    import net.retrocade.utils.USecure;

	/**
     * ...
     * @author
     */
    CF::play
    public class Progress {

        private static const SAVE_GLOBAL_STATES_NAME   :String = "_22_8x4";
        private static const SAVE_GLOBAL_VISITED_NAME  :String = "2_xc022";
        private static const SAVE_GLOBAL_CONQUERED_NAME:String = "48_11_c";
        private static const SAVE_GLOBAL_STATS_NAME    :String = "2x3_21_";
        private static const SAVE_GLOBAL_DEMOS_NAME    :String = "_x_2c31";
        private static const SAVE_GAME_COMPLETED_NAME  :String = "28_cx_2";
        private static const SAVE_GAME_MASTERED_NAME   :String = "_x82_c8";
        private static const SAVE_LOCAL_NAME           :String = "84_0__x";

        private static const SAVE_GLOBAL_STATES_SCRAMBLE   :uint = 23423;
        private static const SAVE_GLOBAL_VISITED_SCRAMBLE  :uint = 97237423;
        private static const SAVE_GLOBAL_CONQUERED_SCRAMBLE:uint = 1669;
        private static const SAVE_GLOBAL_STATS_SCRAMBLE    :uint = 3483742;
        private static const SAVE_GLOBAL_DEMOS_SCRAMBLE    :uint = 62;
        private static const SAVE_GAME_COMPLETED_SCRAMBLE  :uint = 498;
        private static const SAVE_GAME_MASTERED_SCRAMBLE   :uint = 185937461;
        private static const SAVE_LOCAL_SCRAMBLE           :uint = 884934;



        /****************************************************************************************************************/
        /**                                                                                                  VARIABLES  */
        /****************************************************************************************************************/

        /**
         * Whether to save everything, should be true whenever a new
         * room is explored or completed
         */
        private static var _forceFullSave  :Boolean = false;




        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Is game completed?
        // ::::::::::::::::::::::::::::::::::::::::::::::

        /**
         * Whether the game has been already completed at least once
         */
        private static var _isGameCompleted:Boolean = false;

        public static function get isGameCompleted():Boolean {
            return _isGameCompleted;
        }

        public static function set isGameCompleted(isCompleted:Boolean):void {
            if (isCompleted != _isGameCompleted) {
                _isGameCompleted = isCompleted;
                saveProgress_gameCompleted();
            }
        }



        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Is game mastered
        // ::::::::::::::::::::::::::::::::::::::::::::::

        private static var _isGameMastered:Boolean = false;

        public static function get isGameMastered():Boolean {
            return _isGameMastered;
        }

        public static function set isGameMastered(value:Boolean):void {
            if (_isGameMastered != value) {
                _isGameMastered = value;
                saveProgress_gameCompleted();
            }
        }



        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Global to the whole game playthrough
        // ::::::::::::::::::::::::::::::::::::::::::::::

        /**
         * Contains all rooms that were ever visited in all plays
         */
        private static var _allEverVisitedRoomIDs:Array = [];

        /**
         * Contains all rooms that were ever conquered in all plays
         */
        private static var _allEverConqueredRoomIDs:Array = [];

        /**
         * Contains information about game progress for each first room visit
         */
        private static var _roomEntranceStates:Array = [];

        /**
         * An array of room demos data
         */
        private static var _roomDemosData:Array = [];



        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Local to current playthrough
        // ::::::::::::::::::::::::::::::::::::::::::::::

        /**
         * State of current playthruogh
         */
        private static var _currentState:VORoomEntryState = new VORoomEntryState();

        // Static Constructor
        {loadFromDisk()}


        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Miscellanous
        // ::::::::::::::::::::::::::::::::::::::::::::::

        public static var levelStats:PackedVars = new PackedVars();



        /****************************************************************************************************************/
        /**                                                                                             SAVING TO DISK  */
        /****************************************************************************************************************/

        private static function saveProgress(fullSave:Boolean):void {
            if (fullSave)
                saveProgress_global();

            saveProgress_local();
            saveProgress_stats();

            rSave.flush(C.SETTINGS_SAVE_SIZE);
        }

        private static function saveProgress_gameCompleted():void {
            // Game Completed

            var buffer:ByteArray = new ByteArray();
            buffer.writeUTF((_isGameCompleted ? "zaiste" : "roznegatywizowano"));
            buffer.compress();

            USecure.scrambleByteArray(buffer, SAVE_GAME_COMPLETED_SCRAMBLE);

            var save:String = Base64.encodeByteArray(buffer);

            rSave.save(SAVE_GAME_COMPLETED_NAME, save);
            rSave.flush(C.SETTINGS_SAVE_SIZE);

            ''
            // Game Mastered

            buffer = new ByteArray();
            buffer.writeUTF((_isGameCompleted ? "calkowicie" : "niedokonca"));
            buffer.compress();

            USecure.scrambleByteArray(buffer, SAVE_GAME_MASTERED_SCRAMBLE);

            save = Base64.encodeByteArray(buffer);

            rSave.save(SAVE_GAME_MASTERED_NAME, save);
            rSave.flush(C.SETTINGS_SAVE_SIZE);
        }

        private static function saveProgress_global():void {
            // STATES

            var states:Array = [];

            for each(var state:VORoomEntryState in _roomEntranceStates) {
                states.push(state.serialize());
            }

            var save:String = JSON.stringify(states);

            var ba:ByteArray = new ByteArray;
            ba.writeUTFBytes(save);
            ba.compress();

            save = Base64.encodeByteArray(ba);
            save = USecure.scrambleString(save, SAVE_GLOBAL_STATES_SCRAMBLE);

            rSave.save(SAVE_GLOBAL_STATES_NAME, save);


            // VISITED

            save = JSON.stringify(_allEverVisitedRoomIDs);

            ba.position  = ba.length = 0;
            ba.writeUTFBytes(save);
            ba.compress();

            save = Base64.encodeByteArray(ba);
            save = USecure.scrambleString(save, SAVE_GLOBAL_VISITED_SCRAMBLE);

            rSave.save(SAVE_GLOBAL_VISITED_NAME, save);


            // CONQUERED

            save = JSON.stringify(_allEverConqueredRoomIDs);

            ba.position  = ba.length = 0;
            ba.writeUTFBytes(save);
            ba.compress();

            save = Base64.encodeByteArray(ba);
            save = USecure.scrambleString(save, SAVE_GLOBAL_CONQUERED_SCRAMBLE);

            rSave.save(SAVE_GLOBAL_CONQUERED_NAME, save);


            // DEMOS

            var demos:Array = [];

            for each(var i:VODemoRecord in _roomDemosData) {
                demos.push(i.save());
            }

            save = JSON.stringify(demos);

            ba.position = ba.length = 0;
            ba.writeUTF(save);
            ba.compress();

            save = Base64.encodeByteArray(ba);
            save = USecure.scrambleString(save, SAVE_GLOBAL_DEMOS_SCRAMBLE);

            rSave.save(SAVE_GLOBAL_DEMOS_NAME, save);
        }

        private static function saveProgress_local():void {
            var save:String = JSON.stringify(_currentState.serialize());

            var ba:ByteArray = new ByteArray;
            ba.writeUTFBytes(save);
            ba.compress();

            save = Base64.encodeByteArray(ba);
            save = USecure.scrambleString(save, SAVE_LOCAL_SCRAMBLE);

            rSave.save(SAVE_LOCAL_NAME, save);
        }

        private static function saveProgress_stats():void {
            var buffer:ByteArray = levelStats.pack();
            buffer.compress();

            var save:String = Base64.encodeByteArray(buffer);
            save = USecure.scrambleString(save, SAVE_GLOBAL_STATS_SCRAMBLE);

            rSave.save(SAVE_GLOBAL_STATS_NAME, save);
        }

        private static function loadFromDisk():void{
            // Reset state if there is an error!
            try
            {

                var save:String;
                var ba  :ByteArray;

                save = rSave.load(SAVE_LOCAL_NAME, null);

                if (save){
                    save = USecure.unscrambleString(save, SAVE_LOCAL_SCRAMBLE);

                    ba = Base64.decodeByteArray(save);
                    ba.uncompress();
                    ba.position = 0;

                    _currentState.unserialize(Base64.decodeByteArrayByteArray(ba));
                }


                // Conquered

                save = rSave.load(SAVE_GLOBAL_CONQUERED_NAME, null);

                if (save){
                    save = USecure.unscrambleString(save, SAVE_GLOBAL_CONQUERED_SCRAMBLE);

                    ba = Base64.decodeByteArray(save);
                    ba.uncompress();
                    ba.position = 0;

                    save = ba.readUTFBytes(ba.length);

                    _allEverConqueredRoomIDs = JSON.parse(save) as Array;
                } else
                    _allEverConqueredRoomIDs = [];


                // Visited

                save = rSave.load(SAVE_GLOBAL_VISITED_NAME, null);

                if (save){
                    save = USecure.unscrambleString(save, SAVE_GLOBAL_VISITED_SCRAMBLE);

                    ba = Base64.decodeByteArray(save);
                    ba.uncompress();
                    ba.position = 0;

                    save = ba.readUTFBytes(ba.length);

                    _allEverVisitedRoomIDs = JSON.parse(save) as Array;
                } else
                    _allEverVisitedRoomIDs = [];


                // All states

                save = rSave.load(SAVE_GLOBAL_STATES_NAME, null);

                if (save){
                    save = USecure.unscrambleString(save, SAVE_GLOBAL_STATES_SCRAMBLE);

                    ba = Base64.decodeByteArray(save);
                    ba.uncompress();
                    ba.position = 0;

                    save = ba.readUTFBytes(ba.length);

                    var states:Array = JSON.parse(save) as Array;

                    for each(var state:String in states){
                        var stateInstance:VORoomEntryState = new VORoomEntryState();
                        stateInstance.unserialize(Base64.decodeByteArray(state));
                        _roomEntranceStates.push(stateInstance);
                    }
                }


                // Stats

                save = rSave.load(SAVE_GLOBAL_STATS_NAME, null);

                if (save) {
                    save = USecure.unscrambleString(save, SAVE_GLOBAL_STATS_SCRAMBLE);

                    ba = Base64.decodeByteArray(save);
                    ba.uncompress();
                    ba.position = 0;

                    levelStats.unpack(ba);
                }


                // Game mastered

                save = rSave.load(SAVE_GAME_MASTERED_NAME, null);

                if (save) {
                    ba = Base64.decodeByteArray(save);

                    USecure.unscrambleByteArray(ba, SAVE_GAME_MASTERED_SCRAMBLE);
                    ba.uncompress();

                    ba.position = 0;

                    save = ba.readUTF();

                    _isGameMastered = (save == "calkowicie");
                }


                // Game completion

                save = rSave.load(SAVE_GAME_COMPLETED_NAME, null);

                if (save) {
                    ba = Base64.decodeByteArray(save);

                    USecure.unscrambleByteArray(ba, SAVE_GAME_COMPLETED_SCRAMBLE);
                    ba.uncompress();

                    ba.position = 0;

                    save = ba.readUTF();

                    _isGameCompleted = (save == "zaiste");
                }


                // Demos

                save = rSave.load(SAVE_GLOBAL_DEMOS_NAME, null);

                if (save) {
                    save = USecure.unscrambleString(save, SAVE_GLOBAL_DEMOS_SCRAMBLE);

                    ba = Base64.decodeByteArray(save);
                    ba.uncompress();

                    save = ba.readUTF();

                    var demos:Array = JSON.parse(save) as Array;

                    for each(var i:String in demos) {
                        var demo:VODemoRecord = new VODemoRecord(0, i)
                        _roomDemosData.push(demo);
                    }
                }

            } catch (e:Error){
                rSave.deleteData(SAVE_GLOBAL_CONQUERED_NAME);
                rSave.deleteData(SAVE_GLOBAL_DEMOS_NAME);
                rSave.deleteData(SAVE_GLOBAL_STATES_NAME);
                rSave.deleteData(SAVE_GLOBAL_STATS_NAME);
                rSave.deleteData(SAVE_GLOBAL_VISITED_NAME);
                rSave.deleteData(SAVE_LOCAL_NAME);

                rSave.flush(C.SETTINGS_SAVE_SIZE);

                trace("Failed progress load:", e.errorID, e.name, e.message);
                resetProgress();
            }

        }



        /****************************************************************************************************************/
        /**                                                                              IN-GAME PROGRESS MANIPULATION  */
        /****************************************************************************************************************/

        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Action
        // ::::::::::::::::::::::::::::::::::::::::::::::

        public static function roomEntered(roomID:uint, playerX:uint, playerY:uint, playerO:uint):void {
            _currentState.x      = playerX;
            _currentState.y      = playerY;
            _currentState.o      = playerO;
            _currentState.roomID = roomID;

            if (!getRoomEntranceState(roomID)){
                var entranceState:VORoomEntryState = _currentState.clone();
                _roomEntranceStates.push(entranceState);
                _forceFullSave = true;
            }

            if (!wasRoomEverVisited(roomID) && !isRoomExplored(roomID)){
                _allEverVisitedRoomIDs.push(roomID);
                _forceFullSave = true;
            }

            saveProgress(_forceFullSave);

            _forceFullSave = false;
        }

        public static function resetProgress():void{
            _roomEntranceStates     .length = 0;
            _allEverConqueredRoomIDs.length = 0;
            _allEverVisitedRoomIDs  .length = 0;
            _roomDemosData          .length = 0;

            levelStats.clear();

            _currentState.clear();

            isGameCompleted = false;
            isGameMastered  = false;

            saveProgress(true);
        }

        public static function restartHold():void{
            _currentState.clear();
        }

        public static function restoreToRoom(roomID:uint):void{
            var state:VORoomEntryState = getRoomEntranceState(roomID);

            ASSERT(state);
            ASSERT(Level.getRoom(roomID));

            _currentState.setFrom(state);
        }



        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Checkers
        // ::::::::::::::::::::::::::::::::::::::::::::::

        /**
         * Whether the Restore option should be enabled
         */
        public static function hasRestoreProgress():Boolean{
            for each(var i:VORoomEntryState in _roomEntranceStates){
                if (Level.getRoom(i.roomID))
                    return true;
            }

            return false;
        }

        /**
         * Whether the continue option should be enabled
         */
        public static function hasSaveGame():Boolean{
            return _currentState.hasSaveGame();
        }

        /**
         * Checks if all secret rooms were ever conquered and if the hold was ever conquered
         * @return True if the hold is mastered
         */
        public static function checkHoldMastery():Boolean {
            if (!_isGameCompleted)
                return false;

            var rooms:Array = Level.getAllSecretRooms();

            for each(var room:XML in rooms){
                if (!wasRoomEverConquered(room.@RoomID))
                    return false;
            }

            return true;
        }




        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Setters
        // ::::::::::::::::::::::::::::::::::::::::::::::

        public static function markDemoAsUploaded(roomID:uint):void {
            var record:VODemoRecord;

            for each(record in _roomDemosData){
                if (record.roomID == roomID) {
                    record.wasUploaded = true;
                    _forceFullSave     = true;
                    return;
                }
            }
        }

        public static function setGameVars(newGameVars:PackedVars):void{
            _currentState.gameVars = newGameVars;
        }

        public static function setRoomConquered(id:uint, isConquered:Boolean):void {
            if (_currentState.setRoomConquered(id, isConquered))
                _forceFullSave = true;

            if (!wasRoomEverConquered(id)){
                _allEverConqueredRoomIDs.push(id);
                _forceFullSave = true;
            }
        }

        public static function setRoomExplored(id:uint, isExplored:Boolean):void {
            if (_currentState.setRoomExplored(id, isExplored))
                _forceFullSave = true;
        }

        /**
         * @return True if the score was better than a previous one
         */
        public static function setRoomScoreDemo(roomID:uint, newScore:uint, startX:uint, startY:uint, startO:uint):Boolean {
            var score :VODemoRecord;
            var found :Boolean = false;
            var result:Boolean;

            for each(score in _roomDemosData){
                if (score.roomID == roomID) {
                    found = true;
                    break;
                }
            }

            if (!found){
                score = new VODemoRecord(roomID);
                _roomDemosData.push(score);
            }

            result = score.saveDemo(newScore, startX, startY, startO, _currentState.endedScripts, _currentState.gameVars);

            if (result)
                _forceFullSave = true;

            return result;
        }

        public static function clearRoomScoreDemo(roomID:uint):void {
            var score :VODemoRecord;
            var found :Boolean = false;
            var result:Boolean;

            for each(score in _roomDemosData){
                if (score.roomID == roomID) {
                    found = true;
                    break;
                }
            }

            if (!found)
                return;

            score.clearDemo();
        }

        public static function setScriptEnded(id:uint, isEnded:Boolean):void{
            if (_currentState.setScriptEnded(id, isEnded))
                _forceFullSave = true;
        }

        public static function setScriptsEnded(ids:Array, isEnded:Boolean):void{
            for each(var id:uint in ids){
                if (_currentState.setScriptEnded(id, isEnded))
                    _forceFullSave = true;
            }
        }




        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Getters
        // ::::::::::::::::::::::::::::::::::::::::::::::

        public static function get gameVarsClone():PackedVars{
            return _currentState.gameVars.clone();
        }

        public static function get playerX():uint{
            return _currentState.x;
        }

        public static function get playerY():uint{
            return _currentState.y;
        }

        public static function get playerO():uint{
            return _currentState.o;
        }

        public static function get playerRoomID():uint{
            return _currentState.roomID;
        }

        public static function isLevelCompleted(id:uint):Boolean {
            return _currentState.isLevelCompleted(id);
        }

        public static function isLevelVisited(id:uint):Boolean {
            return _currentState.isLevelVisited(id);
        }

        public static function isRoomConquered(id:uint):Boolean {
            return _currentState.isRoomConquered(id);
        }

        public static function isRoomExplored(id:uint):Boolean {
            return _currentState.isRoomExplored(id);
        }

        public static function isScriptEnded(id:uint):Boolean{
            return _currentState.isScriptEnded(id);
        }




        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Global Getters
        // ::::::::::::::::::::::::::::::::::::::::::::::

        public static function wasLevelEverVisited(id:uint):Boolean {
            for each(var room:XML in Level.getRoomsByLevel(id)){
                if (wasRoomEverVisited(room.@RoomID))
                    return true;
            }

            return false;
        }

        public static function wasRoomEverConquered(id:uint):Boolean {
            return _allEverConqueredRoomIDs.indexOf(id) !== -1;
        }

        public static function wasRoomEverVisited(id:uint):Boolean {
            return _allEverVisitedRoomIDs.indexOf(id) !== -1;
        }

        public static function getRoomBestScore(roomID:uint):int {
            var score :VODemoRecord;

            for each(score in _roomDemosData){
                if (score.roomID == roomID) {
                    return score.score;
                }
            }

            return -1;
        }

        public static function getRoomDemo(roomID:uint):VODemoRecord {
            var score :VODemoRecord;

            for each(score in _roomDemosData){
                if (score.roomID == roomID) {
                    return score;
                }
            }

            return null;
        }




        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Retrievers
        // ::::::::::::::::::::::::::::::::::::::::::::::

        public static function getExploredRoomsByLevel(levelID:uint):Array {
            return _currentState.getExploredRoomsByLevel(levelID);
        }

        public static function getRoomEntranceState(roomID:uint):VORoomEntryState {
            for each (var entranceState:VORoomEntryState in _roomEntranceStates) {
                if (entranceState.roomID == roomID)
                    return entranceState;
            }

            return null;
        }
    }

    CF::lib
    public class Progress {
        public static var levelStats:PackedVars = new PackedVars();

        public static function roomEntered(roomID:uint, playerX:uint, playerY:uint, playerO:uint):void {}
        public static function resetProgress():void{}
        public static function restartHold():void{}
        public static function restoreToRoom(roomID:uint):void{}
        public static function hasRestoreProgress():Boolean{ return false }
        public static function hasSaveGame():Boolean { return false; }
        public static function get isGameMastered():Boolean { return false; }
        public static function set isGameMastered(value:Boolean):void { }
        public static function setGameVars(newGameVars:PackedVars):void{}
        public static function setRoomConquered(id:uint, isConquered:Boolean):void {}
        public static function setRoomExplored(id:uint, isExplored:Boolean):void {}
        public static function setRoomScoreDemo(roomID:uint, newScore:uint, startX:uint, startY:uint, startO:uint):Boolean { return false; }
        public static function setScriptEnded(id:uint, isEnded:Boolean):void{}
        public static function setScriptsEnded(ids:Array, isEnded:Boolean):void{}
        public static function isLevelCompleted(id:uint):Boolean { return false;}
        public static function isLevelVisited(id:uint):Boolean { return false; }
        public static function isRoomConquered(id:uint):Boolean { return false; }
        public static function isRoomExplored(id:uint):Boolean { return false; }
        public static function wasLevelEverVisited(id:uint):Boolean { return false; }
        public static function wasRoomEverConquered(id:uint):Boolean { return false; }
        public static function wasRoomEverVisited(id:uint):Boolean { return false; }
        public static function getRoomBestScore(roomID:uint):int { return 0; }
        public static function getExploredRoomsByLevel(levelID:uint):Array { return null; }
        public static function getRoomEntranceState(roomID:uint):VORoomEntryState { return null; }
        public static function get isGameCompleted():Boolean { return false; }
        public static function set isGameCompleted(value:Boolean):void { }
        public static function getRoomDemo(roomID:uint):VODemoRecord { return null;  }
        public static function markDemoAsUploaded(roomID:uint):void { }
        public static function checkHoldMastery():Boolean { return false; }
        public static function clearRoomScoreDemo(roomID:uint):void {}

        /**
         * Demo playback stuff
         */

        private static var _currentState:VORoomEntryState = new VORoomEntryState();

        public static function demoPlayback(demo:VODemoRecord):void {
            _currentState.setFromDemo(demo);
        }

        public static function isScriptEnded(id:uint):Boolean {
            return _currentState.isScriptEnded(id);
        }

        public static function get gameVarsClone():PackedVars{
            return _currentState.gameVars.clone();
        }

        public static function get playerX():uint{
            return _currentState.x;
        }

        public static function get playerY():uint{
            return _currentState.y;
        }

        public static function get playerO():uint{
            return _currentState.o;
        }

        public static function get playerRoomID():uint{
            return _currentState.roomID;
        }
    }
}