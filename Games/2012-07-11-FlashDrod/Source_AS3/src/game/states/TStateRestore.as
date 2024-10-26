package game.states {
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.Shape;
    import flash.display.StageQuality;
    import flash.geom.Point;
    
    import game.global.Commands;
    import game.global.Core;
    import game.global.Game;
    import game.global.Gfx;
    import game.global.Level;
    import game.global.Make;
    import game.global.Progress;
    import game.global.Renderer;
    import game.global.Room;
    import game.interfaces.TRestoreLevel;
    import game.managers.progress.VORoomEntryState;
    import game.widgets.TWidgetLevelName;
    import game.widgets.TWidgetMinimap;
    
    import net.retrocade.camel.core.rDisplay;
    import net.retrocade.camel.core.rGfx;
    import net.retrocade.camel.core.rInput;
    import net.retrocade.camel.core.rState;
    import net.retrocade.standalone.Button;
    import net.retrocade.standalone.Grid9;
    import net.retrocade.standalone.Text;
    import net.retrocade.utils.Key;
    import net.retrocade.utils.UGraphic;
	
	/**
     * ...
     * @author
     */
    public class TStateRestore extends rState {
        private static var _instance:TStateRestore = new TStateRestore();

        public static function show():void {
            _instance.set();
        }


        private var header           :Text;
        private var background       :Bitmap;
        private var minimap          :Bitmap;
        private var minimapData      :BitmapData;
        private var minimapBackground:Shape;
        private var levelsBackground :Grid9;
        private var levelPreview     :Bitmap;
        private var buttonRestore    :Button;
        private var buttonCancel     :Button;

        private var secretsCount     :Text;
        private var roomPosition     :Text;

        private var levels:Array;
        private var currentRoom:uint;

        public function TStateRestore(){
            background = rGfx.getB(Gfx.CLASS_MENU_BACKGROUND);

            header = Make.text(36);

            minimapBackground = new Shape();
            minimapData       = new BitmapData(200, 200, true, 0);
            minimap           = new Bitmap(minimapData);
            levelPreview      = new Bitmap(null, "auto", true);
            levelsBackground  = Grid9.getGrid("textInput", false);
            buttonRestore     = Make.buttonColor(onClickRestore,       _("rstToRoom"));
            buttonCancel      = Make.buttonColor(onClickReturnToTitle, _("rstReturn"));
            secretsCount      = Make.text(20);
            roomPosition      = Make.text(16);


            header.text = _("rstHeader");
            header.x    = (S.SIZE_GAME_WIDTH - header.textWidth - 10) / 2;

            UGraphic.draw(minimapBackground).rectFill(0, 0, 200, 200, 0x663333)
                .rectFill(-2, -2, 204, 2, 0, 0.5)
                .rectFill(-2, 0, 2, 202, 0, 0.5)
                .rectFill(200, 0, 2, 202, 0xFFFFFF, 0.5)
                .rectFill(0, 200, 200, 2, 0xFFFFFF, 0.5);

            minimapBackground.x = minimap.x = 10;
            minimapBackground.y = minimap.y = S.SIZE_GAME_HEIGHT - 210;

            levelsBackground.x = 8;
            levelsBackground.y = 60;
            levelsBackground.width = 204;
            levelsBackground.height = 280;

            secretsCount.x = 5;
            secretsCount.y = levelsBackground.bottom - 6;

            roomPosition.x = 5;
            roomPosition.y = levelsBackground.bottom + 22;

            levelPreview.x = 220;
            levelPreview.y = 60;
            levelPreview.scaleX = 19.6/22;
            levelPreview.scaleY = 19.6/22;

            buttonRestore.x = 220;
            buttonCancel .x = S.SIZE_GAME_WIDTH - buttonCancel.width - 10;

            buttonRestore.y = S.SIZE_GAME_HEIGHT - buttonRestore.height - 10;
            buttonCancel .y = S.SIZE_GAME_HEIGHT - buttonCancel .height - 10;
        }



        /****************************************************************************************************************/
        /**                                                                                           rSTATE OVERRIDES  */
        /****************************************************************************************************************/

        override public function create():void {
            Commands.freeze();

            Core.lMain.add2(background);
            Core.lMain.add2(header);
            Core.lMain.add2(minimapBackground);
            Core.lMain.add2(minimap);
            Core.lMain.add2(levelsBackground);
            Core.lMain.add2(levelPreview);
            Core.lMain.add2(buttonRestore);
            Core.lMain.add2(buttonCancel);
            Core.lMain.add2(roomPosition);

            if (Progress.isGameCompleted)
                Core.lMain.add2(secretsCount);

            createLevels();

            rDisplay.stage.quality = StageQuality.BEST;

            selectRoom(Progress.playerRoomID);
        }

        override public function destroy():void{
            Core.lMain.clear();
            rDisplay.stage.quality = StageQuality.HIGH;

            Commands.unfreeze();
        }

        override public function update():void {
            if (rInput.isKeyDown(Key.ESCAPE)){
                onClickReturnToTitle();
                return;
            }
            
            if (rInput.isMouseHit()) {
                var room:XML = TWidgetMinimap.getRoomOnClick(
                    rInput.mouseX - minimap.x,
                    rInput.mouseY - minimap.y,
                    TWidgetMinimap.MODE_RESTORE);

                if (room && Progress.wasRoomEverVisited(room.@RoomID))
                    selectRoom(room.@RoomID);
            }
        }



        /****************************************************************************************************************/
        /**                                                                                            EVENT LISTENERS  */
        /****************************************************************************************************************/

        private function onClickReturnToTitle():void{
            TStateTitle.show();
        }

        private function onClickRestore():void {
            Commands.unfreeze();
            Commands.clear();

            Progress.restoreToRoom(currentRoom);

            TStateGame.restoreGame();
        }




        /****************************************************************************************************************/
        /**                                                                                               MAP CONTROLS  */
        /****************************************************************************************************************/

        private function createLevels():void{
            levels = [];

            var allLevels:Array = Level.getAllLevels();
            var level:TRestoreLevel;

            var index:uint;

            for each(var levelXML:XML in allLevels){
                if (!Progress.wasLevelEverVisited(levelXML.@LevelID))
                    continue;

                index = parseInt(levelXML.@OrderIndex) - 1;

                level = new TRestoreLevel(onLevelSelected, levelXML);
                level.x = levelsBackground.x + 2
                level.y = levelsBackground.y + 2 + index * TRestoreLevel.HEIGHT;

                Core.lMain.add2(level);

                levels.push(level);
            }

            levels.sortOn("y", Array.NUMERIC);

            index = 0;
            for (var i:uint = 0; i < levels.length; i++ ) {
                level = levels[i];
                if (level.visible) {
                    level.y = levelsBackground.y + 2 + index * TRestoreLevel.HEIGHT;
                    index++;
                }
            }
        }

        private function selectLevelByRoom(roomID:uint):void{
            var levelID:uint = Level.getLevelIDByRoom(roomID);

            for each(var level:TRestoreLevel in levels){
                if (level.levelID == levelID){
                    level.set();
                    return;
                }
            }
        }

        private function selectRoom(roomID:uint):void{
            /*if (currentRoom == roomID){
                selectLevelByRoom(roomID);
                return;
            }*/

            currentRoom = roomID;

            drawWidget       (roomID);
            selectLevelByRoom(roomID);

            var roomOffset   :Point = Level.getRoomOffsetInLevel(roomID);
            var roomStateData:VORoomEntryState = Progress.getRoomEntranceState(roomID);

            var room:Room = new Room();
            room.loadRoom(roomID);
            room.drawRoom();
            Game.player.drawTo(roomStateData.x, roomStateData.y, roomStateData.o, room);
            room.monsters.update();

            var newBD:BitmapData = new BitmapData(S.LEVEL_WIDTH_PIXELS, S.LEVEL_HEIGHT_PIXELS);
            newBD.copyPixels(room.layerUnder.bitmapData, room.layerUnder.bitmapData.rect,
                new Point(-S.LEVEL_OFFSET_X, -S.LEVEL_OFFSET_Y), null, null, false);
            newBD.copyPixels(room.layerActive.bitmapData, room.layerActive.bitmapData.rect,
                new Point(), null, null, true);

            room.clear();

            levelPreview.bitmapData = newBD;
            levelPreview.smoothing  = true;

            // Update room position

            roomPosition.text = TWidgetLevelName.nameFromPosition(roomOffset.x, roomOffset.y);
            roomPosition.x    = (204 - roomPosition.textWidth) / 2;

            updateSecretCount();
        }

        private function updateSecretCount():void {
            if (!Progress.isGameCompleted)
                return;

            var levelID:uint = Level.getLevelIDByRoom(currentRoom);

            var secretRooms:Array = Level.getSecretRoomsByLevelID(levelID);
            var secretsDone:uint = 0;

            for each(var i:XML in secretRooms) {
                if (Progress.wasRoomEverConquered(i.@RoomID))
                    secretsDone++;
            }

            secretsCount.text = _("rstSecrets", secretsDone, secretRooms.length);
            secretsCount.x    = (204 - secretsCount.textWidth) / 2;
        }

        private function onLevelSelected(data:Button):void{
            for each(var level:TRestoreLevel in levels){
                level.unset();
            }

            selectRoom(Level.getAnyVisitedRoomInLevel(data.data.@LevelID).@RoomID);
        }

        private function drawWidget(room:uint):void{
            TWidgetMinimap.setRestoreScreenRoom(room);
            TWidgetMinimap.plotWidget(room, TWidgetMinimap.MODE_RESTORE, minimapData);
        }

    }
}