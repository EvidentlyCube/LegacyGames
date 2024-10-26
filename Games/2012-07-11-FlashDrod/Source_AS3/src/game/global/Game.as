package game.global {
    import flash.utils.getTimer;
    import flash.utils.setTimeout;
    import game.objects.TEffectRoomSlide;
    import net.retrocade.utils.Base64;
    import net.retrocade.utils.UString;

    import game.managers.VOCoord;
    import game.managers.VOSpeech;
    import game.managers.VOSpeechCommand;
    import game.managers.VOStairs;
    import game.objects.TGameObject;
    import game.objects.actives.TBrain;
    import game.objects.actives.TCharacter;
    import game.objects.actives.TMimic;
    import game.objects.actives.TMonster;
    import game.objects.actives.TMonsterPiece;
    import game.objects.actives.TPlayer;
    import game.objects.actives.TPlayerDouble;
    import game.objects.actives.TTarMother;
    import game.widgets.TWidgetLevelName;
    import game.widgets.TWidgetMinimap;
    CF::play{
        import game.states.TStateGame;
        import game.achievements.Achievements;
    }

    /**
     * ...
     * @author
     */
    public class Game {
        //{ Constants
        /******************************************************************************************************/
        /**                                                                                        CONSTANTS  */
        /******************************************************************************************************/

        /**
         * Helper: tiles to check for enemies location depending on player's orientation
         */
        private static const NERVOUS_TILES_X:Array = [
            [ 0,  1,  1], // NW
            [-1,  0,  1], // N
            [-1, -1,  0], // NE
            [ 1,  1,  1], // W
            null,
            [-1, -1, -1], // E
            [ 0,  1,  1], // SW
            [-1,  0,  1], // S
            [-1, -1,  0]  // SE
        ];

        /**
         * Helper: tiles to check for enemies location depending on player's orientation
         */
        private static const NERVOUS_TILES_Y:Array = [
            [ 1,  1,  0], // NW
            [ 1,  1,  1], // N
            [ 0,  1,  1], // NE
            [-1,  0,  1], // W
            null,
            [-1,  0,  1], // E
            [-1, -1,  0], // SW
            [-1, -1, -1], // S
            [ 0, -1, -1]  // SE
        ];

        //}

        //{ Variables
        /******************************************************************************************************/
        /**                                                                                        VARIABLES  */
        /******************************************************************************************************/

        public static var player           :TPlayer = new TPlayer();

        public static var isInvisible      :Boolean = false;
        public static var doesBrainSensePlayer:Boolean = false;

        public static var simultaneousSwordHits:Array = [];

        public static var turnNo:uint = 0;
        public static var spawnCycleCount:uint = 0;
        public static var playerTurn:uint = 0;

        public static var startRoomO:uint;
        public static var startRoomX:uint;
        public static var startRoomY:uint;

        public static var isGameActive         :Boolean = false;
        public static var isPlayerDying        :Boolean = false;
        public static var executeNoMoveCommands:Boolean = false;
        public static var isRoomLocked         :Boolean = false;

        public static var lastCheckpointX:uint  = uint.MAX_VALUE;
        public static var lastCheckpointY:uint  = uint.MAX_VALUE;
        public static var checkpointTurns:Array = [];

        public static var tempGameVars:PackedVars;
        public static var finishedScripts:Array = [];

        /** True if this is the first visit to this room*/
        public static var isNewRoom    :Boolean = false;

        public static var playerLeftRoom:Boolean = false;

        public static var room   :Room;



        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Level Stats
        // ::::::::::::::::::::::::::::::::::::::::::::::

        public static var statKills :uint = 0;
        public static var statDeaths:uint = 0;
        public static var statMoves :uint = 0;
        public static var statTime  :uint = 0;

        public static var statStartTime:Number = 0;

        //}

        //{ Process
        /******************************************************************************************************/
        /**                                                                                          PROCESS  */
        /******************************************************************************************************/

        /**
         * This is a subsidiary of processMonsters() and should only be called by it.
         *
         * Returns if brain sense player in this turn, which happens only if the player is visible
         * or within the smelling range.
         * @return True if player is sensed by any brain.
         */
        private static function doesBrainSenseSwordsman():Boolean {
            if (room.brainCount) {
                for each(var i:TMonster in room.monsters.getAllOriginal()) {
                    if (i && i is TBrain && TBrain(i).canSensePlayer())
                        return true;
                }
            }

            return false;
        }

        /**
         * Processes a single sword hit - breaks walls, kills enemies, adds Simultaneous Sword Hit on tar.
         *
         * @param	sX X position of the sword
         * @param	sY Y position of the sword
         * @param	double Instance of the TPlayerDouble who does the sword hit. If null, it is player hitting.
         * Player killing test is only done if double is set.
         */
        public static function processSwordHit(sX:uint, sY:uint, double:TMonster = null):void {
            if (!F.isValidColRow(sX, sY))
                return;

            var playerDouble:TPlayerDouble = double as TPlayerDouble;

            var swordMovement:uint = (playerDouble ? playerDouble.swordMovement : player.swordMovement);

            // @TODO No critical on entrance

            var monster:TMonster = room.tilesActive[sX + sY * S.LEVEL_WIDTH];
            if (monster){
                if (monster.onStabbed(sX, sY)){
                    if (CueEvents.hasOccuredWith(C.CID_MONSTER_DIED_FROM_STAB, monster)){
                        room.killMonster(monster);
                        monster.killDirection = player.swordMovement;
                        if (!double)
                            CueEvents.add(C.CID_SWORDSMAN_STABBED_MONSTER);
                    }

                    if (F.isTar(room.tilesTransparent[sX + sY * S.LEVEL_WIDTH]) &&
                        monster is TTarMother)
                        simultaneousSwordHits.push(new VOCoord(sX, sY, swordMovement));
                }
            }

            var tileNo:uint = room.tilesTransparent[sX + sY * S.LEVEL_WIDTH];
            switch(tileNo) {
                case(C.T_ORB):
                    room.activateOrb(sX, sY, C.OAT_PLAYER);
                    break;

                case(C.T_TAR):
                    if (room.stabTar(sX, sY, false))
                        simultaneousSwordHits.push(new VOCoord(sX, sY, swordMovement));
                    break;
            }

            tileNo = room.tilesOpaque[sX + sY * S.LEVEL_WIDTH];
            switch(tileNo){
                case(C.T_WALL_BROKEN): case(C.T_WALL_HIDDEN):
                    room.destroyCrumblyWall(sX, sY, swordMovement);
                    break;
            }

            if (double){
                if (player.x == sX && player.y == sY && turnNo){

                    if (double is TCharacter){
                        if (TCharacter(double).swordSafeToPlayer)
                            return;
                    }
                    CueEvents.add(C.CID_MONSTER_KILLED_PLAYER, double);
                }
            }
        }

        /**
         * Subsidiary of processCommand(), it is executed by processCommand and the rest of that function is skipped.
         * It should not be called in any other way.
         *
         * Responses to player controls by moving the target control, and allows placing the double.
         *
         * @param	command Command issued by player
         * @param	x X position to place (only when called by demo replay or mouse interaction)
         * @param	y Y position to place (only when called by demo replay or mouse interaction)
         */
        private static function processDoublePlacement(command:uint, x:uint = uint.MAX_VALUE, y:uint = uint.MAX_VALUE):void{
            ASSERT(player.placingDoubleType);

            var dx:int = 0, dy:int = 0;
            switch(command){
                case(C.CMD_N):  dy = -1;          break;
                case(C.CMD_S):  dy =  1;          break;
                case(C.CMD_W):  dx = -1;          break;
                case(C.CMD_E):  dx =  1;          break;
                case(C.CMD_NW): dy = -1; dx = -1; break;
                case(C.CMD_NE): dy = -1; dx =  1; break;
                case(C.CMD_SW): dy =  1; dx = -1; break;
                case(C.CMD_SE): dy =  1; dx =  1; break;
                case(C.CMD_CC): case(C.CMD_C):
                case(C.CMD_WAIT): case(C.CMD_DOUBLE): break;
                default: return;
            }

            if (command == C.CMD_WAIT || command == C.CMD_DOUBLE){
                if (command == C.CMD_DOUBLE){
                    ASSERT(F.isValidColRow(x, y));
                    player.doubleCursorX = x;
                    player.doubleCursorY = y;
                }

                if (!room.doesSquareContainDoublePlacementObstacle(player.doubleCursorX, player.doubleCursorY)){
                    var double:TPlayerDouble = room.addNewMonster(player.placingDoubleType,
                        player.doubleCursorX, player.doubleCursorY, player.o) as TPlayerDouble;

                    ASSERT(double);
                    player.placingDoubleType = 0;
                    if (double){
                        if (!Commands.isFrozen())
                            Commands.addWithData(C.CMD_DOUBLE, player.doubleCursorX, player.doubleCursorY);

                        CueEvents.add(C.CID_DOUBLE_PLACED);

                        double.process(C.CMD_WAIT);
                        processSimultaneousSwordHits();

                        queryCheckpoint(double.x, double.y);

                        room.processTurn(false);

                        updatePrevCoords();
                    }
                }

            } else { // Not placing
                if (F.isValidColRow(player.doubleCursorX + dx, player.doubleCursorY + dy)){
                    player.doubleCursorX += dx;
                    player.doubleCursorY += dy;
                }
            }
        }

        /**
         * The actual command processing/
         * @TODO Improve documentation
         *
         * @param	command Command issued
         * @param	wx Special X variable, used by replays & mouse interaction
         * @param	wy Special Y variable, used by replays & mouse interaction
         */
        public static function processCommand(command:uint, wx:uint = uint.MAX_VALUE, wy:uint = uint.MAX_VALUE):void {
            ASSERT(isGameActive);

            CueEvents.clear();

            if (!Commands.isFrozen() && !player.placingDoubleType)
                Commands.add(command);

            if (!player.placingDoubleType){
                turnNo++;
                if (!Commands.isFrozen())
                    statMoves++;
            }

            var originalMonsterCount:uint = room.monsterCount;

            {
                var playerLeftRoom:Boolean = false;
                var playerIsMonsterTarget:Boolean = true;

                // Normal turn or placing double?
                if (player.placingDoubleType)
                    processDoublePlacement(command, wx, wy);

                else {
                    playerTurn++;
                    player.process(command);

                    // Ignore move if bumbed master wall or room locked
                    if (CueEvents.hasOccured(C.CID_BUMPED_MASTER_WALL) || CueEvents.hasOccured(C.CID_ROOM_EXIT_LOCKED)) {
                        //Room exit should never be locked during move playback.
                        ASSERT(!CueEvents.hasOccured(C.CID_ROOM_EXIT_LOCKED) || !Commands.isFrozen());

                        --playerTurn;
                        --turnNo;
                        --statMoves;

                        if (!Commands.isFrozen())
                            Commands.removeLast();

                        return;
                    }

                    playerLeftRoom = CueEvents.hasAnyOccured(C.CIDA_PLAYER_LEFT_ROOM);

                    if (CueEvents.hasOccured(C.CID_BUMPED_MASTER_WALL)) {
                        // Make as if this move had never happened

                        ASSERT(playerTurn);
                        playerTurn--;

                        ASSERT(turnNo);
                        turnNo--;

                        ASSERT(statMoves);
                        statMoves--;

                        if (!Commands.isFrozen())
                            Commands.removeLast();

                        return;
                    }

                    {
                        if (playerLeftRoom)
                            simultaneousSwordHits.length = 0;
                        else {
                            processMonsters(command);
                            processSimultaneousSwordHits();
                            room.processTurn(true);
                            setPlayerMood();
                        }
                    }
                } // End Else Placing Double Process

                if (CueEvents.hasAnyOccured(C.CIDA_PLAYER_DIED))
                    isPlayerDying = true;

                // Check Conquerance
                if (!playerLeftRoom && !room.monsterCount && originalMonsterCount && !isCurrentRoomConquered())
                    CueEvents.add(C.CID_ROOM_CONQUER_PENDING);
            }

            // Kill player
            if (CueEvents.hasAnyOccured(C.CIDA_PLAYER_DIED)){
                isGameActive = false;
                statDeaths++;
            }

            // Query Checkpoint
            if (F.isMovementCommand(command) && (player.x != player.prevX || player.y != player.prevY))
                queryCheckpoint(player.x, player.y);

            // Activate checkpoint
            if (CueEvents.hasOccured(C.CID_CHECKPOINT_ACTIVATED)){
                var checkpointPosition:VOCoord = CueEvents.getFirstPrivateData(C.CID_CHECKPOINT_ACTIVATED);

                lastCheckpointX = checkpointPosition.x;
                lastCheckpointY = checkpointPosition.y;

                checkpointTurns.push(turnNo);
            } else if (F.isValidColRow(lastCheckpointX, lastCheckpointY) &&
                (lastCheckpointX != player.x || lastCheckpointY != player.y)){

                var monster:TMonster = room.tilesActive[lastCheckpointX + lastCheckpointY * S.LEVEL_WIDTH];
                if (!monster || !(monster is TMimic))
                    lastCheckpointX = lastCheckpointY = uint.MAX_VALUE;
            }

            if (CueEvents.hasOccured(C.CID_ROOM_CONQUER_PENDING) && !room.greenDoorsOpened)
                CueEvents.add(C.CID_ROOM_CONQUER_PENDING, toggleGreenDoors());

            room.charactersCheckForCueEvents();

            if (room.monsters.nulled)
                room.monsters.garbageCollectAdvanced();
        }

        /**
         * Processes the monster's list. Monsters are updated and postprocessed and garbage collection is run.
         * This is a subsidiary of processCommand() and should only be called by it.
         * @param	lastCommand Command issued to processCommand()
         */
        private static function processMonsters(lastCommand:uint):void{
            spawnCycleCount++;

            doesBrainSensePlayer = doesBrainSenseSwordsman();

            room.setPathmapTarget(player.x, player.y);

            var m:TMonster;
            var monsters:Array = room.monsters.getAllOriginal();
            for(var i:uint = 0, l:uint = monsters.length; i < l; i++){
                if (!(m = monsters[i]))
                    continue;

                if (!m.isAlive){
                    continue;

                } else {
                    m.prevX = m.x;
                    m.prevY = m.y;

                    m.process(lastCommand);
                }
            }

            room.monsters.garbageCollectAdvanced();

            room.currentTurn++;
        }

        //}

        //{ Action
        /******************************************************************************************************/
        /**                                                                                           ACTION  */
        /******************************************************************************************************/

        /**
         * Called when player steps on a potion which creates a double (mimic potion) this function is called.
         * Clears the potion and prepared doublePlacement
         * @param	doubleType Type of the double to place
         */
        public static function drankPotion(doubleType:uint):void {
            player.placingDoubleType = doubleType;
            player.doubleCursorX = player.x;
            player.doubleCursorY = player.y;
            room.plot(player.x, player.y, C.T_EMPTY);
            CueEvents.add(C.CID_DRANK_POTION);
        }

        public static function gotoLevelEntrance(entrance:uint, skipDisplay:Boolean):void{
            handleLeaveLevel(entrance, skipDisplay);
        }

        public static function playCommandsToTurn(endTurnNo:uint):Boolean{
            ASSERT(endTurnNo <= Commands.count());

            if (!endTurnNo)
                return true;

            Commands.freeze();

            var count:uint = endTurnNo;

            var command:uint = Commands.getFirst();
            while(count--){
                if (command == C.CMD_DOUBLE)
                    processCommand(command, Commands.getComplexX(), Commands.getComplexY());
                else
                    processCommand(command);

                command = Commands.getNext();

                CF::play{
                    TStateGame.lastCommand = command;
                    if (count)
                        Achievements.turnPassed();
                }
            }

            player.prevX = player.x;
            player.prevY = player.y;

            Commands.unfreeze();

            return turnNo == endTurnNo;
        }

        public static function processSimultaneousSwordHits():void{
            for each(var i:VOCoord in simultaneousSwordHits){
                room.stabTar(i.x, i.y, true, i.o);
            }

            simultaneousSwordHits.length = 0;
        }

        public static function queryCheckpoint(x:uint, y:uint):void{
            if (CueEvents.hasOccured(C.CID_CHECKPOINT_ACTIVATED)) return;

            if (isGameActive){
                if (room.checkpoints.contains(x, y)){
                    if (x != lastCheckpointX && y != lastCheckpointY)
                        CueEvents.add(C.CID_CHECKPOINT_ACTIVATED, new VOCoord(x, y));

                    return;
                }
            }
        }

        public static function setTurn(turnNo:uint):void{
            if (turnNo >= Commands.count())
                turnNo = Commands.count();

            if (isNewRoom)
                Progress.setRoomExplored(room.roomID, false);

            Commands.freeze();

            room.reload();
            CueEvents.clear();
            setPlayerToRoomStart();
            setMembersAfterRoomLoad(false);

            Commands.unfreeze();

            if (turnNo)
                playCommandsToTurn(turnNo);
        }

        public static function undoCommand():void {
            if (Commands.count() == 0)
                return;

            undoCommands(1);
        }

        public static function undoCommands(undoCount:uint):void{
            ASSERT(undoCount > 0 && undoCount <= Commands.count());

            var playCount:uint = Commands.count() - undoCount;

            setTurn(playCount);
            Commands.truncate(playCount);
        }

        /**
         * Updates the statTime, ie. the time spent in given level
         */
        public static function updateTime():void {
            var time:Number = getTimer();

            while (time > statStartTime + 1000) {
                statTime += 1;
                statStartTime += 1000;
            }
        }


        //}

        //{ Changers
        /******************************************************************************************************/
        /**                                                                                         CHANGERS  */
        /******************************************************************************************************/

        public static function levelStatsSave():void {
            CF::play{
                Progress.levelStats.setUint(room.levelID + "k", statKills);
                Progress.levelStats.setUint(room.levelID + "d", statDeaths);
                Progress.levelStats.setUint(room.levelID + "m", statMoves);
                Progress.levelStats.setUint(room.levelID + "t", statTime);
            }
        }

        public static function levelStatsLoad():void {
            CF::play{
                statKills  = Progress.levelStats.getUint(room.levelID + "k");
                statDeaths = Progress.levelStats.getUint(room.levelID + "d");
                statMoves  = Progress.levelStats.getUint(room.levelID + "m");
                statTime   = Progress.levelStats.getUint(room.levelID + "t");
            }
        }

        public static function setMembersAfterRoomLoad(resetCommands:Boolean = true):void{
            finishedScripts.length = 0;
            tempGameVars = Progress.gameVarsClone;

            isGameActive = true;
            spawnCycleCount = playerTurn = turnNo = 0;
            isInvisible = false;
            doesBrainSensePlayer = false;

            isPlayerDying = false;
            player.placingDoubleType = 0;

            var wasLevelComplete:Boolean = (isCurrentLevelComplete() && Progress.isLevelVisited(room.levelID));

            isNewRoom = !isCurrentRoomExplored();

            if (isNewRoom)
                setCurrentRoomExplored();

            var wasRoomConquered:Boolean = isCurrentRoomConquered();

            var monsterCountAtStart:uint = room.monsterCount;
            room.greenDoorsOpened = false;

            if (F.isCrumblyWall(room.tilesOpaque[player.x + player.y * S.LEVEL_WIDTH]) ||
                    // A workaround to detect Secret Walls hidden as standard wall

                    (F.isWall(room.tilesOpaque[player.x + player.y * S.LEVEL_WIDTH]) &&
                    (room.renderer.opaqueData[player.x + player.y * S.LEVEL_WIDTH] & C.REND_WALL_HIDDEN_SECRET)))
                room.destroyCrumblyWall(player.x, player.y);

            // @TODO Bomb && Mirror remove

            var monster:TMonster = room.tilesActive[player.x + player.y * S.LEVEL_WIDTH];
            if (monster)
                room.killMonster(monster);

            if (isNewRoom && Level.getRoom(room.roomID).@IsSecret == 1)
                CueEvents.add(C.CID_SECRET_ROOM_FOUND);

            if (!wasRoomConquered && !monsterCountAtStart){
                setCurrentRoomConquered();
                isNewRoom = true;
            }

            room.setRoomEntryState(wasLevelComplete, isCurrentLevelComplete(), wasRoomConquered, monsterCountAtStart);
            if (wasRoomConquered)
                monsterCountAtStart = 0;

            player.process(C.CMD_WAIT);

            executeNoMoveCommands = true;
            room.preprocessMonsters();
            executeNoMoveCommands = false;

            if ((monsterCountAtStart) && isCurrentRoomPendingExit())
                toggleGreenDoors();

            if (resetCommands && !Commands.isFrozen())
                Commands.clear();

            room.createPathmaps();

            statMoves = Progress.levelStats.getUint(room.levelID + "m");
        }

        public static function setPlayerToRoomStart():void{
            lastCheckpointX = lastCheckpointY = 0;
            isGameActive = true;

            turnNo = 0;

            player.room = room;

            player.x = player.prevX = startRoomX;
            player.y = player.prevY = startRoomY;
            player.o = player.prevO = startRoomO;
            player.setPosition(startRoomX, startRoomY, true);

            if (!Commands.isFrozen())
                Commands.clear();

            isPlayerDying = false;
        }

        public static function setRoomStartToPlayer():void{
            startRoomX = player.x;
            startRoomY = player.y;
            startRoomO = player.o;
        }

        public static function toggleGreenDoors():Boolean {
            return room.toggleGreenDoors();
        }

        public static function updatePrevCoords():void{
            player.prevX = player.x;
            player.prevY = player.y;

            for each(var monster:TMonster in room.monsters.getAllOriginal()){
                if (monster){
                    monster.prevX = monster.x;
                    monster.prevY = monster.y;
                }
            }
        }

        public static function tallyKill():void {
            if (!Commands.isFrozen())
                statKills++;
        }


        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Save Data
        // ::::::::::::::::::::::::::::::::::::::::::::::

        public static function setCurrentRoomExplored():void{
            Progress.setRoomExplored(room.roomID, true);
        }

        public static function setCurrentRoomConquered():void{
            Progress.setRoomConquered(room.roomID, true);

            if (Level.roomHasMonsters(room.roomID) &&
                    Progress.setRoomScoreDemo(room.roomID, turnNo, startRoomX, startRoomY, startRoomO))
                CueEvents.add(C.CID_SUBMIT_SCORE, room.roomID);
        }


        //}

        //{ Level / Room Playing
        /******************************************************************************************************/
        /**                                                                               LEVEL/ROOM PLAYING  */
        /******************************************************************************************************/

        /**
         * Retrieves the direction of the new room depending on the direction player moved
         * @param	moveDirection Direction in which the player moved
         * @return Direction to the new room (N, S, E or W)
         * @throws ArgumentError when invalid orientation or NO_ORIENTATION
         */
        public static function getRoomExitDirection(moveDirection:uint):uint{
            switch(moveDirection){
                case(C.N): return C.N;
                case(C.S): return C.S;
                case(C.E): return C.E;
                case(C.W): return C.W;
                case(C.NW): return (player.y == 0 ? C.N : C.W);
                case(C.NE): return (player.y == 0 ? C.N : C.E);
                case(C.SW): return (player.y == S.LEVEL_HEIGHT - 1 ? C.S : C.W);
                case(C.SE): return (player.y == S.LEVEL_HEIGHT - 1 ? C.S : C.E);
                default:
                    throw new ArgumentError("Invalid orientation: " + moveDirection);
            }
        }

        public static function handleLeaveLevel(entrance:uint = uint.MAX_VALUE, skipDisplay:Boolean = false):void{
            ASSERT(F.isStairs(room.tilesOpaque[player.x + player.y * S.LEVEL_WIDTH]) || entrance != uint.MAX_VALUE);

            if (CueEvents.hasAnyOccured(C.CIDA_PLAYER_DIED))
                return;

            if (Commands.isFrozen()) {
                CueEvents.add(C.CID_EXIT_ROOM);
                return;
            }

            var wasMastered:Boolean = Progress.isGameMastered;
            var conquered  :Boolean = wasRoomConqueredOnThisVisit();
            if (conquered){
                if (!isCurrentRoomConquered()){
                    CueEvents.add(C.CID_CONQUER_ROOM, room.roomID);
                    setCurrentRoomConquered();
                }
            }

            levelStatsSave();

            Progress.setScriptsEnded(finishedScripts, true);
            Progress.setGameVars(tempGameVars);
            CueEvents.add(C.CID_EXIT_ROOM);

            var entranceId:uint = entrance;
            if (entrance == uint.MAX_VALUE){
                for each(var stairs:VOStairs in room.stairs){
                    if (player.x >= stairs.left && player.x <= stairs.right &&
                        player.y >= stairs.top  && player.y <= stairs.bottom){

                        if (stairs.entrance && !Level.getEntrance(stairs.entrance))
                            continue;

                        entranceId = stairs.entrance;
                        break;
                    }
                }

                if (entranceId == uint.MAX_VALUE)
                    entranceId = 0;
            }

            if (!wasMastered && Progress.checkHoldMastery()) {
                CueEvents.add(C.CID_HOLD_MASTERED);
                Progress.isGameMastered = true;
            }

            var entranceXML:XML = Level.getEntrance(entranceId);
            if (!entranceXML)
                CueEvents.add(C.CID_WIN_GAME);

            else
                CueEvents.add(C.CID_EXIT_LEVEL_PENDING, new VOCoord(entranceId, int(skipDisplay)));

            isGameActive = false;

            updatePrevCoords();
        }

        public static function handleLeaveRoom(orientation:uint, force:Boolean = false):Boolean {
            var oldRoomID:uint = room.roomID;

            var roomO:uint = getRoomExitDirection(orientation);

            var newX:uint = player.x;
            var newY:uint = player.y;

            switch(roomO){
                case(C.N): newY = S.LEVEL_HEIGHT - 1; break;
                case(C.S): newY = 0;                  break;
                case(C.W): newX = S.LEVEL_WIDTH - 1;  break;
                case(C.E): newX = 0;                  break;
            }

            var newRoomID:uint = Level.getRoomIDByNeighbourID(oldRoomID, roomO);

            if (newRoomID == uint.MAX_VALUE)
                return false;

            if (!force && !Level.canEnterRoom(newRoomID, newX, newY))
                return false;

            if (Commands.isFrozen()) {
                CueEvents.add(C.CID_EXIT_ROOM);
                return true;
            }

            levelStatsSave();

            var wasMastered:Boolean = Progress.isGameMastered;
            var conquered  :Boolean = wasRoomConqueredOnThisVisit();
            if (conquered){
                var wasLevelCompleted:Boolean = isCurrentLevelComplete();
                if (!isCurrentRoomConquered()){
                    CueEvents.add(C.CID_CONQUER_ROOM, room.roomID);
                    setCurrentRoomConquered();
                }

                if (isCurrentLevelComplete()){
                    if (!wasLevelCompleted)
                        CueEvents.add(C.CID_COMPLETE_LEVEL);
                }
            }

            var wasSecret:Boolean = Level.getRoom(room.roomID).@IsSecret;

            if (!wasMastered && Progress.checkHoldMastery()) {
                CueEvents.add(C.CID_HOLD_MASTERED);
                Progress.isGameMastered = true;
            }

			if (!Progress.wasRoomEverVisited(newRoomID))
				CueEvents.add(C.CID_ROOM_FIRST_VISIT, newRoomID);
			
            Progress.setScriptsEnded(finishedScripts, true);
            Progress.setGameVars(tempGameVars);
            Progress.roomEntered(newRoomID, newX, newY, player.o);

            new TEffectRoomSlide();

            room.clear();
            room = new Room();

            checkpointTurns.length = 0;

            room.loadRoom(newRoomID);
            player.setPosition(newX, newY, true);

            setRoomStartToPlayer();
            setPlayerToRoomStart();

            setMembersAfterRoomLoad();

            CueEvents.add(C.CID_EXIT_ROOM,  oldRoomID);
            CueEvents.add(C.CID_ENTER_ROOM, newRoomID);

            TWidgetLevelName.update(room.roomID, room.levelID);

            return true;
        }

        public static function loadFromLevelEntrance(entranceID:uint):void{
            var entrance:XML = Level.getEntrance(entranceID);

            Progress.roomEntered(entrance.@RoomID, entrance.@X, entrance.@Y, entrance.@O);

            if (room)
                room.clear();

            room = new Room();

            checkpointTurns.length = 0;

            room.resetRoom();
            room.loadRoom(entrance.@RoomID);

            levelStatsLoad();

            startRoomX = entrance.@X;
            startRoomY = entrance.@Y;
            startRoomO = entrance.@O;

            player.x = player.prevX = startRoomX;
            player.y = player.prevY = startRoomY;
            player.o = player.prevO = startRoomO;

            setRoomStartToPlayer();
            setPlayerToRoomStart();

            setMembersAfterRoomLoad();

            CueEvents.add(C.CID_ENTER_ROOM, entrance.@RoomID);
        }

        public static function loadFromRoom(roomID:uint, x:uint, y:uint, o:uint):void{
            if (room)
                room.clear();

            room = new Room();

            checkpointTurns.length = 0;

            room.loadRoom(roomID);
            CF::play{
                TWidgetLevelName.update(room.roomID, room.levelID);
            }

            startRoomX = x;
            startRoomY = y;
            startRoomO = o;

            player.x = player.prevX = x;
            player.y = player.prevY = y;
            player.o = player.prevO = o;

            setRoomStartToPlayer();
            setPlayerToRoomStart();

            setMembersAfterRoomLoad();

            levelStatsLoad();

            CueEvents.add(C.CID_ENTER_ROOM, roomID);
        }

        public static function restartRoom():void{
            room.reload();

            CueEvents.clear();
            setPlayerToRoomStart();
            setMembersAfterRoomLoad();

            CueEvents.add(C.CID_ENTER_ROOM, room.roomID);
        }

        public static function restartRoomFromLastCheckpoint():void{
            while (checkpointTurns.length && checkpointTurns[checkpointTurns.length - 1] >= turnNo)
                checkpointTurns.pop();

            if (checkpointTurns.length == 0){
                restartRoom();
                return;
            }

            var lastCheckpointTurn:uint = checkpointTurns.pop();
            if (!lastCheckpointTurn){
                restartRoom();
                return;
            }

            setTurn(lastCheckpointTurn);
            Commands.truncate(lastCheckpointTurn);
        }

        //}

        //{ Checkers
        /******************************************************************************************************/
        /**                                                                                         CHECKERS  */
        /******************************************************************************************************/

        public static function executingNoMoveCommands():Boolean {
            return executeNoMoveCommands;
        }

        /**
         * Retrieves the level stats as a string
         * @param	wholeHold Whether to give a total for the whole hold
         * @return String containing the necessary information with labels.
         */
        public static function getLevelStats(wholeHold:Boolean = false):String {
            CF::play{
                var deaths:uint;
                var moves :uint;
                var kills :uint;
                var time  :uint;

                var levelID:uint;

                var secretsFound:uint = 0;
                var secretsTotal:uint = 0;
                var secretRooms:Array;

                var roomXML:XML;

                if (wholeHold) {
                    for each(levelID in Level.getAllLevelIDs()) {
                        deaths += Progress.levelStats.getUint(levelID + "d", 0);
                        moves  += Progress.levelStats.getUint(levelID + "m", 0);
                        kills  += Progress.levelStats.getUint(levelID + "k", 0);
                        time   += Progress.levelStats.getUint(levelID + "t", 0);
                    }

                    secretRooms = Level.getAllSecretRooms();
                    for each(roomXML in secretRooms) {
                        secretsTotal++;

                        if (Progress.wasRoomEverVisited(roomXML.@RoomID))
                            secretsFound++;
                    }
                } else {
                    levelID = room.levelID;

                    deaths += Progress.levelStats.getUint(levelID + "d", 0);
                    moves  += Progress.levelStats.getUint(levelID + "m", 0);
                    kills  += Progress.levelStats.getUint(levelID + "k", 0);
                    time   += Progress.levelStats.getUint(levelID + "t", 0);

                    secretRooms = Level.getSecretRoomsByLevelID(room.levelID);
                    for each(roomXML in secretRooms) {
                        secretsTotal++;

                        if (Progress.wasRoomEverVisited(roomXML.@RoomID))
                            secretsFound++;
                    }
                }

                var result:String = "";

                if (wholeHold)
                    result += _("resultHoldTotals");
                else
                    result += _("resultLevelTotals");

                result += _("resultMoves",  moves);
                result += _("resultKills",  kills);
                result += _("resultDeaths", deaths);
                result += _("resultTime",   UString.styleTime(time * 1000, true, true, true, false));

                if (Progress.isGameCompleted)
                    result += _("resultSecretsBetter", secretsFound, secretsTotal);
                else
                    result += _("resultSecrets", secretsFound);

                return result;
            }
            CF::lib {
                return "";
            }
        }

        public static function getSpeakingEntity(cmd:VOSpeechCommand):TGameObject {
            var speech:VOSpeech = cmd.command.speech;
            var speaker:uint    = speech.character;

            if (speaker == C.SPEAK_Custom)
                speaker = C.SPEAK_None;

            var monster:TMonster    = cmd.speakingEntity;
            var entity :TGameObject = monster;

            if (speaker != C.SPEAK_Self && speaker != C.SPEAK_None) {
                var foundSpeaker:Boolean = false;

                if (monster is TCharacter) {
                    var character:TCharacter = monster as TCharacter;

                    if (character.visible && speaker == F.getSpeakerType(character.identity))
                        foundSpeaker = true;
                }

                if (!foundSpeaker) {
                    entity = room.getSpeaker(C.SPEAKERS[speaker]);
                }

                if (!entity)
                    entity = monster;
            }

            return entity;
        }

        public static function isCurrentRoomConquered():Boolean {
            return Progress.isRoomConquered(room.roomID);
        }

        public static function isCurrentRoomExplored():Boolean{
            return Progress.isRoomExplored(room.roomID);
        }

        public static function isCurrentRoomPendingExit():Boolean{
            return room.monsterCount == 0;
        }

        public static function isCurrentLevelComplete():Boolean{
            return Progress.isLevelCompleted(Level.getLevelIDByRoom(room.roomID))
        }

        public static function setPlayerMood():void{
            // Nervous - Aggressive - Tired - Normal
            var x:int;
            var y:int;
            var o:uint = player.o;
            var monster:TMonster;

            for (var i:uint = 0; i < 3; i++){
                x = player.x + NERVOUS_TILES_X[o][i];
                y = player.y + NERVOUS_TILES_Y[o][i];

                if (!F.isValidColRow(x, y))
                    continue;

                monster = room.tilesActive[x + y * S.LEVEL_WIDTH];

                if (monster && monster.isAggresive()){
                    CueEvents.add(C.CID_SWORDSMAN_AFRAID);
                    return;
                }
            }

            var sx:int = player.swordX;
            var sy:int = player.swordY;

            for (x = sx-1; x <= sx+1; x++){
                for (y = sy-1; y <= sy+1; y++){
                    if (x == sx && y == sy)
                        continue;

                    if (F.isValidColRow(x, y)){
                        monster = room.tilesActive[x + y * S.LEVEL_WIDTH];
                        if (monster && !(monster is TMonsterPiece) && monster.isAggresive()){
                            CueEvents.add(C.CID_SWORDSMAN_AGGRESSIVE);
                            return;
                        }
                    }
                }
            }

            CueEvents.add(C.CID_SWORDSMAN_NORMAL);
        }

        public static function wasRoomConqueredOnThisVisit():Boolean{
            if (room.monsterCount)
                return false;

            return !isCurrentRoomConquered();
        }

        //}

        //{ Snapshot

        /******************************************************************************************************/
        /**                                                                                         SNAPSHOT  */
        /******************************************************************************************************/

        public static function getSnapshot():Object {
            var object:Object = new Object;

            object.playerX = player.x;
            object.playerY = player.y;
            object.playerO = player.o;

            object.isInvisible = isInvisible;
            object.turnNo = turnNo;
            object.spawnCycleCount = spawnCycleCount;
            object.playerTurn = playerTurn;
            object.lastCheckpointX = lastCheckpointX;
            object.lastCheckpointY = lastCheckpointY;
            object.checkpointTurns = checkpointTurns.concat();
            object.tempGameVars = tempGameVars.clone();
            object.finishedScripts = finishedScripts.concat();

            object.room = room.getSnapshot();

            return object;
        }

        public static function loadSnapshot(snapshot:Object):void {

        }

        //}
    }
}