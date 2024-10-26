package game.states{
    import flash.display.BitmapData;
    import flash.events.MouseEvent;
    import flash.ui.Mouse;
    import flash.utils.getTimer;
    import game.global.CaravelConnect;
    import game.global.DrodLayer;
    import game.objects.actives.TEvilEye;
    import game.objects.actives.TMonsterPiece;
    import game.objects.effects.TEffectBump;
    import game.objects.effects.TEffectLevelStats;
    import game.objects.TEffectRoomSlide;
    import game.widgets.TWidgetMoveCounter;
    import game.widgets.TWidgetOrbHighlight;
    import game.windows.TWindowAbout;
    import game.windows.TWindowAchievements;
    import game.windows.TWindowGameCompleted;
    import game.windows.TWindowLevelScore;
    import net.retrocade.camel.effects.rEffFade;
    import net.retrocade.camel.effects.rEffScreenshot;
    import net.retrocade.utils.UGraphic;
    import net.retrocade.utils.UString;

    import game.achievements.Achievements;
    import game.global.Commands;
    import game.global.Core;
    import game.global.CueEvents;
    import game.global.Game;
    import game.global.Gfx;
    import game.global.Level;
    import game.global.Progress;
    import game.global.Room;
    import game.global.Sfx;
    import game.managers.VOCoord;
    import game.managers.VOSpeech;
    import game.managers.VOSpeechCommand;
    import game.managers.VOSwordDraw;
    import game.objects.TGameObject;
    import game.objects.actives.TMonster;
    import game.objects.effects.TEffectBlood;
    import game.objects.effects.TEffectCheckpoint;
    import game.objects.effects.TEffectDebris;
    import game.objects.effects.TEffectEvilEyeGaze;
    import game.objects.effects.TEffectOrbHit;
    import game.objects.effects.TEffectPlayerDeath;
    import game.objects.effects.TEffectSubtitle;
    import game.objects.effects.TEffectSwordSwing;
    import game.objects.effects.TEffectTarSplatter;
    import game.objects.effects.TEffectTextFlash;
    import game.objects.effects.TEffectTrapdoorFall;
    import game.objects.effects.TEffectVermin;
    import game.objects.effects.TEffectWalkStairs;
    import game.objects.effects.TEffectsPlayerDeathFade;
    import game.widgets.TWidgetClock;
    import game.widgets.TWidgetFace;
    import game.widgets.TWidgetLevelName;
    import game.widgets.TWidgetMinimap;
    import game.widgets.TWidgetScroll;
    import game.widgets.TWidgetSpeech;
    import game.windows.TWindowLevelStart;
    import game.windows.TWindowPause;

    import net.retrocade.camel.core.rGfx;
    import net.retrocade.camel.core.rGroup;
    import net.retrocade.camel.core.rInput;
    import net.retrocade.camel.core.rState;
    import net.retrocade.camel.layers.rLayerBlit;
    import net.retrocade.standalone.BitextFont;
    import net.retrocade.standalone.Colorizer;
    import net.retrocade.utils.Key;
    import net.retrocade.utils.Rand;



    public class TStateGame extends rState {
        private static var _instance:TStateGame = new TStateGame();
        public static function show():void {
            _instance.set();
        }

        public static function get instance():TStateGame{
            return _instance;
        }

        public static const MAX_UNDOS:uint = (CF::debug ? uint.MAX_VALUE : 3);


        public static var effectsUnder:rGroup = new rGroup();
        public static var effectsAbove:rGroup = new rGroup();

        /**
         * Layer used by few visual effects (invisibility range & mimic placement)
         */
        public static var effectLayer:DrodLayer;


        public static var offsetSpeed:uint   = 4;
        public static var offsetNow  :uint   = 0;
        public static var offset     :Number = 0;

        public static var isScrollDisplayed:Boolean = false;
        public static var isRoomClearedOnce:Boolean = false;
        public static var isDoingUndo      :Boolean = false;
        public static var areMonstersInRoom:Boolean = true;

        private static var commandQueue:Array = [];

        public static var isStoppingEffectPlaying:Boolean = false;
        public static var isStopEffectKeyReleased:Boolean = false;

        public static var isRoomSliderKeyReleased:Boolean = true;

        private static var swordDraws      :Array = [];
        private static var swordDrawsCount:uint  = 0;

        private static var undosAvailable:uint = 0;

        /**
         * Helper variable used by debugTile();
         */
        private static var debugTileCoordinates:TGameObject = new TGameObject();
        /**
         * Helper variable used when room lock message appears
         */
        private static var roomLockCoordinated:TGameObject = new TGameObject();

        public static var lastCommand:int = -1;

        override public function update():void {
            var forceFullRedraw:Boolean = false;


            if (TEffectRoomSlide.instance) {
                return;
			}


            CF::debug{
                // DEBUG
                if (rInput.isMouseHit()){
                    if (rInput.isCtrlDown()) {
                        if (Game.turnNo == 0) {
                            Game.room.tilesSwords[Game.player.swordX + Game.player.swordY * S.LEVEL_WIDTH]--;
                        }

                        Game.player.setPosition(
                            (rInput.mouseX - S.LEVEL_OFFSET_X) / 22 | 0,
                            (rInput.mouseY - S.LEVEL_OFFSET_Y) / 22 | 0
                        );
                        drawActiveAndEffects(true);
                    }
                }
				
				if (rInput.isCtrlDown()) {
					if (rInput.isKeyHit(Key.LEFT)) {
						rInput.flushAll();
						Game.handleLeaveRoom(C.W, true);
						drawAll();
						return;
					} else if (rInput.isKeyHit(Key.RIGHT)) {
						rInput.flushAll();
						Game.handleLeaveRoom(C.E, true);
						drawAll();
						return;
					} else if (rInput.isKeyHit(Key.UP)) {
						rInput.flushAll();
						Game.handleLeaveRoom(C.N, true);
						drawAll();
						return;
					} else if (rInput.isKeyHit(Key.DOWN)) {
						rInput.flushAll();
						Game.handleLeaveRoom(C.S, true);
						drawAll();
						return;
					}
				}

                if (rInput.isCtrlDown() && rInput.isKeyHit(Key.F12)){
                    Progress.resetProgress();
                    Achievements.clearAll();
                    startHold();
                    return;
                }

                if (rInput.isShiftDown() && rInput.isKeyHit(Key.F12)){
                    Achievements.clearAll();
                    return;
                }

                if (rInput.isKeyHit(Key.F8)) {
                    Game.room.clearMonsters(true);
                    processCommand(C.CMD_WAIT);
                    return;
                }

                if (rInput.isKeyHit(Key.F9)) {
                    Progress.clearRoomScoreDemo(Game.room.roomID);
                    return;
                }
            }

            if (!isStoppingEffectPlaying && rInput.isKeyHit(Key.ESCAPE)){
                //TStateTitle.show();

                TWindowPause.show();
                return;
            }

            // PLAYER DEAD

            if (Game.isPlayerDying){
                drawActiveAndEffects();

                if (rInput.isKeyHit(Core.keyRestart) || rInput.isKeyHit(Key.F5)){
                    if (rInput.isShiftDown())
                        restartCommand(true);
                    else
                        restartCommand();

                } else if (rInput.isKeyHit(Core.keyUndo))
                    undoCommand();

                return;
            }

            if (rInput.isKeyHit(Key.SPACE)) {
                TWidgetSpeech.stopAllSpeech();
                forceFullRedraw = true;
            }

            if (isStoppingEffectPlaying){
                drawActiveAndEffects(false);

                if (!isStopEffectKeyReleased && rInput.isAnyKeyDown())
                    return;

                isStopEffectKeyReleased = true;

                if (rInput.isAnyKeyHit() || rInput.isMouseHit())
                    processStopEffectKeyPress();

                return;
            }

            if (rInput.isKeyHit(Key.ENTER)) {
                TWindowLevelScore.show();
                return;
            }

            if (rInput.isKeyHit(Key.TAB)) {
                TWindowAchievements.show();
                return;
            }


            if (rInput.isKeyHit(Key.F3)) {
                TWidgetMoveCounter.toggle();
                forceFullRedraw = true;
            }

            if (rInput.isKeyHit(Core.keyLock)) {
                Game.isRoomLocked = !Game.isRoomLocked;
                drawAfterTurn();

                Sfx.roomLock();
            }

            if (rInput.isKeyHit(Key.F2)) {
                TWindowPause.clickHelpRoom();
            }

            if (rInput.isKeyHit(Key.F1)) {
                TWindowAbout.show();
            }


            // COMMAND QUEUE

            if (commandQueue.length){
                processCommand(commandQueue.shift());
                return;
            }

            if (rInput.isMouseHit()) {
                var mouseX:uint = (rInput.mouseX - S.LEVEL_OFFSET_X) / 22 | 0;
                var mouseY:uint = (rInput.mouseY - S.LEVEL_OFFSET_Y) / 22 | 0;

                if (Game.player.placingDoubleType)
                    processCommand(C.CMD_DOUBLE, mouseX, mouseY);
                else
                    debugTile(mouseX, mouseY);
            }

            if (rInput.isKeyHit(Core.keyBattle) || rInput.isKeyHit(Key.NUMPAD_PLUS)){
                processCommand(F.reverseCommand(Commands.getLast()));

            } else if (rInput.isKeyHit(Core.keyCW)){
                processCommand(C.CMD_C);
                if (rInput.isShiftDown())
                    commandQueue.push(C.CMD_CC);

            } else if (rInput.isKeyHit(Core.keyCCW)){
                processCommand(C.CMD_CC);
                if (rInput.isShiftDown())
                    commandQueue.push(C.CMD_C);

            } else if (rInput.isKeyHit(Core.keyUpLeft) || rInput.isKeyHit(Key.NUMPAD_7) || rInput.isKeyHit(Key.HOME)){
                processCommand(C.CMD_NW);
                if (rInput.isShiftDown())
                    commandQueue.push(C.CMD_SE);

            } else if (rInput.isKeyHit(Core.keyUp) || rInput.isKeyHit(Key.NUMPAD_8) || rInput.isKeyHit(Key.UP)){
                processCommand(C.CMD_N);
                if (rInput.isShiftDown())
                    commandQueue.push(C.CMD_S);

            } else if (rInput.isKeyHit(Core.keyUpRight) || rInput.isKeyHit(Key.NUMPAD_9) || rInput.isKeyHit(Key.PAGE_UP)){
                processCommand(C.CMD_NE);
                if (rInput.isShiftDown())
                    commandQueue.push(C.CMD_SW);

            } else if (rInput.isKeyHit(Core.keyLeft) || rInput.isKeyHit(Key.NUMPAD_4) || rInput.isKeyHit(Key.LEFT)){
                processCommand(C.CMD_W);
                if (rInput.isShiftDown())
                    commandQueue.push(C.CMD_E);

            } else if (rInput.isKeyHit(Core.keyRight) || rInput.isKeyHit(Key.NUMPAD_6) || rInput.isKeyHit(Key.RIGHT)){
                processCommand(C.CMD_E);
                if (rInput.isShiftDown())
                    commandQueue.push(C.CMD_W);

            } else if (rInput.isKeyHit(Core.keyDownLeft) || rInput.isKeyHit(Key.NUMPAD_1) || rInput.isKeyHit(Key.END)){
                processCommand(C.CMD_SW);
                if (rInput.isShiftDown())
                    commandQueue.push(C.CMD_NE);

            } else if (rInput.isKeyHit(Core.keyDown) || rInput.isKeyHit(Key.NUMPAD_2) || rInput.isKeyHit(Key.DOWN)){
                processCommand(C.CMD_S);
                if (rInput.isShiftDown())
                    commandQueue.push(C.CMD_N);

            } else if (rInput.isKeyHit(Core.keyDownRight) || rInput.isKeyHit(Key.NUMPAD_3) || rInput.isKeyHit(Key.PAGE_DOWN)){
                processCommand(C.CMD_SE);
                if (rInput.isShiftDown())
                    commandQueue.push(C.CMD_NW);

            } else if (rInput.isKeyHit(Core.keyWait) || rInput.isKeyHit(Key.NUMPAD_5) || rInput.isKeyHit(12)){
                processCommand(C.CMD_WAIT);
                if (rInput.isShiftDown()){
                    var i:uint = 30 - (Game.spawnCycleCount % 30);
                    while (i--)
                        commandQueue.push(C.CMD_WAIT);
                }

            } else if (rInput.isKeyHit(Core.keyRestart)) {
                if (rInput.isShiftDown())
                    restartCommand(true);
                else
                    restartCommand();

            } else if (rInput.isKeyHit(Key.F5))
                restartCommand(true);

            else if (rInput.isKeyHit(Core.keyUndo))
                undoCommand();

            else
                drawActiveAndEffects(forceFullRedraw);
        }

        private function processCommand(command:uint, wx:uint = uint.MAX_VALUE, wy:uint = uint.MAX_VALUE):void {
            if (command == C.CMD_UNSPECIFIED)
                return;

            var turnNo:uint = Game.turnNo;
            Game.processCommand(command, wx, wy);

            Mouse.hide();

            if (Game.turnNo > turnNo && undosAvailable < MAX_UNDOS)
                undosAvailable++;

            Game.updateTime();

            if (!Game.player.placingDoubleType)
                offsetNow = offsetSpeed;

            lastCommand = command;

            afterCommand();
        }

        private function afterCommand():void {
            Game.room.drawPlots();

            processEvents();

            drawAfterTurn();

            Achievements.turnPassed();
        }

        public function drawAll():void {
            if (Game.room.monsterCount == 0){
                isRoomClearedOnce = true;
                areMonstersInRoom = false;
            }

            TWidgetMinimap.updateRoomState(Game.room.roomID, isRoomClearedOnce);
            TWidgetMinimap.plotWidget(Game.room.roomID, TWidgetMinimap.MODE_IN_GAME);

            afterCommand();
        }

        private function drawAfterTurn():void{
            Game.room.drawPlots();

            effectLayer  .clear();

            TWidgetClock.update(!isScrollDisplayed && Game.room.isTimerNeeded(), Game.spawnCycleCount);

            TWidgetOrbHighlight.isActive = false;

            drawActiveAndEffects(true);

            // Draw Invisibility rectangle
            if (Game.isInvisible) {
                effectLayer.blitRectDirect(
                    Game.player.x * S.LEVEL_TILE_WIDTH - C.DEFAULT_SMELL_RANGE * S.LEVEL_TILE_WIDTH + S.LEVEL_OFFSET_X,
                    Game.player.y * S.LEVEL_TILE_HEIGHT - C.DEFAULT_SMELL_RANGE * S.LEVEL_TILE_WIDTH + S.LEVEL_OFFSET_Y,
                    242, 242, 0x88000000
                );
            }

            // Draw Mimic
            if (Game.player.placingDoubleType) {
                if (Game.room.doesSquareContainDoublePlacementObstacle(
                        Game.player.doubleCursorX, Game.player.doubleCursorY))
                {
                    effectLayer.blitRect(Game.player.doubleCursorX * S.LEVEL_TILE_WIDTH,
                                         Game.player.doubleCursorY * S.LEVEL_TILE_HEIGHT,
                                         S.LEVEL_TILE_WIDTH,
                                         S.LEVEL_TILE_HEIGHT, 0x88FF0000);
                }

                effectLayer.blitTileRect(Gfx.GENERAL_TILES, T.MIMIC[Game.player.o],
                                         Game.player.doubleCursorX,
                                         Game.player.doubleCursorY);

                effectLayer.blitTileRect(Gfx.GENERAL_TILES, T.MIMIC_SWORD[Game.player.o],
                                         Game.player.doubleCursorX + F.getOX(Game.player.o),
                                         Game.player.doubleCursorY + F.getOY(Game.player.o));

                Game.room.setSaturation(0);

            } else {
                Game.room.setSaturation(1);
            }

            // Draw Lock
            if (Game.isRoomLocked) {
                effectLayer.blitDirectly(Gfx.LOCK, 84, 522);
            }
        }

        private function drawActiveAndEffects(force:Boolean = false):void{
            TWidgetFace.animate();

            TWidgetSpeech.update();

            if (Game.room.monsterCount && Rand.om < 0.0005 * Game.room.monsterCount){
                var item:TMonster = Game.room.monsters.getRandom() as TMonster;
                if (item){
                    item.animationFrame = item.animationFrame ? 0 : 1;
                    item.setGfx();
                    force = true;
                }
            }

            if (offsetNow > 0 || effectsAbove.length || effectsUnder.length || force) {
                if (offsetNow)
                    offset = --offsetNow / offsetSpeed;

                Game.room.layerActive.clear();

                effectsUnder .update();
                Game.player  .update();
                Game.room.monsters.update();
                for each(var so:VOSwordDraw in swordDraws)
                    Game.room.layerActive.blitTileRectPrecise(Gfx.GENERAL_TILES, so.gfxTile, so.x, so.y);

                TWidgetOrbHighlight.update();
                effectsAbove .update();

                TWidgetMoveCounter.draw();

                swordDraws.length = swordDrawsCount = 0;
            }
        }

        public function processEvents():void{
            var i:uint;
            var coords:VOCoord;

            if (CueEvents.hasOccured(C.CID_EXIT_LEVEL_PENDING) || CueEvents.hasOccured(C.CID_WIN_GAME)){
                if (F.isStairs(Game.room.tilesOpaque[Game.player.x + Game.player.y * S.LEVEL_WIDTH])){
                    new TEffectWalkStairs();

                    if (CueEvents.hasOccured(C.CID_WIN_GAME))
                        new TEffectLevelStats(Game.getLevelStats(true), 1500);
                    else
                        new TEffectLevelStats(Game.getLevelStats(), 1500);

                    isStoppingEffectPlaying = true;
                    isStopEffectKeyReleased = false;

                    Sfx.playMusic(C.MUSIC_LEVEL_EXIT);

                } else if (CueEvents.hasOccured(C.CID_WIN_GAME)) {
                    var screenshot:rEffScreenshot = new rEffScreenshot(2500);
                    new rEffFade(screenshot.screenshot, 1, 0, 2500);

                    new TStateOutro();
                    Game.isGameActive = false;

                    Sfx.playMusic(C.MUSIC_LEVEL_EXIT);

                } else {
                    coords = CueEvents.getFirstPrivateData(C.CID_EXIT_LEVEL_PENDING);

                    drawAfterTurn();

                    TWindowLevelStart.show(coords.x, true, Boolean(coords.y));

                    resetState();

                    Game.loadFromLevelEntrance(coords.x);
                    drawAfterTurn();
                    Game.room.drawPlots();

                    if (coords.y)
                        TWindowLevelStart.doCrossFade();

                    TWidgetMinimap.changedLevel(Game.room.levelID);
                }
            }

            if (CueEvents.hasOccured(C.CID_ENTER_ROOM)) {
                var exitRoom:uint = CueEvents.getFirstPrivateData(C.CID_EXIT_ROOM);
                lastCommand = -1;

                isRoomClearedOnce = false;

                resetState();

                TWidgetMinimap.addRoom   (Game.room.roomID);

                // Update the state of the room we just left on the minimap
                if (exitRoom)
                    TWidgetMinimap.updateRoomState(exitRoom, false);

                TWidgetMinimap.plotWidget(Game.room.roomID, TWidgetMinimap.MODE_IN_GAME);

                TWidgetLevelName.update(Game.room.roomID, Game.room.levelID);

                updateMusicState();

                Game.player.hidePlayer = true;
                drawAfterTurn();


                if (TEffectRoomSlide.instance) {
                    TEffectRoomSlide.instance.setNew();
                    TEffectRoomSlide.instance.start(exitRoom,
                        CueEvents.getFirstPrivateData(C.CID_ENTER_ROOM));

                    isRoomSliderKeyReleased = false;
                }

                Game.player.hidePlayer = false;
                Game.player.update();
            }

            if (CueEvents.hasAnyOccured(C.CIDA_PLAYER_LEFT_ROOM))
                isRoomClearedOnce = false;

            if (CueEvents.hasOccured(C.CID_CONQUER_ROOM))
                TWidgetMinimap.updateRoomState(CueEvents.getFirstPrivateData(C.CID_CONQUER_ROOM), false);

            if (CueEvents.hasOccured(C.CID_ROOM_EXIT_LOCKED)) {
                roomLockCoordinated.x = Game.player.x;
                roomLockCoordinated.y = Game.player.y;

                TWidgetSpeech.addInfoSubtitle(roomLockCoordinated, _("roomLocked", _("key" + Core.keyLock)), 2000);

                Sfx.roomLock();
            }

            if (CueEvents.hasOccured(C.CID_SUBMIT_SCORE)) {
                var room:uint = CueEvents.getFirstPrivateData(C.CID_SUBMIT_SCORE);

				if (CueEvents.hasOccured(C.CID_ROOM_FIRST_VISIT))
					CaravelConnect.submitScore(room, onScoreSubmitted, CueEvents.getFirstPrivateData(C.CID_ROOM_FIRST_VISIT));
				else
					CaravelConnect.submitScore(room, onScoreSubmitted)
					
            } else if (CueEvents.hasOccured(C.CID_ROOM_FIRST_VISIT))
				CaravelConnect.submitScore(null, onScoreSubmitted, CueEvents.getFirstPrivateData(C.CID_ROOM_FIRST_VISIT));

            addEffects();
        }

        public function addFlashEvents():void {
            var textFlashOffset:uint = 200;
            var scrollText     :String;

            if (CueEvents.hasOccured(C.CID_COMPLETE_LEVEL)){
                new TEffectTextFlash(_("ingLevelCompleted"), textFlashOffset);
                textFlashOffset += 62;
                Sfx.levelCompleted();
            }

            if (CueEvents.hasOccured(C.CID_SECRET_ROOM_FOUND)) {
                new TEffectTextFlash(_("ingSecretFound"), textFlashOffset);
                textFlashOffset += 62;
                Sfx.secretFound();
            }

            if (CueEvents.hasOccured(C.CID_HOLD_MASTERED)) {
                new TEffectTextFlash(_("ingHoldMastered"), textFlashOffset);
                textFlashOffset += 62;
                Sfx.holdMastered();
            }

            if (CueEvents.hasOccured(C.CID_STEP_ON_SCROLL)){
                for (scrollText = CueEvents.getFirstPrivateData(C.CID_STEP_ON_SCROLL); scrollText != null;
                    scrollText = CueEvents.getNextPrivateData())
                {
                    TWidgetFace.setReading(true);
                    TWidgetClock .update(false, 0);
                    TWidgetScroll.update(true, _(scrollText));

                    isScrollDisplayed = true;

                    Sfx.scrollRead();
                }
            }

            processSpeech();
        }

        private function processSpeech():void {
            var speech         :VOSpeechCommand;

            for (speech = CueEvents.getFirstPrivateData(C.CID_SPEECH); speech != null;
                speech = CueEvents.getNextPrivateData())
            {
                TWidgetSpeech.parseSpeechEvent(speech);
            }
        }

        private function processStopEffectKeyPress():void{
            var i:VOCoord;

            if (CueEvents.hasOccured(C.CID_WIN_GAME)) {
                new TStateOutro();

            } else if (CueEvents.hasOccured(C.CID_EXIT_LEVEL_PENDING)){
                i = CueEvents.getFirstPrivateData(C.CID_EXIT_LEVEL_PENDING);

                TWindowLevelStart.show(i.x, true, i.y as Boolean);

                resetState();

                Game.loadFromLevelEntrance(i.x);
                drawAfterTurn();
                Game.room.drawPlots();

                Achievements.initRoomStarted();

                TWidgetMinimap.changedLevel(Game.room.levelID);

                TWidgetMinimap.addRoom   (Game.room.roomID);
                TWidgetMinimap.plotWidget(Game.room.roomID, TWidgetMinimap.MODE_IN_GAME);

                TWidgetLevelName.update(Game.room.roomID, Game.room.levelID);
            }
        }



        /******************************************************************************************************/
        /**                                                                                          EFFECTS  */
        /******************************************************************************************************/

        private function addEffects():void{
            var unknown   :*;
            var coord     :VOCoord;
            var monster   :TMonster
            var scrollText:String;

            var isPlayerDead:Boolean = CueEvents.hasAnyOccured(C.CIDA_PLAYER_DIED);

            if (CueEvents.hasOccured(C.CID_ORB_ACTIVATED_BY_PLAYER) || CueEvents.hasOccured(C.CID_ORB_ACTIVATED_BY_DOUBLE)){
                for (unknown = CueEvents.getFirstPrivateData(C.CID_ORB_ACTIVATED_BY_PLAYER); unknown != null;
                    unknown = CueEvents.getNextPrivateData())
                {
                    new TEffectOrbHit(unknown, true);
                }

                for (unknown = CueEvents.getFirstPrivateData(C.CID_ORB_ACTIVATED_BY_DOUBLE); unknown != null;
                    unknown = CueEvents.getNextPrivateData())
                {
                    new TEffectOrbHit(unknown, true);
                }

                Sfx.orbHit();
            }

            if (CueEvents.hasOccured(C.CID_SWING_SWORD)){
                for (coord = CueEvents.getFirstPrivateData(C.CID_SWING_SWORD); coord != null;
                    coord = CueEvents.getNextPrivateData())
                {
                    new TEffectSwordSwing(coord.x, coord.y, coord.o);
                }

                Sfx.swordSwing();
            }

            if (CueEvents.hasOccured(C.CID_MONSTER_DIED_FROM_STAB)){
                for (monster = CueEvents.getFirstPrivateData(C.CID_MONSTER_DIED_FROM_STAB); monster != null;
                    monster = CueEvents.getNextPrivateData())
                {
                    addDamageEffect(monster.getType(), new VOCoord(monster.x, monster.y, monster.killDirection));
                }

                Sfx.monsterKilled();
            }

            if (CueEvents.hasOccured(C.CID_SNAKE_DIED_FROM_TRUNCATION)) {
                for (monster = CueEvents.getFirstPrivateData(C.CID_SNAKE_DIED_FROM_TRUNCATION); monster != null;
                    monster = CueEvents.getNextPrivateData())
                {
                    addDamageEffect(monster.getType(), new VOCoord(monster.x, monster.y, C.NO_ORIENTATION));
                }

                Sfx.monsterKilled();
            }

            if (CueEvents.hasOccured(C.CID_TRAPDOOR_REMOVED)){
                for (coord = CueEvents.getFirstPrivateData(C.CID_TRAPDOOR_REMOVED); coord != null;
                    coord = CueEvents.getNextPrivateData())
                {
                    new TEffectTrapdoorFall(coord.x, coord.y);
                }

                Sfx.trapdoorFell();
            }

            if (CueEvents.hasOccured(C.CID_CHECKPOINT_ACTIVATED)){
                for (coord = CueEvents.getFirstPrivateData(C.CID_CHECKPOINT_ACTIVATED); coord != null;
                    coord = CueEvents.getNextPrivateData())
                {
                    new TEffectCheckpoint(coord);
                }

                Sfx.checkpoint();
            }

            if (CueEvents.hasOccured(C.CID_CRUMBLY_WALL_DESTROYED)){
                for (coord = CueEvents.getFirstPrivateData(C.CID_CRUMBLY_WALL_DESTROYED); coord != null;
                    coord = CueEvents.getNextPrivateData())
                {
                    new TEffectDebris(coord, 10, 5, 1.5);
                    new TEffectVermin(coord);
                }

                Sfx.crumblyWallDestroy();
            }

            for (coord = CueEvents.getFirstPrivateData(C.CID_TARSTUFF_DESTROYED); coord != null;
                coord = CueEvents.getNextPrivateData())
            {
                new TEffectTarSplatter(coord, 10, 3);
            }

            for (coord = CueEvents.getFirstPrivateData(C.CID_EVIL_EYE_WOKE); coord != null;
                coord = CueEvents.getNextPrivateData())
            {
                new TEffectEvilEyeGaze(coord);
            }

            if (CueEvents.hasOccured(C.CID_STEP)){
                if (isScrollDisplayed && !CueEvents.hasOccured(C.CID_STEP_ON_SCROLL)){
                    TWidgetFace.setReading(false);
                    isScrollDisplayed = false;
                    TWidgetScroll.update(false);
                }

                Sfx.playerStep();
            }

            addFlashEvents();

            if (CueEvents.hasOccured(C.CID_EVIL_EYE_WOKE))
                Sfx.evilEyeWoke();

            if (CueEvents.hasOccured(C.CID_TARSTUFF_DESTROYED))
                Sfx.tarSplatter();

            if (CueEvents.hasOccured(C.CID_DOUBLE_PLACED))
                Sfx.doublePlaced();

            if (CueEvents.hasOccured(C.CID_ALL_BRAINS_REMOVED))
                Sfx.brainsKilled();

            if (CueEvents.hasOccured(C.CID_DRANK_POTION))
                Sfx.potionDrank();

            if (CueEvents.hasOccured(C.CID_BLACK_GATES_TOGGLED) || CueEvents.hasOccured(C.CID_RED_GATES_TOGGLED) ||
                    CueEvents.getFirstPrivateData(C.CID_ROOM_CONQUER_PENDING) === true){

                Sfx.gates();
            }

            if (CueEvents.hasOccured(C.CID_TAR_BABY_FORMED)){
                updateMusicState();

                if (isRoomClearedOnce && !areMonstersInRoom && Game.room.monsterCount) {
                    areMonstersInRoom = true;
                    TWidgetMinimap.updateRoomState(Game.room.roomID, false);
                    TWidgetMinimap.plotWidget(Game.room.roomID, TWidgetMinimap.MODE_IN_GAME);
                }
            }

            if (!isRoomClearedOnce) {
                if (CueEvents.hasOccured(C.CID_ROOM_CONQUER_PENDING)) {
                    TWidgetMinimap.updateRoomState(Game.room.roomID, true);
                    TWidgetMinimap.plotWidget(Game.room.roomID, TWidgetMinimap.MODE_IN_GAME);
                    isRoomClearedOnce = true;
                    areMonstersInRoom = false;
                }
            } else {
                if (areMonstersInRoom && Game.room.monsterCount == 0) {
                    areMonstersInRoom = false;
                    TWidgetMinimap.updateRoomState(Game.room.roomID, true);
                    TWidgetMinimap.plotWidget(Game.room.roomID, TWidgetMinimap.MODE_IN_GAME);
                }
            }

            if (CueEvents.hasOccured(C.CID_ROOM_CONQUER_PENDING) &&
                    CueEvents.getFirstPrivateData(C.CID_ROOM_CONQUER_PENDING) !== null &&
                    !isPlayerDead){

                Sfx.roomConquered();
            }

            if (CueEvents.hasOccured(C.CID_SWORDSMAN_AFRAID))
                TWidgetFace.setMood(TWidgetFace.MOOD_NERVOUS);
            else if (CueEvents.hasOccured(C.CID_SWORDSMAN_AGGRESSIVE))
                TWidgetFace.setMood(TWidgetFace.MOOD_AGGRESSIVE);
            else if (CueEvents.hasOccured(C.CID_SWORDSMAN_NORMAL))
                TWidgetFace.setMood(TWidgetFace.MOOD_NORMAL);

            if (CueEvents.hasAnyOccured(C.CIDA_PLAYER_DIED)){
                Sfx.playerDies();
                new TEffectPlayerDeath();
                new TEffectsPlayerDeathFade();

            } else if (CueEvents.hasOccured(C.CID_SWORDSMAN_STABBED_MONSTER))
                TWidgetFace.setMood(TWidgetFace.MOOD_STRIKE, 200);

            if (CueEvents.hasOccured(C.CID_HIT_OBSTACLE)){
                Sfx.playerHitsObstacle();

                coord = CueEvents.getFirstPrivateData(C.CID_HIT_OBSTACLE);
                if (coord)
                    new TEffectBump(coord);

            } else if (CueEvents.hasOccured(C.CID_SCARED)) {
                Sfx.beethroScared();
                TWidgetFace.setMood(TWidgetFace.MOOD_NERVOUS, 200);
            }
        }

        private function addDamageEffect(monsterType:uint, coords:VOCoord):void {
            switch(monsterType){
                case(C.M_TARBABY):
                case(C.M_TARMOTHER):
                    new TEffectTarSplatter(coords, 7, 3);
                    break;


                default:
                    new TEffectBlood(coords, 16, 7, 2);
                    break;
            }
        }

        private function onScoreSubmitted(result:Object):void {
            if (!result)
                return;

            var rank :Number = result.place;

            if (isNaN(rank) || rank == 0)
                return;


            var size :uint    = 64;
            var isTie:Boolean = (rank != (rank | 0));
            var text :String;

            rank |= 0;

            if (rank == 1 && !isTie) {
                text = _("score1NoTie");

            } else {
                if (isTie)
                    text = _("scoreTie", _("score" + rank));
                else
                    text = _("score" + rank);
            }


            if (!CaravelConnect.cnetPass || !CaravelConnect.cnetName){
                text += _("scoreNoCnet");
                size  = 50;
            }


            new TEffectTextFlash(text, 0, 4000, size);

            if (CaravelConnect.cnetName && CaravelConnect.cnetPass && result.roomID)
                Progress.markDemoAsUploaded(result.roomID);
        }

        public static function updateMusicState():void {
            var monsterCount:uint = Game.room.monsterCount;

            if (monsterCount == 0)
                Sfx.crossFadeMusic(C.MUSIC_AMBIENT);

            else if (monsterCount < 30)
                Sfx.crossFadeMusic(C.MUSIC_PUZZLE);

            else
                Sfx.crossFadeMusic(C.MUSIC_ACTION);
        }



        /******************************************************************************************************/
        /**                                                                                         COMMANDS  */
        /******************************************************************************************************/

        private function resetState():void {
            commandQueue.length = 0;

            swordDraws.length = 0;
            swordDrawsCount  = 0;

            isStoppingEffectPlaying = false;
            isRoomClearedOnce       = false;
            isScrollDisplayed       = false;
            areMonstersInRoom       = true;

            effectsAbove.clear();
            effectsUnder.clear();

            TWidgetSpeech.clear();
            TWidgetFace  .setMood(TWidgetFace.MOOD_NORMAL);
            TWidgetFace  .isMoodDrawn = false;
            TWidgetScroll.update(false);

            Achievements.initRoomStarted();

            lastCommand = -1;

            undosAvailable = 0;
        }

        public function restartCommand(restartAll:Boolean = false):void {
            resetState();

            isDoingUndo = true;

            if (restartAll)
                Game.restartRoom();
            else
                Game.restartRoomFromLastCheckpoint();

            drawAll();

            Achievements.turnPassed();

            lastCommand = C.CMD_UNDO;
            Achievements.turnPassed();


            isDoingUndo = false;
        }

        public function undoCommand():void {
            if (!undosAvailable)
                return;

            isDoingUndo = true;

            var undos:uint = --undosAvailable;

            resetState();

            undosAvailable = undos;

            if (Commands.count() == 0)
                return;


            if (lastCommand == C.CMD_DOUBLE)
                Game.undoCommands(2);
            else
                Game.undoCommand();

            drawAll();

            lastCommand = C.CMD_UNDO;
            Achievements.turnPassed();


            isDoingUndo = false;
        }

        override public function create():void {
            processEvents();
            drawAfterTurn();
            Game.room.drawPlots();

            TWidgetSpeech.stopAllSpeech();

            //addEffects(); // Removed because it causes some effects (speech, flash messages) to be added twice!

            TWidgetFace.animate();
            TWidgetMinimap.changedLevel(Game.room.levelID);

            updateMusicState();

            rInput.addStageMouseMove(onMouseMoved)
        }

        override public function destroy():void {
            rInput.removeStageMouseMove(onMouseMoved)
            Mouse.show()
            Core.lMain.clear();
        }

        public static function continuePlaying():void{
            CueEvents.clear();

            if (!Game.room){
                if (Progress.hasSaveGame())
                    restoreGame();
                else
                    startHold();
            } else
                show();
        }

        public static function startHold():void{
            CueEvents.clear();

            var entrance:XML = Level.getFirstHoldEntrance();
            Game.loadFromLevelEntrance(entrance.@EntranceID);
            TWindowLevelStart.show(entrance.@EntranceID, true);
            TWidgetMinimap.changedLevel(Game.room.levelID);

            show();
        }

        public static function restoreGame():void{
            CueEvents.clear();
            Level.restoreTo(Progress.playerRoomID, Progress.playerX, Progress.playerY, Progress.playerO);
            TWidgetMinimap.changedLevel(Game.room.levelID);
            show();
            instance.processSpeech();
        }

        public static function addSwordDraw(swordVO:VOSwordDraw):void {
            swordDraws[swordDrawsCount++] = swordVO;
        }

        /**
         * Displays information about tile the user has just clicked
         *
         * @param	x Tile X position
         * @param	y Tile Y position
         */
        private function debugTile(x:uint, y:uint):void {
            if (!F.isValidColRow(x, y))
                return;

            debugTileCoordinates.x = x;
            debugTileCoordinates.y = y;

            var index:uint = x + y * S.LEVEL_WIDTH;

            var toTrace:String = "(" + x + "," + y + ")";
            toTrace += "\n";

            if (Game.player.x == x && Game.player.y == y){
                toTrace += _("monsterPlayer");
                toTrace += "\n";
            }

            // Monster
            var monster:TMonster = Game.room.tilesActive[index];
            if (monster) {
                if (monster.isPiece())
                    monster = TMonsterPiece(monster).monster;

                toTrace += _("monster" + monster.getType());

                var monsterIndex:uint = Game.room.monsters.getIndexOf(monster) + 1;

                if (monsterIndex > 0) {
                    toTrace += " (#" + monsterIndex + ")";
                }

                toTrace += "\n";

                if (monster is TEvilEye)
                    new TEffectEvilEyeGaze(new VOCoord(x, y, monster.o));
            }

            // Transparent Layer
            var tile:uint = Game.room.tilesTransparent[index];
            if (tile != C.T_EMPTY) {
                toTrace += _("tile" + tile);
                toTrace += "\n";

                if (tile == C.T_ORB){
                    TWidgetOrbHighlight.drawOrbHighlights(x, y);
                    drawActiveAndEffects(true);
                } else {
                    TWidgetOrbHighlight.isActive = false
                    drawActiveAndEffects(true);
                }
            } else {
                TWidgetOrbHighlight.isActive = false
                drawActiveAndEffects(true);
            }

            // Floor Layer
            tile = Game.room.tilesFloor[index];
            if (tile != 0) {
                toTrace += _("tile" + tile);
                toTrace += "\n";
            }

            // Checkpoint
            if (Game.room.checkpoints.contains(x, y)) {
                toTrace += _("tileCheckpoint");
                toTrace += "\n";
            }

            // Opaque Layer, is always described
            tile = Game.room.tilesOpaque[index];
            if (tile != 0) {
                if (tile == C.T_WALL && (Game.room.renderer.opaqueData[index] & T.WALL_SECRET_OFFSET))
                    toTrace += _("tile62");
                else
                    toTrace += _("tile" + tile);

                toTrace += "\n";
            }

            var swords:int = Game.room.tilesSwords[index];
            if (swords == 1)
                toTrace += _("sword");
            else if (swords != 0)
                toTrace += _("swords", swords);

            TWidgetSpeech.addInfoSubtitle(debugTileCoordinates, toTrace, 2000);
        }

        private function onMouseMoved(e:MouseEvent):void {
            Mouse.show();
        }
    }
}