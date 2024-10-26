package game.global{
    import flash.events.Event;
    import flash.events.KeyboardEvent;
    import flash.media.Sound;
    import flash.utils.ByteArray;

    import game.states.TStateGame;
    import game.states.TStateTitle;
    import game.windows.TWinFocusPause;
    import game.objects.TClone
    import game.objects.TPlayer
    import game.tiles.TExit
    import game.tiles.TGrowingWall
    import game.tiles.TRotationWall
    import net.retrocade.camel.core.rCore;
    import net.retrocade.camel.core.rGroup;
    import net.retrocade.camel.core.rInput;
    import net.retrocade.camel.core.rSave;
    import net.retrocade.camel.core.rSound;
    import net.retrocade.camel.engines.tilegrid.rTileGrid;
    import net.retrocade.camel.layers.rLayerBlit;
    import net.retrocade.camel.layers.rLayerSprite;
    import net.retrocade.camel.particles.rParticlePixel;
    import net.retrocade.camel.rCollide;
    import net.retrocade.camel.core.rLang;
    import net.retrocade.standalone.Grid9;
    import net.retrocade.utils.Key;

    public class Game {
        [Embed(source = '/../assets/music/music4.mp3')] private static var _music1_:Class;
        [Embed(source = '/../assets/music/music1.mp3')] private static var _music3_:Class;
        [Embed(source = '/../assets/music/musicTitle.mp3')] private static var _music2_:Class;

        [Embed(source="/../assets/gfx/general_blob.png")] public static var _general_blob_:Class;
        [Embed(source="/../assets/gfx/general_casual.png")] public static var _general_casual_:Class;
        [Embed(source="/../assets/gfx/general_cpu.png")] public static var _general_cpu_:Class;
        [Embed(source="/../assets/gfx/general_inka.png")] public static var _general_inka_:Class;
        [Embed(source="/../assets/gfx/general_medieval.png")] public static var _general_medieval_:Class;
        [Embed(source="/../assets/gfx/general_moon.png")] public static var _general_moon_:Class;

        public static function get generalGfxClass(): Class {
            return Game['_general_' + gameMode + '_'];
        }

        private static var _gameMode:String = 'casual';

        public static function get gameMode(): String {
            return _gameMode;
        }

        public static function set gameMode(value: String): void {
            if (['blob', 'casual', 'cpu', 'inka', 'medieval', 'moon'].indexOf(value) === -1) {
                value = 'casual';
            }

            if (value !== _gameMode) {
                _gameMode = value;
                refreshAllGfx();
            }
        }

        public static function refreshAllGfx(): void {
            TClone.refreshGfx() ;
            TPlayer.refreshGfx() ;
            TExit.refreshGfx() ;
            TGrowingWall.refreshGfx() ;
            TRotationWall.refreshGfx() ;
        }

        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Game Variables
        // ::::::::::::::::::::::::::::::::::::::::::::::

        public static var lMain:rLayerSprite;
        public static var lBG  :rLayerBlit;
        public static var lGame:rLayerBlit;
        public static var lPart:rLayerBlit

        public static var gAll :rGroup = new rGroup();

        public static var partPixel:rParticlePixel;

        private static var musics:Array;
        private static var musicTitleInstance:Sound;

        public static function get music():Sound{
            if (!musics){
                musics = [];
                musics[0] = new _music1_;
                musics[1] = new _music3_;
            }

            return musics[musics.length * Math.random() | 0];
        }

        public static function get musicTitle():Sound{
            if (!musicTitleInstance)
                musicTitleInstance = new _music2_;

            return musicTitleInstance;
        }



        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Keys
        // ::::::::::::::::::::::::::::::::::::::::::::::

        public static var keyLeft      :uint;
        public static var keyRight     :uint;
        public static var keyUp        :uint;
        public static var keyDown      :uint;
        public static var keySound     :uint;
        public static var keyMusic     :uint;

        public static var allKeys:Array = ['keyLeft', 'keyRight', 'keySound', 'keyUp', 'keyDown', 'keyMusic'];



        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Init
        // ::::::::::::::::::::::::::::::::::::::::::::::

        public static function init():void{
            keyLeft       = rSave.read('optkeyLeft',       Key.LEFT);
            keyRight      = rSave.read('optkeyRight',      Key.RIGHT);
            keyUp         = rSave.read('optkeyUp',         Key.UP);
            keyDown       = rSave.read('optkeyDown',       Key.DOWN);
            keySound      = rSave.read('optkeySound',      Key.S);
            keyMusic      = rSave.read('optkeyMusic',      Key.M);

            Game.lBG   = new rLayerBlit();
            Game.lGame = new rLayerBlit();
            Game.lPart = new rLayerBlit();
            Game.lMain = new rLayerSprite();

            Game.partPixel = new rParticlePixel(Game.lPart, 1000);
            TStateTitle.instance.set();

            TWinFocusPause.hook();

            rInput.addStageKeyDown(onKeyDown);

            rCollide.initBitmapCollision(48, 48);

            refreshAllGfx();

            new rDebug();
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