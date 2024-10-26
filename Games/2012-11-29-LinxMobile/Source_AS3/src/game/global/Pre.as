package game.global{
    import net.retrocade.camel.global.rGfx;
    import net.retrocade.camel.global.rLang;
    import net.retrocade.camel.global.rSave;
    import net.retrocade.camel.global.rTooltip;
    import net.retrocade.standalone.Grid9;

    public class Pre{
        [Embed(source="/../assets/fonts/jakob/jakob_n.ttf", fontFamily="font", embedAsCFF="false")] private static var _font:Class;
        [Embed(source = '/../assets/i18n/en.txt', mimeType='application/octet-stream')] private static var _lang_en:Class;

        [Embed(source = '/../assets/gfx/by_cage/ui/buttonSystem.png')] public static var _buttonBgSystem_:Class;
        [Embed(source = '/../assets/gfx/by_cage/ui/buttonSystemLit.png')] public static var _buttonLitBgSystem_:Class;
        [Embed(source = '/../assets/gfx/by_cage/ui/windowSystem.png')] public static var _windowBgSystem_:Class;
        [Embed(source = '/../assets/gfx/by_cage/ui/tooltipSystem.png')] public static var _tooltipBgSystem_:Class;

        public static var colorBlind:Boolean = false;

        public static function preCoreInit():void {
            rSave.setStorage(S().saveStorageName);
        }

        public static function init():void{
            loadLanguages();
            loadGrid();

            rTooltip.setBackground("tooltipBG");
            rTooltip.setPadding(0, 4, 0, 4);
            rTooltip.useFontText("font");
        }

        private static function loadGrid():void{
            Grid9.make('buttonBG',  rGfx.getBD(_buttonBgSystem_), 7, 5, 73, 27);
            Grid9.make('buttonLitBG',  rGfx.getBD(_buttonLitBgSystem_), 7, 5, 73, 27);
            Grid9.make('windowBG',  rGfx.getBD(_windowBgSystem_), 13, 13, 73, 77);
            Grid9.make('tooltipBG', rGfx.getBD(_tooltipBgSystem_), 2, 5, 8, 1);
        }

        private static function loadLanguages():void {
            rLang.loadLanguageFile(_lang_en, 'en');
        }
    }
}