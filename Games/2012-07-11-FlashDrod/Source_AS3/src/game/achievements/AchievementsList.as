package game.achievements{
    import flash.display.BitmapData;
    import flash.events.DataEvent;
    import flash.geom.Point;
    import game.global.Progress;
    import game.states.TStateGame;

    import game.global.CueEvents;
    import game.global.Game;
    import game.global.Gfx;
    import game.global.Level;
    import game.objects.actives.TBrain;
    import game.objects.actives.TEvilEye;
    import game.objects.actives.TGoblin;
    import game.objects.actives.TMonster;
    import game.objects.actives.TRoach;
    import game.objects.actives.TRoachEgg;
    import game.objects.actives.TRoachQueen;
    import game.objects.actives.TTarBaby;
    import game.objects.actives.TTarMother;
    import game.objects.actives.TWraithwing;

    import net.retrocade.utils.UBitmapData;

    public function AchievementsList(toArray:Array):void{
        ASSERT(toArray);

        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: First Kills
        // ::::::::::::::::::::::::::::::::::::::::::::::

        toArray.push(Achievement.get("My First Roach", "Kill your first roach",
            "23fza",
            function (bd:BitmapData, x:uint, y:uint):void{
                UBitmapData.blit(Gfx.ACHIEVEMENT, bd, 0, 0);
                T.plotPrecise(bd, T.TI_ROACH_NE, 11, 11);
            },

            function ():Boolean{
                return getMonster(C.M_ROACH) || getMonster(C.M_QROACH);
            },

            function ():Boolean{
                return evKilled(C.M_ROACH);
            }));

        toArray.push(Achievement.get("My First Roach Queen", "Kill your first roach queen",
            "23urfsd9fu",
            function (bd:BitmapData, x:uint, y:uint):void{
                UBitmapData.blit(Gfx.ACHIEVEMENT, bd, 0, 0);
                T.plotPrecise(bd, T.TI_RQUEEN_NE, 11, 11);
            },

            function ():Boolean{
                return getMonster(C.M_QROACH) != null;
            },

            function ():Boolean{
                return evKilled(C.M_QROACH);
            }));

        toArray.push(Achievement.get("My First Roach Egg", "Kill your first roach egg",
            "tr345",
            function (bd:BitmapData, x:uint, y:uint):void{
                UBitmapData.blit(Gfx.ACHIEVEMENT, bd, 0, 0);
                T.plotPrecise(bd, T.TI_REGG_N, 11, 11);
            },

            function ():Boolean{
                return getMonster(C.M_QROACH) != null;
            },

            function ():Boolean{
                return evKilled(C.M_REGG);
            }));

        toArray.push(Achievement.get("My First Evil Eye", "Kill your first evil eye",
            "zce",
            function (bd:BitmapData, x:uint, y:uint):void{
                UBitmapData.blit(Gfx.ACHIEVEMENT, bd, 0, 0);
                T.plotPrecise(bd, T.TI_EEYEW_NE, 11, 11);
            },

            function ():Boolean{
                return getMonster(C.M_QROACH) != null;
            },

            function ():Boolean{
                return evKilled(C.M_REGG);
            }));

        toArray.push(Achievement.get("My First Wraithwing", "Kill your first wraithwing",
            "432gf",
            function (bd:BitmapData, x:uint, y:uint):void{
                UBitmapData.blit(Gfx.ACHIEVEMENT, bd, 0, 0);
                T.plotPrecise(bd, T.TI_WWING_NE, 11, 11);
            },

            function ():Boolean{
                return getMonster(C.M_WWING) != null;
            },

            function ():Boolean{
                return evKilled(C.M_WWING);
            }));

        toArray.push(Achievement.get("Tuning fork", "Strike your first orb",
            "uygn32435sns",
            function (bd:BitmapData, x:uint, y:uint):void{
                UBitmapData.blit(Gfx.ACHIEVEMENT, bd, 0, 0);
                T.plotPrecise(bd, T.TI_ORB, 11, 11, Gfx.GENERAL_TILES);
            },

            function ():Boolean {
                return hasTile(C.T_ORB);
            },

            function ():Boolean {
                return (
                    CueEvents.hasOccured(C.CID_ORB_ACTIVATED) ||
                    CueEvents.hasOccured(C.CID_ORB_ACTIVATED_BY_DOUBLE) ||
                    CueEvents.hasOccured(C.CID_ORB_ACTIVATED_BY_PLAYER));
            }));

        toArray.push(Achievement.get("Down with the green", "Lowered a green gate",
            "uygn32435sns",
            function (bd:BitmapData, x:uint, y:uint):void{
                UBitmapData.blit(Gfx.ACHIEVEMENT, bd, 0, 0);
                T.plotPrecise(bd, T.TI_DOOR_G_SE, 0,  0,  Gfx.GENERAL_TILES);
                T.plotPrecise(bd, T.TI_DOOR_G_SW, 22, 0,  Gfx.GENERAL_TILES);
                T.plotPrecise(bd, T.TI_DOOR_G_NE, 0,  22, Gfx.GENERAL_TILES);
                T.plotPrecise(bd, T.TI_DOOR_G_NW, 22, 22, Gfx.GENERAL_TILES);
            },

            function ():Boolean {
                return (hasTile(C.T_DOOR_G) && !roomConquered()) || (hasTile(C.T_DOOR_GO) && roomConquered());
            },

            function ():Boolean {
                return roomConquered() || evConq();
            }));

        toArray.push(Achievement.get("Down with the blue", "Lowered a blue gate",
            "uygn32435sns",
            function (bd:BitmapData, x:uint, y:uint):void{
                UBitmapData.blit(Gfx.ACHIEVEMENT, bd, 0, 0);
                T.plotPrecise(bd, T.TI_DOOR_C_SE, 0,  0,  Gfx.GENERAL_TILES);
                T.plotPrecise(bd, T.TI_DOOR_C_SW, 22, 0,  Gfx.GENERAL_TILES);
                T.plotPrecise(bd, T.TI_DOOR_C_NE, 0,  22, Gfx.GENERAL_TILES);
                T.plotPrecise(bd, T.TI_DOOR_C_NW, 22, 22, Gfx.GENERAL_TILES);
            },

            function ():Boolean {
                return (hasTile(C.T_DOOR_C) && !levCompl()) || (hasTile(C.T_DOOR_CO) && levCompl());
            },

            function ():Boolean {
                return levCompl();
            }));



        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Multi Kills
        // ::::::::::::::::::::::::::::::::::::::::::::::

        toArray.push(Achievement.get("Horde management", "Kill a total of 2500 monsters",
            "uygnsns",
            function (bd:BitmapData, x:uint, y:uint):void{
                UBitmapData.blit(Gfx.ACHIEVEMENT, bd, 0, 0);
                T.plotPrecise(bd, T.TI_ROACH_NW, -11,  -11);
                T.plotPrecise(bd, T.TI_ROACH_NW,  11,  -11);
                T.plotPrecise(bd, T.TI_ROACH_NW,  33,  -11);
                T.plotPrecise(bd, T.TI_ROACH_NW, -11,   11);
                T.plotPrecise(bd, T.TI_ROACH_NW,  11,   11);
                T.plotPrecise(bd, T.TI_ROACH_NW,  33,   11);
                T.plotPrecise(bd, T.TI_ROACH_NW, -11,   33);
                T.plotPrecise(bd, T.TI_ROACH_NW,  11,   33);
                T.plotPrecise(bd, T.TI_ROACH_NW,  33,   33);


            },

            function ():Boolean{
                if (!this._data.hasOwnProperty("kills"))
                    this._data.kills = 0;

                return room.monsterCount > 0;
            },

            function ():Boolean{
                for (var i:TMonster = CueEvents.getFirstPrivateData(C.CID_MONSTER_DIED_FROM_STAB);
                    i != null;
                    i = CueEvents.getNextPrivateData()){

                    if (this._data.kills++ >= 2500)
                        return true;
                }

                return false;
            }));

        toArray.push(Achievement.get("Respawner", "Die a total of 500 times",
            "uygnsns",
            function (bd:BitmapData, x:uint, y:uint):void{
                UBitmapData.blit(Gfx.ACHIEVEMENT, bd, 0, 0);
                T.plotPrecise(bd, T.TI_BEETHRO_NE, 11, 11);
                T.plotPrecise(bd, T.TI_BEETHRO_SWORD_N, 24, -2);
                T.plotPrecise(bd, T.TI_ROACH_ASE, 0,  0);
                T.plotPrecise(bd, T.TI_ROACH_ANE, 0,  22);
                T.plotPrecise(bd, T.TI_ROACH_ANW, 22, 22);
            },

            function ():Boolean{
                if (!this._data.hasOwnProperty("deaths"))
                    this._data.deaths = 0;

                return room.monsterCount > 0 || hasTile(C.T_TAR);
            },

            function ():Boolean{
                if (CueEvents.hasAnyOccured(C.CIDA_PLAYER_DIED))
                    this._data.deaths++;

                return this._data.deaths >= 500;
            }));

        toArray.push(Achievement.get("Time is nil!", "Undo a total of 5000 moves",
            "uygnsns",
            function (bd:BitmapData, x:uint, y:uint):void{
                UBitmapData.blit(Gfx.ACHIEVEMENT, bd, 0, 0);

                T.plotPrecise(bd, T.TI_BEETHRO_NE, 22, 0);
                T.plotPrecise(bd, T.TI_ROACH_ANW,  30, 8);

                T.plotPrecise(bd, T.TI_BEETHRO_NE, 0, 22);
            },

            function ():Boolean{
                if (!this._data.hasOwnProperty("undos"))
                    this._data.undos = 0;

                return true;
            },

            function ():Boolean{
                if (TStateGame.lastCommand == C.CMD_UNDO)
                    this._data.undos++;

                return this._data.undos >= 500;
            }));

        toArray.push(Achievement.get("Making room", "Drop a total of 800 trapdoors",
            "uygnsns",
            function (bd:BitmapData, x:uint, y:uint):void{
                var tiles:BitmapData = Gfx.STYLES[T.STYLE_DEEP_SPACES][T.TILES];

                UBitmapData.blit(Gfx.ACHIEVEMENT, bd, 0, 0);

                T.plotPrecise(bd, T.TI_TRAPDOOR, -11, -11, tiles);
                T.plotPrecise(bd, T.TI_TRAPDOOR,  11, -11, tiles);
                T.plotPrecise(bd, T.TI_TRAPDOOR,  33, -11, tiles);
                T.plotPrecise(bd, T.TI_TRAPDOOR, -11,  11, tiles);
                T.plotPrecise(bd, T.TI_TRAPDOOR,  11,  11, tiles);
                T.plotPrecise(bd, T.TI_TRAPDOOR,  33,  11, tiles);
                T.plotPrecise(bd, T.TI_TRAPDOOR, -11,  33, tiles);
                T.plotPrecise(bd, T.TI_TRAPDOOR,  11,  33, tiles);
                T.plotPrecise(bd, T.TI_TRAPDOOR,  33,  33, tiles);
            },

            function ():Boolean{
                if (!this._data.hasOwnProperty("trapdoors"))
                    this._data.trapdoors = 0;

                return hasTile(C.T_TRAPDOOR);
            },

            function ():Boolean{
                for (var i:* = CueEvents.getFirstPrivateData(C.CID_TRAPDOOR_REMOVED);
                        i; i = CueEvents.getNextPrivateData())
                    this._data.trapdoors++;

                return this._data.trapdoors >= 800;
            }));

        toArray.push(Achievement.get("Walkin' to the moon", "Take a total of 15,000 steps",
            "uygnsns",
            function (bd:BitmapData, x:uint, y:uint):void{
                UBitmapData.blit(Gfx.ACHIEVEMENT, bd, 0, 0);

                T.plotPrecise(bd, T.TI_BEETHRO_N, 11, 33);
                T.plotPrecise(bd, T.TI_BEETHRO_N, 11, -11);
            },

            function ():Boolean{
                if (!this._data.hasOwnProperty("steps"))
                    this._data.steps = 0;

                return true
            },

            function ():Boolean{
                if (CueEvents.hasOccured(C.CID_STEP))
                    this._data.steps++;

                return this._data.steps >= 15000;
            }));



        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Room-specific Level 1
        // ::::::::::::::::::::::::::::::::::::::::::::::

        toArray.push(Achievement.get("True smitemaster", "Don't hide in the alcove in 6N 2W on First Floor",
            "uygn32435sns",
            function (bd:BitmapData, x:uint, y:uint):void{
                UBitmapData.blit(Gfx.ACHIEVEMENT, bd, 0, 0);
                T.plotPrecise(bd, T.TI_ROACH_AE, -6, 0);
                T.plotPrecise(bd, T.TI_ROACH_E,  -2, 22);
                T.plotPrecise(bd, T.TI_BEETHRO_SWORD_W, 8, 11);
                T.plotPrecise(bd, T.TI_BEETHRO_W, 30, 11);
            },

            function ():Boolean {
                this._data.started = false;
                this._data.failed  = false;

                return levPos(1) && roomPos( -2, -6) && !roomConquered();
            },

            function ():Boolean {
                if (this._data.failed)
                    return false;

                if (this._data.started) {
                    if (!room.isMonsterInRect(1, 6, 19, 9, true))
                        return true;

                    else if (Game.player.y  >= 10)
                        this._data.failed = true;

                } else if (room.tilesOpaque[11 + 6 * S.LEVEL_WIDTH] == C.T_DOOR_YO)
                    this._data.started = true;

                return false;
            }));




        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Room-specific Level 2
        // ::::::::::::::::::::::::::::::::::::::::::::::

        toArray.push(Achievement.get("Queenburger", "Kill the roach queen in Second Floor 2E before she reaches the corner",
            "uygn32435sns",
            function (bd:BitmapData, x:uint, y:uint):void{
                var tiles:BitmapData = Gfx.STYLES[T.STYLE_DEEP_SPACES][T.TILES];

                UBitmapData.blit(Gfx.ACHIEVEMENT, bd, 0, 0);

                T.plotPrecise(bd, T.TI_WALL_E, 0,  0, tiles);
                T.plotPrecise(bd, T.TI_WALL_SW, 22, 0, tiles);
                T.plotPrecise(bd, T.TI_WALL_N, 22, 22, tiles);
                T.plotPrecise(bd, T.TI_RQUEEN_ANE, 0,  22);
            },

            function ():Boolean {
                this._data.failed  = false;

                return levPos(2) && roomPos(2, 0) && !roomConquered();
            },

            function ():Boolean {
                if (this._data.failed)
                    return false;

                if (room.isMonsterInRectOfType(25,1,25,1,C.M_QROACH))
                    this._data.failed = true;

                else if (CueEvents.hasOccured(C.CID_MONSTER_DIED_FROM_STAB)) {
                    for (var i:TMonster = CueEvents.getFirstPrivateData(C.CID_MONSTER_DIED_FROM_STAB);
                            i; i = CueEvents.getNextPrivateData()){
                        if (i is TRoachQueen)
                            return true;
                    }
                }

                return false;
            }));

        toArray.push(Achievement.get("One-way ticket", "Don't rotate your sword in Second Floor 1S after you hit the orb",
            "uygn32435sns",
            function (bd:BitmapData, x:uint, y:uint):void {
                UBitmapData.blit(Gfx.ACHIEVEMENT, bd, 0, 0);

                T.plotPrecise(bd, T.TI_BEETHRO_E, 0,  11);
                T.plotPrecise(bd, T.TI_BEETHRO_SWORD_E, 22,  11);
                T.plotPrecise(bd, T.TI_ROACH_S, 0,  -11);
                T.plotPrecise(bd, T.TI_ROACH_AS, 22,  -8);
                T.plotPrecise(bd, T.TI_ROACH_AN, 00,  35);
                T.plotPrecise(bd, T.TI_ROACH_AN, 22,  36);
            },

            function ():Boolean {
                this._data.failed  = false;
                this._data.started = false;

                return levPos(2) && roomPos(0, 1) && !roomConquered();
            },

            function ():Boolean {
                if (this._data.failed)
                    return false;

                if (this._data.started) {
                    switch(TStateGame.lastCommand) {
                        case(C.CMD_C):
                        case(C.CMD_CC):
                            this._data.failed = true;
                            return false;
                    }

                    if (CueEvents.hasOccured(C.CID_ROOM_CONQUER_PENDING))
                        return true;

                } else if (CueEvents.hasOccured(C.CID_ORB_ACTIVATED_BY_PLAYER))
                    this._data.started = true;

                return false;
            }));

        toArray.push(Achievement.get("Be Quick!", "Kill all roach queens before they lay eggs in Second Floor 2S 2E",
            "uygn32435sns",
            function (bd:BitmapData, x:uint, y:uint):void {
                UBitmapData.blit(Gfx.ACHIEVEMENT, bd, 0, 0);

                T.plotPrecise(bd, T.TI_RQUEEN_AN, 11,  1);
                T.plotPrecise(bd, T.TI_RQUEEN_SW, 0,   21);
                T.plotPrecise(bd, T.TI_RQUEEN_SE, 22,  21);
            },

            function ():Boolean {
                this._data.failed = false;

                return levPos(2) && roomPos(2, 2) && !roomConquered();
            },

            function ():Boolean {
                if (this._data.failed)
                    return false;

                if (Game.spawnCycleCount == 30) {
                    this._data.failed = true;
                    return false;
                }

                if (CueEvents.hasOccured(C.CID_ROOM_CONQUER_PENDING))
                    return true;

                return false;
            }));

        toArray.push(Achievement.get("Be Fast!", "Kill all roach queens before they lay eggs in Second Floor 2S 3E",
            "uygn32435sns",
            function (bd:BitmapData, x:uint, y:uint):void {
                UBitmapData.blit(Gfx.ACHIEVEMENT, bd, 0, 0);

                T.plotPrecise(bd, T.TI_RQUEEN_NE, 0,  0);
                T.plotPrecise(bd, T.TI_RQUEEN_ANE, 22, 0);
                T.plotPrecise(bd, T.TI_RQUEEN_ANE, 22, 22);
                T.plotPrecise(bd, T.TI_REGG_AN,  0, 22);
            },


            function ():Boolean {
                var position:Point = Level.getRoomOffsetInLevel(Game.room.roomID);

                this._data.killCount = 0;

                return levPos(2) && roomPos(2, 3) && !roomConquered();
            },

            function ():Boolean {
                if (CueEvents.hasOccured(C.CID_MONSTER_DIED_FROM_STAB)){
                    this._data.killCount++;

                    if (this._data.killCount < 10 && evConq())
                        return true;
                }

                return false;
            }));

        toArray.push(Achievement.get("Calm arm", "Clear Second Floor 3N without turning your sword",
            "uygn35sns",
            function (bd:BitmapData, x:uint, y:uint):void{
                UBitmapData.blit(Gfx.ACHIEVEMENT, bd, 0, 0);
                T.plotPrecise(bd, T.TI_BEETHRO_SWORD_NW, 10, 10);
            },

            function ():Boolean {
                this._data.canRotate = true;
                this._data.failed    = false;

                return levPos(2) && roomPos(0, -3) && !roomConquered();
            },

            function ():Boolean {
                if (this._data.failed === true)
                    return false;

                switch(TStateGame.lastCommand) {
                    case(C.CMD_C):
                    case(C.CMD_CC):
                        if (!this._data.canRotate) {
                            this._data.failed = true;
                            return false;
                        }
                        break;

                    case(C.CMD_N): case(C.CMD_E): case(C.CMD_W): case(C.CMD_S):
                    case(C.CMD_NE): case(C.CMD_NW): case(C.CMD_SE): case(C.CMD_SW):
                    case(C.CMD_WAIT):
                        this._data.canRotate = false;
                        break;
                }

                if (evConq()){
                    return true;
                }

                return false;
            }));



        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Room-specific Level 3
        // ::::::::::::::::::::::::::::::::::::::::::::::

        toArray.push(Achievement.get("Get the scroll", "Get to the scroll in Third Floor 2N without reentering the room",
            "uygn35sns",
            function (bd:BitmapData, x:uint, y:uint):void{
                UBitmapData.blit(Gfx.ACHIEVEMENT, bd, 0, 0);
                T.plotPrecise(bd, T.TI_SCROLL, 11, 11);
            },

            function ():Boolean {
                this._data.canRotate = true;
                this._data.failed    = false;

                return levPos(3) && roomPos(0, -2) && !roomConquered();
            },

            function ():Boolean {
                return Game.player.x == 5 && Game.player.y == 23 && !roomConquered();
            }));


        toArray.push(Achievement.get("Invisible steadiness", "Kill all roaches without rotating your sword and without drinking the potion in Third Floor 1N 1W",
            "uygn35sns",
            function (bd:BitmapData, x:uint, y:uint):void{
                UBitmapData.blit(Gfx.ACHIEVEMENT, bd, 0, 0);
                T.plotPrecise(bd, T.TI_POTION_I, 11, 11);
            },

            function ():Boolean {
                return levPos(3) && roomPos(-1, -1) && !roomConquered();
            },

            function ():Boolean {
                return evConq() && hasTile(C.T_POTION_I);
            }));

        toArray.push(Achievement.get("Invisibless", "Complete Third Floor 1N 2W without drinking the potion",
            "uygn35sns",
            function (bd:BitmapData, x:uint, y:uint):void{
                UBitmapData.blit(Gfx.ACHIEVEMENT, bd, 0, 0);
                T.plotPrecise(bd, T.TI_POTION_I, 0, 8);
                T.plotPrecise(bd, T.TI_POTION_I, 22, 14);
            },

            function ():Boolean {
                return levPos(3) && roomPos(-2, -1) && !roomConquered();
            },

            function ():Boolean {
                return evConq() && hasTile(C.T_POTION_I);
            }));

        toArray.push(Achievement.get("Speeding", "Conquer Third Floor 1N 1E without queens laying any eggs",
            "uygn35sns",
            function (bd:BitmapData, x:uint, y:uint):void {
                var tiles:BitmapData = Gfx.STYLES[T.STYLE_DEEP_SPACES][T.TILES];

                UBitmapData.blit(Gfx.ACHIEVEMENT, bd, 0, 0);

                T.plotPrecise(bd, T.TI_WALL_EW, 0, -11, tiles);
                T.plotPrecise(bd, T.TI_WALL_EW, 22, -11, tiles);

                T.plotPrecise(bd, T.TI_ARROW_S, 0, 33, tiles);
                T.plotPrecise(bd, T.TI_ARROW_S, 0, 33, tiles);

                T.plotPrecise(bd, T.TI_RQUEEN_AN, -11, 11);
                T.plotPrecise(bd, T.TI_RQUEEN_NW,  11, 11);
                T.plotPrecise(bd, T.TI_RQUEEN_NE,  33, 11);

            },

            function ():Boolean {
                return levPos(3) && roomPos(1, -1) && !roomConquered();
            },

            function ():Boolean {
                return evConq() && Game.spawnCycleCount < 30;
            }));

        toArray.push(Achievement.get("The Eight Gates of Bill", "Solve The Eight Gates of Bill in 5 orb hits (Third Floor 1S)",
            "uygn35sns",
            function (bd:BitmapData, x:uint, y:uint):void {
                UBitmapData.blit(Gfx.ACHIEVEMENT, bd, 0, 0);

                T.plotPrecise(bd, T.TI_DOOR_Y_NS, -11, 0);
                T.plotPrecise(bd, T.TI_DOOR_Y_NS,  33, 0);
                T.plotPrecise(bd, T.TI_DOOR_Y_NS, -11, 22);
                T.plotPrecise(bd, T.TI_DOOR_Y_NS,  33, 22);
            },

            function ():Boolean {
                this._data.count = 0;

                return levPos(3) && roomPos(0, 1);
            },

            function ():Boolean {
                if (CueEvents.hasOccured(C.CID_ORB_ACTIVATED_BY_PLAYER)) {
                    if (++this._data.count == 5 && !hasTile(C.T_DOOR_Y))
                        return true;
                }

                return false;
            }));



        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Room Specific Level 4
        // ::::::::::::::::::::::::::::::::::::::::::::::

        toArray.push(Achievement.get("Not looking back", "In Fourth Floor 1N don't return to the starting passage before killing all roaches",
            "uygn35sns",
            function (bd:BitmapData, x:uint, y:uint):void {
                var tiles:BitmapData = Gfx.STYLES[T.STYLE_DEEP_SPACES][T.TILES];

                UBitmapData.blit(Gfx.ACHIEVEMENT, bd, 0, 0);

                T.plotPrecise(bd, T.TI_WALL_S, -16, 22,  tiles);
                T.plotPrecise(bd, T.TI_WALL_S,  38, 22,  tiles);
                T.plotPrecise(bd, T.TI_BEETHRO_SWORD_N, 11, 0);
                T.plotPrecise(bd, T.TI_BEETHRO_N, 11, 22);
            },

            function ():Boolean {
                this._data.failed  = false;
                this._data.started = false;

                return levPos(4) && roomPos(0, -1) && !roomConquered();
            },

            function ():Boolean {
                if (this._data.failed)
                    return false;

                if (this._data.started) {
                    if (Game.player.x >= 7 && Game.player.x <= 9 && Game.player.y >= 16) {
                        this._data.failed = true;
                        return false;

                    } else if (evConq())
                        return true;
                } else if (Game.player.y < 16)
                    this._data.started = true;

                return false;
            }));

        toArray.push(Achievement.get("Alone with the Roaches", "Conquer Fourth Floor 1S 1E without drinking the mimic potion",
            "uygn35sns",
            function (bd:BitmapData, x:uint, y:uint):void {
                UBitmapData.blit(Gfx.ACHIEVEMENT, bd, 0, 0);

                T.plotPrecise(bd, T.TI_POTION_M, 11, 11);
            },

            function ():Boolean {
                this._data.failed  = false;
                this._data.started = false;

                return levPos(4) && roomPos(1, 1) && !roomConquered();
            },

            function ():Boolean {
                return evConq() && hasTile(C.T_POTION_M);
            }));

        toArray.push(Achievement.get("Pits are Pretty", "Drop all trapdoors in Fourth Floor 1S 2E and conquer the room at the same visit",
            "uygn35sns",
            function (bd:BitmapData, x:uint, y:uint):void {
                var tiles:BitmapData = Gfx.STYLES[T.STYLE_DEEP_SPACES][T.TILES];

                UBitmapData.blit(Gfx.ACHIEVEMENT, bd, 0, 0);

                T.plotPrecise(bd, T.TI_TRAPDOOR, 11, 11, tiles);
            },

            function ():Boolean {
                return levPos(4) && roomPos(1, 2) && !roomConquered();
            },

            function ():Boolean {
                return evConq() && !hasTile(C.T_TRAPDOOR);
            }));

        toArray.push(Achievement.get("Emptiness of Nothingness", "Drop all trapdoors in Fourth Floor 2S 1E and conquer the room at the same visit",
            "uygn35sns",
            function (bd:BitmapData, x:uint, y:uint):void {
                var tiles:BitmapData = Gfx.STYLES[T.STYLE_DEEP_SPACES][T.TILES];

                UBitmapData.blit(Gfx.ACHIEVEMENT, bd, 0, 0);

                T.plotPrecise(bd, T.TI_TRAPDOOR, 0,  0,  tiles);
                T.plotPrecise(bd, T.TI_TRAPDOOR, 22, 0,  tiles);
                T.plotPrecise(bd, T.TI_TRAPDOOR, 0,  22, tiles);
                T.plotPrecise(bd, T.TI_TRAPDOOR, 22, 22, tiles);
            },

            function ():Boolean {
                return levPos(4) && roomPos(2, 1) && !roomConquered();
            },

            function ():Boolean {
                return evConq() && !hasTile(C.T_TRAPDOOR);
            }));



        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Level-wide challenges
        // ::::::::::::::::::::::::::::::::::::::::::::::

        toArray.push(Achievement.get("Steady hand", "Complete or go through all but one rooms in First Level without turning yer sword",
            "uygn35sns",
            function (bd:BitmapData, x:uint, y:uint):void{
                UBitmapData.blit(Gfx.ACHIEVEMENT, bd, 0, 0);
                T.plotPrecise(bd, T.TI_BEETHRO_SWORD_NW, 10, 10);
                T.plotPrecise(bd, T.TI_BEETHRO_SWORD_NE, 10, 10);
            },

            function ():Boolean {
                if (!this._data.hasOwnProperty("rooms")){
                    this._data.rooms    = [];
                    this._data.finished = 0;
                }

                if (this._data.rooms[Game.room.roomID] === true)
                    return false;

                if (Progress.isRoomConquered(Game.room.roomID))
                    return false;


                var position:Point = Level.getRoomOffsetInLevel(Game.room.roomID);

                this._data.canRotate = true;
                this._data.failed    = false;

                switch(position.x + ":" + position.y) {
                    case("-2:-3"):
                    case("-2:-4"):
                    case("-1:-4"):
                    case("-1:-5"):
                    case("-2:-5"):
                    case("-1:-6"):
                        return true;
                        break;
                }

                return false;
            },

            function ():Boolean {
                if (this._data.failed === true || this._data.rooms[Game.room.roomID] === true)
                    return false;

                switch(TStateGame.lastCommand) {
                    case(C.CMD_C):
                    case(C.CMD_CC):
                        if (!this._data.canRotate) {
                            this._data.failed = true;
                            return false;
                        }
                        break;

                    case(C.CMD_N): case(C.CMD_E): case(C.CMD_W): case(C.CMD_S):
                    case(C.CMD_NE): case(C.CMD_NW): case(C.CMD_SE): case(C.CMD_SW):
                    case(C.CMD_WAIT):
                        this._data.canRotate = false;
                        break;
                }

                if (!this._data.failed && CueEvents.hasOccured(C.CID_ROOM_CONQUER_PENDING)){
                    this._data.rooms[Game.room.roomID] = true;

                    this._data.finished++;

                    if (this._data.finished == 6)
                        return true;
                }

                return false;
            }));

        toArray.push(Achievement.get("Amateur delver", "Cleared the first level",
            "uygn32435sns",
            function (bd:BitmapData, x:uint, y:uint):void{
                UBitmapData.blit(Gfx.ACHIEVEMENT, bd, 0, 0);
                T.plotPrecise(bd, T.TI_DOOR_CO, 0,  0,  Gfx.GENERAL_TILES);
                T.plotPrecise(bd, T.TI_DOOR_C, 22, 0,  Gfx.GENERAL_TILES);
                T.plotPrecise(bd, T.TI_DOOR_C, 0,  22, Gfx.GENERAL_TILES);
                T.plotPrecise(bd, T.TI_DOOR_C, 22, 22, Gfx.GENERAL_TILES);
            },

            function ():Boolean {
                return levelID == getLevID(1);
            },

            function ():Boolean {
                return levCompl(getLevID(1));
            }));

        toArray.push(Achievement.get("Fledgling smiter", "Cleared the second level",
            "uygn32435sns",
            function (bd:BitmapData, x:uint, y:uint):void{
                UBitmapData.blit(Gfx.ACHIEVEMENT, bd, 0, 0);
                T.plotPrecise(bd, T.TI_DOOR_CO, 0,  0,  Gfx.GENERAL_TILES);
                T.plotPrecise(bd, T.TI_DOOR_C, 22, 0,  Gfx.GENERAL_TILES);
                T.plotPrecise(bd, T.TI_DOOR_C, 0,  22, Gfx.GENERAL_TILES);
                T.plotPrecise(bd, T.TI_DOOR_CO, 22, 22, Gfx.GENERAL_TILES);
            },

            function ():Boolean {
                return levelID == getLevID(2);
            },

            function ():Boolean {
                return levCompl(getLevID(2));
            }));

        toArray.push(Achievement.get("Contract Exterminator", "Cleared the third level",
            "uygn32435sns",
            function (bd:BitmapData, x:uint, y:uint):void{
                UBitmapData.blit(Gfx.ACHIEVEMENT, bd, 0, 0);
                T.plotPrecise(bd, T.TI_DOOR_CO, 0,  0,  Gfx.GENERAL_TILES);
                T.plotPrecise(bd, T.TI_DOOR_C, 22, 0,  Gfx.GENERAL_TILES);
                T.plotPrecise(bd, T.TI_DOOR_CO, 0,  22, Gfx.GENERAL_TILES);
                T.plotPrecise(bd, T.TI_DOOR_CO, 22, 22, Gfx.GENERAL_TILES);
            },

            function ():Boolean {
                return levelID == getLevID(3);
            },

            function ():Boolean {
                return levCompl(getLevID(3));
            }));

        toArray.push(Achievement.get("I'm a professional!", "Cleared the fourth level",
            "uygn32435sns",
            function (bd:BitmapData, x:uint, y:uint):void{
                UBitmapData.blit(Gfx.ACHIEVEMENT, bd, 0, 0);
                T.plotPrecise(bd, T.TI_DOOR_CO, 0,  0,  Gfx.GENERAL_TILES);
                T.plotPrecise(bd, T.TI_DOOR_CO, 22, 0,  Gfx.GENERAL_TILES);
                T.plotPrecise(bd, T.TI_DOOR_CO, 0,  22, Gfx.GENERAL_TILES);
                T.plotPrecise(bd, T.TI_DOOR_CO, 22, 22, Gfx.GENERAL_TILES);
            },

            function ():Boolean {
                return levelID == getLevID(4);
            },

            function ():Boolean {
                return levCompl(getLevID(4));
            }));

        toArray.push(Achievement.get("Mastery", "Master the hold",
            "uygn32435sns",
            function (bd:BitmapData, x:uint, y:uint):void{
                UBitmapData.blit(Gfx.ACHIEVEMENT, bd, 0, 0);

                T.plotPrecise(bd, T.TI_MASTER_WALL, 11,  11);
            },

            function ():Boolean {
                return true;
            },

            function ():Boolean {
                return CueEvents.hasOccured(C.CID_HOLD_MASTERED);
            }));

        toArray.push(Achievement.get("Post-mastery", "Post-master the hold",
            "uygn32435sns",
            function (bd:BitmapData, x:uint, y:uint):void{
                UBitmapData.blit(Gfx.ACHIEVEMENT, bd, 0, 0);

                T.plotPrecise(bd, T.TI_MASTER_WALL, 0,  0,  Gfx.GENERAL_TILES);
                T.plotPrecise(bd, T.TI_MASTER_WALL, 22, 0,  Gfx.GENERAL_TILES);
                T.plotPrecise(bd, T.TI_MASTER_WALL, 0,  22, Gfx.GENERAL_TILES);
                T.plotPrecise(bd, T.TI_MASTER_WALL, 22, 22, Gfx.GENERAL_TILES);
            },

            function ():Boolean {
                return levPos(5);
            },

            function ():Boolean {
                return levCompl(getLevID(5));
            }));


        function drawAchievement(to:BitmapData, x:uint, y:uint):void{
            UBitmapData.blit(Gfx.ACHIEVEMENT, to, x, y);
        }
    }
}
import flash.geom.Point;
import game.global.CueEvents;
import game.global.Game;
import game.global.Level;
import game.global.Progress;
import game.global.Room;
import game.objects.actives.TMonster;

