package game.global{
    import flash.display.BitmapData;
    import flash.events.Event;
    import flash.events.KeyboardEvent;
    import flash.media.Sound;
    import flash.utils.ByteArray;
    import flash.utils.Dictionary;

    import game.states.TStateFinish;
    import game.states.TStateTitle;
    import game.windows.TWinFocusPause;

    import net.retrocade.camel.core.rCore;
    import net.retrocade.camel.core.rGfx;
    import net.retrocade.camel.core.rGroup;
    import net.retrocade.camel.core.rInput;
    import net.retrocade.camel.core.rSave;
    import net.retrocade.camel.core.rSound;
    import net.retrocade.camel.engines.tilegrid.rTileGrid;
    import net.retrocade.camel.layers.rLayerBlit;
    import net.retrocade.camel.layers.rLayerSprite;
    import net.retrocade.camel.particles.rParticleFireworks;
    import net.retrocade.camel.particles.rParticlePixel;
    import net.retrocade.camel.core.rLang;
    import net.retrocade.standalone.BitextFont;
    import net.retrocade.standalone.Grid9;
    import net.retrocade.utils.Key;

    public class Game {
        [Embed(source="/../assets/gfx/by_cage/tiles/path_white.png")]  public static var _gfx_0:Class;
        [Embed(source="/../assets/gfx/by_cage/tiles/path_red.png")]    public static var _gfx_1:Class;
        [Embed(source="/../assets/gfx/by_cage/tiles/path_orange.png")] public static var _gfx_2:Class;
        [Embed(source="/../assets/gfx/by_cage/tiles/path_yellow.png")] public static var _gfx_3:Class;
        [Embed(source="/../assets/gfx/by_cage/tiles/path_green.png")]  public static var _gfx_4:Class;
        [Embed(source="/../assets/gfx/by_cage/tiles/path_cyan.png")]   public static var _gfx_5:Class;
        [Embed(source="/../assets/gfx/by_cage/tiles/path_blue.png")]   public static var _gfx_6:Class;
        [Embed(source="/../assets/gfx/by_cage/tiles/path_violet.png")] public static var _gfx_7:Class;
        [Embed(source="/../assets/gfx/by_cage/tiles/path_black.png")]  public static var _gfx_8:Class;

        [Embed(source="/../assets/gfx/by_cage/tiles/path_white_cb.png")]  public static var _gfx_cb0:Class;
        [Embed(source="/../assets/gfx/by_cage/tiles/path_red_cb.png")]    public static var _gfx_cb1:Class;
        [Embed(source="/../assets/gfx/by_cage/tiles/path_orange_cb.png")] public static var _gfx_cb2:Class;
        [Embed(source="/../assets/gfx/by_cage/tiles/path_yellow_cb.png")] public static var _gfx_cb3:Class;
        [Embed(source="/../assets/gfx/by_cage/tiles/path_green_cb.png")]  public static var _gfx_cb4:Class;
        [Embed(source="/../assets/gfx/by_cage/tiles/path_cyan_cb.png")]   public static var _gfx_cb5:Class;
        [Embed(source="/../assets/gfx/by_cage/tiles/path_blue_cb.png")]   public static var _gfx_cb6:Class;
        [Embed(source="/../assets/gfx/by_cage/tiles/path_violet_cb.png")] public static var _gfx_cb7:Class;
        [Embed(source="/../assets/gfx/by_cage/tiles/path_black_cb.png")]  public static var _gfx_cb8:Class;

        [Embed(source="/../assets/music/usteczka/usteczka_by_Ojciec.mp3")]  public static var _music_title_ :Class;
        [Embed(source="/../assets/music/biesiada/biesiada_by_Lesnik.mp3")] public static var _music_ending_:Class;
        [Embed(source="/../assets/music/toiletstory4u/toilet4_by_Ghidorah.mp3")]  public static var _music_tune_1_:Class;
        [Embed(source="/../assets/music/xp1002/xp1002_by_Macherman.mp3")]  public static var _music_tune_2_:Class;
        [Embed(source="/../assets/music/tremendous/_tremendous_by_Opal.mp3")]  public static var _music_tune_3_:Class;


        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Game Variables
        // ::::::::::::::::::::::::::::::::::::::::::::::

        public static var lMain:rLayerSprite;
        public static var lGame:rLayerBlit;
        public static var lBG:rLayerBlit;

        public static var lFireworks:rLayerBlit;
        public static var lPixels:rLayerBlit;
        public static var partFireworks:rParticleFireworks;
        public static var partPixels:rParticlePixel;

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
            keyClear      = rSave.read('optkeyClear',      Key.SPACE);
            keySound      = rSave.read('optkeySound',      Key.S);
            keyMusic      = rSave.read('optkeyMusic',      Key.M);

            Score.loadLevels();

            Game.lBG   = new rLayerBlit();
            Game.lGame = new rLayerBlit();
            Game.lMain = new rLayerSprite();
            Game.lFireworks = new rLayerBlit();
            Game.lPixels    = new  rLayerBlit();

            Game.partFireworks = new rParticleFireworks(Game.lFireworks, 500, 5);
            Game.partPixels    = new rParticlePixel(Game.lPixels, 500)

            Game.lBG       .setScale(2, 2);
            Game.lGame     .setScale(2, 2);
            Game.lFireworks.setScale(2, 2);
            Game.lPixels   .setScale(2, 2);

            rCore.setState(TStateTitle.instance);

            //TWinFocusPause.hook();

            rInput.addStageKeyDown(onKeyDown);
        }



        private static var oldSoundVolume:Number = 1;
        private static var oldMusicVolume:Number = 1;
        public static var disableQuickSFXToggle:Boolean = false;

        private static function onKeyDown(e:KeyboardEvent):void{
            if (disableQuickSFXToggle)
                return;

            if (e.keyCode == Game.keySound){
                if (rSound.soundVolume == 0)
                    rSound.soundVolume = oldSoundVolume;
                else {
                    oldSoundVolume = rSound.soundVolume;
                    rSound.soundVolume = 0;
                }

                rSave.write('optVolumeSound', rSound.soundVolume);
            } else if (e.keyCode == Game.keyMusic){
                if (rSound.musicVolume == 0)
                    rSound.musicVolume = oldMusicVolume;
                else {
                    oldMusicVolume = rSound.musicVolume;
                    rSound.musicVolume = 0;
                }

                rSave.write('optVolumeMusic', rSound.musicVolume);
            }
        }
    }
}