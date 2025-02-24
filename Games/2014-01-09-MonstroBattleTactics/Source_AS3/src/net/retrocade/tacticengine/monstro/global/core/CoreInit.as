
package net.retrocade.tacticengine.monstro.global.core {
    import flash.display.DisplayObjectContainer;
    import flash.display.Stage;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.geom.Rectangle;
	import flash.utils.ByteArray;
	import flash.utils.setTimeout;

    import net.retrocade.random.Random;
    import net.retrocade.random.RandomEngineType;
    import net.retrocade.retrocamel.core.RetrocamelCore;
	import net.retrocade.retrocamel.display.starling.RetrocamelTextureAtlas;
	import net.retrocade.retrocamel.global.RetrocamelEventsQueue;
    import net.retrocade.retrocamel.locale.RetrocamelLocaleParserRetrocadeProperties;

    import net.retrocade.retrocamel.core.RetrocamelStarlingCore;
    import net.retrocade.tacticengine.core.log;

    import starling.core.Starling;
    import starling.textures.Texture;

    public class CoreInit {
        [Embed(source="/../assets/gfx/sheets/gui.png")] public static var _gui_set_class:Class;
        [Embed(source="/../assets/gfx/sheets/gui.json",mimeType="application/octet-stream")] public static var _gui_json_class:Class;
        [Embed(source="/../assets/i18n/en.txt",mimeType="application/octet-stream")] private static var _language_file_en:Class;
        [Embed(source="/../assets/i18n/descriptions.en.txt",mimeType="application/octet-stream")] private static var _language_file_en_descriptions:Class;
        private static var _guiTexture:Texture;
		private static var _guiAtlas:RetrocamelTextureAtlas;
        private static var _isInitialized:Boolean = false;

        public static function init(root:DisplayObjectContainer):void{
            if (_isInitialized){
                return;
            }

            _l("CoreInit.init()");

            _isInitialized = true;

            _l("CoreInit.init() -> MonstroData.init()");
            MonstroData.init();
            _l("CoreInit.init() -> MonstroGameDisplayController.initialize()");
			MonstroGameDisplayController.initialize(root);
            _l("CoreInit.init() -> MonstroEscapeBlocker.initialize()");
			MonstroEscapeBlocker.initialize(root);

            _l("CoreInit.init() -> Setup stage");
			var stage:Stage = root.stage;
            stage.scaleMode = StageScaleMode.NO_SCALE;
            stage.align     = StageAlign.TOP_LEFT;
            stage.frameRate = 60;

            _l("CoreInit.init() -> RetrocamelCore.initFlash()");
            RetrocamelCore.initFlash(stage, root, S(), null);

            _l("CoreInit.init() -> Initializing locale");
            RetrocamelLocaleParserRetrocadeProperties.parse(_language_file_en, "en");
            RetrocamelLocaleParserRetrocadeProperties.parse(_language_file_en_descriptions, "en");
            RetrocamelEventsQueue.autoClear = false;

            _l("CoreInit.init() -> Apply settings");
			MonstroData.applySettings();

            _l("CoreInit.init() -> Initialize randoms");
            Random.defaultEngine.randomizeSeed();
            Random.defaultEngineType = RandomEngineType.KISS;

            _l("CoreInit.init() -> Initialize starling");
            Starling.handleLostContext = true;
            setTimeout(RetrocamelStarlingCore.initialize, 1000, MonstroRoot, stage, new Rectangle(0, 0, S().gameWidth, S().gameHeight));
        }

        public static function get guiTexture():Texture{
			initGuiTextureAtlas();

            return _guiTexture;
        }

        public static function get guiTextureAtlas():RetrocamelTextureAtlas{
			initGuiTextureAtlas();

            return _guiAtlas;
        }

		private static function initGuiTextureAtlas():void{
			if (_guiTexture){
				return;
			}

			_guiTexture = Texture.fromBitmap(new _gui_set_class, false);
			_guiAtlas = new RetrocamelTextureAtlas(_guiTexture);

			var jsonByteArray:ByteArray = new _gui_json_class;
			var jsonString:String = jsonByteArray.readUTFBytes(jsonByteArray.length);
			_guiAtlas.parseAtlasJson(JSON.parse(jsonString));
		}
    }
}
