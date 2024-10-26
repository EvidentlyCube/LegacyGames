package game.global {
    import flash.utils.ByteArray;
    import flash.utils.Dictionary;
    import flash.utils.getTimer;
    import flash.utils.setTimeout;

    import game.data.TBase;
    import game.data.TPath;
    import game.objects.TConnector;
    import game.objects.TCursor;
    import game.objects.TEscButton;
    import game.objects.THud;
    import game.standalone.HelpMessage;
    import game.states.TStateFinish;
    import game.states.TStateGame;
    import game.states.TStateTitle;
    import game.tiles.TTileFloor;
    import game.tiles.TTilePit;
    import game.windows.TWinCompleted;
    import game.windows.TWinLevelCompleted;

    import net.retrocade.camel.core.rCore;
    import net.retrocade.camel.core.rGfx;
    import net.retrocade.camel.core.rGroup;
    import net.retrocade.camel.core.rSave;
    import net.retrocade.camel.core.rSound;
    import net.retrocade.camel.effects.rEffFadeScreen;
    import net.retrocade.camel.effects.rEffQuake;
    import net.retrocade.camel.effects.rEffVolumeFade;
    import net.retrocade.camel.engines.tilegrid.rTileGrid;
    import net.retrocade.standalone.Bitext;
    import net.retrocade.standalone.Text;
    import net.retrocade.vault.Safe;

    /**
     * ...
     * @author
     */
    public class Level {
        [Embed(source = '/../assets/levels/regular/1.lvl',  mimeType = "application/octet-stream")]  private static var _level_regular_1_:Class;
        [Embed(source = '/../assets/levels/regular/2.lvl',  mimeType = "application/octet-stream")]  private static var _level_regular_2_:Class;
        [Embed(source = '/../assets/levels/regular/3.lvl',  mimeType = "application/octet-stream")]  private static var _level_regular_3_:Class;
        [Embed(source = '/../assets/levels/regular/4.lvl',  mimeType = "application/octet-stream")]  private static var _level_regular_4_:Class;
        [Embed(source = '/../assets/levels/regular/5.lvl',  mimeType = "application/octet-stream")]  private static var _level_regular_5_:Class;
        [Embed(source = '/../assets/levels/regular/6.lvl',  mimeType = "application/octet-stream")]  private static var _level_regular_6_:Class;
        [Embed(source = '/../assets/levels/regular/7.lvl',  mimeType = "application/octet-stream")]  private static var _level_regular_7_:Class;
        [Embed(source = '/../assets/levels/regular/8.lvl',  mimeType = "application/octet-stream")]  private static var _level_regular_8_:Class;
        [Embed(source = '/../assets/levels/regular/9.lvl',  mimeType = "application/octet-stream")]  private static var _level_regular_9_:Class;
        [Embed(source = '/../assets/levels/regular/10.lvl', mimeType = "application/octet-stream")]  private static var _level_regular_10_:Class;
        [Embed(source = '/../assets/levels/regular/11.lvl', mimeType = "application/octet-stream")]  private static var _level_regular_11_:Class;
        [Embed(source = '/../assets/levels/regular/12.lvl', mimeType = "application/octet-stream")]  private static var _level_regular_12_:Class;
        [Embed(source = '/../assets/levels/regular/13.lvl', mimeType = "application/octet-stream")]  private static var _level_regular_13_:Class;
        [Embed(source = '/../assets/levels/regular/14.lvl', mimeType = "application/octet-stream")]  private static var _level_regular_14_:Class;
        [Embed(source = '/../assets/levels/regular/15.lvl', mimeType = "application/octet-stream")]  private static var _level_regular_15_:Class;
        [Embed(source = '/../assets/levels/regular/16.lvl', mimeType = "application/octet-stream")]  private static var _level_regular_16_:Class;
        [Embed(source = '/../assets/levels/regular/17.lvl', mimeType = "application/octet-stream")]  private static var _level_regular_17_:Class;
        [Embed(source = '/../assets/levels/regular/18.lvl', mimeType = "application/octet-stream")]  private static var _level_regular_18_:Class;
        [Embed(source = '/../assets/levels/regular/19.lvl', mimeType = "application/octet-stream")]  private static var _level_regular_19_:Class;
        [Embed(source = '/../assets/levels/regular/20.lvl', mimeType = "application/octet-stream")]  private static var _level_regular_20_:Class;
        [Embed(source = '/../assets/levels/regular/21.lvl', mimeType = "application/octet-stream")]  private static var _level_regular_21_:Class;
        [Embed(source = '/../assets/levels/regular/22.lvl', mimeType = "application/octet-stream")]  private static var _level_regular_22_:Class;
        [Embed(source = '/../assets/levels/regular/23.lvl', mimeType = "application/octet-stream")]  private static var _level_regular_23_:Class;
        [Embed(source = '/../assets/levels/regular/24.lvl', mimeType = "application/octet-stream")]  private static var _level_regular_24_:Class;
        [Embed(source = '/../assets/levels/regular/25.lvl', mimeType = "application/octet-stream")]  private static var _level_regular_25_:Class;
        [Embed(source = '/../assets/levels/regular/26.lvl', mimeType = "application/octet-stream")]  private static var _level_regular_26_:Class;
        [Embed(source = '/../assets/levels/regular/27.lvl', mimeType = "application/octet-stream")]  private static var _level_regular_27_:Class;
        [Embed(source = '/../assets/levels/regular/28.lvl', mimeType = "application/octet-stream")]  private static var _level_regular_28_:Class;
        [Embed(source = '/../assets/levels/regular/29.lvl', mimeType = "application/octet-stream")]  private static var _level_regular_29_:Class;
        [Embed(source = '/../assets/levels/regular/30.lvl', mimeType = "application/octet-stream")]  private static var _level_regular_30_:Class;
        [Embed(source = '/../assets/levels/regular/31.lvl', mimeType = "application/octet-stream")]  private static var _level_regular_31_:Class;
        [Embed(source = '/../assets/levels/regular/32.lvl', mimeType = "application/octet-stream")]  private static var _level_regular_32_:Class;
        [Embed(source = '/../assets/levels/regular/33.lvl', mimeType = "application/octet-stream")]  private static var _level_regular_33_:Class;
        [Embed(source = '/../assets/levels/regular/34.lvl', mimeType = "application/octet-stream")]  private static var _level_regular_34_:Class;
        [Embed(source = '/../assets/levels/regular/35.lvl', mimeType = "application/octet-stream")]  private static var _level_regular_35_:Class;
        [Embed(source = '/../assets/levels/regular/36.lvl', mimeType = "application/octet-stream")]  private static var _level_regular_36_:Class;
        [Embed(source = '/../assets/levels/regular/37.lvl', mimeType = "application/octet-stream")]  private static var _level_regular_37_:Class;
        [Embed(source = '/../assets/levels/regular/38.lvl', mimeType = "application/octet-stream")]  private static var _level_regular_38_:Class;
        [Embed(source = '/../assets/levels/regular/39.lvl', mimeType = "application/octet-stream")]  private static var _level_regular_39_:Class;
        [Embed(source = '/../assets/levels/regular/40.lvl', mimeType = "application/octet-stream")]  private static var _level_regular_40_:Class;

        [Embed(source = '/../assets/levels/easy/1.lvl',  mimeType = "application/octet-stream")]  private static var _level_easy_1_:Class;
        [Embed(source = '/../assets/levels/easy/2.lvl',  mimeType = "application/octet-stream")]  private static var _level_easy_2_:Class;
        [Embed(source = '/../assets/levels/easy/3.lvl',  mimeType = "application/octet-stream")]  private static var _level_easy_3_:Class;
        [Embed(source = '/../assets/levels/easy/4.lvl',  mimeType = "application/octet-stream")]  private static var _level_easy_4_:Class;
        [Embed(source = '/../assets/levels/easy/5.lvl',  mimeType = "application/octet-stream")]  private static var _level_easy_5_:Class;
        [Embed(source = '/../assets/levels/easy/6.lvl',  mimeType = "application/octet-stream")]  private static var _level_easy_6_:Class;
        [Embed(source = '/../assets/levels/easy/7.lvl',  mimeType = "application/octet-stream")]  private static var _level_easy_7_:Class;
        [Embed(source = '/../assets/levels/easy/8.lvl',  mimeType = "application/octet-stream")]  private static var _level_easy_8_:Class;
        [Embed(source = '/../assets/levels/easy/9.lvl',  mimeType = "application/octet-stream")]  private static var _level_easy_9_:Class;
        [Embed(source = '/../assets/levels/easy/10.lvl', mimeType = "application/octet-stream")]  private static var _level_easy_10_:Class;
        [Embed(source = '/../assets/levels/easy/11.lvl', mimeType = "application/octet-stream")]  private static var _level_easy_11_:Class;
        [Embed(source = '/../assets/levels/easy/12.lvl', mimeType = "application/octet-stream")]  private static var _level_easy_12_:Class;
        [Embed(source = '/../assets/levels/easy/13.lvl', mimeType = "application/octet-stream")]  private static var _level_easy_13_:Class;
        [Embed(source = '/../assets/levels/easy/14.lvl', mimeType = "application/octet-stream")]  private static var _level_easy_14_:Class;
        [Embed(source = '/../assets/levels/easy/15.lvl', mimeType = "application/octet-stream")]  private static var _level_easy_15_:Class;
        [Embed(source = '/../assets/levels/easy/16.lvl', mimeType = "application/octet-stream")]  private static var _level_easy_16_:Class;
        [Embed(source = '/../assets/levels/easy/17.lvl', mimeType = "application/octet-stream")]  private static var _level_easy_17_:Class;
        [Embed(source = '/../assets/levels/easy/18.lvl', mimeType = "application/octet-stream")]  private static var _level_easy_18_:Class;
        [Embed(source = '/../assets/levels/easy/19.lvl', mimeType = "application/octet-stream")]  private static var _level_easy_19_:Class;
        [Embed(source = '/../assets/levels/easy/20.lvl', mimeType = "application/octet-stream")]  private static var _level_easy_20_:Class;
        [Embed(source = '/../assets/levels/easy/21.lvl', mimeType = "application/octet-stream")]  private static var _level_easy_21_:Class;
        [Embed(source = '/../assets/levels/easy/22.lvl', mimeType = "application/octet-stream")]  private static var _level_easy_22_:Class;
        [Embed(source = '/../assets/levels/easy/23.lvl', mimeType = "application/octet-stream")]  private static var _level_easy_23_:Class;
        [Embed(source = '/../assets/levels/easy/24.lvl', mimeType = "application/octet-stream")]  private static var _level_easy_24_:Class;
        [Embed(source = '/../assets/levels/easy/25.lvl', mimeType = "application/octet-stream")]  private static var _level_easy_25_:Class;
        [Embed(source = '/../assets/levels/easy/26.lvl', mimeType = "application/octet-stream")]  private static var _level_easy_26_:Class;
        [Embed(source = '/../assets/levels/easy/27.lvl', mimeType = "application/octet-stream")]  private static var _level_easy_27_:Class;
        [Embed(source = '/../assets/levels/easy/28.lvl', mimeType = "application/octet-stream")]  private static var _level_easy_28_:Class;
        [Embed(source = '/../assets/levels/easy/29.lvl', mimeType = "application/octet-stream")]  private static var _level_easy_29_:Class;
        [Embed(source = '/../assets/levels/easy/30.lvl', mimeType = "application/octet-stream")]  private static var _level_easy_30_:Class;
        [Embed(source = '/../assets/levels/easy/31.lvl', mimeType = "application/octet-stream")]  private static var _level_easy_31_:Class;
        [Embed(source = '/../assets/levels/easy/32.lvl', mimeType = "application/octet-stream")]  private static var _level_easy_32_:Class;
        [Embed(source = '/../assets/levels/easy/33.lvl', mimeType = "application/octet-stream")]  private static var _level_easy_33_:Class;
        [Embed(source = '/../assets/levels/easy/34.lvl', mimeType = "application/octet-stream")]  private static var _level_easy_34_:Class;
        [Embed(source = '/../assets/levels/easy/35.lvl', mimeType = "application/octet-stream")]  private static var _level_easy_35_:Class;
        [Embed(source = '/../assets/levels/easy/36.lvl', mimeType = "application/octet-stream")]  private static var _level_easy_36_:Class;
        [Embed(source = '/../assets/levels/easy/37.lvl', mimeType = "application/octet-stream")]  private static var _level_easy_37_:Class;
        [Embed(source = '/../assets/levels/easy/38.lvl', mimeType = "application/octet-stream")]  private static var _level_easy_38_:Class;
        [Embed(source = '/../assets/levels/easy/39.lvl', mimeType = "application/octet-stream")]  private static var _level_easy_39_:Class;
        [Embed(source = '/../assets/levels/easy/40.lvl', mimeType = "application/octet-stream")]  private static var _level_easy_40_:Class;

        [Embed(source = '/../assets/levels/hard/1.lvl',  mimeType = "application/octet-stream")]  private static var _level_hard_1_:Class;
        [Embed(source = '/../assets/levels/hard/2.lvl',  mimeType = "application/octet-stream")]  private static var _level_hard_2_:Class;
        [Embed(source = '/../assets/levels/hard/3.lvl',  mimeType = "application/octet-stream")]  private static var _level_hard_3_:Class;
        [Embed(source = '/../assets/levels/hard/4.lvl',  mimeType = "application/octet-stream")]  private static var _level_hard_4_:Class;
        [Embed(source = '/../assets/levels/hard/5.lvl',  mimeType = "application/octet-stream")]  private static var _level_hard_5_:Class;
        [Embed(source = '/../assets/levels/hard/6.lvl',  mimeType = "application/octet-stream")]  private static var _level_hard_6_:Class;
        [Embed(source = '/../assets/levels/hard/7.lvl',  mimeType = "application/octet-stream")]  private static var _level_hard_7_:Class;
        [Embed(source = '/../assets/levels/hard/8.lvl',  mimeType = "application/octet-stream")]  private static var _level_hard_8_:Class;
        [Embed(source = '/../assets/levels/hard/9.lvl',  mimeType = "application/octet-stream")]  private static var _level_hard_9_:Class;
        [Embed(source = '/../assets/levels/hard/10.lvl', mimeType = "application/octet-stream")]  private static var _level_hard_10_:Class;
        [Embed(source = '/../assets/levels/hard/11.lvl', mimeType = "application/octet-stream")]  private static var _level_hard_11_:Class;
        [Embed(source = '/../assets/levels/hard/12.lvl', mimeType = "application/octet-stream")]  private static var _level_hard_12_:Class;
        [Embed(source = '/../assets/levels/hard/13.lvl', mimeType = "application/octet-stream")]  private static var _level_hard_13_:Class;
        [Embed(source = '/../assets/levels/hard/14.lvl', mimeType = "application/octet-stream")]  private static var _level_hard_14_:Class;
        [Embed(source = '/../assets/levels/hard/15.lvl', mimeType = "application/octet-stream")]  private static var _level_hard_15_:Class;
        [Embed(source = '/../assets/levels/hard/16.lvl', mimeType = "application/octet-stream")]  private static var _level_hard_16_:Class;
        [Embed(source = '/../assets/levels/hard/17.lvl', mimeType = "application/octet-stream")]  private static var _level_hard_17_:Class;
        [Embed(source = '/../assets/levels/hard/18.lvl', mimeType = "application/octet-stream")]  private static var _level_hard_18_:Class;
        [Embed(source = '/../assets/levels/hard/19.lvl', mimeType = "application/octet-stream")]  private static var _level_hard_19_:Class;
        [Embed(source = '/../assets/levels/hard/20.lvl', mimeType = "application/octet-stream")]  private static var _level_hard_20_:Class;
        [Embed(source = '/../assets/levels/hard/21.lvl', mimeType = "application/octet-stream")]  private static var _level_hard_21_:Class;
        [Embed(source = '/../assets/levels/hard/22.lvl', mimeType = "application/octet-stream")]  private static var _level_hard_22_:Class;
        [Embed(source = '/../assets/levels/hard/23.lvl', mimeType = "application/octet-stream")]  private static var _level_hard_23_:Class;
        [Embed(source = '/../assets/levels/hard/24.lvl', mimeType = "application/octet-stream")]  private static var _level_hard_24_:Class;
        [Embed(source = '/../assets/levels/hard/25.lvl', mimeType = "application/octet-stream")]  private static var _level_hard_25_:Class;
        [Embed(source = '/../assets/levels/hard/26.lvl', mimeType = "application/octet-stream")]  private static var _level_hard_26_:Class;
        [Embed(source = '/../assets/levels/hard/27.lvl', mimeType = "application/octet-stream")]  private static var _level_hard_27_:Class;
        [Embed(source = '/../assets/levels/hard/28.lvl', mimeType = "application/octet-stream")]  private static var _level_hard_28_:Class;
        [Embed(source = '/../assets/levels/hard/29.lvl', mimeType = "application/octet-stream")]  private static var _level_hard_29_:Class;
        [Embed(source = '/../assets/levels/hard/30.lvl', mimeType = "application/octet-stream")]  private static var _level_hard_30_:Class;
        [Embed(source = '/../assets/levels/hard/31.lvl', mimeType = "application/octet-stream")]  private static var _level_hard_31_:Class;
        [Embed(source = '/../assets/levels/hard/32.lvl', mimeType = "application/octet-stream")]  private static var _level_hard_32_:Class;
        [Embed(source = '/../assets/levels/hard/33.lvl', mimeType = "application/octet-stream")]  private static var _level_hard_33_:Class;
        [Embed(source = '/../assets/levels/hard/34.lvl', mimeType = "application/octet-stream")]  private static var _level_hard_34_:Class;
        [Embed(source = '/../assets/levels/hard/35.lvl', mimeType = "application/octet-stream")]  private static var _level_hard_35_:Class;
        [Embed(source = '/../assets/levels/hard/36.lvl', mimeType = "application/octet-stream")]  private static var _level_hard_36_:Class;
        [Embed(source = '/../assets/levels/hard/37.lvl', mimeType = "application/octet-stream")]  private static var _level_hard_37_:Class;
        [Embed(source = '/../assets/levels/hard/38.lvl', mimeType = "application/octet-stream")]  private static var _level_hard_38_:Class;
        [Embed(source = '/../assets/levels/hard/39.lvl', mimeType = "application/octet-stream")]  private static var _level_hard_39_:Class;
        [Embed(source = '/../assets/levels/hard/40.lvl', mimeType = "application/octet-stream")]  private static var _level_hard_40_:Class;

        public static var levelsMode: String = "regular";

        public static var levelLocked:Boolean = false;

        public static var level:rTileGrid = new rTileGrid(12, 14, 16, 16);

        public static var bases:rGroup = new rGroup();
        public static var paths:rGroup = new rGroup();

        public static var selectedColor:int = -1;

        public static var levelTimeStarted:Number;

        private static var _levels:Dictionary = new Dictionary();
        public static function getLevel(id:uint):ByteArray {
            var dictId: String = levelsMode + ":" + id;
            if (!_levels[dictId])
                _levels[dictId] = new Level['_level_' + levelsMode + "_" + id + '_'];

            ByteArray(_levels[dictId]).position = 0;
            return _levels[dictId];
        }

        public static function startGame():void{
            playLevel(1);
        }

        public static function continueGame(levelID:uint):void{
            playLevel(levelID);
        }

        public static function levelCompleted():void {
            Score.getCompletedArray()[Score.level.get() - 1] = true;
            Score.saveLevels();

            levelLocked   = true;
            selectedColor = -1;

            var newLevel:int = Score.getNextUncompletedLevel();

            if (!rSave.read("outroSeen", false) && newLevel == -1){
                new rEffFadeScreen(1, 0, 0, 2000, gotoOutro);
                new rEffVolumeFade(false, 1800);

            } else {
                if (newLevel == -1) {
                    Score.level.set(Score.getNextLevel());
                } else {
                    Score.level.set(newLevel);
                }
                TWinLevelCompleted.instance.show();
            }
        }

        private static function gotoOutro():void{
            rSound.stopMusic();
            TStateFinish.instance.set();
        }

        private static function playLevel(id:uint):void {
            THud.nowPlayedLevel = id;

            levelTimeStarted = getTimer();

            selectedColor = -1;

            levelLocked = false;

            Score.level.set(id);

            level.clear();
            bases.clear();
            paths.clear();
            TStateGame.instance.defaultGroup.clear();

            Game.gAll .clear();
            Game.lMain.clear();
            Game.lBG  .clear();
            Game.lGame.clear();

            Score.pathsMax.set(0);
            Score.pathsPlaced.set(0);

            THud.instance.hookTo(Game.lGame);

            // @TODO - Hook hud to layer
            //THud.instance.hookTo(Game.lGame);

            // @TODO - Draw BG when starting level
            //Game.lBG.draw(rGfx.getBD(_bg_), 0, 0)

            var lvl:ByteArray = getLevel(id);
            var byte:uint;
            var posX:uint = 0;
            var posY:uint = 0;

            while(lvl.position < lvl.length){
                posX = (lvl.position % S().TILE_GRID_WIDTH) * S().TILE_GRID_TILE_WIDTH;
                posY = (lvl.position / S().TILE_GRID_WIDTH | 0) * S().TILE_GRID_TILE_HEIGHT

                byte = lvl[lvl.position++];

                parse(byte, posX, posY, lvl);

                TTileFloor.drawFloor(posX, posY);
            }

            loadHelp(id);

            //rSound.playMusic(Game.music);
            new rEffFadeScreen(0, 1, 0, 250);

            new TCursor;

            //TEscButton.set();
        }




        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Level Parsing
        // ::::::::::::::::::::::::::::::::::::::::::::::

        private static function loadHelp(levelID:uint):void {
            switch(levelID){
                case(1):
                    new HelpMessage(_("help1", _("key" + Game.keyClear)));
                    return;

                case(2):
                    new HelpMessage(_("help2"));
                    return;

                case(3):
                case(4):
                    new HelpMessage(_("help3"));
                    return;

                case(5):
                    new HelpMessage(_("help4", _("key" + Game.keyClear)));
                    return;

                case(6):
                    new HelpMessage(_("help5", _("key" + Game.keyClear)));
                    return;

                case(10):
                case(11):
                    new HelpMessage(_("help6", _("key" + Game.keyClear)));
                    return;

                case(12):
                case(13):
                    new HelpMessage(_("help7"));
                    return;
            }
        }

        private static function parse(byte:uint, x:uint, y:uint, array:ByteArray):void {
            if (byte > 0 && byte < 10){
                new TBase(x, y, byte - 1);

            } else if (byte == 20){ // Pit
                new TTilePit(x, y);

            } else if (byte >= 10 && byte < 19)
                Score.pathsMax.add(1);
        }




        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Other Functionality
        // ::::::::::::::::::::::::::::::::::::::::::::::

        public static function countBasesByColor(colorGiven:uint):uint{
            var closure:Function = function():Boolean{
                return this.color == colorGiven;
            };

            return bases.countByFunction(closure);
        }

        public static function getFirstBase(colorGiven:uint):TBase{
            var closure:Function = function():Boolean{
                return this.color == colorGiven;
            };

            return bases.getOneByFunction(closure) as TBase;
        }

        public static function getAllByColor(colorGiven:uint):Array{
            var closure:Function = function():Boolean{
                return this.color == colorGiven;
            };

            return bases.getAllByFunction(closure).concat(paths.getAllByFunction(closure));
        }

        public static function clearPaths():void{
            var allPaths:Array = paths.getAll();

            levelTimeStarted = getTimer();

            for each(var path:TPath in allPaths){
                if (path)
                    path.clear();
            }
        }
    }
}