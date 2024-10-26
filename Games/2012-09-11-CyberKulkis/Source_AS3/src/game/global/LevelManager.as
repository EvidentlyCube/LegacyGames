package game.global{
    import flash.display.BitmapData;
    import flash.events.Event;
    import flash.net.FileFilter;
    import flash.net.FileReference;
    import flash.utils.ByteArray;
    import flash.utils.Dictionary;
    import flash.utils.getTimer;
    import flash.utils.setTimeout;

    import game.global.Game;
    import game.global.help.LoadHelpBlob;
    import game.global.help.LoadHelpCasual;
    import game.global.help.LoadHelpCpu;
    import game.global.help.LoadHelpInka;
    import game.global.help.LoadHelpMedieval;
    import game.global.help.LoadHelpMoon;
    import game.objects.TBomb;
    import game.objects.TBonus;
    import game.objects.TClone;
    import game.objects.TCrate;
    import game.objects.THelp;
    import game.objects.TPlayer;
    import game.states.TStateGame;
    import game.states.TStateOutro;
    import game.states.TStateTitle;
    import game.tiles.TAnimatedWall;
    import game.tiles.TArrow;
    import game.tiles.TBounce;
    import game.tiles.TCannon;
    import game.tiles.TExit;
    import game.tiles.TGrowingWall;
    import game.tiles.TPiercedWall;
    import game.tiles.TPit;
    import game.tiles.TRotationWall;
    import game.tiles.TStop;
    import game.tiles.TSwitch;
    import game.tiles.TTeleport;
    import game.tiles.TTile;
    import game.tiles.TWall;

    import net.retrocade.camel.core.rCore;
    import net.retrocade.camel.core.rGfx;
    import net.retrocade.camel.core.rSave;
    import net.retrocade.camel.core.rSound;
    import net.retrocade.camel.effects.rEffFadeScreen;
    import net.retrocade.camel.effects.rEffQuake;
    import net.retrocade.camel.effects.rEffVolumeFade;
    import net.retrocade.camel.objects.rScroller;
    import net.retrocade.utils.UGraphic;

    public class LevelManager{

        [Embed(source = '/../assets/levels/casual/001.oel',  mimeType = "application/octet-stream")] private static var _level_casual_0_:Class;
        [Embed(source = '/../assets/levels/casual/002.oel',  mimeType = "application/octet-stream")] private static var _level_casual_1_:Class;
        [Embed(source = '/../assets/levels/casual/003.oel',  mimeType = "application/octet-stream")] private static var _level_casual_2_:Class;
        [Embed(source = '/../assets/levels/casual/004.oel',  mimeType = "application/octet-stream")] private static var _level_casual_3_:Class;
        [Embed(source = '/../assets/levels/casual/005.oel',  mimeType = "application/octet-stream")] private static var _level_casual_4_:Class;
        [Embed(source = '/../assets/levels/casual/006.oel',  mimeType = "application/octet-stream")] private static var _level_casual_5_:Class;
        [Embed(source = '/../assets/levels/casual/007.oel',  mimeType = "application/octet-stream")] private static var _level_casual_6_:Class;
        [Embed(source = '/../assets/levels/casual/008.oel',  mimeType = "application/octet-stream")] private static var _level_casual_7_:Class;
        [Embed(source = '/../assets/levels/casual/009.oel',  mimeType = "application/octet-stream")] private static var _level_casual_8_:Class;
        [Embed(source = '/../assets/levels/casual/010.oel',  mimeType = "application/octet-stream")] private static var _level_casual_9_:Class;
        [Embed(source = '/../assets/levels/casual/011.oel',  mimeType = "application/octet-stream")] private static var _level_casual_10_:Class;
        [Embed(source = '/../assets/levels/casual/012.oel',  mimeType = "application/octet-stream")] private static var _level_casual_11_:Class;
        [Embed(source = '/../assets/levels/casual/013.oel',  mimeType = "application/octet-stream")] private static var _level_casual_12_:Class;
        [Embed(source = '/../assets/levels/casual/014.oel',  mimeType = "application/octet-stream")] private static var _level_casual_13_:Class;
        [Embed(source = '/../assets/levels/casual/015.oel',  mimeType = "application/octet-stream")] private static var _level_casual_14_:Class;
        [Embed(source = '/../assets/levels/casual/016.oel',  mimeType = "application/octet-stream")] private static var _level_casual_15_:Class;
        [Embed(source = '/../assets/levels/casual/017.oel',  mimeType = "application/octet-stream")] private static var _level_casual_16_:Class;
        [Embed(source = '/../assets/levels/casual/018.oel',  mimeType = "application/octet-stream")] private static var _level_casual_17_:Class;
        [Embed(source = '/../assets/levels/casual/019.oel',  mimeType = "application/octet-stream")] private static var _level_casual_18_:Class;
        [Embed(source = '/../assets/levels/casual/020.oel',  mimeType = "application/octet-stream")] private static var _level_casual_19_:Class;

        [Embed(source = '/../assets/levels/blob/001.oel',  mimeType = "application/octet-stream")] private static var _level_blob_0_:Class;
        [Embed(source = '/../assets/levels/blob/002.oel',  mimeType = "application/octet-stream")] private static var _level_blob_1_:Class;
        [Embed(source = '/../assets/levels/blob/003.oel',  mimeType = "application/octet-stream")] private static var _level_blob_2_:Class;
        [Embed(source = '/../assets/levels/blob/004.oel',  mimeType = "application/octet-stream")] private static var _level_blob_3_:Class;
        [Embed(source = '/../assets/levels/blob/005.oel',  mimeType = "application/octet-stream")] private static var _level_blob_4_:Class;
        [Embed(source = '/../assets/levels/blob/006.oel',  mimeType = "application/octet-stream")] private static var _level_blob_5_:Class;
        [Embed(source = '/../assets/levels/blob/007.oel',  mimeType = "application/octet-stream")] private static var _level_blob_6_:Class;
        [Embed(source = '/../assets/levels/blob/008.oel',  mimeType = "application/octet-stream")] private static var _level_blob_7_:Class;
        [Embed(source = '/../assets/levels/blob/009.oel',  mimeType = "application/octet-stream")] private static var _level_blob_8_:Class;
        [Embed(source = '/../assets/levels/blob/010.oel',  mimeType = "application/octet-stream")] private static var _level_blob_9_:Class;
        [Embed(source = '/../assets/levels/blob/011.oel',  mimeType = "application/octet-stream")] private static var _level_blob_10_:Class;
        [Embed(source = '/../assets/levels/blob/012.oel',  mimeType = "application/octet-stream")] private static var _level_blob_11_:Class;
        [Embed(source = '/../assets/levels/blob/013.oel',  mimeType = "application/octet-stream")] private static var _level_blob_12_:Class;
        [Embed(source = '/../assets/levels/blob/014.oel',  mimeType = "application/octet-stream")] private static var _level_blob_13_:Class;
        [Embed(source = '/../assets/levels/blob/015.oel',  mimeType = "application/octet-stream")] private static var _level_blob_14_:Class;
        [Embed(source = '/../assets/levels/blob/016.oel',  mimeType = "application/octet-stream")] private static var _level_blob_15_:Class;
        [Embed(source = '/../assets/levels/blob/017.oel',  mimeType = "application/octet-stream")] private static var _level_blob_16_:Class;
        [Embed(source = '/../assets/levels/blob/018.oel',  mimeType = "application/octet-stream")] private static var _level_blob_17_:Class;
        [Embed(source = '/../assets/levels/blob/019.oel',  mimeType = "application/octet-stream")] private static var _level_blob_18_:Class;
        [Embed(source = '/../assets/levels/blob/020.oel',  mimeType = "application/octet-stream")] private static var _level_blob_19_:Class;

        [Embed(source = '/../assets/levels/cpu/001.oel',  mimeType = "application/octet-stream")] private static var _level_cpu_0_:Class;
        [Embed(source = '/../assets/levels/cpu/002.oel',  mimeType = "application/octet-stream")] private static var _level_cpu_1_:Class;
        [Embed(source = '/../assets/levels/cpu/003.oel',  mimeType = "application/octet-stream")] private static var _level_cpu_2_:Class;
        [Embed(source = '/../assets/levels/cpu/004.oel',  mimeType = "application/octet-stream")] private static var _level_cpu_3_:Class;
        [Embed(source = '/../assets/levels/cpu/005.oel',  mimeType = "application/octet-stream")] private static var _level_cpu_4_:Class;
        [Embed(source = '/../assets/levels/cpu/006.oel',  mimeType = "application/octet-stream")] private static var _level_cpu_5_:Class;
        [Embed(source = '/../assets/levels/cpu/007.oel',  mimeType = "application/octet-stream")] private static var _level_cpu_6_:Class;
        [Embed(source = '/../assets/levels/cpu/008.oel',  mimeType = "application/octet-stream")] private static var _level_cpu_7_:Class;
        [Embed(source = '/../assets/levels/cpu/009.oel',  mimeType = "application/octet-stream")] private static var _level_cpu_8_:Class;
        [Embed(source = '/../assets/levels/cpu/010.oel',  mimeType = "application/octet-stream")] private static var _level_cpu_9_:Class;
        [Embed(source = '/../assets/levels/cpu/011.oel',  mimeType = "application/octet-stream")] private static var _level_cpu_10_:Class;
        [Embed(source = '/../assets/levels/cpu/012.oel',  mimeType = "application/octet-stream")] private static var _level_cpu_11_:Class;
        [Embed(source = '/../assets/levels/cpu/013.oel',  mimeType = "application/octet-stream")] private static var _level_cpu_12_:Class;
        [Embed(source = '/../assets/levels/cpu/014.oel',  mimeType = "application/octet-stream")] private static var _level_cpu_13_:Class;
        [Embed(source = '/../assets/levels/cpu/015.oel',  mimeType = "application/octet-stream")] private static var _level_cpu_14_:Class;
        [Embed(source = '/../assets/levels/cpu/016.oel',  mimeType = "application/octet-stream")] private static var _level_cpu_15_:Class;
        [Embed(source = '/../assets/levels/cpu/017.oel',  mimeType = "application/octet-stream")] private static var _level_cpu_16_:Class;
        [Embed(source = '/../assets/levels/cpu/018.oel',  mimeType = "application/octet-stream")] private static var _level_cpu_17_:Class;
        [Embed(source = '/../assets/levels/cpu/019.oel',  mimeType = "application/octet-stream")] private static var _level_cpu_18_:Class;
        [Embed(source = '/../assets/levels/cpu/020.oel',  mimeType = "application/octet-stream")] private static var _level_cpu_19_:Class;

        [Embed(source = '/../assets/levels/inka/001.oel',  mimeType = "application/octet-stream")] private static var _level_inka_0_:Class;
        [Embed(source = '/../assets/levels/inka/002.oel',  mimeType = "application/octet-stream")] private static var _level_inka_1_:Class;
        [Embed(source = '/../assets/levels/inka/003.oel',  mimeType = "application/octet-stream")] private static var _level_inka_2_:Class;
        [Embed(source = '/../assets/levels/inka/004.oel',  mimeType = "application/octet-stream")] private static var _level_inka_3_:Class;
        [Embed(source = '/../assets/levels/inka/005.oel',  mimeType = "application/octet-stream")] private static var _level_inka_4_:Class;
        [Embed(source = '/../assets/levels/inka/006.oel',  mimeType = "application/octet-stream")] private static var _level_inka_5_:Class;
        [Embed(source = '/../assets/levels/inka/007.oel',  mimeType = "application/octet-stream")] private static var _level_inka_6_:Class;
        [Embed(source = '/../assets/levels/inka/008.oel',  mimeType = "application/octet-stream")] private static var _level_inka_7_:Class;
        [Embed(source = '/../assets/levels/inka/009.oel',  mimeType = "application/octet-stream")] private static var _level_inka_8_:Class;
        [Embed(source = '/../assets/levels/inka/010.oel',  mimeType = "application/octet-stream")] private static var _level_inka_9_:Class;
        [Embed(source = '/../assets/levels/inka/011.oel',  mimeType = "application/octet-stream")] private static var _level_inka_10_:Class;
        [Embed(source = '/../assets/levels/inka/012.oel',  mimeType = "application/octet-stream")] private static var _level_inka_11_:Class;
        [Embed(source = '/../assets/levels/inka/013.oel',  mimeType = "application/octet-stream")] private static var _level_inka_12_:Class;
        [Embed(source = '/../assets/levels/inka/014.oel',  mimeType = "application/octet-stream")] private static var _level_inka_13_:Class;
        [Embed(source = '/../assets/levels/inka/015.oel',  mimeType = "application/octet-stream")] private static var _level_inka_14_:Class;
        [Embed(source = '/../assets/levels/inka/016.oel',  mimeType = "application/octet-stream")] private static var _level_inka_15_:Class;
        [Embed(source = '/../assets/levels/inka/017.oel',  mimeType = "application/octet-stream")] private static var _level_inka_16_:Class;
        [Embed(source = '/../assets/levels/inka/018.oel',  mimeType = "application/octet-stream")] private static var _level_inka_17_:Class;
        [Embed(source = '/../assets/levels/inka/019.oel',  mimeType = "application/octet-stream")] private static var _level_inka_18_:Class;
        [Embed(source = '/../assets/levels/inka/020.oel',  mimeType = "application/octet-stream")] private static var _level_inka_19_:Class;

        [Embed(source = '/../assets/levels/medieval/001.oel',  mimeType = "application/octet-stream")] private static var _level_medieval_0_:Class;
        [Embed(source = '/../assets/levels/medieval/002.oel',  mimeType = "application/octet-stream")] private static var _level_medieval_1_:Class;
        [Embed(source = '/../assets/levels/medieval/003.oel',  mimeType = "application/octet-stream")] private static var _level_medieval_2_:Class;
        [Embed(source = '/../assets/levels/medieval/004.oel',  mimeType = "application/octet-stream")] private static var _level_medieval_3_:Class;
        [Embed(source = '/../assets/levels/medieval/005.oel',  mimeType = "application/octet-stream")] private static var _level_medieval_4_:Class;
        [Embed(source = '/../assets/levels/medieval/006.oel',  mimeType = "application/octet-stream")] private static var _level_medieval_5_:Class;
        [Embed(source = '/../assets/levels/medieval/007.oel',  mimeType = "application/octet-stream")] private static var _level_medieval_6_:Class;
        [Embed(source = '/../assets/levels/medieval/008.oel',  mimeType = "application/octet-stream")] private static var _level_medieval_7_:Class;
        [Embed(source = '/../assets/levels/medieval/009.oel',  mimeType = "application/octet-stream")] private static var _level_medieval_8_:Class;
        [Embed(source = '/../assets/levels/medieval/010.oel',  mimeType = "application/octet-stream")] private static var _level_medieval_9_:Class;
        [Embed(source = '/../assets/levels/medieval/011.oel',  mimeType = "application/octet-stream")] private static var _level_medieval_10_:Class;
        [Embed(source = '/../assets/levels/medieval/012.oel',  mimeType = "application/octet-stream")] private static var _level_medieval_11_:Class;
        [Embed(source = '/../assets/levels/medieval/013.oel',  mimeType = "application/octet-stream")] private static var _level_medieval_12_:Class;
        [Embed(source = '/../assets/levels/medieval/014.oel',  mimeType = "application/octet-stream")] private static var _level_medieval_13_:Class;
        [Embed(source = '/../assets/levels/medieval/015.oel',  mimeType = "application/octet-stream")] private static var _level_medieval_14_:Class;
        [Embed(source = '/../assets/levels/medieval/016.oel',  mimeType = "application/octet-stream")] private static var _level_medieval_15_:Class;
        [Embed(source = '/../assets/levels/medieval/017.oel',  mimeType = "application/octet-stream")] private static var _level_medieval_16_:Class;
        [Embed(source = '/../assets/levels/medieval/018.oel',  mimeType = "application/octet-stream")] private static var _level_medieval_17_:Class;
        [Embed(source = '/../assets/levels/medieval/019.oel',  mimeType = "application/octet-stream")] private static var _level_medieval_18_:Class;
        [Embed(source = '/../assets/levels/medieval/020.oel',  mimeType = "application/octet-stream")] private static var _level_medieval_19_:Class;

        [Embed(source = '/../assets/levels/moon/001.oel',  mimeType = "application/octet-stream")] private static var _level_moon_0_:Class;
        [Embed(source = '/../assets/levels/moon/002.oel',  mimeType = "application/octet-stream")] private static var _level_moon_1_:Class;
        [Embed(source = '/../assets/levels/moon/003.oel',  mimeType = "application/octet-stream")] private static var _level_moon_2_:Class;
        [Embed(source = '/../assets/levels/moon/004.oel',  mimeType = "application/octet-stream")] private static var _level_moon_3_:Class;
        [Embed(source = '/../assets/levels/moon/005.oel',  mimeType = "application/octet-stream")] private static var _level_moon_4_:Class;
        [Embed(source = '/../assets/levels/moon/006.oel',  mimeType = "application/octet-stream")] private static var _level_moon_5_:Class;
        [Embed(source = '/../assets/levels/moon/007.oel',  mimeType = "application/octet-stream")] private static var _level_moon_6_:Class;
        [Embed(source = '/../assets/levels/moon/008.oel',  mimeType = "application/octet-stream")] private static var _level_moon_7_:Class;
        [Embed(source = '/../assets/levels/moon/009.oel',  mimeType = "application/octet-stream")] private static var _level_moon_8_:Class;
        [Embed(source = '/../assets/levels/moon/010.oel',  mimeType = "application/octet-stream")] private static var _level_moon_9_:Class;
        [Embed(source = '/../assets/levels/moon/011.oel',  mimeType = "application/octet-stream")] private static var _level_moon_10_:Class;
        [Embed(source = '/../assets/levels/moon/012.oel',  mimeType = "application/octet-stream")] private static var _level_moon_11_:Class;
        [Embed(source = '/../assets/levels/moon/013.oel',  mimeType = "application/octet-stream")] private static var _level_moon_12_:Class;
        [Embed(source = '/../assets/levels/moon/014.oel',  mimeType = "application/octet-stream")] private static var _level_moon_13_:Class;
        [Embed(source = '/../assets/levels/moon/015.oel',  mimeType = "application/octet-stream")] private static var _level_moon_14_:Class;
        [Embed(source = '/../assets/levels/moon/016.oel',  mimeType = "application/octet-stream")] private static var _level_moon_15_:Class;
        [Embed(source = '/../assets/levels/moon/017.oel',  mimeType = "application/octet-stream")] private static var _level_moon_16_:Class;
        [Embed(source = '/../assets/levels/moon/018.oel',  mimeType = "application/octet-stream")] private static var _level_moon_17_:Class;
        [Embed(source = '/../assets/levels/moon/019.oel',  mimeType = "application/octet-stream")] private static var _level_moon_18_:Class;
        [Embed(source = '/../assets/levels/moon/020.oel',  mimeType = "application/octet-stream")] private static var _level_moon_19_:Class;

        private static var _nextLevelFade   :rEffFadeScreen;
        private static var _restartLevelFade:rEffFadeScreen;

        public static function canPlayerMove():Boolean{
            return !(_nextLevelFade || _restartLevelFade);
        }

        public static function getLevel(id:uint):ByteArray {
            if (_qfr){
                return _qfr.data;
            }
            const data:* = new LevelManager['_level_' + Game.gameMode + "_" + id + '_'];

            data.position = 0;
            return data;
        }

        public static function startGame():void{
            Score.currentLevel = Score.getNextUncompletedLevel(0);
            playLevel(Score.currentLevel);
        }

        public static function continueGame(level:uint):void{
            playLevel(Score.currentLevel = level);
        }


        public static function restartLevel(fadeout:Number = 500):void{
            if (_restartLevelFade)
                return;

            _restartLevelFade = new rEffFadeScreen(1, 0, 0, fadeout, onRestartFade);
        }

        private static function onRestartFade():void{
            _restartLevelFade = null;
            playLevel(Score.currentLevel);
        }

        public static function levelCompleted():void{
            if (_nextLevelFade)
                return;

            var oldRoomCount:uint = Score.countLevelsCompleted();

            Score.setLevelSteps(Score.currentLevel, Score.movesMade.get());
            Score.setLevelTime (Score.currentLevel, getTimer() - Score.time.get());

            Score.currentLevel = Score.getNextUncompletedLevel(Score.currentLevel);

            new rEffVolumeFade(false, 500);

            if (Score.countLevelsCompleted() >= 20 && !Score.wasGameCompleted)
                _nextLevelFade = new rEffFadeScreen(1, 0, 0, 500, onEndGameFaded);
            else
                _nextLevelFade = new rEffFadeScreen(1, 0, 0, 500, onNextLevelFaded);
        }

        private static function onNextLevelFaded():void{
            _nextLevelFade = null;

            playLevel(Score.currentLevel);
            rSound.playMusic(Game.music, 0, 1000);
        }

        private static function onEndGameFaded():void{
            _nextLevelFade = null;

            rSound.stopMusic();

            rCore.setState(new TStateOutro);

            Score.wasGameCompleted = true;
        }

        private static function toID(tx:uint, ty:uint):uint{
            return (tx / 24) + (ty / 24 | 0) * 20;
        }

        public static function gameOver():void {

        }

        private static function playLevel(id:uint):void {
            Level.level.clear();

            Game.gAll.clear();
            Game.partPixel.clear();
            Game.lMain.clear();

            Level.active.clear();

            Score.levelRestart();

            var lvlData:ByteArray = getLevel(id);
            if (lvlData == null)
                throw new Error("Invalid level data");

            lvlData.position = 0;

            var xml:XML = new XML(lvlData.readUTFBytes(lvlData.length));

            Level.widthTiles  = parseInt(xml.width .text()) / 24;
            Level.heightTiles = parseInt(xml.height.text()) / 24;

            Level.widthPixels  = Level.widthTiles  * 24;
            Level.heightPixels = Level.heightTiles * 24;

            Level.level.init(Level.widthTiles, Level.heightTiles);

            Score.levelName   = xml.@title .toString();
            Score.levelAuthor = xml.@author.toString();

            for (var i:uint = 0; i < Level.widthTiles; i++){
                for (var j:uint = 0; j < Level.heightTiles; j++){
                    Level.level.set(i * 24, j * 24, new TTile(i * 24, j * 24));
                }
            }

            var drawOffsetX:Number = (600 - Level.widthPixels)  / 2 | 0;
            var drawOffsetY:Number = (552 - Level.heightPixels) / 2 | 0;

            Level.levelDrawOffsetX = drawOffsetX;
            Level.levelDrawOffsetY = drawOffsetY;

            Game.lBG  .scrollX = drawOffsetX;
            Game.lBG  .scrollY = drawOffsetY;
            Game.lGame.scrollX = drawOffsetX;
            Game.lGame.scrollY = drawOffsetY;
            Game.lPart.scrollX = drawOffsetX;
            Game.lPart.scrollY = drawOffsetY;

            UGraphic.clear(Game.lMain.graphics)
                .rectFill(0, 0, S().gameWidth, drawOffsetY, 0)
                .rectFill(0, drawOffsetY + Level.heightTiles * 24, S().gameWidth, drawOffsetY + 48, 0)
                .rectFill(0, drawOffsetY, drawOffsetX, Level.heightTiles * 24, 0)
                .rectFill(S().gameWidth - drawOffsetX, drawOffsetY, drawOffsetX, Level.heightTiles * 24, 0);

            /*UGraphic.clear(Game.lMain.graphics)
                .rectFillBitmap(0, 0, S().gameWidth, drawOffsetY, bd, 0, 0)
                .rectFillBitmap(0, drawOffsetY + Level.heightTiles * 24, S().gameWidth, drawOffsetY + 48, bd, 0, 0)
                .rectFillBitmap(0, drawOffsetY, drawOffsetX, Level.heightTiles * 24, bd, 0, 0)
                .rectFillBitmap(S().gameWidth - drawOffsetX, drawOffsetY, drawOffsetX, Level.heightTiles * 24, bd, 0, 0)
                .rectOutline(drawOffsetX - 6, drawOffsetY - 6, Level.widthPixels + 12, Level.heightPixels + 12, 6, 0, 0.5);
            */

            var item:XML;
            for each(item in xml.floorLayer.children()){
                loadItem(item.@x, item.@y, item.@tx, item.@ty, false);
            }
            var node:XML;
            for each(item in xml.solidLayer.children()){
                loadItem(item.@x, item.@y, item.@tx, item.@ty, false);
            }
            for each(item in xml.alternateLayer.children()){
                loadItem(item.@x, item.@y, item.@tx, item.@ty, true);
            }

            for each(item in xml.actors.children()){
                switch(item.name().toString()){
                    case("buttonToggle"):
                        new TSwitch(item.@x, item.@y, true, item.children(), false);
                        break;

                    case("buttonFire"):
                        new TSwitch(item.@x, item.@y, false, item.children(), false);
                        break;

                    case("teleport"):
                        node = item.node[0];
                        new TTeleport(item.@x, item.@y, node.@x, node.@y, false);
                        break;

                    case("stop"):      new TStop(item.@x, item.@y, false); break;
                    case("bounceBLU"): new TBounce(item.@x, item.@y, TBounce.TYPE_DIAG_TOPRIGHT, false); break;
                    case("bounceTLD"): new TBounce(item.@x, item.@y, TBounce.TYPE_DIAG_TOPLEFT,  false); break;
                    case("bounceLFT"): new TBounce(item.@x, item.@y, TBounce.TYPE_VERT_LEFT,     false); break;
                    case("bounceRGT"): new TBounce(item.@x, item.@y, TBounce.TYPE_VERT_RIGHT,    false); break;
                    case("bounceTOP"): new TBounce(item.@x, item.@y, TBounce.TYPE_HORI_TOP,      false); break;
                    case("bounceBTM"): new TBounce(item.@x, item.@y, TBounce.TYPE_HORI_BOTTOM,   false); break;
                    case("exit"):      new TExit(item.@x, item.@y, false); break;
                    case("arrowRGT"):  new TArrow(item.@x, item.@y, 0, false); break;
                    case("arrowDWN"):  new TArrow(item.@x, item.@y, 1, false); break;
                    case("arrowLFT"):  new TArrow(item.@x, item.@y, 2, false); break;
                    case("arrowTOP"):  new TArrow(item.@x, item.@y, 3, false); break;
                    case("arrowDWR"):  new TArrow(item.@x, item.@y, 4, false); break;
                    case("arrowDWL"):  new TArrow(item.@x, item.@y, 5, false); break;
                    case("arrowUPL"):  new TArrow(item.@x, item.@y, 6, false); break;
                    case("arrowUPR"):  new TArrow(item.@x, item.@y, 7, false); break;
                    case("arrowLFR"):  new TArrow(item.@x, item.@y, 8, false); break;
                    case("arrowUPD"):  new TArrow(item.@x, item.@y, 9, false); break;
                    case("player"):    new TPlayer(item.@x, item.@y); break;
                    case("slimeWall"): new TGrowingWall(item.@x, item.@y, false); break;

                }
            }

            Hud.hook();

            new rEffFadeScreen(0, 1, 0, 300);

            loadHelp(id);

            TStateGame.instance.resetBackgroundAnimation();
        }

        private static function loadItem(x:uint, y:uint, tx:uint, ty:uint, alternate:Boolean):void{
            if (ty == 0){
                if (tx <= 216)
                new TArrow(x, y, tx / 24, alternate);

            } else if (ty == 24){
                new TBonus(x, y, tx, ty, alternate);

            } else if (ty == 48){
                if (tx <= 120)      new TBounce(x, y, tx / 24, alternate);
                else if (tx == 168) new TStop(x, y, alternate);
                else if (tx == 216) new TPit(x, y, alternate);
                else if (tx == 336) new TCrate(x, y, tx, ty, true,  false);
                else if (tx == 360) new TCrate(x, y, tx, ty, false, false);
                else if (tx == 384) new TCrate(x, y, tx, ty, true,  true);
                else if (tx == 408) new TCrate(x, y, tx, ty, false, true);
                else if (tx == 456) new TGrowingWall(x, y, alternate);

            } else if (ty == 72){
                if (tx == 0)
                    new TExit(x, y, alternate);

            } else if (ty == 120){
                if (tx <= 72)
                    new TCannon(x, y, tx / 24, alternate);
                else if (tx == 336)
                    new TBomb(x, y, alternate);
                else if (tx >= 216 && tx <= 288)
                    new TClone(x, y, (tx - 216) / 24);
            } else if (ty == 144){
                if (tx >= 264 && tx <= 336)
                    new TPlayer(x, y);

            } else if (ty >= 192 && ty <= 264)
                TTile(Level.level.get(x, y)).setFloor(tx, ty);

            else if (ty == 336){
                if (tx == 0)
                    new TRotationWall(x, y, true, alternate);
                else
                    new TRotationWall(x, y, false, alternate);
            } else if (ty == 360){
                if (tx == 0)
                    new TPiercedWall(x, y, tx, ty, false, false, alternate);
                else if (tx == 24)
                    new TPiercedWall(x, y, tx, ty, true, false, alternate);
                else if (tx == 48)
                    new TPiercedWall(x, y, tx, ty, false, true, alternate);
                else if (tx == 96)
                    new TAnimatedWall(x, y, 0, alternate);

            } else if (ty >= 384){
                switch(tx * 1000 + ty){
                    case(216384):
                        new TAnimatedWall(x, y, 1, alternate);
                        break;
                    case(360384):
                        new TAnimatedWall(x, y, 2, alternate);
                        break;
                    case(216408):
                        new TAnimatedWall(x, y, 3, alternate);
                        break;
                    case(360408):
                        new TAnimatedWall(x, y, 4, alternate);
                        break;
                    default:
                        new TWall(x, y, tx, ty, alternate);
                        break;
                }
            }
        }

        private static function loadHelp(levelIndex:uint):void{
            switch (Game.gameMode) {
                case 'blob': LoadHelpBlob(levelIndex); break;
                case 'cpu': LoadHelpCpu(levelIndex); break;
                case 'inka': LoadHelpInka(levelIndex); break;
                case 'medieval': LoadHelpMedieval(levelIndex); break;
                case 'moon': LoadHelpMoon(levelIndex); break;
                case 'casual':
                default:
                    LoadHelpCasual(levelIndex);
                    break;
            }
        }

        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Level Load From File
        // ::::::::::::::::::::::::::::::::::::::::::::::

        private static var _qfr:FileReference;
        public static function loadLevelFromFile():void{
            _qfr = new FileReference();
            _qfr.addEventListener(Event.SELECT, fLevelStartLoading);
            _qfr.addEventListener(Event.COMPLETE, fLevelLoaded);

            _qfr.browse([ new FileFilter("All", "*")]);
        }

        private static function fLevelStartLoading(e:Event):void{
            _qfr.load();
        }

        private static function fLevelLoaded(e:Event):void{
            playLevel(0);
        }
    }
}