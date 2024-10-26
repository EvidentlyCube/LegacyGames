package game.global{
    import flash.events.Event;
    import flash.events.KeyboardEvent;
    import flash.events.MouseEvent;
    import flash.geom.Point;
    import flash.media.Sound;
    import flash.net.FileReference;
    import flash.system.System;
    import flash.utils.ByteArray;
    import game.states.TStateGame;
    import game.widgets.TWidgetVolumeMuter;

    CF::play{
        import game.objects.actives.TPlayer;
        import game.states.TStateGame;
        import game.states.TStateRestore;
        import game.states.TStateTest;
        import game.states.TStateTitle;
        import game.states.TStateInitialize;
        import game.states.TStateOutro;
        import game.windows.TWindowMessage;
    }

    import net.retrocade.camel.core.rCore;
    import net.retrocade.camel.core.rDisplay;
    import net.retrocade.camel.core.rGroup;
    import net.retrocade.camel.core.rInput;
    import net.retrocade.camel.core.rSave;
    import net.retrocade.camel.core.rSound;
    import net.retrocade.camel.engines.tilegrid.rTileGrid;
    import net.retrocade.camel.layers.rLayerBlit;
    import net.retrocade.camel.layers.rLayerSprite;
    import net.retrocade.camel.particles.rParticlePixel;
    import net.retrocade.camel.rLang;
    import net.retrocade.standalone.BitextFont;
    import net.retrocade.standalone.Colorizer;
    import net.retrocade.standalone.Grid9;
    import net.retrocade.utils.Key;
    import net.retrocade.utils.UByteArray;

    public class Core {

        CF::play {
            CF::holdKdd1{
                [Embed(source = "/../assets/levels/kdd1.hold", mimeType = "application/octet-stream")]
                public static var _hold_:Class;
            }
            CF::holdKdd2{
                [Embed(source = "/../assets/levels/kdd2.hold", mimeType = "application/octet-stream")]
                public static var _hold_:Class;
            }
            CF::holdKdd3{
                [Embed(source = "/../assets/levels/kdd3.hold", mimeType = "application/octet-stream")]
                public static var _hold_:Class;
            }
        }



        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Game Variables
        // ::::::::::::::::::::::::::::::::::::::::::::::

        public static var lMain:rLayerSprite;



        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Keys
        // ::::::::::::::::::::::::::::::::::::::::::::::

        public static var keyUp        :uint = Key.NUMBER_8;
        public static var keyUpRight   :uint = Key.NUMBER_9
        public static var keyRight     :uint = Key.O
        public static var keyDownRight :uint = Key.L
        public static var keyDown      :uint = Key.K
        public static var keyDownLeft  :uint = Key.J
        public static var keyLeft      :uint = Key.U
        public static var keyUpLeft    :uint = Key.NUMBER_7
        public static var keyWait      :uint = Key.I
        public static var keyRestart   :uint = Key.R;
        public static var keyUndo      :uint = Key.BACKSPACE;
        public static var keyBattle    :uint = Key.EQUAL;

        public static var keyCW        :uint = Key.W;
        public static var keyCCW       :uint = Key.Q;

        public static var keyLock      :uint = Key.X;

        public static var volumeEffects:Number = 1;
        public static var volumeVoices :Number = 1;
        public static var volumeMusic  :Number = 1;
        public static var repeatRate   :Number = 1;

        public static function getKey(name:String):uint {
            return Core[name];
        }

        public static function setKey(name:String, value:uint):void {
            Core[name] = value;
        }

        public static function saveKeys():void {
			rSave.setStorage(S.SAVE_OPTIONS_STORAGE);
            rSave.save("keyUpLeft",     keyUpLeft);
            rSave.save("keyUp",         keyUp);
            rSave.save("keyUpRight",    keyUpRight);
            rSave.save("keyLeft",       keyLeft);
            rSave.save("keyWait",       keyWait);
            rSave.save("keyRight",      keyRight);
            rSave.save("keyDownLeft",   keyDownLeft);
            rSave.save("keyDown",       keyDown);
            rSave.save("keyDownRight",  keyDownRight);
            rSave.save("keyCW",         keyCW);
            rSave.save("keyCCW",        keyCCW);
            rSave.save("keyUndo",       keyUndo);
            rSave.save("keyRestart",    keyRestart);
            rSave.save("keyBattle",     keyBattle);
            rSave.save("keyLock",       keyLock);

            rSave.flush(C.SETTINGS_SAVE_SIZE);
			rSave.setStorage(S.SAVE_STORAGE_NAME);
        }

        public static function loadKeys():void {
			rSave.setStorage(S.SAVE_OPTIONS_STORAGE);
            keyUpLeft       = rSave.load("keyUpLeft",    Key.NUMBER_7);
            keyUp           = rSave.load("keyUp",        Key.NUMBER_8);
            keyUpRight      = rSave.load("keyUpRight",   Key.NUMBER_9);
            keyLeft         = rSave.load("keyLeft",      Key.U);
            keyWait         = rSave.load("keyWait",      Key.I);
            keyRight        = rSave.load("keyRight",     Key.O);
            keyDownLeft     = rSave.load("keyDownLeft",  Key.J);
            keyDown         = rSave.load("keyDown",      Key.K);
            keyDownRight    = rSave.load("keyDownRight", Key.L);
            keyCW           = rSave.load("keyCW",        Key.W);
            keyCCW          = rSave.load("keyCCW",       Key.Q);
            keyUndo         = rSave.load("keyUndo",      Key.BACKSPACE);
            keyRestart      = rSave.load("keyRestart",   Key.R);
            keyBattle       = rSave.load("keyBattle",    Key.EQUAL);
            keyLock         = rSave.load("keyLock",      Key.X);
			rSave.setStorage(S.SAVE_STORAGE_NAME);
        }


        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Init
        // ::::::::::::::::::::::::::::::::::::::::::::::

        public static function init():void{
            // http://forum.caravelgames.com/flash/data.json

            /*

            Current version fixes:
			- [url=][/url]
            - [url=][/url]
            - [url=][/url]


            - [b]Editor: [/b]Updated the .SWF file in the package
            */

            CF::play{
                TStateGame.effectLayer = new DrodLayer(S.SIZE_SWF_WIDTH, S.SIZE_SWF_HEIGHT, 0, 0);
                Core.lMain             = new rLayerSprite();

                TStateGame.effectLayer.offsetX = S.LEVEL_OFFSET_X;
                TStateGame.effectLayer.offsetY = S.LEVEL_OFFSET_Y;

                unpackHold();

                new TStateInitialize();

                rCore.fpsSteadifier = false;

				rSave.setStorage(S.SAVE_OPTIONS_STORAGE);
                volumeEffects = rSave.read(C.SETTING_VOLUME_EFFECTS, 0.6);
                volumeVoices  = rSave.read(C.SETTING_VOLUME_VOICES,  1);
                volumeMusic   = rSave.read(C.SETTING_VOLUME_MUSIC,   0.8);
                repeatRate    = rSave.read(C.SETTING_REPEAT,         0);
				rSave.setStorage(S.SAVE_STORAGE_NAME);

                loadKeys();

                TStateGame.offsetSpeed = repeatRate * 12;

                CF::debug {
                    rCore.errorCallback = onErrorCallback;
                }

                TWidgetVolumeMuter.init();
            }
        }

        CF::play
        private static function unpackHold():void {
            var byteArray   :ByteArray;

            byteArray = new _hold_;


            // Decompress

            var i:uint = byteArray.length;
            while(i--)
                byteArray[i] = byteArray[i] ^ 0xFF;

            byteArray.uncompress();

            Level.prepareHold(new XML(byteArray.readUTFBytes(byteArray.length)));
        }

        CF::lib
        public static function unpackHold(hold:ByteArray):void {
            var byteArray   :ByteArray = hold;

            // Decompress

            var i:uint = byteArray.length;
            while(i--)
                byteArray[i] = byteArray[i] ^ 0xFF;

            byteArray.uncompress();

            Level.prepareHold(new XML(byteArray.readUTFBytes(byteArray.length)));
        }

        CF::play{
            CF::debug
            private static function onErrorCallback(e:Error):void {
                var window:String = "A critical error: \n\n" + e.errorID + ": " + e.message + "\n" + e.getStackTrace();

                TWindowMessage.show(window, 400, true);
            }
        }
    }

}