function roomConquered():Boolean {
    return Progress.isRoomConquered(roomID);
}

function roomPos(x:int, y:int):Boolean {
    var position:Point = roomOffset();

    return position.x == x && position.y == y;
}

function roomOffset():Point {
    return Level.getRoomOffsetInLevel(roomID);
}

function get roomID():uint {
    return room.roomID;
}

function get levelID():uint {
    return room.levelID;
}

function getLevID(order:uint):uint {
    return Level.getLevelNthID(order);
}

function levPos(order:uint):Boolean {
    return getLevID(order) == levelID;
}

function evConq():Boolean {
    return CueEvents.hasOccured(C.CID_ROOM_CONQUER_PENDING);
}

function evKilled(type:uint):Boolean {
    for (var i:TMonster = CueEvents.getFirstPrivateData(C.CID_MONSTER_DIED_FROM_STAB);
            i; i = CueEvents.getNextPrivateData() ) {
        if (i.getType() == type)
            return true;
    }

    return false;
}

function getMonster(type:uint):TMonster {
    return room.getMonsterOfType(type);
}

function get room():Room {
    return Game.room;
}

function hasTile(type:uint):Boolean {
    return room.hasTile(type);
}

function levCompl(levID:Number = NaN):Boolean {
    return isNaN(levID) ? Progress.isLevelCompleted(levelID) : Progress.isLevelCompleted(levID);
}

function getPos():Point {
    return Level.getRoomOffsetInLevel(roomID);
}