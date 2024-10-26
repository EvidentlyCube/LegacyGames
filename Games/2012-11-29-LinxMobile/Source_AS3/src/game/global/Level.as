package game.global {
    import flash.utils.ByteArray;
    import flash.utils.Dictionary;
    import flash.utils.getTimer;

    import game.data.TBase;
    import game.data.TConnectorManager;
    import game.data.TPath;
    import game.data.TWildcard;
    import game.global.newTutorial.NewTutorial;
    import game.global.tutorial.TTutorial;
    import game.global.tutorial.TTutorialEntry;
    import game.levels.LevelManager;
    import game.objects.TConnector;
    import game.objects.TCursor;
    import game.objects.THud;
    import game.states.TStateGame;
    import game.states.TStateLevelSelect;
    import game.states.TStateSplashOutro;
    import game.tiles.TTileFloor;
    import game.tiles.TTilePit;
    import game.windows.TWinLevelCompleted;

    import net.retrocade.camel.effects.rEffFade;
    import net.retrocade.camel.engines.tilegrid.rTileGrid;
    import net.retrocade.camel.global.rEvents;
    import net.retrocade.camel.global.rGroup;
    import net.retrocade.camel.global.rSave;
    import net.retrocade.camel.global.rSfx;

    /**
     * ...
     * @author
     */
    public class Level {
        public static var levelLocked:Boolean = false;

        public static var level:rTileGrid;

        public static var groupBases:rGroup = new rGroup();
        public static var groupPaths:rGroup = new rGroup();
        public static var groupOtherTiles:rGroup = new rGroup();

        public static var selectedColor:int = -1;

        public static var levelTimeStarted:Number;

        private static var _levels:Dictionary = new Dictionary();

        public static function startGame():void{
            // @TODO - Action when starting game
            playLevel(Score.getNextUncompletedLevel());
        }

        public static function continueGame(levelID:uint):void{
            playLevel(levelID);
        }

        public static function levelCompleted():void {
            Score.completedLevels[Score.level.get() - 1 + S().totalLevels * Score.gameMode] = true;
            Score.saveLevels();

            levelLocked   = true;
            selectedColor = -1;

            if (Score.countCompleted() == S().totalLevels && Score.gameMode != Score.MODE_EASY &&
                    Score.gameMode != Score.MODE_BRANDED && !rSave.read("outroSeen" + Score.gameMode, false)){

                new rEffFade(Game.lGame.displayObject, 1, 0, 2000);
                new rEffFade(Game.lMain.displayObject, 1, 0, 2000, gotoOutro);

            } else {
                TWinLevelCompleted.instance.show();
            }
        }

        private static function gotoOutro():void{
            rSfx.stopMusic();
            new TStateSplashOutro(Score.gameMode == Score.MODE_NORMAL);
        }

        private static function gotoNextTutorialLevel():void{
            var currentLevel:uint = Score.level.get();


            levelLocked   = true;
            selectedColor = -1;

            Score.pathsPlaced.set(0);
            currentLevel = LevelManager.instance.getNextTutorialLevel(Score.gameMode, currentLevel);

            if (currentLevel == -1){
                Permit.setPermission(C.allowAll);
                TStateLevelSelect.instance.set();
                return;
            }

            continueGame(currentLevel);
        }

        public static function clearLevel():void{
            Minimap.instance.clear();

            var conn:TConnector;

            for each(conn in groupBases){
                conn.dispose();
            }

            for each(conn in groupPaths){
                conn.dispose();
            }

            for each(conn in groupOtherTiles){
                conn.dispose();
            }

            groupBases.clear();
            groupPaths.clear();
            groupOtherTiles.clear();

            Game.lStarling.clear();

            level.clear();
            TStateGame.instance.defaultGroup.clear();
        }

        private static function playLevel(id:uint):void {
            Game.lMain.alpha = 0;

            NewTutorial.clear();

            //rSave.write('bestLevel', Score.level.get());

            THud.nowPlayedLevel = id;

            levelTimeStarted = getTimer();

            selectedColor = -1;

            levelLocked = false;

            Score.level.set(id);

            clearLevel();

            Game.gAll .clear();
            Game.lMain.clear();
            Game.lGame.clear();

            Score.pathsMax.set(0);
            Score.pathsPlaced.set(0);

            // @TODO - Hook hud to layer
            //THud.instance.hookTo(Game.lGame);

            var lvl:ByteArray = LevelManager.instance.getLevel(Score.gameMode, id);

            if (!parseXmlLevel(lvl)){
                var byte:uint;
                var posX:uint = 0;
                var posY:uint = 0;

                // BEcause the game is now 14x14 and the old level size was 14x12 we are adding the two rows of pits
                var filler:int = 0;
                while (filler < S().tileGridWidth){
                    new TTilePit(filler * S().tileWidth, 0);
                    new TTilePit(filler * S().tileWidth, (S().tileGridHeight - 1) * S().tileHeight);

                    filler++
                }

                while(lvl.position < lvl.length){
                    posX = (lvl.position % 12) * S().tileWidth + S().tileWidth;
                    posY = (lvl.position / 12| 0) * S().tileHeight;

                    byte = lvl[lvl.position++];

                    // PosX and PosY are swapped because the display is (used to be) wider than higher and our default orientation is landscape
                    parse(byte, posY, posX);
                }
            }

            TConnectorManager.recheckAllColors();

            TTileFloor.drawFloors();

            //rSfx.playMusic(Game.music);
            new rEffFade(Game.lGame.displayObject, 0, 1, 500);
            new rEffFade(Game.lMain.displayObject, 0, 1, 500);

            new TCursor;

            THud.instance.hookTo();

            LevelManager.instance.loadHelp(Score.gameMode, id);

            TStateGame.instance.redrawAll();
        }




        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Level Parsing
        // ::::::::::::::::::::::::::::::::::::::::::::::



        private static function parse(byte:uint, x:uint, y:uint):void {
            if (byte > 0 && byte < 10){
                new TBase(x / S().tileWidth, y / S().tileHeight, byte - 1);

            } else if (byte == 20){ // Pit
                new TTilePit(x, y);

            } else if (byte >= 10 && byte < 19){
                //new TPath(x, y, byte - 10);
                Score.pathsMax.add(1);
            } else if (byte == 21)
                new TWildcard(x, y);
        }

        private static function parseXmlLevel(byteArray:ByteArray):Boolean{
            if (byteArray.length == 168)
                return false;

            try {
                var xml:XML = new XML(byteArray.readUTFBytes(byteArray.length));
            } catch (e:*){
                return false;
            }

            for each(var tile:XML in xml..tile){

                var byte:uint = (parseInt(tile.@tx) / 50 + parseInt(tile.@ty) * 9 / 50) + 1
                parse(
                    byte >= 19 ? byte + 1 : byte,
                    parseInt(tile.@x),
                    parseInt(tile.@y)
                );
            }

            return true;
        }


        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Other Functionality
        // ::::::::::::::::::::::::::::::::::::::::::::::

        public static function countBasesByColor(colorGiven:uint):uint{
            var closure:Function = function():Boolean{
                return this.tileColor == colorGiven;
            };

            return groupBases.countByFunction(closure);
        }

        public static function getFirstBase(colorGiven:uint):TBase{
            var closure:Function = function():Boolean{
                return this.tileColor == colorGiven;
            };

            return groupBases.getOneByFunction(closure) as TBase;
        }

        public static function getAllByColor(colorGiven:uint):Array{
            var closure:Function = function():Boolean{
                return this.tileColor == colorGiven;
            };

            return groupBases.getAllByFunction(closure).concat(groupPaths.getAllByFunction(closure));
        }

        public static function clearPaths():void{
            var undo:UndoStep = new UndoStep();

            var allPaths:Array = groupPaths.getAll();

            levelTimeStarted = getTimer();

            for each(var path:TPath in allPaths){
                if (path){
                    undo.remove(path.x / S().tileWidth, path.y / S().tileHeight, path.tileColor);
                    path.removePath();
                }
            }

            rEvents.add(C.eventPathNumberChanged);

            TStateGame.instance.redrawAll();

            TCursor._undoHistory.push(undo);
        }

        public static function redraw():void{
            for each(var path:TPath in groupPaths.getAllOriginal()){
                if (path && path.tileColor != selectedColor)
                    path.update();
            }

            for each(var base:TBase in groupBases.getAllOriginal()){
                if (base && base.tileColor != selectedColor)
                    base.update();
            }
        }

        public static function redrawAsTransparent():void{
            for each(var path:TPath in groupPaths.getAllOriginal()){
                if (path)
                    if (path.tileColor != selectedColor)
                        path.redrawTransparent();
                    else
                        path.update();

            }

            for each(var base:TBase in groupBases.getAllOriginal()){
                if (base)
                    if (base.tileColor != selectedColor)
                        base.redrawTransparent();
                    else
                        base.update();
            }
        }
    }
}