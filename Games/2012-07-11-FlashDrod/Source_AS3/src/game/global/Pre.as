package game.global{
    import flash.events.ContextMenuEvent;
    import flash.events.IOErrorEvent;
	import flash.net.LocalConnection;
    import flash.net.navigateToURL;
    import flash.net.URLLoader;
    import flash.net.URLLoaderDataFormat;
    import flash.net.URLRequest;
    import flash.ui.ContextMenu;
    import flash.ui.ContextMenuItem;
    import flash.utils.ByteArray;

    import net.retrocade.camel.core.rDisplay;
    import net.retrocade.camel.core.rGfx;
    import net.retrocade.camel.core.rSave;
    import net.retrocade.camel.core.rSound;
    import net.retrocade.camel.core.rTooltip;
    import net.retrocade.camel.rLang;
    import net.retrocade.standalone.BitextFont;
    import net.retrocade.standalone.Grid9;
    import net.retrocade.standalone.QuickURLLoader;

    public class Pre {
        CF::holdKdd1{
            [Embed(source = '/../assets/languages/en.kdd1.txt', mimeType = 'application/octet-stream')] private static var _lang_en:Class;
            [Embed(source = '/../assets/languages/nl.kdd1.txt', mimeType = 'application/octet-stream')] private static var _lang_nl:Class;
            [Embed(source = '/../assets/languages/de.kdd1.txt', mimeType = 'application/octet-stream')] private static var _lang_de:Class;
            [Embed(source = '/../assets/languages/fi.kdd1.txt', mimeType = 'application/octet-stream')] private static var _lang_fi:Class;
			[Embed(source = '/../assets/languages/es.kdd1.txt', mimeType = 'application/octet-stream')] private static var _lang_es:Class;
			[Embed(source = '/../assets/languages/pt.kdd1.txt', mimeType = 'application/octet-stream')] private static var _lang_pt:Class;
			[Embed(source = '/../assets/languages/fr.kdd1.txt', mimeType = 'application/octet-stream')] private static var _lang_fr:Class;
        }

        CF::holdKdd2{
            [Embed(source = '/../assets/languages/en.kdd2.txt', mimeType = 'application/octet-stream')] private static var _lang_en:Class;
            [Embed(source = '/../assets/languages/nl.kdd2.txt', mimeType = 'application/octet-stream')] private static var _lang_nl:Class;
            [Embed(source = '/../assets/languages/de.kdd2.txt', mimeType = 'application/octet-stream')] private static var _lang_de:Class;
            [Embed(source = '/../assets/languages/fi.kdd2.txt', mimeType = 'application/octet-stream')] private static var _lang_fi:Class;
			[Embed(source = '/../assets/languages/es.kdd2.txt', mimeType = 'application/octet-stream')] private static var _lang_es:Class;
			[Embed(source = '/../assets/languages/pt.kdd2.txt', mimeType = 'application/octet-stream')] private static var _lang_pt:Class;
			[Embed(source = '/../assets/languages/fr.kdd2.txt', mimeType = 'application/octet-stream')] private static var _lang_fr:Class;
        }

        CF::holdKdd3{
            [Embed(source = '/../assets/languages/en.kdd3.txt', mimeType = 'application/octet-stream')] private static var _lang_en:Class;
            [Embed(source = '/../assets/languages/nl.kdd3.txt', mimeType = 'application/octet-stream')] private static var _lang_nl:Class;
            [Embed(source = '/../assets/languages/de.kdd3.txt', mimeType = 'application/octet-stream')] private static var _lang_de:Class;
            [Embed(source = '/../assets/languages/fi.kdd3.txt', mimeType = 'application/octet-stream')] private static var _lang_fi:Class;
            [Embed(source = '/../assets/languages/es.kdd3.txt', mimeType = 'application/octet-stream')] private static var _lang_es:Class;
            [Embed(source = '/../assets/languages/pt.kdd3.txt', mimeType = 'application/octet-stream')] private static var _lang_pt:Class;
            [Embed(source = '/../assets/languages/fr.kdd3.txt', mimeType = 'application/octet-stream')] private static var _lang_fr:Class;
        }

        [Embed(source = '/../assets/languages/en.txt', mimeType = 'application/octet-stream')] private static var _lang_en_global:Class;
        [Embed(source = '/../assets/languages/nl.txt', mimeType = 'application/octet-stream')] private static var _lang_nl_global:Class;
        [Embed(source = '/../assets/languages/de.txt', mimeType = 'application/octet-stream')] private static var _lang_de_global:Class;
        [Embed(source = '/../assets/languages/fi.txt', mimeType = 'application/octet-stream')] private static var _lang_fi_global:Class;
		[Embed(source = '/../assets/languages/es.txt', mimeType = 'application/octet-stream')] private static var _lang_es_global:Class;
		[Embed(source = '/../assets/languages/pt.txt', mimeType = 'application/octet-stream')] private static var _lang_pt_global:Class;
		[Embed(source = '/../assets/languages/fr.txt', mimeType = 'application/octet-stream')] private static var _lang_fr_global:Class;

        [Embed(source = '/../assets/gfx/ui/buttonSystem.jpg')]     private static var _buttonBgSystem_:Class;
        [Embed(source = '/../assets/gfx/ui/buttonSystemDown.jpg')] private static var _buttonDownBgSystem_:Class;
        [Embed(source = '/../assets/gfx/ui/windowSystem.jpg')]     private static var _windowBgSystem_:Class;
        [Embed(source = '/../assets/gfx/ui/tooltipSystem.jpg')]    private static var _tooltipBgSystem:Class;
        [Embed(source = '/../assets/gfx/ui/TextInput.jpg')]        private static var _inputBgSystem:Class;

        [Embed(source = "/../assets/fonts/tomsnewroman/toms_new_roman.ttf", fontFamily = "tomNewRoman", embedAsCFF="false")] private static var _font:Class;

        public static function init():void{
            loadLanguages();
            loadGrid();
            loadOptions();

            rTooltip.setPadding(0, 3, 3, 3);
            rTooltip.setBackground(Grid9.getGrid("tooltip", true));
            rTooltip.useFontText(C.FONT_FAMILY);
            rTooltip.setColor(0);
            rTooltip.setShadow(45, 4, 5, 1, 0.5, 0);

            makeContextMenu();
        }

        private static function loadOptions():void {
			rSave.setStorage(S.SAVE_OPTIONS_STORAGE);
            rSound.musicVolume = rSave.read('optVolumeMusic', 1.0);
            rSound.soundVolume = rSave.read('optVolumeSound', 1.0);
			rSave.setStorage(S.SAVE_STORAGE_NAME);
        }

        private static function loadGrid():void{
            Grid9.make('button',     rGfx.getBD(_buttonBgSystem_), 2, 2, 146, 28);
            Grid9.make('buttonDown', rGfx.getBD(_buttonDownBgSystem_), 2, 2, 146, 28);
            Grid9.make('window',     rGfx.getBD(_windowBgSystem_), 7, 7, 286, 286);
            Grid9.make('tooltip',    rGfx.getBD(_tooltipBgSystem), 8, 8, 66, 66);
            Grid9.make('textInput',  rGfx.getBD(_inputBgSystem), 2, 2, 146, 146);
        }

        private static function loadLanguages():void {
            rLang.loadLanguageFile(_lang_de_global, 'de');
            rLang.loadLanguageFile(_lang_en_global, 'en');
            rLang.loadLanguageFile(_lang_nl_global, 'nl');
            rLang.loadLanguageFile(_lang_fi_global, 'fi');
			rLang.loadLanguageFile(_lang_es_global, 'es');
			rLang.loadLanguageFile(_lang_pt_global, 'pt');
			rLang.loadLanguageFile(_lang_fr_global, 'fr');
            rLang.loadLanguageFile(_lang_de,        'de');
            rLang.loadLanguageFile(_lang_en,        'en');
            rLang.loadLanguageFile(_lang_nl,        'nl');
            rLang.loadLanguageFile(_lang_fi,        'fi');
			rLang.loadLanguageFile(_lang_es,        'es');
			rLang.loadLanguageFile(_lang_pt,        'pt');
			rLang.loadLanguageFile(_lang_fr,        'fr');

            var checkLang:* = function(header:String, left: String, right: String): void {
                var result:Array = rLang.checkLangAgainstLang(left, right);

                if (result.length > 0) {
			        trace("Missing "+header+":\n " + result.join("\n"));
                }
            }
			checkLang("DE", "en", "de");
			checkLang("NL", "en", "nl");
			checkLang("FI", "en", "fi");
			checkLang("ES", "en", "es");
			checkLang("PT", "en", "pt");
			checkLang("FR", "en", "fr");
			checkLang("EN DE", "de", "en");
			checkLang("EN NL", "nl", "en");
			checkLang("EN FI", "fi", "en");
			checkLang("EN ES", "es", "en");
			checkLang("EN PT", "pt", "en");
			checkLang("EN FR", "fr", "en");

			rSave.setStorage(S.SAVE_OPTIONS_STORAGE);
			rLang.selected = rSave.read("lang", rLang.defaultLanguage);
			rSave.setStorage(S.SAVE_STORAGE_NAME);
        }

        private static function makeContextMenu():void {
            var menu:ContextMenu = new ContextMenu();
            menu.hideBuiltInItems();

            var itemCaravel:ContextMenuItem = new ContextMenuItem("Caravelgames.com");
            var itemRetro  :ContextMenuItem = new ContextMenuItem("Retrocade.net");

            itemCaravel.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, onContextCaravel);
            itemRetro  .addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, onContextRetrocade);


            menu.customItems.push(itemCaravel);
            menu.customItems.push(itemRetro);

            rDisplay.application.contextMenu = menu;
        }

        private static function onContextCaravel(e:ContextMenuEvent):void {
            navigateToURL(new URLRequest("http://caravelgames.com"), "_blank");
        }

        private static function onContextRetrocade(e:ContextMenuEvent):void {
            navigateToURL(new URLRequest("http://retrocade.net"), "_blank");
        }
    }
}