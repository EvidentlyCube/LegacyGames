package game.achievements{
    import flash.display.BitmapData;
    import flash.events.DataEvent;
    import flash.geom.Point;
    import game.global.Progress;
    import game.objects.actives.TMimic;
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

    public function AchievementsListKdd1(toArray:Array):void{
        ASSERT(toArray);

        toArray.push(Achievement.get(_("achName0"), _("achDesc0"),
            "9d68b049bdff26e2c42a0d2ea309ac9b",
            function (bd:BitmapData, x:uint, y:uint):void {
                UBitmapData.blit(Gfx.ACHIEVEMENT, bd, 0, 0);

                T.plotPrecise(bd, T.TI_EEYEW_S, 0,   1);
                T.plotPrecise(bd, T.TI_EEYEW_S, 22,  1);
                T.plotPrecise(bd, T.TI_EEYEW_S, 11, 21);
            },
            function ():Boolean {
                this._data.failed  = false;
                this._data.rescued = false;

                return room.getMonsterOfType(C.M_EYE) != null;
            },
            function ():Boolean {
                var count:uint;
                if (ev(C.CID_EVIL_EYE_WOKE)) {
                    count = 1;

                    CueEvents.getFirstPrivateData(C.CID_EVIL_EYE_WOKE);

                    while (CueEvents.getNextPrivateData())
                        count++;
                }

                return count >= 3;
            }));

        toArray.push(Achievement.get(_("achName1"), _("achDesc1"),
            "5bf1c0225da3602fa2b94249a1f82a4f",
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

        toArray.push(Achievement.get(_("achName2"), _("achDesc2"),
            "5f1c70a7d2078ebae8c7e213c4adce47",
            function (bd:BitmapData, x:uint, y:uint):void {
                var tiles:BitmapData = Gfx.STYLES[T.STYLE_FOUNDATION][T.TILES];

                UBitmapData.blit(Gfx.ACHIEVEMENT, bd, 0, 0);

                T.plotPrecise(bd, T.TI_WALLB_SE4, 0,  0,  tiles);
                T.plotPrecise(bd, T.TI_WALLB_SW3, 22, 0,  tiles);
                T.plotPrecise(bd, T.TI_WALLB_NE2, 0,  22, tiles);
                T.plotPrecise(bd, T.TI_WALLB_NW1, 22, 22, tiles);

            },
            function ():Boolean {
                return levPos(2) && roomPos(1, -1);
            },
            function ():Boolean {
                return !hasTile(C.T_WALL_BROKEN);
            }));



        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Room-specific Level 1
        // ::::::::::::::::::::::::::::::::::::::::::::::

        toArray.push(Achievement.get(_("achName3"), _("achDesc3"),
            "6a82119fe491524caa1e3d9bedecee03",
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

        toArray.push(Achievement.get(_("achName4"),
            function ():String {
                var count:String =  this._data.finished || 0;
                return _("achDesc4", count);
            },
            "e0361318eeb0281b671070ecbbd68919",
            function (bd:BitmapData, x:uint, y:uint):void{
                UBitmapData.blit(Gfx.ACHIEVEMENT, bd, 0, 0);
                T.plotPrecise(bd, T.TI_BEETHRO_SWORD_NE, 22, 0);
                T.plotPrecise(bd, T.TI_BEETHRO_NE,  0, 22);
                T.plotPrecise(bd, T.TI_BEETHRO_SWORD_SE, 22, 22);
                T.plotPrecise(bd, T.TI_BEETHRO_SE,  0, 0);
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

                if (!this._data.failed && evConq()){
                    this._data.rooms[Game.room.roomID] = true;

                    this._data.finished++;

                    if (this._data.finished == 6)
                        return true;
                }

                return false;
            }));



        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Room-specific Level 2
        // ::::::::::::::::::::::::::::::::::::::::::::::

        toArray.push(Achievement.get(_("achName5"), _("achDesc5"),
            "37a3cd0fcfe02c24538680eba2c16178",
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

        toArray.push(Achievement.get(_("achName6"), _("achDesc6"),
            "873c8a066373c3e443f224800bd1581b",
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

                    if (evConq())
                        return true;

                } else if (CueEvents.hasOccured(C.CID_ORB_ACTIVATED_BY_PLAYER))
                    this._data.started = true;

                return false;
            }));

        toArray.push(Achievement.get(_("achName7"), _("achDesc7"),
            "1c7b5dacd87c6fb13b38c50f33d66871",
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

                if (evConq())
                    return true;

                return false;
            }));

        toArray.push(Achievement.get(_("achName8"), _("achDesc8"),
            "c96dbc86093d595444051d63392a0f2c",
            function (bd:BitmapData, x:uint, y:uint):void {
                UBitmapData.blit(Gfx.ACHIEVEMENT, bd, 0, 0);

                T.plotPrecise(bd, T.TI_RQUEEN_NE, 0,  0);
                T.plotPrecise(bd, T.TI_RQUEEN_ANE, 22, 0);
                T.plotPrecise(bd, T.TI_RQUEEN_ANE, 22, 22);
                T.plotPrecise(bd, T.TI_REGG_AN,  0, 22);
            },


            function ():Boolean {
                this._data.killCount = 0;

                return levPos(2) && roomPos(3, 2) && !roomConquered();
            },

            function ():Boolean {
                if (TStateGame.lastCommand == C.CMD_UNDO)
                    return false;

                if (CueEvents.hasOccured(C.CID_MONSTER_DIED_FROM_STAB)){
                    this._data.killCount++;

                    if (this._data.killCount < 9 && evConq())
                        return true;
                }

                return false;
            }));

        toArray.push(Achievement.get(_("achName9"), _("achDesc9"),
            "5ff967a6354cd8fc86f5573b6f15baa8",
            function (bd:BitmapData, x:uint, y:uint):void{
                UBitmapData.blit(Gfx.ACHIEVEMENT, bd, 0, 0);
                T.plotPrecise(bd, T.TI_BEETHRO_SWORD_NW, 0, 0);
                T.plotPrecise(bd, T.TI_BEETHRO_NW, 22, 22);
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

        toArray.push(Achievement.get(_("achName10"), _("achDesc10"),
            "be87af484a2b27199cfd29132454682a",
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


        toArray.push(Achievement.get(_("achName11"), _("achDesc11"),
            "af6f7a087526342a80beac0448c07495",
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

        toArray.push(Achievement.get(_("achName12"), _("achDesc12"),
            "1a05e10f77418da58dbfbdf3ddc9c0d8",
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

        toArray.push(Achievement.get(_("achName13"), _("achDesc13"),
            "c1af59a0ebd36f20d6b5766dd5c8639f",
            function (bd:BitmapData, x:uint, y:uint):void {
                var tiles:BitmapData = Gfx.STYLES[T.STYLE_DEEP_SPACES][T.TILES];

                UBitmapData.blit(Gfx.ACHIEVEMENT, bd, 0, 0);

                T.plotPrecise(bd, T.TI_WALL_EW, 0, -11, tiles);
                T.plotPrecise(bd, T.TI_WALL_EW, 22, -11, tiles);

                T.plotPrecise(bd, T.TI_ARROW_S, -11, 33, tiles);
                T.plotPrecise(bd, T.TI_ARROW_S, 11, 33, tiles);
                T.plotPrecise(bd, T.TI_ARROW_S, 33, 33, tiles);

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

        toArray.push(Achievement.get(_("achName14"), _("achDesc14"),
            "b4579b9343d177ae0ba5d05f12366e0b",
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

        toArray.push(Achievement.get(_("achName15"), _("achDesc15"),
            "1c45d52b7f4ff3255f3a8b376b16cd51",
            function (bd:BitmapData, x:uint, y:uint):void {
                UBitmapData.blit(Gfx.ACHIEVEMENT, bd, 0, 0);

                T.plotPrecise(bd, T.TI_ROACH_AS, 11,  1);
                T.plotPrecise(bd, T.TI_ROACH_ANE, 0,   21);
                T.plotPrecise(bd, T.TI_ROACH_NW, 22,  21);
            },

            function ():Boolean {
                this._data.failed  = false;
                this._data.rescued = false;

                return levPos(3) && roomPos(1, -2) && !roomConquered();
            },

            function ():Boolean {
                if (this._data.failed)
                    return false;

                if (!room.isMonsterInRect(3, 3, 23, 22, true))
                    this._data.rescued = true;

                if (evKilled(C.M_ROACH)) {
                    if (!this._data.rescued){
                        this._data.failed = true;
                        return false;
                    }
                }

                return evConq();
            }));

        toArray.push(Achievement.get(_("achName16"), _("achDesc16"),
            "ee61633c14af918489612e96fccb1947",
            function (bd:BitmapData, x:uint, y:uint):void {
                UBitmapData.blit(Gfx.ACHIEVEMENT, bd, 0, 0);

                T.plotPrecise(bd, T.TI_DOOR_G_NS,  22,  0);
                T.plotPrecise(bd, T.TI_DOOR_G_NS,  22, 22);
                T.plotPrecise(bd, T.TI_POTION_M,    0,  0);
                T.plotPrecise(bd, T.TI_BEETHRO_NE,  0, 22);
                T.plotPrecise(bd, T.TI_BEETHRO_SWORD_NE,  22, 0);
            },

            function ():Boolean {
                this._data.failed  = false;

                return levPos(3) && roomPos(0, -3) && !roomConquered();
            },

            function ():Boolean {
                if (this._data.failed)
                    return false;

                if (player.x == 6 && player.y == 12) {
                    this._data.failed = true;
                    return false;
                }

                return evConq();
            }));



        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Room Specific Level 4
        // ::::::::::::::::::::::::::::::::::::::::::::::

        toArray.push(Achievement.get(_("achName17"), _("achDesc17"),
            "234f4368d90c64ac753360b08cf5440f",
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

        toArray.push(Achievement.get(_("achName18"), _("achDesc18"),
            "4edaf7c04cf584ffa50f52962012e422",
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

        toArray.push(Achievement.get(_("achName19"), _("achDesc19"),
            "bea4dce8ad52b7f5d416e99afd254cff",
            function (bd:BitmapData, x:uint, y:uint):void {
                var tiles:BitmapData = Gfx.STYLES[T.STYLE_DEEP_SPACES][T.TILES];

                UBitmapData.blit(Gfx.ACHIEVEMENT, bd, 0, 0);

                T.plotPrecise(bd, T.TI_TRAPDOOR, 11, 11, tiles);
            },

            function ():Boolean {
                return levPos(4) && roomPos(2, 1) && !roomConquered();
            },

            function ():Boolean {
                return evConq() && !hasTile(C.T_TRAPDOOR);
            }));

        toArray.push(Achievement.get(_("achName20"), _("achDesc20"),
            "0d32fd1503f8bef4d5372cbe679ed3a9",
            function (bd:BitmapData, x:uint, y:uint):void {
                var tiles:BitmapData = Gfx.STYLES[T.STYLE_DEEP_SPACES][T.TILES];

                UBitmapData.blit(Gfx.ACHIEVEMENT, bd, 0, 0);

                T.plotPrecise(bd, T.TI_TRAPDOOR, 0,  0,  tiles);
                T.plotPrecise(bd, T.TI_TRAPDOOR, 22, 0,  tiles);
                T.plotPrecise(bd, T.TI_TRAPDOOR, 0,  22, tiles);
                T.plotPrecise(bd, T.TI_TRAPDOOR, 22, 22, tiles);
            },

            function ():Boolean {
                return levPos(4) && roomPos(1, 2) && !roomConquered();
            },

            function ():Boolean {
                return evConq() && !hasTile(C.T_TRAPDOOR);
            }));

        toArray.push(Achievement.get(_("achName21"), _("achDesc21"),
            "d4af6190f8367d2d652cba05ead484e7",
            function (bd:BitmapData, x:uint, y:uint):void {
                UBitmapData.blit(Gfx.ACHIEVEMENT, bd, 0, 0);

                T.plotPrecise(bd, T.TI_MIMIC_W, 22, -11);
                T.plotPrecise(bd, T.TI_MIMIC_W, 22,  11);
                T.plotPrecise(bd, T.TI_MIMIC_W, 22,  33);
                T.plotPrecise(bd, T.TI_MIMIC_SWORD_W, 0, -11);
                T.plotPrecise(bd, T.TI_MIMIC_SWORD_W, 0,  11);
                T.plotPrecise(bd, T.TI_MIMIC_SWORD_W, 0,  33);
            },

            function ():Boolean {
                return levPos(4) && roomPos(2, 0) && !roomConquered();
            },

            function ():Boolean {
                for (var i:uint = 8; i <= 16; i++) {
                    var tile:TMonster = room.tilesActive[7 + i * S.LEVEL_WIDTH];

                    if (!tile || !(tile is TMimic))
                        return false;
                }

                return evConq();
            }));



        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Level-wide challenges
        // ::::::::::::::::::::::::::::::::::::::::::::::




        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: First Kills
        // ::::::::::::::::::::::::::::::::::::::::::::::

        toArray.push(Achievement.get(_("achName22"), _("achDesc22"),
            "bcc7b25124fd5e4741514a231ebf4660",
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

        toArray.push(Achievement.get(_("achName23"), _("achDesc23"),
            "730211914eefa3c263dc3f73855b9cec",
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

        toArray.push(Achievement.get(_("achName24"), _("achDesc24"),
            "2aadf9663e6ad09ae37e40048e583ad3",
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

        toArray.push(Achievement.get(_("achName25"), _("achDesc25"),
            "8731de00309108e787e7ff51589a422f",
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

        toArray.push(Achievement.get(_("achName26"), _("achDesc26"),
            "0c56b6c73e29aa4beaa7264327d9b1e7",
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

        toArray.push(Achievement.get(_("achName27"), _("achDesc27"),
            "9e4d6e49e2a3626936ca5f1fb6e282dc",
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

        toArray.push(Achievement.get(_("achName28"),
            function():String {
                if (!this.acquired)
                    return _("achHidden");
                else
                    return _("achDesc28");
            },
            "1dff7e1fd84f42ec4efd1fa94e22ae64",
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

        toArray.push(Achievement.get(_("achName29"),
            function():String {
                if (!this.acquired)
                    return _("achHidden");
                else
                    return _("achDesc29");
            },
            "3ee01ac5afd75e01ed2fa519085fd315",
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

        toArray.push(Achievement.get(_("achName30"),
            function():String {
                if (!this.acquired)
                    return _("achHidden");
                else
                    return _("achDesc30");
            },
            "9b9992c3454642da629c86e3a24227d6",
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

        toArray.push(Achievement.get(_("achName31"),
            function():String {
                if (!this.acquired)
                    return _("achHidden");
                else
                    return _("achDesc31");
            },
            "9a22ecd358e9cb42dc63308caae17b18",
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

        toArray.push(Achievement.get(_("achName32"),
            function():String {
                if (!this.acquired)
                    return _("achHidden");
                else
                    return _("achDesc32");
            },
            "f221f448ab1b91b5b46565d4472af6e0",
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

        toArray.push(Achievement.get(_("achName33"),
            function():String {
                if (!this.acquired)
                    return _("achHidden");
                else
                    return _("achDesc33");
            },
            "08464af5ff0630c42828b648d54c79c4",
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

        toArray.push(Achievement.get(_("achName34"),
            function():String {
                if (!this.acquired)
                    return _("achHidden");
                else
                    return _("achDesc34");
            },
            "59b11aa89dcdcbb217a5fc342471dc82",
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

        toArray.push(Achievement.get(_("achName35"),
            function():String {
                if (!this.acquired)
                    return _("achHidden");
                else
                    return _("achDesc35");
            },
            "90544f28991a8940e5a9427731638523",
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

        toArray.push(Achievement.get(_("achName36"),
            function ():String {
                if (!this.acquired)
                    return _("achHidden");
                else
                    return _("achDesc36");
            },
            "4ad04b650f37aa6795c4a0adb7e0799f",
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

                return this._data.deaths >= 50;
            }));

        toArray.push(Achievement.get(_("achName37"),
            function ():String {
                if (!this.acquired)
                    return _("achHidden");
                else
                    return _("achDesc37");
            },
            "7c54e15cb09464df3788da1983f85794",
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

                return this._data.undos >= 250;
            }));

        toArray.push(Achievement.get(_("achName38"),
            function():String {
                if (!this.acquired)
                    return _("achHidden");
                else
                    return _("achDesc38");
            },
            "883f475d24cd084519a0df06f5207247",
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
            function ():Boolean {
                if (isUndo)
                    return false;

                for (var i:* = CueEvents.getFirstPrivateData(C.CID_TRAPDOOR_REMOVED);
                        i; i = CueEvents.getNextPrivateData())
                    this._data.trapdoors++;

                return this._data.trapdoors >= 100;
            }));

        toArray.push(Achievement.get(_("achName39"),
            function():String {
                if (!this.acquired)
                    return _("achHidden");
                else
                    return _("achDesc39");
            },
            "677760af887cd95aa0618dcbf68ce837",
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

                return this._data.steps >= 5000;
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

function get isUndo():Boolean {
    return TStateGame.isDoingUndo;
}