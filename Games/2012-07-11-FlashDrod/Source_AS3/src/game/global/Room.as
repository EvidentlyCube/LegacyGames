package game.global {
    import game.objects.actives.TPlayerDouble;
    import net.retrocade.utils.Base64;

    import flash.display.BitmapData;
    import flash.utils.ByteArray;
    import flash.utils.getTimer;

    import game.managers.VOCheckpoints;
    import game.managers.VOCoord;
    import game.managers.VOOrb;
    import game.managers.VOOrbAgent;
    import game.managers.VOScroll;
    import game.managers.VOStairs;
    import game.objects.TGameObject;
    import game.objects.actives.TBrain;
    import game.objects.actives.TCharacter;
    import game.objects.actives.TEvilEye;
    import game.objects.actives.TGoblin;
    import game.objects.actives.TMimic;
    import game.objects.actives.TMonster;
    import game.objects.actives.TPlayer;
    import game.objects.actives.TRedSerpent;
    import game.objects.actives.TRoach;
    import game.objects.actives.TRoachEgg;
    import game.objects.actives.TRoachQueen;
    import game.objects.actives.TSerpent;
    import game.objects.actives.TSpider;
    import game.objects.actives.TTarBaby;
    import game.objects.actives.TTarMother;
    import game.objects.actives.TWraithwing;
    import game.widgets.TWidgetLevelName;

    import net.retrocade.camel.core.rGfx;
    import net.retrocade.camel.core.rGroup;
    import net.retrocade.camel.layers.rLayerBlit;
    import net.retrocade.standalone.Bitext;
    import net.retrocade.standalone.BitextFont;
    import net.retrocade.utils.UString;

    /**
     * ...
     * @author
     */
    public class Room {
        private static var _doorTiles:Array = [330,242,308,44,264,198,0,22,286,176,220,110,132,154,66,88];
        private static var _tarOrthoCheckX:Array = [ 0, 1, 0, -1];
        private static var _tarOrthoCheckY:Array = [-1, 0, 1,  0];

        /**
         * Opaque tiles BYTE
         */
        public var tilesOpaque     :Array = [];

        /**
         * Transparent BYTE
         */
        public var tilesTransparent:Array = [];

        /**
         * Transparent param BYTE
         */
        public var tilesTransparentParam:Array = [];

        /**
         * Active TGameObject
         */
        public var tilesActive     :Array = [];

        /**
         * Floor BYTE
         */
        public var tilesFloor      :Array = [];

        /**
         * Counts amount of swords on the given tile BYTE
         */
        public var tilesSwords     :Array = [];

        public var layerUnder      :DrodLayer;
        public var layerActive     :DrodLayer;

        public var monsters        :rGroup = new rGroup();
        public var plots           :Array = [];

        public var charactersWaitingForCueEvents:Array = [];

        public var trapdoorsLeft   :uint = 0;
        public var tarLeft         :uint = 0;
        public var monsterCount    :uint = 0;
        public var brainCount      :uint = 0;

        public var roomID          :uint = uint.MAX_VALUE;
        public var levelID         :uint = uint.MAX_VALUE;

        public var lastRoomID      :uint = uint.MAX_VALUE; // Used to help myself with some of
        public var lastLevelID     :uint = uint.MAX_VALUE; // Minimap widget calculations

        public var currentTurn     :uint = 1;

        public var brainMove       :Boolean = true;
        public var greenDoorsOpened:Boolean = false;
        public var tarWasStabbed   :Boolean = false;

        public var pathmapGround   :Pathmap;
        public var pathmapAir      :Pathmap;

        // Agents
        public var orbs            :Array = [];
        public var stairs          :Array = [];
        public var scrolls         :Array = [];
        public var checkpoints     :VOCheckpoints = new VOCheckpoints;

        public var renderer        :Renderer = new Renderer();



        //{ Uncategorized

        /******************************************************************************************************/
        /**                                                                                    UNGATEGORIZED  */
        /******************************************************************************************************/

        public function Room() {
            CF::play {
                layerActive       = new DrodLayer(S.LEVEL_WIDTH_PIXELS, S.LEVEL_HEIGHT_PIXELS, S.LEVEL_OFFSET_X, S.LEVEL_OFFSET_Y);
                layerUnder        = new DrodLayer(S.SIZE_GAME_WIDTH, S.SIZE_GAME_HEIGHT, 0, 0);

                layerUnder.offsetX = S.LEVEL_OFFSET_X;
                layerUnder.offsetY = S.LEVEL_OFFSET_Y;

                layerUnder.blitDirectly(Gfx.IN_GAME_SCREEN, 0, 0);
            }
            CF::lib {
                if (!SpiderMain.noGfx){
                    layerActive       = new DrodLayer(S.LEVEL_WIDTH_PIXELS, S.LEVEL_HEIGHT_PIXELS, S.LEVEL_OFFSET_X, S.LEVEL_OFFSET_Y);
                    layerUnder        = new DrodLayer(S.SIZE_GAME_WIDTH, S.SIZE_GAME_HEIGHT, 0, 0);

                    layerUnder.offsetX = S.LEVEL_OFFSET_X;
                    layerUnder.offsetY = S.LEVEL_OFFSET_Y;
                }
            }
        }

        public function clear():void{
            checkpoints.clear();
            renderer   .clear();
            monsters   .clear();

            CF::play {
                layerUnder .removeLayer();
                layerActive.removeLayer();
            }
            CF::lib {
                if (!SpiderMain.noGfx){
                    layerUnder .removeLayer();
                    layerActive.removeLayer();
                }
            }

            if (pathmapGround) pathmapGround.clear();
            if (pathmapAir)    pathmapAir   .clear();

            tilesOpaque           = null;
            tilesTransparent      = null;
            tilesTransparentParam = null;
            tilesActive           = null;
            tilesFloor            = null;
            tilesSwords           = null;
            plots                 = null;
            orbs                  = null;
            stairs                = null;
            scrolls               = null;
            checkpoints           = null;
        }

        public function loadRoom(roomID:uint):void {
            resetRoom();

            lastRoomID   = this.roomID;
            this.roomID  = roomID;

            var room:XML = Level.getRoom(roomID);

            lastLevelID  = levelID;
            levelID      = room.@LevelID;

            var styleName:String = Base64.decodeWChar(room.@StyleName);

            loadSquaresIntoArrays(roomID, tilesOpaque, tilesTransparent, tilesTransparentParam, tilesFloor);

            // Load monsters
            var i:uint = 0;
            var monster:XML;
            while ((monster = room.Monsters[i++]) != null) {
                addNewMonsterXML(monster);
            }

            // Load orbs
            i = 0;
            var orb:XML;
            while ((orb = room.Orbs[i++]) != null) {
                var orbData:VOOrb = new VOOrb(parseInt(orb.@X), parseInt(orb.@Y));

                for each(var orbAgent:XML in orb.children()) {
                    orbData.addAgent(orbAgent.@Type, orbAgent.@X, orbAgent.@Y);
                }

                orbs[orbData.x + orbData.y * S.LEVEL_WIDTH] = orbData;
                plot(orb.@X, orb.@Y, C.T_ORB, 0);
            }

            // Load stairs
            i = 0;
            var exit:XML;
            while ((exit = room.Exits[i++]) != null){
                stairs.push(new VOStairs(exit));
            }

            // Load checkpoints
            i = 0;
            var checkpoint:XML;
            while ((checkpoint = room.Checkpoints[i++]) != null){
                checkpoints.addCheckpoint(checkpoint);
            }

            // Load scrolls
            i = 0;
            var scroll:XML;
            while ((scroll = room.Scrolls[i++]) != null){
                var scrollData:VOScroll = new VOScroll(scroll.@X, scroll.@Y, Base64.decodeWChar(scroll.@Message));
                scrolls[scrollData.x + scrollData.y * S.LEVEL_WIDTH] = scrollData;
            }

            renderer.prepareRoom(styleName, tilesOpaque, tilesTransparent, tilesTransparentParam, tilesFloor, checkpoints, layerUnder);
            drawRoom();

            initRoomStats();
        }

        public function loadSquaresIntoArrays(roomID:uint, tilesO:Array, tilesT:Array, tilesTParam:Array,
                                                     tilesF:Array):void{
            var room:XML = Level.getRoom(roomID);

            ASSERT(room, "Invalid Room ID: " + roomID);

            lastLevelID  = levelID;
            levelID      = room.@LevelID;

            var squaresBA:ByteArray = Base64.decodeByteArray(room.@Squares);

            squaresBA.position = 0;

            if (squaresBA.readUnsignedByte() != 5)
                throw new ArgumentError("Invalid data format version, should be 5 was: " + squaresBA[0]);

            var i    :uint = 0;
            var count:int = 0;
            var tile :int = 0;

            // Opaque Layer
            for(i = 0; i < S.LEVEL_WIDTH * S.LEVEL_HEIGHT; i++){
                if (!count){
                    count = squaresBA.readUnsignedByte();
                    tile  = tileSanitizer(squaresBA.readUnsignedByte());
                }

                tilesO[i] = tile;
                count--;
            }

            // Floor Layer
            for(i = 0; i <  S.LEVEL_WIDTH * S.LEVEL_HEIGHT; i++){
                if (!count){
                    count = squaresBA.readUnsignedByte();
                    tile  = tileSanitizer(squaresBA.readUnsignedByte());
                }

                tilesF[i] = tile;
                count--;
            }

            var lastParam:uint = 0;
            // Transparent Layer with Parameter (ignored)
            for(i = 0; i <  S.LEVEL_WIDTH * S.LEVEL_HEIGHT; i++){
                if (!count){
                    count = squaresBA.readUnsignedByte();
                    tile  = tileSanitizer(squaresBA.readUnsignedByte());

                    lastParam = squaresBA.readUnsignedByte();
                }

                if (tile != C.T_EMPTY)
                    tilesT[i] = tile;

                tilesTParam[i] = lastParam;
                count--;
            }
        }

        public function reload():void{
            loadRoom(roomID);
        }

        /** Counts all elements in the room and gathers other data **/
        public function initRoomStats():void{
            for(var i:uint = 0; i < S.LEVEL_TOTAL; i++){
                switch(tilesOpaque[i]){
                    case(C.T_TRAPDOOR): case(C.T_TRAPDOOR_WATER):
                        trapdoorsLeft++; break;
                }

                switch(tilesTransparent[i]){
                    case(C.T_MUD): case(C.T_TAR): case(C.T_GEL):
                        tarLeft++;break;
                }
            }
        }

        public function setRoomEntryState(wasLevelComplete:Boolean, isCurrentLevelComplete:Boolean,
                                                 wasRoomConquered:Boolean, monsterCountAtStart:uint):void{
            if (wasRoomConquered){
                toggleGreenDoors();
                clearMonsters(true);
                monsterCountAtStart = 0;

            } else if (!monsterCountAtStart){
                CueEvents.add(C.CID_CONQUER_ROOM, roomID);
                toggleGreenDoors();
                clearMonsters(true);

            }

            removeFinishedCharacters();

            if (isCurrentLevelComplete){
                if (!wasLevelComplete)
                    CueEvents.add(C.CID_COMPLETE_LEVEL);
                toggleOTiles(C.T_DOOR_C, C.T_DOOR_CO);
            }

            if (trapdoorsLeft == 0)
                toggleOTiles(C.T_DOOR_R, C.T_DOOR_RO);

            if (tarLeft == 0)
                toggleBlackGates();

            else if (!monsterCountAtStart)
                fixUnstableTar();
        }

        public function resetRoom():void {
            var i:uint, l:uint;

            for (i = 0, l =  S.LEVEL_WIDTH * S.LEVEL_HEIGHT; i < l; i++) {
                tilesOpaque[i]           = C.T_FLOOR;
                tilesTransparent[i]      = C.T_EMPTY;
                tilesTransparentParam[i] = 0;
                tilesFloor[i]            = C.T_EMPTY;
                tilesActive[i]           = null;
                tilesSwords[i]           = 0;
            }

            monsters.clear();

            trapdoorsLeft = 0;
            tarLeft       = 0;
            brainCount    = 0;
            monsterCount  = 0;

            CF::play {
                layerUnder      .clearTiles();
                layerActive     .clearTiles();
            }
            CF::lib {
                if (!SpiderMain.noGfx){
                    layerUnder      .clearTiles();
                    layerActive     .clearTiles();
                }
            }

            orbs   .length = 0;
            stairs .length = 0;
            scrolls.length = 0;

            checkpoints.clear();
        }

        //}

        //{ Action

        /******************************************************************************************************/
        /**                                                                                           ACTION  */
        /******************************************************************************************************/

        public function activateOrb(wX:uint, wY:uint, activationType:uint):void {
            var orb:VOOrb = orbs[wX + wY * S.LEVEL_WIDTH];

            switch(activationType) {
                case(C.OAT_PLAYER):
                    CueEvents.add(C.CID_ORB_ACTIVATED_BY_PLAYER, orb || new VOCoord(wX, wY, 0));
                    break;

                case(C.OAT_MONSTER):
                case(C.OAT_SCRIPT_ORB):
                    CueEvents.add(C.CID_ORB_ACTIVATED_BY_DOUBLE, orb || new VOCoord(wX, wY, 0));
                    break;
            }

            if (!orb || !orb.agents)
                return;

            var agent:VOOrbAgent;
            for each(agent in orb.agents) {
                var TTile:uint = tilesTransparent[agent.tX + agent.tY * S.LEVEL_WIDTH];

                switch(agent.type) {
                    case(C.OA_TOGGLE):
                        toggleYellowDoor(agent.tX, agent.tY);
                        break;

                    case(C.OA_OPEN):
                        openYellowDoors(agent.tX, agent.tY);
                        break;

                    case(C.OA_CLOSE):
                        closeYellowDoors(agent.tX, agent.tY);
                        break;
                }
            }
        }

        /**
         * Calls checkForCueEvents() on all characters which
         * failed to get their CueEvent wait resolved this turn
         */
        public function charactersCheckForCueEvents():void{
            for each (var character:TCharacter in charactersWaitingForCueEvents)
                character.checkForCueEvents();

            charactersWaitingForCueEvents.length = 0;
        }

        public function fixUnstableTar():void {
            var stable:Boolean;

            var x:uint, y:uint, index:uint, tile:uint, monster:TMonster;
            do {
                stable = true;
                for (y = 0; y < S.LEVEL_HEIGHT; y++){
                    for (x = 0; x < S.LEVEL_WIDTH; x++) {
                        tile = tilesTransparent[index = x + y * S.LEVEL_WIDTH];

                        if (F.isTar(tile) && !isTarStableAt(x, y, tile)) {
                            monster = tilesActive[index];

                            if (monster && F.isMother(monster.getType()))
                                continue;

                            destroyTar(x, y);
                            stable = false;
                        }
                    }
                }
            } while (!stable);
        }

        public function isTarStableAt(tx:uint, ty:uint, type:uint):Boolean {
            var tar:Array = [];
            var x:uint, y:uint;

            for (y = ty - 1; y != ty + 2; y++){
                if (y < S.LEVEL_HEIGHT){
                    for (x = tx - 1; x != tx + 2; x++){
                        if (x < S.LEVEL_WIDTH)
                            tar[x - tx + 1 + (y - ty + 1) * 3] =
                                (tilesTransparent[x + y * S.LEVEL_WIDTH] == type);
                    }
                }
            }

            return (tar[0] && tar[3] && tar[1])  ||
                   (tar[6] && tar[3] && tar[7])  ||
                   (tar[2] && tar[5] && tar[1])  ||
                   (tar[8] && tar[5] && tar[7]);
        }

        public function preprocessMonsters():void{
            var m:TMonster;
            var monsters:Array = monsters.getAllOriginal();

            for(var i:uint = 0, l:uint = monsters.length; i < l; i++){
                if (!(m = monsters[i]))
                    continue;

                if (m is TCharacter)
                    m.process(C.CMD_WAIT);
            }
        }

        public function processTurn(fullMove:Boolean):void{
            if (fullMove){
                if (CueEvents.hasOccured(C.CID_TAR_GREW)){
                    var babies:Array = [];

                    growTar(C.T_TAR, babies);
                }
            }
        }

        public function stabTar(x:uint, y:uint, removeNow:Boolean, stabO:uint = C.NO_ORIENTATION):Boolean{
            if (removeNow){
                var tSquare:uint = tilesTransparent[x + y * S.LEVEL_WIDTH];
                if (F.isTar(tSquare)){
                    removeStabbedTar(x, y);
                    tarWasStabbed = true;

                    CueEvents.add(C.CID_TARSTUFF_DESTROYED, new VOCoord(x, y, stabO));

                    return true;
                }
                return false;
            }

            return isTarVulnerableToStab(x, y);
        }

        //}

        //{ Setters

        /******************************************************************************************************/
        /**                                                                                          SETTERS  */
        /******************************************************************************************************/

        public function updatePathmapAt(x:uint, y:uint):void {
            if (pathmapGround)
                pathmapGround.squareChanged(x, y);

            if (pathmapAir)
                pathmapAir.squareChanged(x, y);
        }

        public function createPathmap(x:uint, y:uint, movementType:uint):void{
            switch(movementType){
                case(C.MOVEMENT_GROUND):
                    if (!pathmapGround)
                        pathmapGround = new Pathmap(movementType, false);
                    pathmapGround.setTarget(x, y);

                    pathmapGround.room = this;
                    pathmapGround.resetDeep();
                    break;

                case(C.MOVEMENT_AIR):
                    if (!pathmapAir)
                        pathmapAir = new Pathmap(movementType, false);
                    pathmapAir.setTarget(x, y);

                    pathmapAir.room = this;
                    pathmapAir.resetDeep();
                    break;
            }
            // @TODO Add other pathmaps
        }

        public function deletePathmaps():void{
            if (pathmapGround) pathmapGround.clear();
            if (pathmapAir)    pathmapAir   .clear();

            pathmapGround = null;
            pathmapAir    = null;
        }

        public function createPathmaps():void{
            if (!isPathmapNeeded())
                return;

            createPathmap(Game.player.x, Game.player.y, C.MOVEMENT_GROUND);

            if (getMonsterOfType(C.M_WWING))
                createPathmap(Game.player.x, Game.player.y, C.MOVEMENT_AIR);
        }

        public function setPathmapTarget(x:uint, y:uint):void{
            if (pathmapGround) pathmapGround.setTarget(x, y);
            if (pathmapAir)    pathmapAir   .setTarget(x, y);
        }

        //}

        //{ Checkers

        /******************************************************************************************************/
        /**                                                                                         CHECKERS  */
        /******************************************************************************************************/

        public function doesSquareContainDoublePlacementObstacle(x:uint, y:uint):Boolean{
            ASSERT(F.isValidColRow(x, y));

            var index:uint = x + y * S.LEVEL_WIDTH;
            if (tilesActive[index])
                return true;

            var tile:uint = tilesTransparent[index];
            if (!(tile == C.T_EMPTY || tile == C.T_FUSE || tile == C.T_TOKEN))
                return true;

            if (F.isArrow(tilesFloor[index]))
                return true;

            tile = tilesOpaque[index];
            if (F.isTrapdoor(tile) || !(F.isFloor(tile) || F.isPlatform(tile) ||
                (F.isOpenDoor(tile) && tile != C.T_DOOR_YO)))
                return true;

            if (x == Game.player.x && y == Game.player.y)
                return true;

            if (tilesSwords[index])
                return true;

            return false;
        }

        public function getSpeaker(type:uint, considerBaseType:Boolean = false):TGameObject {
            if (type == C.M_BEETHRO)
                return Game.player;

            for each(var monster:TMonster in monsters.getAllOriginal) {
                if (!monster)
                    continue;

                if (monster is TCharacter) {
                    var character:TCharacter = monster as TCharacter;
                    if (character.visible && type == character.logicalIdentity)
                        return character;

                } else {
                    if (monster.getType() == type)
                        return monster;
                }
            }

            return null;
        }

        public function hasTile(tile:uint):Boolean{
            var layer:Array = F.tilesArrayFromLayerID(C.TILE_LAYER[tile], this);

            for (var i:uint = 0; i < S.LEVEL_TOTAL; i++)
                if (layer[i] == tile)
                    return true;

            return false;
        }

        public function isMonsterInRect(left:uint, top:uint, right:uint, bottom:uint, considerPieces:Boolean):Boolean{
            ASSERT(left <= right && top <= bottom);
            ASSERT(right < S.LEVEL_WIDTH && top < S.LEVEL_HEIGHT);

            var monster:TMonster;
            for (var y:uint = top; y <= bottom; y++){
                for (var x:uint = left; x <= right; x++){
                    monster = tilesActive[x + y * S.LEVEL_WIDTH];

                    if (monster && monster.isAlive && !(
                            F.isBeethroDouble(monster.getType()) ||
                            monster.getType() == C.M_CHARACTER) &&
                            (considerPieces || !monster.isPiece()))
                        return true;
                }
            }

            return false;
        }

        public function isMonsterInRectOfType(left:uint, top:uint, right:uint, bottom:uint, type:uint, considerNPC:Boolean = false):Boolean{
            ASSERT(left <= right && top <= bottom);
            ASSERT(right < S.LEVEL_WIDTH && top < S.LEVEL_HEIGHT);

            var monster:TMonster;
            for (var y:uint = top; y <= bottom; y++){
                for (var x:uint = left; x <= right; x++){
                    monster = tilesActive[x + y * S.LEVEL_WIDTH];

                    if (monster && monster.isAlive){
                        if (monster.getType() == type)
                            return true;

                        if (monster is TCharacter && considerNPC && monster.getIdentity() == type)
                            return true;
                    }
                }
            }

            return false;
        }

        public function isPathmapNeeded():Boolean{
            if (brainCount > 0)
                return true;

            // @TODO Implement for Slayers and Guards

            return false;
        }

        public function isSwordWithinRect(left:int, top:int, right:int, bottom:int):Boolean {
            if (left   <  0)              left   = 0;
            if (top    <  0)              top    = 0;
            if (right  >= S.LEVEL_WIDTH)  right  = S.LEVEL_WIDTH  - 1;
            if (bottom >= S.LEVEL_HEIGHT) bottom = S.LEVEL_HEIGHT - 1;

            for (var i:uint = left; i <= right; i++) {
                for (var j:uint = top; j <= bottom; j++) {
                    if (tilesSwords[i + j * S.LEVEL_WIDTH])
                        return true;
                }
            }

            return false;
        }

        public function isTarVulnerableToStab(x:uint, y:uint):Boolean{
            var i:uint;
            var j:int;

            var tx:uint;
            var ty:uint;

            var dx:uint;
            var dy:uint;

            var failed:Boolean = true;

            var tarType:uint = tilesTransparent[x + y * S.LEVEL_WIDTH];

            switch(tarType){
                case(C.T_TAR):
                    for (i = 0; i < 4; i++){
                        tx = x + _tarOrthoCheckX[i];
                        ty = y + _tarOrthoCheckY[i];

                        if (!F.isValidColRow(tx, ty) || tilesTransparent[tx + ty * S.LEVEL_WIDTH] != tarType){
                            failed = false;
                            break;
                        }
                    }

                    if (failed)
                        return false;

                    dx = _tarOrthoCheckX[i];
                    dy = _tarOrthoCheckY[i];

                    for (i = 0; i <= 1; i++){
                        for (j = -1; j <= 1; j++){
                            tx = x + dy * j - dx * i;
                            ty = y + dx * j - dy * i;

                            if (!F.isValidColRow(tx, ty) || tilesTransparent[tx + ty * S.LEVEL_WIDTH] != tarType)
                                return false;
                        }
                    }

                    return true;
            }

            throw new Error("This should have never happened!");
        }

        public function isTimerNeeded():Boolean{
            for each(var monster:TMonster in monsters.getAllOriginal()){
                if (monster is TRoachQueen || monster is TTarMother || monster is TSerpent)
                    return true;
            }

            return false;
        }

        public function getMonsterOfType(type:uint):TMonster{
            for each(var monster:TMonster in monsters.getAllOriginal()){
                if (monster && monster.getType() == type && (!(monster is TCharacter) || monster.isVisible()))
                    return monster;
            }

            return null;
        }

        /** TODO EightNeighbour, ignore and region mask not implemented **/
        public function getConnectedTiles(wX:uint, wY:uint, tileMask:Array, eightNeighbour:Boolean, ignore:Array = null, regionMask:Array = null):Array {
            var squares:Array = [];
            var coords :Array = [];

            var coordNow:uint = 0;
            var coordsTotal:uint = 1;

            var posNow:uint = 0;

            coords[0] = wX + wY * S.LEVEL_WIDTH;

            while (coordNow < coordsTotal) {
                posNow = coords[coordNow++];

                squares[posNow] = true;

                var notTop   :Boolean = (posNow / S.LEVEL_WIDTH | 0) > 0;
                var notBottom:Boolean = (posNow / S.LEVEL_WIDTH | 0) < S.LEVEL_HEIGHT - 1;

                if (posNow % S.LEVEL_WIDTH > 0)
                    pushTileIfOfType(posNow - 1);

                if (notTop)
                    pushTileIfOfType(posNow - S.LEVEL_WIDTH);

                if (posNow % S.LEVEL_WIDTH < S.LEVEL_WIDTH - 1)
                    pushTileIfOfType(posNow + 1);

                if (notBottom)
                    pushTileIfOfType(posNow + S.LEVEL_WIDTH);

            }

            function pushTileIfOfType(pos:uint):void {
                if ((tileMask.indexOf(tilesOpaque[pos]) != -1 || tileMask.indexOf(tilesTransparent[pos]) != -1) &&
                    squares[pos] == undefined) {

                    coords[coordsTotal++] = pos;
                }
            }

            return coords;
        }

        public function newTarWouldBeStable(addedTar:Array, tx:uint, ty:uint):Boolean{
            var tar:Array = [];
            var endX:uint = tx + 2;
            var endY:uint = ty + 2;
            var x:uint, y:uint;

            for (y = ty - 1; y != endY; y++){
                if (y < S.LEVEL_HEIGHT){
                    var dy:int = y - ty + 1;
                    for (x = tx - 1; x != endX; x++){
                        if (x < S.LEVEL_WIDTH)
                            tar[x - tx + 1 + (y - ty + 1) * 3] = (addedTar[x + y * S.LEVEL_WIDTH] != C.TAR_NO);
                    }
                }
            }

            return (tar[0] && tar[3] && tar[1])  ||
                   (tar[6] && tar[3] && tar[7])  ||
                   (tar[2] && tar[5] && tar[1])  ||
                   (tar[8] && tar[5] && tar[7]);
        }

        //}

        //{ Level Modifiers

        /******************************************************************************************************/
        /**                                                                                  LEVEL MODIFIERS  */
        /******************************************************************************************************/

        public function destroyTrapdoor(x:uint, y:uint):void {
            plot(x, y, C.T_PIT);
            if (--trapdoorsLeft == 0){
                CueEvents.add(C.CID_ALL_TRAPDOORS_REMOVED);

                if (toggleOTiles(C.T_DOOR_R, C.T_DOOR_RO))
                    CueEvents.add(C.CID_RED_GATES_TOGGLED);
            }

            CueEvents.add(C.CID_TRAPDOOR_REMOVED, new VOCoord(x, y));
        }

        public function destroyCrumblyWall(x:uint, y:uint, o:uint = C.NO_ORIENTATION):void{
            ASSERT(
                F.isCrumblyWall(tilesOpaque[x + y * S.LEVEL_WIDTH]) ||

                // A workaround to detect Secret Walls hidden as standard wall
                (renderer.opaqueData[x + y * S.LEVEL_WIDTH] & C.REND_WALL_HIDDEN_SECRET)
                );
            plot(x, y, renderer.getNeighbourFloor(x, y));
            CueEvents.add(C.CID_CRUMBLY_WALL_DESTROYED, new VOCoord(x, y, o));
        }

        public function destroyTar(x:uint, y:uint):void{
            ASSERT(F.isTar(tilesTransparent[x + y * S.LEVEL_WIDTH]));
            ASSERT(tarLeft);
            plot(x, y, C.T_EMPTY);
            --tarLeft;

            if (!tarLeft){
                CueEvents.add(C.CID_ALL_TAR_REMOVED);
                toggleBlackGates();
            }
        }

        public function growTar(tarType:uint, babies:Array):void{
            var playerX:uint = Game.player.x;
            var playerY:uint = Game.player.y;

            var motherType:uint = C.M_TARMOTHER;
            var cid       :uint = C.CID_TAR_GREW;

            var roomHasTar:Boolean = tarLeft > 0;
            var motherIsAlive:Boolean = false;

            ASSERT(CueEvents.hasOccured(cid));

            var monster:TMonster = CueEvents.getFirstPrivateData(cid);
            var mothers:Array = [];

            ASSERT(monster);

            while (monster){
                if (monster.isAlive){
                    motherIsAlive = true;
                    mothers.push(monster);
                }

                monster = CueEvents.getNextPrivateData();
            }

            if (!motherIsAlive)
                return;

            for each(monster in mothers){
                if (monster.getType() == motherType && tilesTransparent[monster.x + monster.y * S.LEVEL_WIDTH] != tarType){
                    plot(monster.x, monster.y, tarType);
                    tarLeft++;
                }
            }

            var x:uint, y:uint;

            var possible:Array = [];
            var addedTar:Array = [];
            var index:uint;

            for (x = 0; x < S.LEVEL_WIDTH; x++){
                for (y = 0; y < S.LEVEL_HEIGHT; y++){
                    index = x + y * S.LEVEL_WIDTH;
                    var tileT:uint = tilesTransparent[index];
                    var tileO:uint;
                    var o    :uint;
                    var nx   :uint;
                    var ny   :uint;

                    if (tileT == tarType){
                        addedTar[index] = C.TAR_OLD;
                        continue;
                    }

                    addedTar[index] = C.TAR_NO;
                    monster         = tilesActive[index];
                    tileO           = tilesOpaque[index];
                    if ((F.isFloor(tileO) || F.isOpenDoor(tileO)) &&
                        tilesFloor[index] == C.T_EMPTY && tileT == C.T_EMPTY &&
                        !(x == playerX && y == playerY) &&
                        (!monster || monster.getType() == motherType || babies[index])){
                        for (o = 0; o < C.ORIENTATION_COUNT; ++o){
                            if (o == C.NO_ORIENTATION) continue;

                            nx = x + F.getOX(o);
                            ny = y + F.getOY(o);

                            if (!F.isValidColRow(nx, ny)) continue;
                            if (tilesTransparent[nx + ny * S.LEVEL_WIDTH] == tarType){
                                addedTar[index] = C.TAR_NEW;
                                possible.push(index);
                                break;
                            }
                        }
                    }
                }
            } // EndFor

            var i:int = possible.length;
            while (i--){
                index = possible[i];

                x = index % S.LEVEL_WIDTH;
                y = index / S.LEVEL_WIDTH | 0;

                if (newTarWouldBeStable(addedTar, x, y)){
                    if (babies[index]){
                        delete babies[index];
                        killMonsterAtSquare(x, y);
                    }

                    plot(x, y, tarType);
                    tarLeft++;
                } else
                    addBaby(x, y);

            }

            if (!roomHasTar && tarLeft)
                toggleBlackGates();

            function addBaby(x:uint, y:uint):void{
                if (tilesSwords[index] || babies[index])
                    return;

                monster = addNewMonster(C.M_TARBABY, x, y, 0);
                CueEvents.add(C.CID_TAR_BABY_FORMED, monster);
                babies[index] = true;
            }
        }

        public function removeFinishedCharacters():void{
            for each(var monster:TMonster in monsters.getAllOriginal()){
                if (monster is TCharacter && Progress.isScriptEnded(TCharacter(monster).scriptID))
                    killMonster(monster);

            }
        }

        public function removeStabbedTar(x:uint, y:uint, delayBabyMoves:Boolean = false):void{
            var tarType:uint = tilesTransparent[x + y * S.LEVEL_WIDTH];

            ASSERT(F.isTar(tarType));

            destroyTar(x, y);

            while(recompute()){}

            // Returns true if it has to be called again
            function recompute():Boolean{
                var i:uint, j:uint;

                for(j = y - 1; j != y + 2; ++j){
                    for (i = x - 1; i != x + 2; i++){
                        if (!F.isValidColRow(i, j) || tilesTransparent[i + j * S.LEVEL_WIDTH] != tarType)
                            continue;

                        var isNorthTar:Boolean = (j > 0 ? tilesTransparent[i + (j - 1) * S.LEVEL_WIDTH] == tarType : false);
                        var isSouthTar:Boolean = (j < S.LEVEL_HEIGHT - 1 ? tilesTransparent[i + (j + 1) * S.LEVEL_WIDTH] == tarType : false);
                        var isWestTar :Boolean = (i > 0 ? tilesTransparent[i - 1 + j * S.LEVEL_WIDTH] == tarType : false);
                        var isEastTar :Boolean = (i < S.LEVEL_WIDTH - 1 ? tilesTransparent[i + 1 + j * S.LEVEL_WIDTH] == tarType : false);

                        if ((i > 0 && j > 0 &&
                                tilesTransparent[i - 1 + (j - 1) * S.LEVEL_WIDTH] == tarType &&
                                isNorthTar && isWestTar) ||

                            (i < S.LEVEL_WIDTH - 1 && j > 0 &&
                                tilesTransparent[i + 1 + (j - 1) * S.LEVEL_WIDTH] == tarType &&
                                isNorthTar && isEastTar) ||

                            (i > 0 && j < S.LEVEL_HEIGHT - 1 &&
                                tilesTransparent[i - 1 + (j + 1) * S.LEVEL_WIDTH] == tarType &&
                                isSouthTar && isWestTar) ||

                            (i < S.LEVEL_WIDTH - 1 && j < S.LEVEL_HEIGHT - 1 &&
                                tilesTransparent[i + 1 + (j + 1) * S.LEVEL_WIDTH] == tarType &&
                                isSouthTar && isEastTar))
                            continue;

                        const index:uint = i + j * S.LEVEL_WIDTH;

                        var monster:TMonster = tilesActive[index];
                        if (!monster || !F.isMother(monster.getType())){
                            destroyTar(i, j);

                            if (!monster){
                                var tileO:uint = tilesOpaque[index];
                                if (!(tilesSwords[index] || F.isStairs(tileO) || F.isPit(tileO))){
                                    switch(tarType){
                                        case(C.T_TAR):
                                            monster = addNewMonster(C.M_TARBABY, i, j, 0);
                                            CueEvents.add(C.CID_TAR_BABY_FORMED, monster);
                                            break;
                                    }
                                }
                            }

                            return true;
                        }
                    }
                }

                return false;
            }
        }



        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Monster Related
        // ::::::::::::::::::::::::::::::::::::::::::::::

        public function addNewMonster(type:uint, x:uint, y:uint, o:uint, pieces:XML = null, extra:String = null):TMonster{
            var monster:TMonster;

            switch(type){
                case(C.M_ROACH):        monster = new TRoach();              break;
                case(C.M_QROACH):       monster = new TRoachQueen();         break;
                case(C.M_REGG):         monster = new TRoachEgg();           break;
                case(C.M_GOBLIN):       monster = new TGoblin();             break;
                case(C.M_WWING):        monster = new TWraithwing();         break;
                case(C.M_EYE):          monster = new TEvilEye();            break;
                case(C.M_SERPENT):      monster = new TRedSerpent();         break;
                case(C.M_TARMOTHER):    monster = new TTarMother();          break;
                case(C.M_TARBABY):      monster = new TTarBaby();            break;
                case(C.M_BRAIN):        monster = new TBrain();              break;
                case(C.M_MIMIC):        monster = new TMimic();              break;
                case(C.M_SPIDER):       monster = new TSpider();             break;
                case(C.M_CHARACTER):    monster = new TCharacter();          break;
            }

            monster.x = monster.prevX = x;
            monster.y = monster.prevY = y;
            monster.o = monster.prevO = o;

            monster.room = this;

            switch(monster.getType()){
                case(C.M_CHARACTER): case(C.M_SLAYER):  case(C.M_SLAYER2):
                case(C.M_CLONE):     case(C.M_DECOY):   case(C.M_MIMIC):
                case(C.M_CITIZEN):   case(C.M_WUBBA):   case(C.M_HALPH):
                case(C.M_HALPH2):    case(C.M_FEGUNDO): case(C.M_FEGUNDOASHES):
                case(C.M_STALWART):
                    break;

                case(C.M_BRAIN):
                    brainCount++;

                default:
                    monsterCount++;
                    break;
            }

            if (extra)
                monster.setMembersFromExtraVars(new PackedVars(Base64.decodeByteArray(extra)));

            monster.initialize(pieces);
            monster.setGfx();

            linkMonster(monster, monster.isVisible());

            return monster;
        }

        public function addNewMonsterXML(xml:XML):TMonster{
            return addNewMonster(xml.@Type, xml.@X, xml.@Y, xml.@O, xml, xml.@ExtraVars);
        }

        public function clearMonsters(retainCharacters:Boolean):void{
            var monster:TMonster;

            for(var i:uint = 0, k:uint = monsters.length; i < k; i++){
                monster = monsters.getAt(i) as TMonster;

                if (!monster)
                    continue;

                if (retainCharacters)
                    switch(monster.getType()){
                        case(C.M_WUBBA): case(C.M_HALPH): case(C.M_HALPH2): case(C.M_SLAYER):
                        case(C.M_SLAYER2): case(C.M_CHARACTER): case(C.M_CITIZEN):
                        case(C.M_MIMIC): case(C.M_DECOY): case(C.M_CLONE):
                        case(C.M_FEGUNDO): case(C.M_STALWART):
                            continue;

                        case(C.M_SERPENT):
                            monster.killPieces();
                            break;
                    }


                tilesActive[monster.x + monster.y * S.LEVEL_WIDTH] = null;
                monsters.nullifyAt(i);
            }

            monsters.garbageCollectAdvanced();

            monsterCount = brainCount = 0;
        }

        public function killMonster(monster:TMonster, force:Boolean = false, ignoreEvents:Boolean = false):Boolean{
            tilesActive[monster.x + monster.y * S.LEVEL_WIDTH] = null;

            monsters.nullify(monster);

            switch(monster.getType()) {
                case(C.M_CHARACTER):
                    var character:TCharacter = monster as TCharacter;
                    if (character.imperative == C.IMP_REQUIRED_TO_CONQUER){
                        monsterCount--;
                        Game.tallyKill();
                    }

                    if (!character.swordSheathed)
                        tilesSwords[character.swordX + character.swordY * S.LEVEL_WIDTH]--;

                    if (!ignoreEvents)
                        CueEvents.add(C.CID_NPC_KILLED, this);
                    break;
                case(C.M_MIMIC):
                    var mimic:TPlayerDouble = monster as TPlayerDouble;
                    if (!mimic.swordSheathed)
                        tilesSwords[mimic.swordX + mimic.swordY * S.LEVEL_WIDTH]--;
                    break;

                case(C.M_BRAIN):
                    ASSERT(brainCount)

                    Game.tallyKill();
                    monsterCount--;
                    brainCount--;
                    if (brainCount == 0)
                        CueEvents.add(C.CID_ALL_BRAINS_REMOVED);

                    if (!isPathmapNeeded())
                        deletePathmaps();

                    break;

                case(C.M_SERPENT):
                    monster.killPieces();
                    Game.tallyKill();
                    monsterCount--;
                    break;

                default:
                    if (monster.isAlive){
                        monsterCount--;
                        Game.tallyKill();
                    }
            }

            monster.isAlive = false;

            return true;
        }

        public function killMonsterAtSquare(x:uint, y:uint, force:Boolean = false):Boolean{
            var monster:TMonster = tilesActive[x + y * S.LEVEL_WIDTH];

            if (monster)
                return killMonster(monster, force);

            return false;
        }

        public function linkMonster(monster:TMonster, isInRoom:Boolean):void{
            var monstersArray:Array = monsters.getAllOriginal();

            var lastMonster:TMonster;
            var nowMonster :TMonster;

            for (var i:uint = 0, l:uint = monstersArray.length; i < l; i++){
                nowMonster = monstersArray[i];

                if (nowMonster && nowMonster.getProcessSequence() > monster.getProcessSequence())
                    break;

                if (nowMonster)
                    lastMonster = nowMonster;
            }

            if (lastMonster){
                if (i == l)
                    monsters.add(monster);

                else
                    monsters.addAt(monster, i);

            } else
                monsters.addAt(monster, 0);

            if (isInRoom)
                tilesActive[monster.x + monster.y * S.LEVEL_WIDTH] = monster;
        }



        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Doors
        // ::::::::::::::::::::::::::::::::::::::::::::::

        public function toggleYellowDoor(x:uint, y:uint):void {
            if (tilesOpaque[x + y * S.LEVEL_WIDTH] == C.T_DOOR_Y)
                openYellowDoors(x, y);
            else
                closeYellowDoors(x, y);
        }

        public function openYellowDoors(x:uint, y:uint):void {
            if (tilesOpaque[x + y * S.LEVEL_WIDTH] == C.T_DOOR_Y)
                floodPlot(x, y, C.T_DOOR_YO);
        }

        public function closeYellowDoors(x:uint, y:uint):void {
            if (tilesOpaque[x + y * S.LEVEL_WIDTH] == C.T_DOOR_YO)
                floodPlot(x, y, C.T_DOOR_Y);
        }

        public function toggleGreenDoors():Boolean {
            greenDoorsOpened = true;
            return toggleOTiles(C.T_DOOR_G, C.T_DOOR_GO);
        }

        public function toggleBlackGates():void{
            if (toggleOTiles(C.T_DOOR_B, C.T_DOOR_BO))
                CueEvents.add(C.CID_BLACK_GATES_TOGGLED);
        }




        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: General Usage
        // ::::::::::::::::::::::::::::::::::::::::::::::

        public function floodPlot(wX:uint, wY:uint, tileNo:uint):void {
            var layerID:uint = C.TILE_LAYER[tileNo];
            var layer:Array = F.tilesArrayFromLayerID(layerID, this);

            var tileMask:Array = [ layer[wX + wY * S.LEVEL_WIDTH] ];
            var filledSquares:Array = getConnectedTiles(wX, wY, tileMask, false);

            for (var i:uint = 0, l:uint = filledSquares.length; i < l; i++) {
                plot(filledSquares[i] % S.LEVEL_WIDTH, filledSquares[i] / S.LEVEL_WIDTH | 0, tileNo, 2);
            }
        }

        /** Toggles given tiles on the Opaque layer, returns true if any tiles were changed **/
        public function toggleOTiles(tileA:uint, tileB:uint):Boolean{
            var tile:uint;
            var anyTileChanged:Boolean = false
            for(var i:uint = 0; i < S.LEVEL_WIDTH; i++){
                for(var j:uint = 0; j < S.LEVEL_HEIGHT; j++){
                    tile = tilesOpaque[i + j * S.LEVEL_WIDTH];
                    if (tile == tileA){
                        plot(i, j, tileB, 2);
                        anyTileChanged = true;
                    } else if (tile == tileB){
                        plot(i, j, tileA, 2);
                        anyTileChanged = true;
                    }
                }
            }

            return anyTileChanged;
        }


        //}

        //{ Drawing

        /******************************************************************************************************/
        /**                                                                                          DRAWING  */
        /******************************************************************************************************/

        public function setSaturation(saturation:Number):void {
            layerActive.saturation = saturation;
            layerUnder .saturation = saturation;
        }

        public function drawRoom():void {
            CF::lib {
                if (SpiderMain.noGfx)
                    return;
            }

            layerUnder.clearTiles();

            for (var j:uint = 0; j < S.LEVEL_HEIGHT; j++) {
                for (var i:uint = 0; i < S.LEVEL_WIDTH; i++) {
                    renderer.drawTile(i, j);
                }
            }
        }

        public function redrawTile(x:uint, y:uint):void{
            if (!F.isValidColRow(x, y))
                return;

            renderer.redrawTile(x, y);
        }

        /** Plots a tile to the level and redraws all necessary tiles.
         RedrawMode: 0 - no redraw, 1 - single redraw, 2 - complex redraw   **/
        public function plot(x:uint, y:uint, tile:uint, redrawMode:uint = 2):void {
            var redrawPitlike:Boolean = false;
            var redrawEight  :Boolean = false;
            var redrawFour   :Boolean = false;

            var arrPos:uint = x + y * S.LEVEL_WIDTH;

            var tileOld:uint = F.tilesArrayFromLayerID(C.TILE_LAYER[tile], this)[arrPos];

            if (tile == tileOld)
                return;

            F.tilesArrayFromLayerID(C.TILE_LAYER[tile], this)[arrPos] = tile;

            updatePathmapAt(x, y);

            renderer.recheckAroundTile(x, y, plots);
        }

        public function drawPlots():void {
            for (var i:String in plots) {
                var j:uint = parseInt(i);
                redrawTile(j % S.LEVEL_WIDTH, j / S.LEVEL_WIDTH | 0);
            }

            plots.length = 0;
        }

        private function tileSanitizer(tileInput:uint):uint{
            switch(tileInput){
                case(38):
                    throw new ArgumentError("Speed Potions are not supported!");
                case(39):
                case(40):
                case(41):
                    throw new ArgumentError("Briar is not supported!");
                case(43):
                    throw new ArgumentError("Bomb is not supported!");
                case(45):
                    throw new ArgumentError("OrthoSquares are not supported!");
                case(46):
                    throw new ArgumentError("Tokens are not supported!");
                case(47):
                case(48):
                case(63):
                case(64):
                    throw new ArgumentError("Tunnels are not supported!");
                case(49):
                    throw new ArgumentError("Mirrors are not supported!");
                case(50):
                    throw new ArgumentError("Clone Potions are not supported!");
                case(51):
                    throw new ArgumentError("Decoy Potions are not supported!");
                case(52):
                case(53):
                    throw new ArgumentError("Platforms are not supported!");
                case(60):
                    throw new ArgumentError("Mud is not supported!");
                case(67):
                    throw new ArgumentError("Water is not supported!");

                case(42): // Ceiling Light
                case(44): // Fuse
                    return C.T_EMPTY;
                case(72): // Trapdoor over water
                    return C.T_TRAPDOOR;
            }

            return tileInput;
        }

        //}

        //{ Snapshot

        /******************************************************************************************************/
        /**                                                                                         SNAPSHOT  */
        /******************************************************************************************************/

        public function getSnapshot():Object {
            var object:Object = new Object();

            object.tilesOpaque      = tilesOpaque.concat();
            object.tilesTransparent = tilesTransparent.concat();
            object.tilesFloor       = tilesFloor.concat();

            object.trapdoorsLeft    = trapdoorsLeft;
            object.tarLeft          = tarLeft;
            object.monsterCount     = monsterCount;
            object.brainCount       = brainCount;
            object.currentTurn      = currentTurn;

            object.brainMove        = brainMove;
            object.greenDoorsOpened = greenDoorsOpened;
            object.tarWasStabbed    = tarWasStabbed;

            object.monsters = [];
            for each(var i:TMonster in monsters.getAllOriginal()) {
                if (i)
                    object.monsters.push(i.getSnapshot());
            }

            return object;
        }

        //}
    }
}