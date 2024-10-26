package game.global{
    import flash.display.Bitmap;

    import net.retrocade.camel.core.rDisplay;
    import net.retrocade.camel.core.rGfx;
    import net.retrocade.camel.core.rSave;
    import net.retrocade.camel.core.rSound;
    import net.retrocade.camel.core.rTooltip;
    import net.retrocade.camel.core.rLang;
    import net.retrocade.standalone.BitextFont;
    import net.retrocade.standalone.Grid9;

    public class Pre{
        [Embed(source = '/../assets/i18n/en.txt', mimeType='application/octet-stream')] private static var _lang_en:Class;
        [Embed(source = '/../assets/i18n/pl.txt', mimeType='application/octet-stream')] private static var _lang_pl:Class;

        [Embed(source = "/../assets/gfx/by_maurycy/font.png")]      public static var _font:Class;
        [Embed(source = '/../assets/gfx/by_cage/ui/buttonSystem.png')] public static var _buttonBgSystem_:Class;
        [Embed(source = '/../assets/gfx/by_cage/ui/windowSystem.png')] public static var _windowBgSystem_:Class;
        [Embed(source = '/../assets/gfx/by_cage/ui/tooltipSystem.png')] public static var _tooltipBgSystem_:Class;
        [Embed(source = '/../assets/gfx/by_cage/bgs/bg3.png')] public static var _bg_:Class;
        [Embed(source="/../assets/gfx/by_cage/tiles/minis.png")] public static var _ribbon_:Class;

        public static var font:BitextFont

        public static var colorBlind:Boolean = false;

        public static function preCoreInit():void {
            loadFont();
        }

        public static function init():void{
            loadLanguages();
            loadGrid();
            loadOptions();

            rTooltip.setBackground("tooltipBG");
            rTooltip.setPadding(0, 4, 0, 4);
        }

        public static function setCursor():void{
            var cursor:Bitmap = rGfx.getB(Preloader._gfx_arrow);

            cursor.scaleX = 2;
            cursor.scaleY = 2;

            rDisplay.cursor = cursor;
            rDisplay.cursorScale = 2;
        }

        private static function loadOptions():void{
            rSave.setStorage(S().saveStorageName);

            rSound.musicVolume = rSave.read('optVolumeMusic', 1.0);
            rSound.soundVolume = rSave.read('optVolumeSound', 1.0);
        }

        private static function loadFont():void{
            var characters:String = String.fromCharCode.apply(null, [
                32,   33,   34,   35,   36,   37,   38,   39,   40,   41,   42,   43,   44,   45,   46,   47,   48,   49,   50,   51,
                52,   53,   54,   55,   56,   57,   58,   59,   60,   61,   62,   63,   64,   65,   66,   67,   68,   69,   70,   71,
                72,   73,   74,   75,   76,   77,   78,   79,   80,   81,   82,   83,   84,   85,   86,   87,   88,   89,   90,   91,
                92,   93,   94,   95,   96,   97,   98,   99,  100,  101,  102,  103,  104,  105,  106,  107,  108,  109,  110,  111,
                112,  113,  114,  115,  116,  117,  118,  119,  120,  121,  122,  123,  124,  125,  126,  180,  196,  201,  214,  220,
                223,  225,  226,  227,  228,  231,  233,  234,  237,  243,  245,  246,  250,  252,  261,  263,  281,  321,  322,  324,
                346,  347,  378,  380, 8212, 8217, 8230,12290,19968,19975,19978,19979,19981,19982,19988,20010,20013,20026,20037,20043,
                20048,20102,20110,20154,20171,20174,20182,20197,20204,20247,20250,20294,20303,20307,20316,20320,20351,20415,20572,20687,
                20799,20811,20837,20840,20851,20854,20889,20943,20986,20987,20998,20999,21040,21046,21069,21147,21152,21160,21315,21333,
                21345,21361,21364,21435,21453,21464,21475,21487,21491,21516,21518,21521,21592,21629,21644,21862,21916,22235,22238,22312,
                22320,22353,22359,22604,22768,22810,22823,22825,22833,22855,22914,22987,23089,23376,23383,23384,23433,23436,23450,23460,
                23494,23547,23558,23567,23601,23613,23621,23679,23707,24038,24050,24102,24180,24182,24207,24211,24213,24320,24377,24378,
                24403,24425,24448,24456,24471,24494,24515,24555,24597,24598,24656,24685,24744,24930,25103,25104,25110,25151,25152,25163,
                25165,25171,25214,25226,25321,25351,25353,25442,25481,25484,25490,25509,25511,25913,25928,25968,26031,26032,26041,26102,
                26126,26159,26174,26242,26263,26368,26377,26463,26465,26469,26524,26631,26679,26684,27036,27425,27454,27809,27833,27934,
                28034,28040,28145,28165,28216,28304,28459,28857,29289,29609,29616,29983,29992,30011,30028,30340,30424,30456,30475,30528,
                30896,31070,31163,31181,31227,31243,31348,31354,31505,32456,32461,32463,32467,32472,32487,32493,32763,32773,32791,32930,
                33021,33394,33756,33853,34892,34987,35201,35328,35768,35793,35821,35831,35874,36133,36164,36182,36215,36335,36339,36523,
                36710,36731,36807,36814,36820,36825,36827,36864,36873,36895,37027,37096,37324,37325,37327,38025,38145,38190,38271,38381,
                38383,38388,38500,38505,38754,38899,39033,39068,40657,40736,21457,27491,31245,31561,36830,36865,25991,21734,22269,24230,
                25758,27492,27861,35299,  377,  260,  262,  280,  323,  379, 8734,  211,20027,20123,20132,20219,20877,20915,21033,21161,
                21449,21543,21561,22418,22836,23427,23545,23614,24039,24049,24110,24444,24452,24819,24847,24935,25216,25773,25910,25918,
                26080,26234,29255,30097,30422,30495,30742,32447,32852,32988,33258,33719,35206,35760,36733,36793,36816,36890,36947,37117,
                38062,38169,38386,38480,38543,38590,39029,65281,65292,  224,  232,  244]);

            font = new BitextFont(_font, 15, 13, false, 5, characters);
        }

        private static function loadGrid():void{
            Grid9.make('buttonBG',  rGfx.getBD(_buttonBgSystem_), 4, 14, 16, 2);
            Grid9.make('windowBG',  rGfx.getBD(_windowBgSystem_), 4, 42, 2, 2);
            Grid9.make('tooltipBG', rGfx.getBD(_tooltipBgSystem_), 2, 5, 8, 1);
        }

        private static function loadLanguages():void {
            rLang.loadLanguageFile(_lang_en, 'en');
            rLang.loadLanguageFile(_lang_pl, 'pl');
        }
    }
}