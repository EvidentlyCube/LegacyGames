package game.global{
    import net.retrocade.camel.core.rGfx;
    import net.retrocade.camel.core.rSave;
    import net.retrocade.camel.core.rSound;
    import net.retrocade.camel.core.rTooltip;
    import net.retrocade.camel.core.rLang;
    import net.retrocade.standalone.BitextFont;
    import net.retrocade.standalone.Grid9;

    public class Pre{
        [Embed(source = '/../assets/i18n/en.txt', mimeType='application/octet-stream')] private static var _lang_en:Class;

        [Embed(source="/../assets/fonts/centurygothic/CenturyGothic.ttf", fontFamily="font")] private static var ___FONT:Class;


        [Embed(source = '/../assets/gfx/buttonSystem.png')] private static var _buttonBgSystem_:Class;
        [Embed(source = '/../assets/gfx/tooltipSystem.png')] private static var _tooltipBgSystem_:Class;
        [Embed(source = '/../assets/gfx/windowSystem.png')] private static var _windowBgSystem_:Class;

        public static function preCoreInit():void {
        }

        public static function init():void{
            loadLanguages();
            loadGrid();
            loadOptions();

            rTooltip.setBackground(Grid9.getGrid("tooltip"));

            rTooltip.setPadding(5, 3, 5, 3);
            rTooltip.useFontText("font");
            rTooltip.setSize(12);
            rTooltip.retrieveTextObject().setShadow(2, 45, 0, 1, 2, 2);
        }

        private static function loadOptions():void{
            rSound.musicVolume = rSave.read('optVolumeMusic', 1.0);
            rSound.soundVolume = rSave.read('optVolumeSound', 1.0);
        }

        private static function loadGrid():void{
            Grid9.make('buttonBG', rGfx.getBD(_buttonBgSystem_),  11, 8, 94,  23);
            Grid9.make('tooltip',  rGfx.getBD(_tooltipBgSystem_), 9, 9,  533, 495);
            Grid9.make('window',   rGfx.getBD(_windowBgSystem_),  9, 47, 533, 495);

        }

        private static function loadLanguages():void {
            rLang.loadLanguageFile(_lang_en, 'en');
        }
    }
}