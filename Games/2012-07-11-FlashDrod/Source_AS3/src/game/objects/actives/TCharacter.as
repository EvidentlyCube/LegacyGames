package game.objects.actives {
    import flash.utils.ByteArray;

    import game.global.CueEvents;
    import game.global.DB;
    import game.global.Game;
    import game.global.Level;
    import game.global.PackedVars;
    import game.managers.VOCharacterCommand;
    import game.managers.VOCommands;
    import game.managers.VOSpeech;
    import game.managers.VOSpeechCommand;
    import game.objects.TGameObject;
    import game.states.TStateGame;

    import net.retrocade.utils.UByteArray;

    public class TCharacter extends TPlayerDouble{

        private var commands       :Array = [];

        private var jumpLabel      :uint;
        private var currentCommand :uint = 0;
        private var turnDelay      :uint = 0;

        public  var swordSafeToPlayer:Boolean = false;
        private var endWhenKilled    :Boolean = false;
        private var directMovement   :Boolean = false;

        public  var identity       :uint;
        public  var logicalIdentity:uint;
        public  var visible        :Boolean;
        private var playerTouchedMe:Boolean;

        private var ifBlock            :Boolean;

        public  var imperative         :uint;
        public  var scriptID           :uint;

        private var movingRelative     :Boolean = false;
        private var relX               :uint    = 0;
        private var relY               :uint    = 0;

        public  var scriptDone         :Boolean = false;





        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Game logic
        // ::::::::::::::::::::::::::::::::::::::::::::::

        override public function getType()    :uint    { return C.M_CHARACTER;  }
        override public function getIdentity():uint    { return identity;       }
        override public function isAggresive():Boolean { return false;          }
        override public function isVisible()  :Boolean { return visible;        }

        override public function update():void{
            if (visible)
                super.update();

            if (!swordSheathed && isVisible()){
                swordVO.x = swordX * S.LEVEL_TILE_WIDTH  + (prevX - x) * TStateGame.offset * S.LEVEL_TILE_WIDTH;
                swordVO.y = swordY * S.LEVEL_TILE_HEIGHT + (prevY - y) * TStateGame.offset * S.LEVEL_TILE_HEIGHT;
                TStateGame.addSwordDraw(swordVO);
            }
        }

        override public function setGfx():void {
            if (identity != C.M_BRAIN && o == C.NO_ORIENTATION)
                o = C.S;

            if (!swordSheathed){
                updateSwordChangedSheathing(true);
                swordSheathed = true;
            }

            switch(identity){
                case(C.M_BRAIN):
                    prevO = o = C.NO_ORIENTATION;
                    gfx = T.BRAIN[animationFrame]
                    break;
                case(C.M_CITIZEN1):
                case(C.M_CITIZEN2):
                case(C.M_CITIZEN3):
                case(C.M_CITIZEN4):
                    gfx = T.CITIZEN[o];
                    break;
                case(C.M_EYE):
                    gfx = T.EEYE[animationFrame][o];
                    break;
                case(C.M_EYE_ACTIVE):
                    gfx = T.EEYE[2][o];
                    break;
                case(C.M_GOBLIN):
                    gfx = T.GOBLIN[animationFrame][o];
                    break;
                case(C.M_MIMIC):
                    gfx = T.MIMIC[o];
                    swordSheathed = false;
                    updateSwordChangedSheathing(false);
                    break;
                case(C.M_MUDCOORDINATOR):
                    gfx = T.MUDCOORDINATOR[o];
                    break;
                case(C.M_NEGOTIATOR):
                    gfx = T.NEGOTIATOR[o];
                    break;
                case(C.M_QROACH):
                    gfx = T.RQUEEN[animationFrame][o];
                    break;
                case(C.M_ROACH):
                    gfx = T.ROACH[animationFrame][o];
                    break;
                case(C.M_REGG):
                    gfx = T.REGG[animationFrame][o];
                    break;
                case(C.M_SPIDER):
                    gfx = T.SPIDER[animationFrame][o];
                    break;
                case(C.M_TARBABY):
                    gfx = T.TARBABY[animationFrame][o];
                    break;
                case(C.M_TARTECHNICIAN):
                    gfx = T.TARTECHNICIAN[o];
                    break;
                case(C.M_WWING):
                    gfx = T.WWING[animationFrame][o];
                    break;
            }

            if (!swordSheathed)
                swordVO.gfxTile = T.SWORD[o];
        }

        override public function onStabbed(sX:uint, sY:uint):Boolean{
            if (imperative & C.IMP_INVULNERABLE)
                return false;

            CueEvents.add(C.CID_MONSTER_DIED_FROM_STAB, this);
            return true;
        }



        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Character logic
        // ::::::::::::::::::::::::::::::::::::::::::::::

        override public function process(lastCommand:uint):void {
            // #DEFINE /*STOP_COMMAND*/ {if (!jumpLabel) {finish(this); return;} jumpLabel=0; processNextCommand = true; break;}
            // #DEFINE /*STOP_DONECOMMAND*/ {if (!jumpLabel) {finish(this); return;} jumpLabel=0; break;}

            if (currentCommand >= commands.length)
                {finish(this); return;}

            var player:TPlayer = Game.player;

            var executeNoMoveCommands:Boolean = Game.executingNoMoveCommands();
            var doSwordHit           :Boolean = !executeNoMoveCommands;

            ifBlock = false;
            jumpLabel = 0;

            var processNextCommand:Boolean = false;
            var command:VOCharacterCommand;

            // Checking for infinite loops
            var turnCount:uint;
            var varSets  :uint;

            do {
                if (turnDelay) {
                    turnDelay -= 1;
                    {finish(this); return;}
                }

                if (currentCommand >= commands.length)
                    {finish(this); return;}

                command = commands[currentCommand];

                processNextCommand = false;

                switch(command.command) {
                    case(C.CC_APPEAR):
                        processNextCommand = true;

                        if (visible) break;

                        ASSERT(F.isValidColRow(x, y));
                        if (room.tilesActive[x + y * S.LEVEL_WIDTH] != null ||
                                (player.x == x && player.y == y) ||
                                room.tilesSwords[x + y * S.LEVEL_WIDTH])
                            /*STOP_COMMAND*/ {if (!jumpLabel) {finish(this); return;} jumpLabel=0; processNextCommand = true; break;}

                        setGfx();
                        visible = true;
                        room.tilesActive[x + y * S.LEVEL_WIDTH] = this;

                        if (imperative == C.IMP_REQUIRED_TO_CONQUER) {
                            room.monsterCount++;
                            CueEvents.add(C.CID_NPC_TYPE_CHANGE);
                        }

                        executeNoMoveCommands = true;

                        if (!swordSheathed)
                            updateSwordChangedSheathing(false);
                    break;
                    // Appear at (x,y)
                    case(C.CC_APPEAR_AT):
                        processNextCommand = true;

                        if (visible) break;

                        if (room.tilesActive[command.x + command.y * S.LEVEL_WIDTH] != null ||
                                (player.x == command.x && player.y == command.y) ||
                                room.tilesSwords[command.x + command.y * S.LEVEL_WIDTH])
                            /*STOP_COMMAND*/ {if (!jumpLabel) {finish(this); return;} jumpLabel=0; processNextCommand = true; break;}

                        setGfx();
                        visible = true;
                        prevX = x = command.x;
                        prevY = y = command.y;
                        room.tilesActive[x + y * S.LEVEL_WIDTH] = this;

                        if (imperative == C.IMP_REQUIRED_TO_CONQUER) {
                            room.monsterCount++;
                            CueEvents.add(C.CID_NPC_TYPE_CHANGE);
                        }

                        executeNoMoveCommands = true;

                        if (!swordSheathed)
                            updateSwordChangedSheathing(false);
                    break;

                    case(C.CC_DISAPPEAR):
                        processNextCommand = true;

                        if (!visible) break;

                        if (imperative == C.IMP_REQUIRED_TO_CONQUER) {
                            room.monsterCount--;
                            CueEvents.add(C.CID_NPC_TYPE_CHANGE);
                        }

                        disappear();
                        executeNoMoveCommands = true;

                        if (!swordSheathed)
                            updateSwordChangedSheathing(true);
                    break;

                    // Move to (x,y); w = Forbid Turning; h = Single Step
                    case(C.CC_MOVE_TO):
                        if (executeNoMoveCommands) {
                            if (jumpLabel)
                                currentCommand -= 1;
                            {finish(this); return;}
                        }

                        if (!visible) break;

                        var destX:int = command.x;
                        var destY:int = command.y;

                        // Moving towards specific character
                        if (command.flags){
                            var destination:TGameObject;
                            if (command.flags & C.FLAG_PLAYER)
                                destination = Game.player;

                            else if (command.flags & C.FLAG_MONSTER)
                                destination = room.monsters.getFirst() as TGameObject;

                            else if (command.flags & C.FLAG_NPC)
                                destination = room.getMonsterOfType(C.M_CHARACTER);

                            else if (command.flags & C.FLAG_PDOUBLE)
                                destination = room.getMonsterOfType(C.M_MIMIC);

                            else if (command.flags & C.FLAG_SELF)
                                break;

                            else if (command.flags & C.FLAG_PLAYER)
                                destination = Game.player;

                            if (!destination)
                                /*STOP_COMMAND*/ {if (!jumpLabel) {finish(this); return;} jumpLabel=0; processNextCommand = true; break;}

                            destX = destination.x;
                            destY = destination.y;
                        }

                        if (x == destX && y == destY) {
                            processNextCommand = true;
                            break;
                        }

                        if (directMovement)
                            throw new Error("Not yet implemented");
                        else
                            getBeelineMovementSmart(destX, destY, true, true);

                        if (!dx && !dy){
                            if (command.h){ // Is single move set?
                                if (!command.w) // Allow turning?
                                    setOrientation(dxFirst, dyFirst);

                                break;
                            }
                            /*STOP_COMMAND*/ {if (!jumpLabel) {finish(this); return;} jumpLabel=0; processNextCommand = true; break;}
                        }

                        //If moving toward a target entity, the NPC can't step on it
                        //unless it's the player and the NPC can kill him,
                        //so don't try to move if already adjacent.
                        if (!(command.flags && F.distanceInTiles(x, y, destX, destY) == 1 &&
                            (!(command.flags & C.FLAG_PLAYER) || safeToPlayer)))
                            moveCharacter(dx, dy, !command.w);

                        if (command.h)
                            break;

                        if (x != command.x || y != command.y)
                            /*STOP_DONECOMMAND*/ {if (!jumpLabel) {finish(this); return;} jumpLabel=0; break;}
                    break;

                    // Move by (x,y); w = Forbid Turning; h = Single Step
                    case(C.CC_MOVE_REL):
                        if (executeNoMoveCommands) {
                            if (jumpLabel)
                                currentCommand -= 1;
                            {finish(this); return;}
                        }

                        if (!visible) break;

                        // Initialize this funciton call
                        if (!movingRelative){
                            if (!command.x && !command.y){
                                processNextCommand = true;
                                break;
                            }

                            destX = x + int(command.x);
                            destY = y + int(command.y);

                            if (destX < 0)
                                destX = 0;
                            else if (destX >= S.LEVEL_WIDTH)
                                destX = S.LEVEL_WIDTH - 1;

                            if (destY < 0)
                                destY = 0;
                            else if (destY >= S.LEVEL_HEIGHT)
                                destY = S.LEVEL_HEIGHT - 1;

                            relX           = destX;
                            relY           = destY;
                            movingRelative = true;
                        }

                        if (directMovement)
                            throw new Error("Not yet implemented");
                        else
                            getBeelineMovementSmart(relX, relY, true, true);

                        if (!dx && !dy){
                            if (command.h){ // Is single move set?
                                if (!command.w) // Allow turning?
                                    setOrientation(dxFirst, dyFirst);

                                break;
                            }
                            /*STOP_COMMAND*/ {if (!jumpLabel) {finish(this); return;} jumpLabel=0; processNextCommand = true; break;}
                        }

                        moveCharacter(dx, dy, !command.w);

                        if (command.h){
                            movingRelative = false;
                            break;
                        }

                        if (x != relX || y != relY)
                            /*STOP_DONECOMMAND*/ {if (!jumpLabel) {finish(this); return;} jumpLabel=0; break;}

                        movingRelative = false;
                    break;

                    // Set orientation to W
                    case(C.CC_FACE_DIRECTION):
                        if (executeNoMoveCommands && visible) {
                            if (jumpLabel)
                                --currentCommand;
                            {finish(this); return;}
                        }

                        prevO = o;
                        switch(command.x){
                            case(C.CMD_C):
                                o = F.nextCO(o);
                                break;

                            case(C.CMD_CC):
                                o = F.nextCCO(o);
                                break;

                            default:
                                ASSERT(F.isValidOrientation(command.x) && command.x != C.NO_ORIENTATION);
                                o = command.x;
                                break;
                        }

                        if (!swordSheathed && isVisible()){
                            room.tilesSwords[swordX + swordY * S.LEVEL_WIDTH]--;
                            swordX = x + F.getOX(o);
                            swordY = y + F.getOY(o);
                            room.tilesSwords[swordX + swordY * S.LEVEL_WIDTH]++;
                        }

                        setGfx();

                        if (!visible || prevO == o)
                            processNextCommand = true;
                    break;

                    // Activate item (x,y)
                    case(C.CC_ACTIVATE_ITEM_AT):
                        if (room.tilesTransparent[command.x + command.y * S.LEVEL_WIDTH] == C.T_ORB){
                            if (executeNoMoveCommands) return;
                            room.activateOrb(command.x, command.y, C.OAT_SCRIPT_ORB);

                        } else
                            processNextCommand = true;
                    break;

                    // Wait x turns
                    case(C.CC_WAIT):
                        if (command.x){
                            if (executeNoMoveCommands)
                                /*STOP_COMMAND*/ {if (!jumpLabel) {finish(this); return;} jumpLabel=0; processNextCommand = true; break;}

                            turnDelay = command.x - 1;
                        }
                    break;

                    // Wait for x event
                    case(C.CC_WAIT_FOR_CUE_EVENT):
                        if (!CueEvents.hasOccured(command.x)){
                            if (!jumpLabel)
                                room.charactersWaitingForCueEvents.push(this);

                            /*STOP_COMMAND*/ {if (!jumpLabel) {finish(this); return;} jumpLabel=0; processNextCommand = true; break;}
                        }

                        processNextCommand = true;
                    break;

                    // Wait until an entity in flags is in rect (x,y,w,h).
                    case(C.CC_WAIT_FOR_RECT):
                    case(C.CC_WAIT_FOR_NOT_RECT):
                        var found:Boolean = false;
                        if (!found && (!command.flags || (command.flags & C.FLAG_PLAYER))){
                            if (player.x >= command.x && player.x <= command.x + command.w &&
                                    player.y >= command.y && player.y <= command.y + command.h)
                                found = true;
                        }
                        if (!found && (command.flags & C.FLAG_MONSTER)){
                            if (room.isMonsterInRect(command.x, command.y,
                                    command.x + command.w, command.y + command.h, true))
                                found = true;
                        }
                        if (!found && (command.flags & C.FLAG_NPC)){
                            if (room.isMonsterInRectOfType(command.x, command.y,
                                    command.x + command.w, command.y + command.h, C.M_CHARACTER))
                                found = true;
                        }
                        if (!found && (command.flags & C.FLAG_MONSTER)){
                            if (room.isMonsterInRectOfType(command.x, command.y,
                                    command.x + command.w, command.y + command.h, C.M_MIMIC))
                                found = true;
                        }
                        if (!found && (command.flags & C.FLAG_SELF)){
                            if (x >= command.x && x <= command.x + command.w &&
                                    y >= command.y && y <= command.y + command.h)
                                found = true;
                        }
                        if (!found && (command.flags & C.FLAG_BEETHRO)){
                            if (player.x >= command.x && player.x <= command.x + command.w &&
                                    player.y >= command.y && player.y <= command.y + command.h)
                                found = true;
                        }
                        // @TODO Tweaks for when appearances are added

                        if ((command.command == C.CC_WAIT_FOR_RECT && !found) ||
                                (command.command == C.CC_WAIT_FOR_NOT_RECT && found))
                            /*STOP_COMMAND*/ {if (!jumpLabel) {finish(this); return;} jumpLabel=0; processNextCommand = true; break;}

                        processNextCommand = true;
                    break;

                    // Wait for door at (x,y) to be w = closed / opened
                    case(C.CC_WAIT_FOR_DOOR_TO):
                        var tile:uint = room.tilesOpaque[command.x + command.y * S.LEVEL_WIDTH];
                        if (command.w == C.OA_CLOSE && !F.isDoor(tile))
                            /*STOP_COMMAND*/ {if (!jumpLabel) {finish(this); return;} jumpLabel=0; processNextCommand = true; break;}
                        if (command.w == C.OA_OPEN && F.isDoor(tile))
                            /*STOP_COMMAND*/ {if (!jumpLabel) {finish(this); return;} jumpLabel=0; processNextCommand = true; break;}

                        processNextCommand = true;
                    break;

                    // Wait until room reaches turn X
                    case(C.CC_WAIT_FOR_TURN):
                        if (Game.spawnCycleCount < command.x)
                            /*STOP_COMMAND*/ {if (!jumpLabel) {finish(this); return;} jumpLabel=0; processNextCommand = true; break;}

                        processNextCommand = true;
                    break;

                    // Wait until room is cleared
                    case(C.CC_WAIT_FOR_CLEAN_ROOM):
                        if (!room.greenDoorsOpened)
                            /*STOP_COMMAND*/ {if (!jumpLabel) {finish(this); return;} jumpLabel=0; processNextCommand = true; break;}

                        processNextCommand = true;
                    break;

                    // Wait until player faces orientation X
                    case(C.CC_WAIT_FOR_PLAYER_TO_FACE):
                        switch(command.x){
                            case (C.CMD_C):
                                if (player.o != F.nextCO(player.prevO))
                                    /*STOP_COMMAND*/ {if (!jumpLabel) {finish(this); return;} jumpLabel=0; processNextCommand = true; break;}
                                break;
                            case (C.CMD_CC):
                                if (player.o != F.nextCCO(player.prevO))
                                    /*STOP_COMMAND*/ {if (!jumpLabel) {finish(this); return;} jumpLabel=0; processNextCommand = true; break;}
                                break;
                            default:
                                if (player.o != command.x)
                                    /*STOP_COMMAND*/ {if (!jumpLabel) {finish(this); return;} jumpLabel=0; processNextCommand = true; break;}
                                break;
                        }
                        processNextCommand = true;
                    break;

                    // Wait until player moves in direction X
                    case(C.CC_WAIT_FOR_PLAYER_TO_MOVE):
                        var playerMoved:Boolean = (player.x != player.prevX || player.y != player.prevY);

                        switch(command.x){
                            case (C.CMD_C):
                                if (player.o != F.nextCO(player.prevO))
                                    /*STOP_COMMAND*/ {if (!jumpLabel) {finish(this); return;} jumpLabel=0; processNextCommand = true; break;}
                                break;
                            case (C.CMD_CC):
                                if (player.o != F.nextCCO(player.prevO))
                                    /*STOP_COMMAND*/ {if (!jumpLabel) {finish(this); return;} jumpLabel=0; processNextCommand = true; break;}
                                break;
                            default:
                                if (!playerMoved ||
                                    TPlayer.getSwordMovement(lastCommand, C.NO_ORIENTATION) != command.x)
                                    /*STOP_COMMAND*/ {if (!jumpLabel) {finish(this); return;} jumpLabel=0; processNextCommand = true; break;}
                                break;
                        }
                        processNextCommand = true;
                    break;

                    // Wait until player bumps
                    case(C.CC_WAIT_FOR_PLAYER_TO_TOUCH_ME):
                        if (!playerTouchedMe)
                            /*STOP_COMMAND*/ {if (!jumpLabel) {finish(this); return;} jumpLabel=0; processNextCommand = true; break;}
                        processNextCommand = true;
                    break;

                    // Label holder
                    case(C.CC_LABEL):
                        processNextCommand = true;
                    break;

                    // Goto label X
                    case(C.CC_GOTO):
                        var nextIndex:uint = getIndexOfCommandWithLabel(command.x);
                        if (nextIndex != -1)
                            currentCommand = nextIndex;
                        else
                            currentCommand++;

                        processNextCommand = true;
                    break;

                    // Deliver speech SpeechID at (x,y)
                    case(C.CC_SPEECH):
                        if (!command.speech)
                            break;

                        var speech:VOSpeechCommand = new VOSpeechCommand(this, command, Game.turnNo, scriptID, currentCommand);
                        speech.text = command.speech.message;

                        CueEvents.add(C.CID_SPEECH, speech);

                        processNextCommand = true;
                    break;

                    // Purge speech events in queue (x=display/erase)
                    case(C.CC_FLUSH_SPEECH):
                        // @TODO Implement Flush Speech
                        //throw new Error("Not implemented");
                        processNextCommand = true;
                    break;

                    // Sets imperative status to X
                    case(C.CC_IMPERATIVE):
                        var newImperative   :uint    = command.x;
                        var changeImperative:Boolean = true;

                        switch(newImperative) {
                            case(C.IMP_SAFE):
                                safeToPlayer     = true;
                                changeImperative = false;
                                break;
                            case(C.IMP_SWORD_SAFE_TO_PLAYER):
                                swordSafeToPlayer = true;
                                changeImperative  = false;
                                break;
                            case(C.IMP_END_WHEN_KILLED):
                                endWhenKilled    = true;
                                changeImperative = false;
                                break;
                            case(C.IMP_DEADLY):
                                safeToPlayer     = swordSafeToPlayer = false;
                                changeImperative = false;
                                break;
                            case(C.IMP_DIE):
                                if (executeNoMoveCommands && changeImperative)
                                    return;

                                if (changeImperative)
                                    currentCommand = commands.length;

                                if (visible) {
                                    if (!executeNoMoveCommands)
                                        CueEvents.add(C.CID_MONSTER_DIED_FROM_STAB, this);

                                    if (changeImperative) {
                                        killDirection = C.NO_ORIENTATION;
                                        room.killMonster(this, true);
                                    }
                                }
                                break;
                            case(C.IMP_FLEXIBLE_BEELINING):
                                directMovement   = false;
                                changeImperative = false;
                                break;
                            case(C.IMP_DIRECT_BEELINING):
                                directMovement   = true;
                                changeImperative = false;
                                break;
                        }

                        if (changeImperative) {
                            var oldImperative:uint = imperative;
                            if (visible && newImperative != oldImperative) {
                                if (newImperative == C.IMP_REQUIRED_TO_CONQUER) {
                                    room.monsterCount++;
                                    CueEvents.add(C.CID_NPC_TYPE_CHANGE);

                                } else if (oldImperative == C.IMP_REQUIRED_TO_CONQUER) {
                                    if (isAlive)
                                        room.monsterCount--;
                                    CueEvents.add(C.CID_NPC_TYPE_CHANGE);
                                }
                            }

                            imperative = newImperative;
                        }

                        if (isAlive)
                            processNextCommand = true;
                    break;

                    // Turns into monster
                    case(C.CC_TURN_INTO_MONSTER):
                        turnIntoMonster();
                    break;

                    // End script
                    case(C.CC_END_SCRIPT):
                        if (!scriptDone){
                            scriptDone = true;
                            Game.finishedScripts.push(scriptID);
                        }
                        currentCommand = commands.length;
                    break;
                    case(C.CC_END_SCRIPT_ON_EXIT):
                        if (!scriptDone){
                            scriptDone = true;
                            Game.finishedScripts.push(scriptID);
                        }
                        processNextCommand = true;
                    break;
                    case(C.CC_IF):
                        currentCommand++;
                        jumpLabel          = currentCommand + 1;
                        ifBlock            = true;
                        processNextCommand = true;
                    continue;
                    case(C.CC_IF_ELSE):
                        ifBlock            = true;
                        processNextCommand = true;
                    break;
                    case(C.CC_IF_END):
                        processNextCommand = true;
                    break;

                    // Takes player to level entrance X.  If Y is set, skip level entrance display.
                    case(C.CC_LEVEL_ENTRANCE):
                        if (!Game.turnNo)
                            return;

                        Game.gotoLevelEntrance(command.x, command.y != 0);
                    break;

                    // Sets var X (operation Y) W, e.g. X += 5
                    case(C.CC_VAR_SET):
                        var leftName :String  = command.x.toString();
                        var leftType :uint    = Game.tempGameVars.typeOf(leftName);
                        var isLeftInt:Boolean = (leftType == C.UVT_int || leftType == C.UVT_unknown);

                        var operand  :int     = command.w as int;

                        if (command.label){
                            var operandName:String = Level.getVarIDByName(command.label);
                            var operandType:uint   = Game.tempGameVars.typeOf(operandName);

                            if (operandName != "" && (operandType == C.UVT_int || operandType == C.UVT_unknown))
                                operand = Game.tempGameVars.getInt(operandName);
                        }

                        var leftOperand:int    = 0;
                        var setNumber  :Boolean = (leftType != C.VAR_AppendText || leftType != C.VAR_AssignText);

                        switch(command.y){
                            case(C.VAR_Assign):
                                leftOperand = operand;
                                break;

                            case(C.VAR_Inc):
                                if (isLeftInt)
                                    leftOperand = Game.tempGameVars.getInt(leftName, 0);
                                leftOperand += operand;
                                break;

                            case(C.VAR_Dec):
                                if (isLeftInt)
                                    leftOperand = Game.tempGameVars.getInt(leftName, 0);
                                leftOperand -= operand;
                                break;

                            case(C.VAR_MultiplyBy):
                                if (isLeftInt)
                                    leftOperand = Game.tempGameVars.getInt(leftName, 0);
                                leftOperand *= operand;
                                break;

                            case(C.VAR_DivideBy):
                                if (isLeftInt)
                                    leftOperand = Game.tempGameVars.getInt(leftName, 0);
                                if (operand)
                                    leftOperand /= operand;
                                break;

                            case(C.VAR_Mod):
                                if (isLeftInt)
                                    leftOperand = Game.tempGameVars.getInt(leftName, 0);
                                leftOperand %= operand;
                                break;

                            case(C.VAR_AssignText):
                                Game.tempGameVars.setString(leftName, command.label);
                                break;

                            case(C.VAR_AssignText):
                                Game.tempGameVars.setString(leftName, Game.tempGameVars.getString(leftName, "") + command.label);
                                break;
                        }

                        if (setNumber)
                            Game.tempGameVars.setInt(leftName, leftOperand);

                        varSets++;
                        turnCount = 0;

                        processNextCommand = true;
                    break;

                    // Wait until var X (comparison Y) W, e.g. X >= 5
                    case(C.CC_WAIT_FOR_VAR):
                        leftName  = command.x.toString();
                        leftType  = Game.tempGameVars.typeOf(leftName);
                        isLeftInt = (leftType == C.UVT_int || leftType == C.UVT_unknown);

                        operand   = command.w as int;

                        if (command.label){
                            operandName = Level.getVarIDByName(command.label);
                            operandType   = Game.tempGameVars.typeOf(operandName);

                            if (operandName != "" && (operandType == C.UVT_int || operandType == C.UVT_unknown))
                                operand = Game.tempGameVars.getInt(operandName);
                        }

                        leftOperand             = 0;
                        var isNumber   :Boolean = (isLeftInt && command.y != C.VAR_EqualsText);

                        if (isNumber)
                            leftOperand = Game.tempGameVars.getInt(leftName, 0);

                        switch(command.y){
                            case (C.VAR_Equals):
                                if (leftOperand != operand)
                                    /*STOP_COMMAND*/ {if (!jumpLabel) {finish(this); return;} jumpLabel=0; processNextCommand = true; break;}
                            break;
                            case (C.VAR_Greater):
                                if (leftOperand <= operand)
                                /*STOP_COMMAND*/ {if (!jumpLabel) {finish(this); return;} jumpLabel=0; processNextCommand = true; break;}
                                break;
                            case (C.VAR_Less):
                                if (leftOperand >= operand)
                                    /*STOP_COMMAND*/ {if (!jumpLabel) {finish(this); return;} jumpLabel=0; processNextCommand = true; break;}
                                break;
                            case (C.VAR_EqualsText):
                                var str:String;
                                if (leftType == C.UVT_char_string)
                                    str = Game.tempGameVars.getString(leftName, "");

                                if (str != command.label)
                                    /*STOP_COMMAND*/ {if (!jumpLabel) {finish(this); return;} jumpLabel=0; processNextCommand = true; break;}
                                break;
                        }

                        processNextCommand = true;
                    break;

                    // Sets this NPC to look like entity X.
                    case(C.CC_SET_NPC_APPEARANCE):
                        identity = logicalIdentity = command.x;
                        setGfx();
                        processNextCommand = true;
                    break;


                }

                currentCommand++;

                if (ifBlock)
                    movingRelative = false;

                if (jumpLabel){
                    nextIndex = ifBlock ? jumpLabel : getIndexOfCommandWithLabel(jumpLabel);

                    if (nextIndex != -1)
                        currentCommand = nextIndex;

                    jumpLabel = 0;
                    ifBlock = false;
                } else if (ifBlock)
                    failedIfCondition();

                if (++turnCount > commands.length || varSets > 1000){
                    throw new Error("Infinite character loop");
                    currentCommand = commands.length;
                }

            } while (processNextCommand);

            finish(this);

            function finish(self:TCharacter):void {
                playerTouchedMe = false;
                if (doSwordHit && !swordSheathed && isVisible())
                    Game.processSwordHit(swordX, swordY, self);
            }
        }

        /**
         * If character is waiting for CueEvent and it hadn't happened in its
         * Process sequence, it is added to be checked after all monsters move
         * and room actions take place, after which a check is made
         * of the CueEvent again
         */
        public function checkForCueEvents():void{
            var command:VOCharacterCommand = commands[currentCommand];

            if (CueEvents.hasOccured(command.x))
                currentCommand++;
        }

        /**
         * Changes the character into a monster
         */
        private function turnIntoMonster():void{
            var identity:uint = getIdentity();

            if (!F.isValidMonsterType(identity)){
                if (identity != C.M_EYE_ACTIVE){
                    currentCommand = commands.length;
                    return;
                }

                identity = C.M_EYE;
            }

            room.killMonster(this, true, true);

            if (!visible)
                return;

            var monster:TMonster = room.addNewMonster(identity, x, y, o);
            if (monster is TEvilEye && active){
                TEvilEye(monster).active = true;
                monster.setGfx();
            }

            CueEvents.add(C.CID_NPC_TYPE_CHANGE);
        }

        private function moveCharacter(dx:int, dy:int, allowTurning:Boolean):void{
            var oTile:uint = room.tilesOpaque[x + y * S.LEVEL_WIDTH];

            move(x + dx, y + dy);
            swordMovement = F.getO(dx, dy);

            if (!swordSheathed && isVisible()){
                room.tilesSwords[swordX + swordY * S.LEVEL_WIDTH]--;
                swordX = x + F.getOX(o);
                swordY = y + F.getOY(o);
                room.tilesSwords[swordX + swordY * S.LEVEL_WIDTH]++;
            }

            if (allowTurning)
                setOrientation(dx, dy);

            if (!safeToPlayer && Game.player.x == x && Game.player.y == y)
                CueEvents.add(C.CID_MONSTER_KILLED_PLAYER, this);
        }

        private function disappear():void {
            ASSERT(room);
            visible = false;
            ASSERT(room.tilesActive[x + y * S.LEVEL_WIDTH] == this);
            room.tilesActive[x + y * S.LEVEL_WIDTH] = null;
        }

        private function getIndexOfCommandWithLabel(label:uint):int{
            if (label)
                for (var i:uint = commands.length; i--;){
                    var command:VOCharacterCommand = commands[i];
                    if (command.command == C.CC_LABEL && label == command.x)
                        return i;
                }

            return -1;
        }

        private function failedIfCondition():void{
            var nestingDepth:uint    = 0;
            var scanning    :Boolean = true;

            do {
                if (currentCommand >= commands.length)
                    return;

                var command:VOCharacterCommand = commands[currentCommand];

                switch (command.command){
                    case(C.CC_IF):
                        nestingDepth++;
                        break;
                    case(C.CC_IF_ELSE):
                        if (nestingDepth == 0)
                            scanning = false;
                        break;
                    case(C.CC_IF_END):
                        if (nestingDepth-- == 0)
                            scanning = false;
                        break;
                }

                currentCommand++;
            } while (scanning);

            ifBlock = false;
        }


        // DESERIALIZATION

        override public function setMembersFromExtraVars(extra:PackedVars):void {
            logicalIdentity = extra.getUint("id", 0);
            identity        = logicalIdentity;

            visible = extra.getBool("visible", false);

            swordSheathed = true;

            setGfx();

            scriptID = extra.getUint("ScriptID", 0);

            var commandBuffer:ByteArray = extra.getByteArray("Commands", null);

            if (commandBuffer)
                deserializeCommands(commandBuffer);
        }

        private function deserializeCommands(buffer:ByteArray):void{
            var index:uint = 0;
            var bufferSize:uint = buffer.length;

            while (index < bufferSize){
                var command:VOCharacterCommand = new VOCharacterCommand;

                command.command = readBpUINT(buffer);
                command.x       = readBpUINT(buffer);
                command.y       = readBpUINT(buffer);
                command.w       = readBpUINT(buffer);
                command.h       = readBpUINT(buffer);
                command.flags   = readBpUINT(buffer);

                var speechID:uint = readBpUINT(buffer);
                if (speechID){
                    command.speech = DB.getSpeech(speechID);
                    CF::play{
                        ASSERT(command.speech);
                    }
                }

                var labelSize:uint = readBpUINT(buffer);
                if (labelSize){
                    var wchars:uint = labelSize/2;

                    index = buffer.position;
                    command.label = UByteArray.readWChar(buffer, index, labelSize);
                    buffer.position = index + labelSize;
                }

                index = buffer.position;

                commands.push(command);
            }

        }

        private function readBpUINT(buffer:ByteArray):uint {
            var index :uint = buffer.position;
            var index2:uint = index++;

            var n:uint = 0

            do{
                n = (n << 7) + buffer[index2];

                if (buffer[index2++] & 0x80)
                    break;

                index++;

            } while (true);

            buffer.position = index;

            return n - 0x80;
        }
    }
}