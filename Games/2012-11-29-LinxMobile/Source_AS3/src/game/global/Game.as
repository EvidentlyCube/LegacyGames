package game.global{
    import flash.display.Bitmap;
    import flash.events.KeyboardEvent;
    import flash.filters.DropShadowFilter;
    import flash.media.Sound;
    import flash.utils.Dictionary;

    import game.states.TStateSplashRetrocade;
    import game.states.TStateSplashInfo;

    import net.retrocade.camel.engines.tilegrid.rTileGrid;
    import net.retrocade.camel.global.rCore;
    import net.retrocade.camel.global.rDisplay;
    import net.retrocade.camel.global.rGfx;
    import net.retrocade.camel.global.rGroup;
    import net.retrocade.camel.global.rInput;
    import net.retrocade.camel.global.rSave;
    import net.retrocade.camel.global.rSfx;
    import net.retrocade.camel.layers.rLayerBlit;
    import net.retrocade.camel.layers.rLayerSprite;
    import net.retrocade.camel.layers.rLayerStarling;
    import net.retrocade.utils.UDisplay;

    import starling.display.Image;
    import starling.events.Event;

    public class Game {
        [Embed(source="/../assets/gfx/by_cage/bgs/background.png")] public static var _background:Class;
        [Embed(source="/../assets/gfx/by_cage/bgs/bg_title.png")]   public static var _background_title:Class;

        [Embed(source="/../assets/music/usteczka/usteczka_by_Ojciec.mp3")]  public static var _music_title_ :Class;
        [Embed(source="/../assets/music/biesiada/biesiada_by_Lesnik.mp3")] public static var _music_ending_:Class;
        [Embed(source="/../assets/music/toiletstory4u/toilet4_by_Ghidorah.mp3")]  public static var _music_tune_1_:Class;
        [Embed(source="/../assets/music/xp1002/xp1002_by_Macherman.mp3")]  public static var _music_tune_2_:Class;
        [Embed(source="/../assets/music/tremendous/_tremendous_by_Opal.mp3")]  public static var _music_tune_3_:Class;

        [Embed(source="/../assets/gfx/by_cage/ui/icon4_big.png")]  public static var _button_back:Class;
        [Embed(source="/../assets/gfx/by_cage/ui/icon6_big.png")]  public static var _button_undo:Class;
        [Embed(source="/../assets/gfx/by_cage/ui/icon2a_big.png")] public static var _button_restart:Class;
        [Embed(source="/../assets/gfx/by_cage/ui/icon2b_big.png")] public static var _button_restart_confirm:Class;
        [Embed(source="/../assets/gfx/by_cage/ui/icon3a_big.png")] public static var _button_not_cblind:Class;
        [Embed(source="/../assets/gfx/by_cage/ui/icon3b_big.png")] public static var _button_cblind:Class;


        public static const FILTER_SHADOW:Array = [ new DropShadowFilter() ];

        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Game Variables
        // ::::::::::::::::::::::::::::::::::::::::::::::

        public static var lMain:rLayerSprite;
        public static var lGame:rLayerBlit;
        public static var lBG:rLayerStarling;
        public static var lStarling:rLayerStarling;
        public static var lMinimap:rLayerStarling;
        public static var lHud:rLayerStarling;

        public static var background:Image;

        public static function onStageResized(e:* = null):void{
            UDisplay.calculateScale(
                background.width / background.scaleX,
                background.height / background.scaleX,
                S().gameWidth,
                S().gameHeight,
                UDisplay.NO_BORDER
            )
            ;
            background.scaleX = UDisplay.lastScaleX;
            background.scaleY = UDisplay.lastScaleY;

            background.x = (S().gameWidth - background.width) / 2;
            background.y = (S().gameHeight - background.height) / 2;
        }

        public static var gAll :rGroup = new rGroup();
        private static var musics:Dictionary;
        public static function getMusic(cls:Class):Sound{
            if (!musics){
                musics = new Dictionary();
                musics[_music_title_] = new _music_title_;
                musics[_music_ending_] = new _music_ending_;
                musics[_music_tune_1_] = new _music_tune_1_;
                musics[_music_tune_2_] = new _music_tune_2_;
                musics[_music_tune_3_] = new _music_tune_3_;
            }

            return musics[cls];
        }


        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Keys
        // ::::::::::::::::::::::::::::::::::::::::::::::

        public static var keyClear     :uint;
        public static var keySound     :uint;
        public static var keyMusic     :uint;

        public static var allKeys:Array = ['keyClear', 'keySound', 'keyMusic'];





        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Init
        // ::::::::::::::::::::::::::::::::::::::::::::::

        public static function init():void{
            rSfx.musicVolume = rSave.read('musicVolume', 1);
            rSfx.soundVolume = rSave.read('soundVolume', 1);
            Pre.colorBlind     = rSave.read('colorBlind', false);

            Score.loadLevels();

            Game.lGame = new rLayerBlit(S().tileWidth * S().tileGridWidth, S().tileWidth * S().tileGridWidth);
            Game.lMain = new rLayerSprite();

            Bitmap(Game.lGame.displayObject).smoothing = true;

            Level.level = new rTileGrid(S().tileGridWidth, S().tileGridHeight, S().tileWidth, S().tileHeight);

            //rCore.setState(TStateTitle.instance);
            // rCore.setState(new TStateSplashRetrocade);
            rCore.setState(new TStateSplashInfo);

            rInput.addStageKeyDown(onKeyDown);

            //rDisplay.setBackgroundImageBitmap(rGfx.getB(_background));
        }



        private static var oldSoundVolume:Number = 1;
        private static var oldMusicVolume:Number = 1;
        public static var disableQuickSFXToggle:Boolean = false;

        private static function onKeyDown(e:KeyboardEvent):void{
            if (disableQuickSFXToggle)
                return;

            if (e.keyCode == Game.keySound){
                if (rSfx.soundVolume == 0)
                    rSfx.soundVolume = oldSoundVolume;
                else {
                    oldSoundVolume = rSfx.soundVolume;
                    rSfx.soundVolume = 0;
                }

                rSave.write('optVolumeSound', rSfx.soundVolume);
            } else if (e.keyCode == Game.keyMusic){
                if (rSfx.musicVolume == 0)
                    rSfx.musicVolume = oldMusicVolume;
                else {
                    oldMusicVolume = rSfx.musicVolume;
                    rSfx.musicVolume = 0;
                }

                rSave.write('optVolumeMusic', rSfx.musicVolume);
            }
        }
    }
}