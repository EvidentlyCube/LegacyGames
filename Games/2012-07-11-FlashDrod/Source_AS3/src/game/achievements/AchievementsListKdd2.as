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

    public function AchievementsListKdd2(toArray:Array):void{
        ASSERT(toArray);

        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Multi Kills
        // ::::::::::::::::::::::::::::::::::::::::::::::

        toArray.push(Achievement.get(_("achName0"), _("achDesc0"),
            "d7c7031b125fe0a4ff08ef3ccc2a1215",
            function (bd:BitmapData, x:uint, y:uint):void{
                UBitmapData.blit(Gfx.ACHIEVEMENT, bd, 0, 0);

                T.plotPrecise(bd, T.TI_MASTER_WALL, -11, -11,  Gfx.GENERAL_TILES);
                T.plotPrecise(bd, T.TI_MASTER_WALL,  33, -11,  Gfx.GENERAL_TILES);
                T.plotPrecise(bd, T.TI_MASTER_WALL, -11,  33, Gfx.GENERAL_TILES);
                T.plotPrecise(bd, T.TI_MASTER_WALL,  33,  33, Gfx.GENERAL_TILES);
            },

            function ():Boolean {
                return hasTile(C.T_WALL_MASTER);
            },

            function ():Boolean {
                return hasTile(C.T_WALL_MASTER);
            }));



        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Room Specific
        // ::::::::::::::::::::::::::::::::::::::::::::::

        toArray.push(Achievement.get(_("achName1"), _("achDesc1"),
            "73b00573aa2e093cb0e28771e91b7366",
            function (bd:BitmapData, x:uint, y:uint):void{
                UBitmapData.blit(Gfx.ACHIEVEMENT, bd, 0, 0);

                T.plotPrecise(bd, T.TI_BEETHRO_E, 0, 11);
                T.plotPrecise(bd, T.TI_BEETHRO_SWORD_E, 22, 11);
            },

            function ():Boolean {
                this._data.canRotate = true;
                this._data.failed    = false;

                return levPos(1) && roomPos( -1, 0) && !roomConquered();
            },

            function ():Boolean{
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

                        if (Game.player.o != C.E){
                            this._data.failed = true;
                            return false;
                        }

                        break;
                }

                if (evConq()){
                    return true;
                }

                return false;
            }));

        toArray.push(Achievement.get(_("achName2"), _("achDesc2"),
            "6caa97d73df0de77ac0c24f9f18df7c9",
            function (bd:BitmapData, x:uint, y:uint):void {
                var tiles:BitmapData = Gfx.STYLES[T.STYLE_ICEWORKS][T.TILES];

                UBitmapData.blit(Gfx.ACHIEVEMENT, bd, 0, 0);

                T.plotPrecise(bd, T.TI_TRAPDOOR, 22, 0, tiles);
                T.plotPrecise(bd, T.TI_BEETHRO_NE, 0, 22);
                T.plotPrecise(bd, T.TI_BEETHRO_SWORD_NE, 22, 0);
            },

            function ():Boolean {
                return levPos(1) && roomPos(-2, -1) && !roomConquered();
            },

            function ():Boolean{
                return !hasTile(C.T_TRAPDOOR) && evConq();
            }));

        toArray.push(Achievement.get(_("achName3"), _("achDesc3"),
            "c51440aca12c4f8618658c4ad68aee7d",
            function (bd:BitmapData, x:uint, y:uint):void {
                UBitmapData.blit(Gfx.ACHIEVEMENT, bd, 0, 0);

                T.plotPrecise(bd, T.TI_ORB, 0, 0);
                T.plotPrecise(bd, T.TI_BEETHRO_SE, 22, 22);
            },

            function ():Boolean {
                this._data.failed = false;

                return levPos(1) && roomPos(0, -2) && !roomConquered();
            },

            function ():Boolean {
                if (this._data.failed)
                    return false;

                if (ev(C.CID_ORB_ACTIVATED_BY_PLAYER) || ev(C.CID_ORB_ACTIVATED_BY_DOUBLE)) {
                    this._data.failed = true;
                    return false;
                }

                return evConq();
            }));

        toArray.push(Achievement.get(_("achName4"), _("achDesc4"),
            "0f4fd00433d8a8dfc6b96d6cf8e97dae",
            function (bd:BitmapData, x:uint, y:uint):void {
                UBitmapData.blit(Gfx.ACHIEVEMENT, bd, 0, 0);

                T.plotPrecise(bd, T.TI_BEETHRO_SE, 0, 0);
                T.plotPrecise(bd, T.TI_BEETHRO_SWORD_SE, 22, 22);
            },

            function ():Boolean {
                this._data.canRotate = true;
                this._data.failed    = false;

                return levPos(1) && roomPos(0, 1) && !roomConquered();
            },

            function ():Boolean{
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

        toArray.push(Achievement.get(_("achName5"), _("achDesc5"),
            "5fc68d55a92cde0adcfa2718b1ec5ebf",
            function (bd:BitmapData, x:uint, y:uint):void {
                UBitmapData.blit(Gfx.ACHIEVEMENT, bd, 0, 0);

                T.plotPrecise(bd, T.TI_POTION_I, 11, 11);
            },

            function ():Boolean {
                this._data.failed = false;

                return levPos(1) && roomPos(0, 2) && !roomConquered();
            },

            function ():Boolean{
                if (this._data.failed === true)
                    return false;

                if (Game.isInvisible) {
                    this._data.failed = true;
                    return false;
                }

                if (evConq()){
                    return true;
                }

                return false;
            }));

        toArray.push(Achievement.get(_("achName6"), _("achDesc6"),
            "e8194ec0cc5a0d613cf7e28a11c287f0",
            function (bd:BitmapData, x:uint, y:uint):void {
                UBitmapData.blit(Gfx.ACHIEVEMENT, bd, 0, 0);

                T.plotPrecise(bd, T.TI_ORB, 22, 0);
                T.plotPrecise(bd, T.TI_BEETHRO_SW, 0, 22);
            },

            function ():Boolean {
                this._data.failed = false;

                return levPos(1) && roomPos(3, 0) && !roomConquered();
            },

            function ():Boolean {
                if (this._data.failed)
                    return false;

                if (ev(C.CID_ORB_ACTIVATED_BY_PLAYER) || ev(C.CID_ORB_ACTIVATED_BY_DOUBLE)) {
                    this._data.failed = true;
                    return false;
                }

                return evConq();
            }));

        toArray.push(Achievement.get(_("achName7"), _("achDesc7"),
            "528f03486840ddf60e00336b572735fa",
            function (bd:BitmapData, x:uint, y:uint):void {
                UBitmapData.blit(Gfx.ACHIEVEMENT, bd, 0, 0);

                T.plotPrecise(bd, T.TI_POTION_M, 11, 11);
            },

            function ():Boolean {
                this._data.started = false;
                this._data.failed  = false;

                return levPos(1) && roomPos(-1, 1) && !roomConquered();
            },

            function ():Boolean {
                if (this._data.failed)
                    return false;

                if (!this._data.started){
                    if (player.x == 23 && player.y == 21)
                        this._data.started = true;
                } else {
                    if ((player.x >= 20 && player.y >= 20 && player.x <= 25 && player.y <= 23) ||
                            (player.x >= 23 && player.x <= 24 && player.y == 19)) {
                        return evConq();
                    } else {
                        this._data.failed = true;
                        return false;
                    }
                }

                return false;
            }));

        toArray.push(Achievement.get(_("achName8"), _("achDesc8"),
            "934f2c27478b83458801b90644ea1d4c",
            function (bd:BitmapData, x:uint, y:uint):void{
                UBitmapData.blit(Gfx.ACHIEVEMENT, bd, 0, 0);

                T.plotPrecise(bd, T.TI_DOOR_YO, 11, 11);
                T.plotPrecise(bd, T.TI_BEETHRO_SE, -11, -11);
                T.plotPrecise(bd, T.TI_BEETHRO_SWORD_SE, 11, 11);
                T.plotPrecise(bd, T.TI_WWING_ASE, 33, 33);
            },

            function ():Boolean {
                this._data.failed = false;

                return levPos(1) && roomPos(2, 2) && !roomConquered();
            },

            function ():Boolean {
                if (this._data.failed)
                    return false;

                if (player.x == 11 && player.y == 7) {
                    this._data.failed = true;
                    return false;
                }

                return evConq();
            }));

        toArray.push(Achievement.get(_("achName9"), _("achDesc9"),
            "fa7423560480f03dfba4d7a6d84d5915",
            function (bd:BitmapData, x:uint, y:uint):void {
                UBitmapData.blit(Gfx.ACHIEVEMENT, bd, 0, 0);

                T.plotPrecise(bd, T.TI_BEETHRO_E, -11,  11);
                T.plotPrecise(bd, T.TI_BEETHRO_W,  33,  11);
                T.plotPrecise(bd, T.TI_BEETHRO_S,  11, -11);
                T.plotPrecise(bd, T.TI_BEETHRO_N,  11,  33);

                T.plotPrecise(bd, T.TI_BEETHRO_SWORD_E,  11,  11);
                T.plotPrecise(bd, T.TI_BEETHRO_SWORD_S,  11,  11);
                T.plotPrecise(bd, T.TI_BEETHRO_SWORD_W,  11,  11);
                T.plotPrecise(bd, T.TI_BEETHRO_SWORD_N,  11,  11);
            },

            function ():Boolean {
                this._data.failed = false;

                return levPos(3) && roomPos(0, 1) && !roomConquered();
            },

            function ():Boolean {
                if (this._data.failed)
                    return false;

                if (TStateGame.lastCommand == C.SW ||
                        TStateGame.lastCommand == C.NW ||
                        TStateGame.lastCommand == C.SE ||
                        TStateGame.lastCommand == C.NE) {

                    this._data.failed = true;
                    return false;
                }

                return evConq();
            }));

        toArray.push(Achievement.get(_("achName10"), _("achDesc10"),
            "da9a7696395292b6a519d898b0d98b00",
            function (bd:BitmapData, x:uint, y:uint):void {
                UBitmapData.blit(Gfx.ACHIEVEMENT, bd, 0, 0);

                T.plotPrecise(bd, T.TI_BEETHRO_SWORD_NW, 0, 0);
                T.plotPrecise(bd, T.TI_BEETHRO_NW, 22, 22);
            },

            function ():Boolean {
                this._data.canRotate = true;
                this._data.failed    = false;

                return levPos(3) && roomPos(1, 0) && !roomConquered();
            },

            function ():Boolean{
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

        toArray.push(Achievement.get(_("achName11"), _("achDesc11"),
            "0c8f5401fc568e936ea2e08ad2913767",
            function (bd:BitmapData, x:uint, y:uint):void {
                UBitmapData.blit(Gfx.ACHIEVEMENT, bd, 0, 0);

                T.plotPrecise(bd, T.TI_SNKH_W, 0, 0);
                T.plotPrecise(bd, T.TI_SNK_SW, 22, 0);
                T.plotPrecise(bd, T.TI_SNKT_S, 22, 22);
                T.plotPrecise(bd, T.TI_ROACH_ANE, 0, 22);
            },

            function ():Boolean {
                this._data.killedSnake = false;
                this._data.failed      = false;

                return levPos(3) && roomPos(2, -1) && !roomConquered();
            },

            function ():Boolean{
                if (this._data.failed === true)
                    return false;

                if (ev(C.CID_MONSTER_DIED_FROM_STAB) && !this._data.killedSnake) {
                    this._data.failed = true;
                    return false;
                }

                return ev(C.CID_SNAKE_DIED_FROM_TRUNCATION);
            }));

        toArray.push(Achievement.get(_("achName12"), _("achDesc12"),
            "845f052683fc646cad9374218e509c43",
            function (bd:BitmapData, x:uint, y:uint):void {
                UBitmapData.blit(Gfx.ACHIEVEMENT, bd, 0, 0);

                T.plotPrecise(bd, T.TI_BEETHRO_SWORD_SW, 0, 22);
                T.plotPrecise(bd, T.TI_BEETHRO_SW, 22, 0);
            },

            function ():Boolean {
                this._data.canRotate = true;
                this._data.failed    = false;

                return levPos(3) && roomPos(1, -3) && !roomConquered();
            },

            function ():Boolean{
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

        toArray.push(Achievement.get(_("achName13"), _("achDesc13"),
            "119ee2d6c60477fc6a9c88d7ac87e79b",
            function (bd:BitmapData, x:uint, y:uint):void {
                UBitmapData.blit(Gfx.ACHIEVEMENT, bd, 0, 0);

                T.plotPrecise(bd, T.TI_SNKH_AS, 0, 0);
                T.plotPrecise(bd, T.TI_ROACH_S, 22, 0);
                T.plotPrecise(bd, T.TI_ROACH_E, 0, 22);
                T.plotPrecise(bd, T.TI_BEETHRO_NW, 22, 22)
                T.plotPrecise(bd, T.TI_BEETHRO_SWORD_NW, 0, 0)
            },

            function ():Boolean {
                return levPos(3) && roomPos(-1, -2) && !roomConquered();
            },

            function ():Boolean{
                return evConq();
            }));


        toArray.push(Achievement.get(_("achName14"), _("achDesc14"),
            "63ac715d928e51c25a3bbb7ba434329c",
            function (bd:BitmapData, x:uint, y:uint):void {
                UBitmapData.blit(Gfx.ACHIEVEMENT, bd, 0, 0);

                T.plotPrecise(bd, T.TI_POTION_M, 0, 0);
                T.plotPrecise(bd, T.TI_TAR_SE, 22, 22);
            },

            function ():Boolean {
                this._data.failed = false;

                return levPos(4) && roomPos(3, 4) && !roomConquered();
            },

            function ():Boolean {
                if (this._data.failed)
                    return false;

                if (player.x == 8 && player.y == 6) {
                    this._data.failed = true;
                    return false;
                }

                return evConq();
            }));



        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Level-wide challenges
        // ::::::::::::::::::::::::::::::::::::::::::::::

        toArray.push(Achievement.get(_("achName15"), _("achDesc15"),
            "995749d8dc69a6a06cea16360cf79ad5",
            function (bd:BitmapData, x:uint, y:uint):void{
                UBitmapData.blit(Gfx.ACHIEVEMENT, bd, 0, 0);

                T.plotPrecise(bd, T.TI_TAR_SE, 0,  0);
                T.plotPrecise(bd, T.TI_TAR_SW, 22, 0);
                T.plotPrecise(bd, T.TI_TAR_NE, 0,  22);
                T.plotPrecise(bd, T.TI_TAR_NW, 22, 22);
            },

            function ():Boolean {
                return levPos(4) && hasTile(C.T_TAR);
            },

            function ():Boolean {
                return !hasTile(C.T_TAR);
            }));

        toArray.push(Achievement.get(_("achName16"), _("achDesc16"),
            "561a8da69a7515513e6d1154c9d4cd89",
            function (bd:BitmapData, x:uint, y:uint):void{
                UBitmapData.blit(Gfx.ACHIEVEMENT, bd, 0, 0);

                T.plotPrecise(bd, T.TI_TAR_SE, 0,  0);
                T.plotPrecise(bd, T.TI_TAR_SW, 22, 0);
                T.plotPrecise(bd, T.TI_TAR_NE, 0,  22);
                T.plotPrecise(bd, T.TI_TAR_NW, 22, 22);
                T.plotPrecise(bd, T.TI_TMOTHER_WO, 0, 11);
                T.plotPrecise(bd, T.TI_TMOTHER_EO, 22, 11);
            },

            function ():Boolean {
                return levPos(4) && getMonster(C.M_TARMOTHER) && !roomConquered();
            },

            function ():Boolean {
                return Game.spawnCycleCount < 30 && !getMonster(C.M_TARMOTHER);
            }));

        toArray.push(Achievement.get(_("achName17"), _("achDesc17"),
            "1c0d5ed558281d0084e6a838c326cdff",
            function (bd:BitmapData, x:uint, y:uint):void{
                UBitmapData.blit(Gfx.ACHIEVEMENT, bd, 0, 0);

                T.plotPrecise(bd, T.TI_EEYE_AN,  -11, -11);
                T.plotPrecise(bd, T.TI_EEYE_SW,  -11,  11);
                T.plotPrecise(bd, T.TI_EEYE_ANE, -11,  33);
                T.plotPrecise(bd, T.TI_EEYE_AE,   11, -11);
                T.plotPrecise(bd, T.TI_EEYE_SW,   11,  11);
                T.plotPrecise(bd, T.TI_EEYE_S,    11,  33);
                T.plotPrecise(bd, T.TI_EEYE_ANW,  33, -11);
                T.plotPrecise(bd, T.TI_EEYE_SE,   33,  11);
                T.plotPrecise(bd, T.TI_EEYE_W,    33,  33);

            },

            function ():Boolean {
                this._data.failed = false;

                return getMonster(C.M_EYE) != null && !roomConquered();
            },

            function ():Boolean {
                if (this._data.failed)
                    return false;

                if (ev(C.CID_EVIL_EYE_WOKE)) {
                    this._data.failed = true;
                    return false;
                }

                return evConq();
            }));

        toArray.push(Achievement.get(_("achName18"), _("achDesc18"),
            "e1499ad2aef069de6b2adb5d3ef2dfc1",
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

        toArray.push(Achievement.get(_("achName19"), _("achDesc19"),
            "b64f52ebb88743f4c18344a61eace40f",
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

        toArray.push(Achievement.get(_("achName20"), _("achDesc20"),
            "b9d9c322be6daa6d86283024ea997426",
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

        toArray.push(Achievement.get(_("achName21"), _("achDesc21"),
            "5c231e3bbd5aad4b89b9fe0ab0d0b29f",
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

        toArray.push(Achievement.get(_("achName22"), _("achDesc22"),
            "28d3438eefc3696cdf8d01f0f7ae0caa",
            function (bd:BitmapData, x:uint, y:uint):void{
                UBitmapData.blit(Gfx.ACHIEVEMENT, bd, 0, 0);

                T.plotPrecise(bd, T.TI_MASTER_WALL, 11,  11);
            },

            function ():Boolean {
                return true;
            },

            function ():Boolean {
                return Progress.isGameMastered;
            }));

        toArray.push(Achievement.get(_("achName23"), _("achDesc23"),
            "6ee1f0b6ba838e1f2773fe20ae9a1a4a",
            function (bd:BitmapData, x:uint, y:uint):void{
                UBitmapData.blit(Gfx.ACHIEVEMENT, bd, 0, 0);

                T.plotPrecise(bd, T.TI_MASTER_WALL, 0,  0,  Gfx.GENERAL_TILES);
                T.plotPrecise(bd, T.TI_MASTER_WALL, 22, 0,  Gfx.GENERAL_TILES);
                T.plotPrecise(bd, T.TI_MASTER_WALL, 0,  22, Gfx.GENERAL_TILES);
                T.plotPrecise(bd, T.TI_MASTER_WALL, 22, 22, Gfx.GENERAL_TILES);
            },

            function ():Boolean {
                return levPos(5) && roomPos(0, 1);
            },

            function ():Boolean {
                return player.x == 18 && player.y == 8;
            }));



        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: SECRETED
        // ::::::::::::::::::::::::::::::::::::::::::::::

        toArray.push(Achievement.get(_("achName24"),
            function():String {
                if (!this.acquired)
                    return _("achHidden");
                else
                    return _("achDesc24");
            },
            "f342bdb246f1282085e2d0a8263ef07f",
            function (bd:BitmapData, x:uint, y:uint):void{
                UBitmapData.blit(Gfx.ACHIEVEMENT, bd, 0, 0);
                T.plotPrecise(bd, T.TI_RQUEEN_NE, 11, 11);
            },

            function ():Boolean{
                if (!this._data.hasOwnProperty("kills"))
                    this._data.kills = 0;

                return getMonster(C.M_QROACH) != null;
            },

            function ():Boolean {
                if (isUndo)
                    return false;

                if (evKilled(C.M_QROACH))
                    this._data.kills++;

                return this._data.kills >= 20;
            }));

        toArray.push(Achievement.get(_("achName25"),
            function():String {
                if (!this.acquired)
                    return _("achHidden");
                else
                    return _("achDesc25");
            },
            "cf4ddc44bf2172450ee4902cd90176d6",
            function (bd:BitmapData, x:uint, y:uint):void{
                UBitmapData.blit(Gfx.ACHIEVEMENT, bd, 0, 0);
                T.plotPrecise(bd, T.TI_REGG_N, 11, 11);
            },

            function ():Boolean{
                if (!this._data.hasOwnProperty("kills"))
                    this._data.kills = 0;

                return getMonster(C.M_QROACH) != null;
            },

            function ():Boolean {
                if (isUndo)
                    return false;

                if (evKilled(C.M_REGG))
                    this._data.kills++;

                return this._data.kills >= 15;
            }));

        toArray.push(Achievement.get(_("achName26"),
            function():String {
                if (!this.acquired)
                    return _("achHidden");
                else
                    return _("achDesc26");
            },
            "c473e7cfeedce0cf16b08ecb218c1320",
            function (bd:BitmapData, x:uint, y:uint):void{
                UBitmapData.blit(Gfx.ACHIEVEMENT, bd, 0, 0);
                T.plotPrecise(bd, T.TI_EEYEW_NE, 11, 11);
            },

            function ():Boolean{
                if (!this._data.hasOwnProperty("kills"))
                    this._data.kills = 0;

                return getMonster(C.M_EYE) != null;
            },

            function ():Boolean {
                if (isUndo)
                    return false;

                if (evKilled(C.M_EYE))
                    this._data.kills++;

                return this._data.kills >= 15;
            }));

        toArray.push(Achievement.get(_("achName27"),
            function():String {
                if (!this.acquired)
                    return _("achHidden");
                else
                    return _("achDesc27");
            },
            "31b98b637d9c2f7d8c86cd03faabe3c1",
            function (bd:BitmapData, x:uint, y:uint):void{
                UBitmapData.blit(Gfx.ACHIEVEMENT, bd, 0, 0);
                T.plotPrecise(bd, T.TI_WWING_NE, 11, 11);
            },

            function ():Boolean{
                if (!this._data.hasOwnProperty("kills"))
                    this._data.kills = 0;

                return getMonster(C.M_WWING) != null;
            },

            function ():Boolean {
                if (isUndo)
                    return false;

                if (evKilled(C.M_WWING))
                    this._data.kills++;

                return this._data.kills >= 5;
            }));

        toArray.push(Achievement.get(_("achName28"),
            function():String {
                if (!this.acquired)
                    return _("achHidden");
                else
                    return _("achDesc28");
            },
            "fa3e8a45ec49d61da5054475d948fbf2",
            function (bd:BitmapData, x:uint, y:uint):void{
                UBitmapData.blit(Gfx.ACHIEVEMENT, bd, 0, 0);
                T.plotPrecise(bd, T.TI_SNKH_AE, 22, 0);
                T.plotPrecise(bd, T.TI_SNK_SE, 0, 0);
                T.plotPrecise(bd, T.TI_SNK_NE, 0, 22);
                T.plotPrecise(bd, T.TI_SNKT_E, 22, 22);
            },

            function ():Boolean{
                if (!this._data.hasOwnProperty("kills"))
                    this._data.kills = 0;

                return getMonster(C.M_SERPENT) != null;
            },

            function ():Boolean {
                if (isUndo)
                    return false;

                if (evKilled(C.M_SERPENT) || ev(C.CID_SNAKE_DIED_FROM_TRUNCATION))
                    this._data.kills++;

                return this._data.kills >= 10;
            }));

        toArray.push(Achievement.get(_("achName29"),
            function():String {
                if (!this.acquired)
                    return _("achHidden");
                else
                    return _("achDesc29");
            },
            "e74a891590f437b0f042cb0d09f24e75",
            function (bd:BitmapData, x:uint, y:uint):void{
                UBitmapData.blit(Gfx.ACHIEVEMENT, bd, 0, 0);
                T.plotPrecise(bd, T.TI_ORB, 11, 11, Gfx.GENERAL_TILES);
            },

            function ():Boolean {
                if (!this._data.hasOwnProperty("striking")){
                    this._data.striking = 0;
                    this._data.count    = 0;
                }

                return hasTile(C.T_ORB);
            },

            function ():Boolean {
                if (ev(C.CID_ORB_ACTIVATED) ||
                        ev(C.CID_ORB_ACTIVATED_BY_DOUBLE) ||
                        ev(C.CID_ORB_ACTIVATED_BY_PLAYER)) {

                    if (this._data.striking)
                        this._data.count++;
                    else {
                        this._data.striking = true;
                        this._data.count = 1;
                    }
                } else {
                    this._data.striking = false;
                    this._data.count = 0;
                }

                return this._data.count == 3;
            }));

        toArray.push(Achievement.get(_("achName30"),
            function():String {
                if (!this.acquired)
                    return _("achHidden");
                else
                    return _("achDesc30");
            },
            "49c78a22aa30df3f442a09a1b6d28312",
            function (bd:BitmapData, x:uint, y:uint):void{
                UBitmapData.blit(Gfx.ACHIEVEMENT, bd, 0, 0);
                T.plotPrecise(bd, T.TI_DOOR_G_SE, 0,  0,  Gfx.GENERAL_TILES);
                T.plotPrecise(bd, T.TI_DOOR_G_SW, 22, 0,  Gfx.GENERAL_TILES);
                T.plotPrecise(bd, T.TI_DOOR_G_NE, 0,  22, Gfx.GENERAL_TILES);
                T.plotPrecise(bd, T.TI_DOOR_G_NW, 22, 22, Gfx.GENERAL_TILES);
            },

            function ():Boolean {
                if (!this._data.hasOwnProperty("count")){
                    this._data.count    = 0;
					this._data.lastRoom = -1;
				}

                return hasTile(C.T_DOOR_G) && !roomConquered();
            },

            function ():Boolean {
                if (isUndo || this._data.lastRoom == roomID)
                    return false;

                if (evConq()){
                    this._data.count++;
					this._data.lastRoom = roomID;
				}

                return this._data.count >= 5;
            }));

        toArray.push(Achievement.get(_("achName31"),
            function():String {
                if (!this.acquired)
                    return _("achHidden");
                else
                    return _("achDesc31");
            },
            "f0629cd1bec42ce33c6c7857ae2ea3b4",
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

            function ():Boolean {
                if (isUndo)
                    return false;

                for (var i:TMonster = CueEvents.getFirstPrivateData(C.CID_MONSTER_DIED_FROM_STAB);
                    i != null;
                    i = CueEvents.getNextPrivateData()){

                    if (this._data.kills++ >= 2500)
                        return true;
                }

                return false;
            }));

        toArray.push(Achievement.get(_("achName32"),
            function ():String {
                if (!this.acquired)
                    return _("achHidden");
                else
                    return _("achDesc32");
            },
            "fa6eeafaf23adc664734d3496e6f8c74",
            function (bd:BitmapData, x:uint, y:uint):void{
                UBitmapData.blit(Gfx.ACHIEVEMENT, bd, 0, 0);
                T.plotPrecise(bd, T.TI_BEETHRO_NE, 11, 11);
                T.plotPrecise(bd, T.TI_BEETHRO_SWORD_NW, 22, 0);
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

                return this._data.deaths >= 70;
            }));

        toArray.push(Achievement.get(_("achName33"),
            function ():String {
                if (!this.acquired)
                    return _("achHidden");
                else
                    return _("achDesc33");
            },
            "39ff9d6c43b2da58b3d9253fe5f9bfee",
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

                return this._data.undos >= 350;
            }));

        toArray.push(Achievement.get(_("achName34"),
            function():String {
                if (!this.acquired)
                    return _("achHidden");
                else
                    return _("achDesc34");
            },
            "39493bc66b4237115df89216576750c2",
            function (bd:BitmapData, x:uint, y:uint):void{
                var tiles:BitmapData = Gfx.STYLES[T.STYLE_ICEWORKS][T.TILES];

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
            function ():Boolean {
                if (isUndo)
                    return false;

                for (var i:* = CueEvents.getFirstPrivateData(C.CID_TRAPDOOR_REMOVED);
                        i; i = CueEvents.getNextPrivateData())
                    this._data.trapdoors++;

                return this._data.trapdoors >= 200;
            }));

        toArray.push(Achievement.get(_("achName35"),
            function():String {
                if (!this.acquired)
                    return _("achHidden");
                else
                    return _("achDesc35");
            },
            "69c33a549a75745776933812ea662d03",
            function (bd:BitmapData, x:uint, y:uint):void{
                UBitmapData.blit(Gfx.ACHIEVEMENT, bd, 0, 0);

                T.plotPrecise(bd, T.TI_BEETHRO_N, 11, 33);
                T.plotPrecise(bd, T.TI_BEETHRO_SWORD_N, 11, 11);
                T.plotPrecise(bd, T.TI_BEETHRO_N, 11, -11);
            },
            function ():Boolean{
                if (!this._data.hasOwnProperty("steps"))
                    this._data.steps = 0;

                return true
            },
            function ():Boolean {
                if (isUndo)
                    return false;

                if (CueEvents.hasOccured(C.CID_STEP))
                    this._data.steps++;

                return this._data.steps >= 7000;
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
import game.objects.actives.TPlayer;
import game.states.TStateGame;

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
    return CueEvents.hasOccured(C.CID_ROOM_CONQUER_PENDING) || Game.room.monsterCount == 0;
}

function evKilled(type:uint):Boolean {
    for (var i:TMonster = CueEvents.getFirstPrivateData(C.CID_MONSTER_DIED_FROM_STAB);
            i; i = CueEvents.getNextPrivateData() ) {
        if (i.getType() == type)
            return true;
    }

    return false;
}

function ev(type:uint):Boolean {
    return CueEvents.hasOccured(type);
}

function getMonster(type:uint):TMonster {
    return room.getMonsterOfType(type);
}

function get room():Room {
    return Game.room;
}

function get player():TPlayer {
    return Game.player;
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

function get isUndo():Boolean {
    return TStateGame.isDoingUndo;
}