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

    public function AchievementsListKdd3(toArray:Array):void{
        ASSERT(toArray);

        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Room Specific
        // ::::::::::::::::::::::::::::::::::::::::::::::

        toArray.push(Achievement.get(_("achName0"), _("achDesc0"),
            "bbf28d894f7431e7a64621a3bf67c2c1",
            function (bd:BitmapData, x:uint, y:uint):void {
                var tiles:BitmapData = Gfx.STYLES[T.STYLE_ABOVEGROUND][T.TILES];

                UBitmapData.blit(Gfx.ACHIEVEMENT, bd, 0, 0);

                T.plotPrecise(bd, T.TI_WALL, 11, 11, tiles);

                T.plotPrecise(bd, T.TI_BEETHRO_SE, -11, -11);
                T.plotPrecise(bd, T.TI_BEETHRO_SW,  33, -11);
                T.plotPrecise(bd, T.TI_BEETHRO_NW,  33,  33);
                T.plotPrecise(bd, T.TI_BEETHRO_NE, -11,  33);
            },

            function ():Boolean {
                if (!this._data.hasOwnProperty('count'))
                    this._data.count = [];
                else
                    this._data.count.length = 0;

                this._data.failed = false;
                this._data.isOn   = -1;

                return levPos(1) && roomPos(3, -4) && !roomConquered();T
            },

            function ():Boolean{
                if (this._data.failed === true)
                    return false;

                var isOn:int = -1;

                if (playerIn(1, 2, 2, 3))
                    isOn = 0;

                if (playerIn(14, 1, 16, 1))
                    isOn = 1;

                if (playerIn(25, 4, 25, 6))
                    isOn = 2;

                if (playerIn(25, 17, 25, 19))
                    isOn = 3;

                if (playerIn(21, 22, 22, 23))
                    isOn = 4;

                if (playerIn(10, 21, 11, 23))
                    isOn = 5;

                if (isOn != -1) {
                    this._data.isOn = isOn;

                } else if (this._data.isOn != -1) {
                    if (this._data.count[this._data.isOn]) {
                        this._data.failed = true;
                        return false;
                    } else {
                        this._data.count[this._data.isOn] = true;
                        this._data.isOn = -1;
                    }
                }

                return evConq();
            }));

        toArray.push(Achievement.get(_("achName1"), _("achDesc1"),
            "faf7a3578615b1b93b91cd4c14c048a9",
            function (bd:BitmapData, x:uint, y:uint):void {
                var tiles:BitmapData = Gfx.STYLES[T.STYLE_ABOVEGROUND][T.TILES];

                UBitmapData.blit(Gfx.ACHIEVEMENT, bd, 0, 0);

                T.plotPrecise(bd, T.TI_WALL, 11, 11, tiles);

                T.plotPrecise(bd, T.TI_BEETHRO_S,  11, -11);
                T.plotPrecise(bd, T.TI_BEETHRO_W,  33,  11);
                T.plotPrecise(bd, T.TI_BEETHRO_N,  11,  33);
                T.plotPrecise(bd, T.TI_BEETHRO_E, -11,  11);
            },

            function ():Boolean {
                if (!this._data.hasOwnProperty('count'))
                    this._data.count = [];
                else
                    this._data.count.length = 0;

                this._data.failed = false;
                this._data.isOn   = -1;

                return levPos(1) && roomPos(3, -3) && !roomConquered();T
            },

            function ():Boolean{
                if (this._data.failed === true)
                    return false;

                var isOn:int = -1;

                if (playerIn(0, 9, 2, 11))
                    isOn = 0;

                if (playerIn(11, 1, 13, 1))
                    isOn = 1;

                if (playerIn(23, 11, 25, 13))
                    isOn = 2;

                if (playerIn(12, 22, 14, 23))
                    isOn = 3;

                if (isOn != -1) {
                    this._data.isOn = isOn;

                } else if (this._data.isOn != -1) {
                    if (this._data.count[this._data.isOn]) {
                        this._data.failed = true;
                        return false;
                    } else {
                        this._data.count[this._data.isOn] = true;
                        this._data.isOn = -1;
                    }
                }

                return evConq();
            }));

        toArray.push(Achievement.get(_("achName2"), _("achDesc2"),
            "8e04e8be71fa5c42391f0e9630698215",
            function (bd:BitmapData, x:uint, y:uint):void {
                UBitmapData.blit(Gfx.ACHIEVEMENT, bd, 0, 0);

                T.plotPrecise(bd, T.TI_BEETHRO_SWORD_NE, 22, 0);
                T.plotPrecise(bd, T.TI_BEETHRO_NE, 0, 22);
                T.plotPrecise(bd, T.TI_SPIDER_S, 0, 0);
                T.plotPrecise(bd, T.TI_SPIDER_AW, 22, 22);

            },

            function ():Boolean {
                this._data.canRotate = true;
                this._data.failed    = false;

                return levPos(2) && roomPos(1, -1) && !roomConquered();T
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

        toArray.push(Achievement.get(_("achName3"), _("achDesc3"),
            "c09b5aa4c0e23056efafaded55826c29",
            function (bd:BitmapData, x:uint, y:uint):void {
                UBitmapData.blit(Gfx.ACHIEVEMENT, bd, 0, 0);

                T.plotPrecise(bd, T.TI_BEETHRO_SWORD_NW, 0, 0);
                T.plotPrecise(bd, T.TI_BEETHRO_NW, 22, 22);
                T.plotPrecise(bd, T.TI_SPIDER_AS, 22, 0);
                T.plotPrecise(bd, T.TI_SPIDER_E, 0, 22);
            },

            function ():Boolean {
                this._data.canRotate = true;
                this._data.failed    = false;

                return levPos(2) && roomPos(1, 0) && !roomConquered();
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

        toArray.push(Achievement.get(_("achName4"), _("achDesc4"),
            "759fce8b66c429ed4dc2516a604c5388",
            function (bd:BitmapData, x:uint, y:uint):void {
                UBitmapData.blit(Gfx.ACHIEVEMENT, bd, 0, 0);

                T.plotPrecise(bd, T.TI_BEETHRO_SWORD_SW, 0, 22);
                T.plotPrecise(bd, T.TI_BEETHRO_SW, 22, 0);
                T.plotPrecise(bd, T.TI_RQUEEN_W, 0, 0);
                T.plotPrecise(bd, T.TI_RQUEEN_AS, 22, 22);
            },

            function ():Boolean {
                this._data.canRotate = true;
                this._data.failed    = false;

                return levPos(2) && roomPos(-1, 1) && !roomConquered();
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
            "f02688dc91ff5c464a3af81cda357278",
            function (bd:BitmapData, x:uint, y:uint):void {
                UBitmapData.blit(Gfx.ACHIEVEMENT, bd, 0, 0);

                T.plotPrecise(bd, T.TI_POTION_M, 11, 11);
            },

            function ():Boolean {
                this._data.failed = false;

                return levPos(2) && roomPos(0, 1) && !roomConquered();
            },

            function ():Boolean{
                if (this._data.failed === true)
                    return false;

                if (player.x == 14 && player.y == 13) {
                    this._data.failed = true;
                    return false;
                }

                if (evConq()){
                    return true;
                }

                return false;
            }));

        toArray.push(Achievement.get(_("achName6"), _("achDesc6"),
            "e3e74811cf5b80218c16904c1ff4810e",
            function (bd:BitmapData, x:uint, y:uint):void {
                var tiles:BitmapData = Gfx.STYLES[T.STYLE_ABOVEGROUND][T.TILES];

                UBitmapData.blit(Gfx.ACHIEVEMENT, bd, 0, 0);

                T.plotPrecise(bd, T.TI_WALLB_NSEW123, -11,  -11, tiles);
                T.plotPrecise(bd, T.TI_WALLB_NEW12,  11,  -11, tiles);
                T.plotPrecise(bd, T.TI_WALLB_NSEW124,  33,  -11, tiles);
                T.plotPrecise(bd, T.TI_WALLB_NSW13, -11,   11, tiles);
                T.plotPrecise(bd, T.TI_WALLB_NSE24,  33,   11, tiles);
                T.plotPrecise(bd, T.TI_WALLB_NSEW134, -11,   33, tiles);
                T.plotPrecise(bd, T.TI_WALLB_SEW34,  11,   33, tiles);
                T.plotPrecise(bd, T.TI_WALLB_NSEW234,  33,   33, tiles);
                T.plotPrecise(bd, T.TI_ROACH_ASE, 11, 11);
            },

            function ():Boolean {
                return levPos(3) && roomPos(2, 1);
            },

            function ():Boolean {
                return Game.turnNo < 150 && evConq();
            }));

        toArray.push(Achievement.get(_("achName7"), _("achDesc7"),
            "260c5192997525b33495a35ad4d1832f",
            function (bd:BitmapData, x:uint, y:uint):void{
                UBitmapData.blit(Gfx.ACHIEVEMENT, bd, 0, 0);

                T.plotPrecise(bd, T.TI_TAR_SE, 0,  0);
                T.plotPrecise(bd, T.TI_TAR_SW, 22, 0);
                T.plotPrecise(bd, T.TI_TAR_NE, 0,  22);
                T.plotPrecise(bd, T.TI_TAR_NW, 22, 22);
            },

            function ():Boolean {
                return levPos(3) && hasTile(C.T_TAR);
            },

            function ():Boolean {
                return !hasTile(C.T_TAR);
            }));

        toArray.push(Achievement.get(_("achName8"), _("achDesc8"),
            "64b82de4f8a734eb2fadb268988b7e6b",
            function (bd:BitmapData, x:uint, y:uint):void {
                UBitmapData.blit(Gfx.ACHIEVEMENT, bd, 0, 0);

                T.plotPrecise(bd, T.TI_BEETHRO_N,  11,  11);
                T.plotPrecise(bd, T.TI_SNKH_AN,    11,  33);
                T.plotPrecise(bd, T.TI_SNKH_AS,    11, -11);
                T.plotPrecise(bd, T.TI_SNKH_AE,   -11,  11);
                T.plotPrecise(bd, T.TI_SNKH_AW,    33,  11);
            },

            function ():Boolean {
                this._data.failed = false;

                return levPos(4) && roomPos(2, 1) && !roomConquered();
            },

            function ():Boolean{
                if (this._data.failed === true)
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

        toArray.push(Achievement.get(_("achName9"), _("achDesc9"),
            "e6a152fc2a11d08c2ccef13da91c490b",
            function (bd:BitmapData, x:uint, y:uint):void {
                UBitmapData.blit(Gfx.ACHIEVEMENT, bd, 0, 0);

                T.plotPrecise(bd, T.TI_POTION_M, 0, 11);
                T.plotPrecise(bd, T.TI_POTION_M, 22, 11);
            },

            function ():Boolean {
                this._data.failed = false;

                return levPos(4) && roomPos(1, 2) && !roomConquered();
            },

            function ():Boolean{
                if (this._data.failed === true)
                    return false;

                if (player.x == 12 && player.y == 10) {
                    this._data.failed = true;
                    return false;
                }

                return evConq();
            }));

        toArray.push(Achievement.get(_("achName10"), _("achDesc10"),
            "5d4aa5e3dde3d0978c3578b28c045759",
            function (bd:BitmapData, x:uint, y:uint):void {
                var tiles:BitmapData = Gfx.STYLES[T.STYLE_ABOVEGROUND][T.TILES];

                UBitmapData.blit(Gfx.ACHIEVEMENT, bd, 0, 0);

                T.plotPrecise(bd, T.TI_EEYEW_S, 11,  11);
                T.plotPrecise(bd, T.TI_EEYEW_S, 11, -11);

                T.plotPrecise(bd, T.TI_BEETHRO_W, 11, 33);

                T.plotPrecise(bd, T.TI_BEETHRO_SWORD_W, -11, 33);

                T.plotPrecise(bd, T.TI_SNKH_W, 33, 33);

                T.plotPrecise(bd, T.TI_WALL_NW1, -11, 11, tiles);
                T.plotPrecise(bd, T.TI_WALL_NSW13, -11, -11, tiles);

                T.plotPrecise(bd, T.TI_WALL_NE2, 33, 11, tiles);
                T.plotPrecise(bd, T.TI_WALL_NSE24, 33, -11, tiles);
            },

            function ():Boolean {
                this._data.wakes = 0;

                return levPos(4) && roomPos(0, 1) && !roomConquered();
            },

            function ():Boolean {
                if (this._data.wakes > 1)
                    return false;

                if (ev(C.CID_EVIL_EYE_WOKE)) {
                    this._data.wakes++;
                    return false;
                }

                return evConq();
            }));

        toArray.push(Achievement.get(_("achName11"), _("achDesc11"),
            "8b1ffc953c776c0a9d4e6f904a558921",
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

        toArray.push(Achievement.get(_("achName12"), _("achDesc12"),
            "8474c9356ab419ded14f9817e9c98884",
            function (bd:BitmapData, x:uint, y:uint):void {
                UBitmapData.blit(Gfx.ACHIEVEMENT, bd, 0, 0);

                T.plotPrecise(bd, T.TI_RQUEEN_ASW, 11, 11);
                T.plotPrecise(bd, T.TI_REGG_AN,  -11, -11);
                T.plotPrecise(bd, T.TI_REGG_ASW,  11, -11);
                T.plotPrecise(bd, T.TI_REGG_SW,   33, -11);
                T.plotPrecise(bd, T.TI_REGG_AW,  -11,  11);
                T.plotPrecise(bd, T.TI_REGG_NW,   33,  11);
                T.plotPrecise(bd, T.TI_REGG_W,   -11,  33);
                T.plotPrecise(bd, T.TI_REGG_N,    11,  33);
                T.plotPrecise(bd, T.TI_REGG_ANW,  33,  33);
            },
            function ():Boolean {
                this._data.failed  = false;
                this._data.rescued = false;

                return room.getMonsterOfType(C.M_QROACH) != null;
            },
            function ():Boolean {
                if (evKilled(C.M_QROACH)) {
                    for (var i:TMonster = CueEvents.getFirstPrivateData(C.CID_MONSTER_DIED_FROM_STAB);
                            i;  i = CueEvents.getNextPrivateData()) {
                        if (i && i is TRoachQueen &&
                                room.isMonsterInRectOfType(Math.max(0, i.x - 1),
                                    Math.max(0, i.y - 1),
                                    Math.min(S.LEVEL_WIDTH - 1, i.x + 1),
                                    Math.min(S.LEVEL_HEIGHT, i.y + 1),
                                    C.M_REGG)){
                            return true;
                        }
                    }
                }

                return false;
            }));


        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Level Specific
        // ::::::::::::::::::::::::::::::::::::::::::::::

        toArray.push(Achievement.get(_("achName13"), _("achDesc13"),
            "8fd318a6e01a0c99ac8886f1581fa84c",
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

        toArray.push(Achievement.get(_("achName14"), _("achDesc14"),
            "03f752e496f3153029b62f939ae8ae6a",
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

        toArray.push(Achievement.get(_("achName15"), _("achDesc15"),
            "542b1a300f93fab81f45038cb7fbebb8",
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

        toArray.push(Achievement.get(_("achName16"), _("achDesc16"),
            "055a60818297e39eeb37b69276e3d1ce",
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

        toArray.push(Achievement.get(_("achName17"), _("achDesc17"),
            "e41b97bdbd59df0ecf8ea49aa37cd322",
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

        toArray.push(Achievement.get(_("achName18"), _("achDesc18"),
            "c36b3b6cf64fd3c6d182a6fe9293f1ad",
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

        toArray.push(Achievement.get(_("achName19"),
            function():String {
                if (!this.acquired)
                    return _("achHidden");
                else
                    return _("achDesc19");
            },
            "6f0d2eb89dbba156cd3b5fdf60921f17",
            function (bd:BitmapData, x:uint, y:uint):void{
                UBitmapData.blit(Gfx.ACHIEVEMENT, bd, 0, 0);
                T.plotPrecise(bd, T.TI_ROACH_NE, 11, 11);
            },

            function ():Boolean {
                if (!this._data.hasOwnProperty("kills"))
                    this._data.kills = 0;

                return getMonster(C.M_ROACH) || getMonster(C.M_QROACH);
            },

            function ():Boolean {
                if (isUndo)
                    return false;

                if (evKilled(C.M_ROACH))
                    this._data.kills++;

                return this._data.kills >= 35;
            }));

        toArray.push(Achievement.get(_("achName20"),
            function():String {
                if (!this.acquired)
                    return _("achHidden");
                else
                    return _("achDesc20");
            },
            "594ecec90bd15bb44ff2374fe1557ddd",
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

        toArray.push(Achievement.get(_("achName21"),
            function():String {
                if (!this.acquired)
                    return _("achHidden");
                else
                    return _("achDesc21");
            },
            "1f42132ec37ab99ed164d4cae376545d",
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

        toArray.push(Achievement.get(_("achName22"),
            function():String {
                if (!this.acquired)
                    return _("achHidden");
                else
                    return _("achDesc22");
            },
            "9bb81d929ef839c31e3106e1d3687bd7",
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

        toArray.push(Achievement.get(_("achName23"),
            function():String {
                if (!this.acquired)
                    return _("achHidden");
                else
                    return _("achDesc23");
            },
            "65f116bc66a9948fac732ce07a64e132",
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

        toArray.push(Achievement.get(_("achName24"),
            function():String {
                if (!this.acquired)
                    return _("achHidden");
                else
                    return _("achDesc24");
            },
            "53fd4a12e78af170b9696ac5d529cca4",
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

        toArray.push(Achievement.get(_("achName25"),
            function():String {
                if (!this.acquired)
                    return _("achHidden");
                else
                    return _("achDesc25");
            },
            "2fd6813527aedb8cdce33439658ee979",
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

        toArray.push(Achievement.get(_("achName26"),
            function():String {
                if (!this.acquired)
                    return _("achHidden");
                else
                    return _("achDesc26");
            },
            "ba2fada0543a2fe5a9e11fd57fca94a3",
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

        toArray.push(Achievement.get(_("achName27"),
            function():String {
                if (!this.acquired)
                    return _("achHidden");
                else
                    return _("achDesc27");
            },
            "c9c0d07ee5fdbcb6dceb658c1738900c",
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

        toArray.push(Achievement.get(_("achName28"),
            function ():String {
                if (!this.acquired)
                    return _("achHidden");
                else
                    return _("achDesc28");
            },
            "e36f66b50adbf17fb960884a7de484dc",
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

                return this._data.deaths >= 100;
            }));

        toArray.push(Achievement.get(_("achName29"),
            function ():String {
                if (!this.acquired)
                    return _("achHidden");
                else
                    return _("achDesc29");
            },
            "ac516a5baa7c340a9679398f8cd2ae86",
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

                return this._data.undos >= 450;
            }));

        toArray.push(Achievement.get(_("achName30"),
            function():String {
                if (!this.acquired)
                    return _("achHidden");
                else
                    return _("achDesc30");
            },
            "00da1e2f98aedfd238d74d7e74a5f657",
            function (bd:BitmapData, x:uint, y:uint):void{
                var tiles:BitmapData = Gfx.STYLES[T.STYLE_ABOVEGROUND][T.TILES];

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

        toArray.push(Achievement.get(_("achName31"),
            function():String {
                if (!this.acquired)
                    return _("achHidden");
                else
                    return _("achDesc31");
            },
            "e74068589e03f03fa40c1c40f6275925",
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

                return this._data.steps >= 8000;
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

function ev(type:uint):Boolean {
    return CueEvents.hasOccured(type);
}

function get player():TPlayer {
    return Game.player;
}

function playerIn(left:uint, top:uint, right:uint, bottom:uint):Boolean {
    return (player.x >= left && player.y >= top && player.x <= right && player.y <= bottom);
}

function get isUndo():Boolean {
    return TStateGame.isDoingUndo;
}