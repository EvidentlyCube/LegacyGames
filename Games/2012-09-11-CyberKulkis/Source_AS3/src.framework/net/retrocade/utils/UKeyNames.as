package net.retrocade.utils{
    import flash.utils.Dictionary;

    public class UKeyNames{

        private static var languagesWithKeys:Dictionary = new Dictionary;

        public static function getName(keyCode:uint, language:String = "en"):String{
            language = initLanguage(language);

            if (languagesWithKeys[language][keyCode] == null || languagesWithKeys[language][keyCode] == undefined)
                return getName(keyCode, 'en');

            return languagesWithKeys[language][keyCode];
        }

        private static function initLanguage(language:String):String{
            if (languagesWithKeys[language] != undefined)
                return language.toLowerCase();

            switch(language){
                case("en"):
                    initEnglish();
                    break;

                case("pl"):
                    initPolish();
                    break;

                default:
                    return initLanguage('en');
                    break;
            }

            return language.toLowerCase();
        }

        private static function initEnglish():void{
            languagesWithKeys['en']    = new Array(255);

            languagesWithKeys['en'][8] = 'Backspace';
            languagesWithKeys['en'][9] = 'Tab';
            languagesWithKeys['en'][13] = 'Enter';
            languagesWithKeys['en'][16] = 'Shift';
            languagesWithKeys['en'][17] = 'Control';
            languagesWithKeys['en'][18] = 'Alt';
            languagesWithKeys['en'][19] = 'Pause/Break';
            languagesWithKeys['en'][20] = 'Caps Lock';
            languagesWithKeys['en'][27] = 'Escape';
            languagesWithKeys['en'][32] = 'Space';
            languagesWithKeys['en'][33] = 'Page Up';
            languagesWithKeys['en'][34] = 'Page Down';
            languagesWithKeys['en'][35] = 'End';
            languagesWithKeys['en'][36] = 'Home';
            languagesWithKeys['en'][37] = 'Left';
            languagesWithKeys['en'][38] = 'Up';
            languagesWithKeys['en'][39] = 'Right';
            languagesWithKeys['en'][40] = 'Down';
            languagesWithKeys['en'][45] = 'Insert';
            languagesWithKeys['en'][46] = 'Delete';
            languagesWithKeys['en'][48] = '0';
            languagesWithKeys['en'][49] = '1';
            languagesWithKeys['en'][50] = '2';
            languagesWithKeys['en'][51] = '3';
            languagesWithKeys['en'][52] = '4';
            languagesWithKeys['en'][53] = '5';
            languagesWithKeys['en'][54] = '6';
            languagesWithKeys['en'][55] = '7';
            languagesWithKeys['en'][56] = '8';
            languagesWithKeys['en'][57] = '9';
            languagesWithKeys['en'][65] = 'A';
            languagesWithKeys['en'][66] = 'B';
            languagesWithKeys['en'][67] = 'C';
            languagesWithKeys['en'][68] = 'D';
            languagesWithKeys['en'][69] = 'E';
            languagesWithKeys['en'][70] = 'F';
            languagesWithKeys['en'][71] = 'G';
            languagesWithKeys['en'][72] = 'H';
            languagesWithKeys['en'][73] = 'I';
            languagesWithKeys['en'][74] = 'J';
            languagesWithKeys['en'][75] = 'K';
            languagesWithKeys['en'][76] = 'L';
            languagesWithKeys['en'][77] = 'M';
            languagesWithKeys['en'][78] = 'N';
            languagesWithKeys['en'][79] = 'O';
            languagesWithKeys['en'][80] = 'P';
            languagesWithKeys['en'][81] = 'Q';
            languagesWithKeys['en'][82] = 'R';
            languagesWithKeys['en'][83] = 'S';
            languagesWithKeys['en'][84] = 'T';
            languagesWithKeys['en'][85] = 'U';
            languagesWithKeys['en'][86] = 'V';
            languagesWithKeys['en'][87] = 'W';
            languagesWithKeys['en'][88] = 'X';
            languagesWithKeys['en'][89] = 'Y';
            languagesWithKeys['en'][90] = 'Z';
            languagesWithKeys['en'][91] = 'Left Windows/Command';
            languagesWithKeys['en'][92] = 'Right Windows';
            languagesWithKeys['en'][93] = 'Menu';
            languagesWithKeys['en'][96] = 'Numpad 0';
            languagesWithKeys['en'][97] = 'Numpad 1';
            languagesWithKeys['en'][98] = 'Numpad 2';
            languagesWithKeys['en'][99] = 'Numpad 3';
            languagesWithKeys['en'][100] = 'Numpad 4';
            languagesWithKeys['en'][101] = 'Numpad 5';
            languagesWithKeys['en'][102] = 'Numpad 6';
            languagesWithKeys['en'][103] = 'Numpad 7';
            languagesWithKeys['en'][104] = 'Numpad 8';
            languagesWithKeys['en'][105] = 'Numpad 9';
            languagesWithKeys['en'][106] = 'Numpad Multiply';
            languagesWithKeys['en'][107] = 'Numpad Add';
            languagesWithKeys['en'][109] = 'Numpad Subtract';
            languagesWithKeys['en'][110] = 'Numpad Dot';
            languagesWithKeys['en'][111] = 'Numpad Divide';
            languagesWithKeys['en'][112] = 'F1';
            languagesWithKeys['en'][113] = 'F2';
            languagesWithKeys['en'][114] = 'F3';
            languagesWithKeys['en'][115] = 'F4';
            languagesWithKeys['en'][116] = 'F5';
            languagesWithKeys['en'][117] = 'F6';
            languagesWithKeys['en'][118] = 'F7';
            languagesWithKeys['en'][119] = 'F8';
            languagesWithKeys['en'][120] = 'F9';
            languagesWithKeys['en'][121] = 'F10';
            languagesWithKeys['en'][122] = 'F11';
            languagesWithKeys['en'][123] = 'F12';
            languagesWithKeys['en'][124] = 'F13';
            languagesWithKeys['en'][125] = 'F14';
            languagesWithKeys['en'][126] = 'F15';
            languagesWithKeys['en'][144] = 'Numlock';
            languagesWithKeys['en'][145] = 'Scroll Lock';
            languagesWithKeys['en'][186] = 'Semicolon';
            languagesWithKeys['en'][187] = 'Equals';
            languagesWithKeys['en'][188] = 'Comma';
            languagesWithKeys['en'][189] = 'Minus';
            languagesWithKeys['en'][190] = 'Period';
            languagesWithKeys['en'][191] = 'Slash';
            languagesWithKeys['en'][192] = 'Tilde';
            languagesWithKeys['en'][219] = 'Bracket Left';
            languagesWithKeys['en'][220] = 'Backslash';
            languagesWithKeys['en'][221] = 'Bracket Right';
            languagesWithKeys['en'][222] = 'Apostrophe';
        }

        private static function initPolish():void{
            languagesWithKeys['pl']    = new Array(255);

            languagesWithKeys['pl'][8] = 'Backspace';
            languagesWithKeys['pl'][9] = 'Tab';
            languagesWithKeys['pl'][13] = 'Enter';
            languagesWithKeys['pl'][16] = 'Shift';
            languagesWithKeys['pl'][17] = 'Control';
            languagesWithKeys['pl'][18] = 'Alt';
            languagesWithKeys['pl'][19] = 'Pauza/Break';
            languagesWithKeys['pl'][20] = 'Caps Lock';
            languagesWithKeys['pl'][27] = 'Escape';
            languagesWithKeys['pl'][32] = 'Spacja';
            languagesWithKeys['pl'][33] = 'Page Up';
            languagesWithKeys['pl'][34] = 'Page Down';
            languagesWithKeys['pl'][35] = 'End';
            languagesWithKeys['pl'][36] = 'Home';
            languagesWithKeys['pl'][37] = 'Strzałka w Lewo';
            languagesWithKeys['pl'][38] = 'Strzałka w Górę';
            languagesWithKeys['pl'][39] = 'Strzałka w Prawo';
            languagesWithKeys['pl'][40] = 'Strzalka w Dół';
            languagesWithKeys['pl'][45] = 'Insert';
            languagesWithKeys['pl'][46] = 'Delete';
            languagesWithKeys['pl'][48] = '0';
            languagesWithKeys['pl'][49] = '1';
            languagesWithKeys['pl'][50] = '2';
            languagesWithKeys['pl'][51] = '3';
            languagesWithKeys['pl'][52] = '4';
            languagesWithKeys['pl'][53] = '5';
            languagesWithKeys['pl'][54] = '6';
            languagesWithKeys['pl'][55] = '7';
            languagesWithKeys['pl'][56] = '8';
            languagesWithKeys['pl'][57] = '9';
            languagesWithKeys['pl'][65] = 'A';
            languagesWithKeys['pl'][66] = 'B';
            languagesWithKeys['pl'][67] = 'C';
            languagesWithKeys['pl'][68] = 'D';
            languagesWithKeys['pl'][69] = 'E';
            languagesWithKeys['pl'][70] = 'F';
            languagesWithKeys['pl'][71] = 'G';
            languagesWithKeys['pl'][72] = 'H';
            languagesWithKeys['pl'][73] = 'I';
            languagesWithKeys['pl'][74] = 'J';
            languagesWithKeys['pl'][75] = 'K';
            languagesWithKeys['pl'][76] = 'L';
            languagesWithKeys['pl'][77] = 'M';
            languagesWithKeys['pl'][78] = 'N';
            languagesWithKeys['pl'][79] = 'O';
            languagesWithKeys['pl'][80] = 'P';
            languagesWithKeys['pl'][81] = 'Q';
            languagesWithKeys['pl'][82] = 'R';
            languagesWithKeys['pl'][83] = 'S';
            languagesWithKeys['pl'][84] = 'T';
            languagesWithKeys['pl'][85] = 'U';
            languagesWithKeys['pl'][86] = 'V';
            languagesWithKeys['pl'][87] = 'W';
            languagesWithKeys['pl'][88] = 'X';
            languagesWithKeys['pl'][89] = 'Y';
            languagesWithKeys['pl'][90] = 'Z';
            languagesWithKeys['pl'][91] = 'Lewy Windows/Command';
            languagesWithKeys['pl'][92] = 'Prawy Windows';
            languagesWithKeys['pl'][93] = 'Menu';
            languagesWithKeys['pl'][96] = 'Numeryczna 0';
            languagesWithKeys['pl'][97] = 'Numeryczna 1';
            languagesWithKeys['pl'][98] = 'Numeryczna 2';
            languagesWithKeys['pl'][99] = 'Numeryczna 3';
            languagesWithKeys['pl'][100] = 'Numeryczna 4';
            languagesWithKeys['pl'][101] = 'Numeryczna 5';
            languagesWithKeys['pl'][102] = 'Numeryczna 6';
            languagesWithKeys['pl'][103] = 'Numeryczna 7';
            languagesWithKeys['pl'][104] = 'Numeryczna 8';
            languagesWithKeys['pl'][105] = 'Numeryczna 9';
            languagesWithKeys['pl'][106] = 'Numeryczna Mnożenie';
            languagesWithKeys['pl'][107] = 'Numeryczna Dodawanie';
            languagesWithKeys['pl'][109] = 'Numeryczna Odejmowanie';
            languagesWithKeys['pl'][110] = 'Numeryczna Kropka';
            languagesWithKeys['pl'][111] = 'Numeryczna Dzielenie';
            languagesWithKeys['pl'][112] = 'F1';
            languagesWithKeys['pl'][113] = 'F2';
            languagesWithKeys['pl'][114] = 'F3';
            languagesWithKeys['pl'][115] = 'F4';
            languagesWithKeys['pl'][116] = 'F5';
            languagesWithKeys['pl'][117] = 'F6';
            languagesWithKeys['pl'][118] = 'F7';
            languagesWithKeys['pl'][119] = 'F8';
            languagesWithKeys['pl'][120] = 'F9';
            languagesWithKeys['pl'][121] = 'F10';
            languagesWithKeys['pl'][122] = 'F11';
            languagesWithKeys['pl'][123] = 'F12';
            languagesWithKeys['pl'][124] = 'F13';
            languagesWithKeys['pl'][125] = 'F14';
            languagesWithKeys['pl'][126] = 'F15';
            languagesWithKeys['pl'][144] = 'Numlock';
            languagesWithKeys['pl'][145] = 'Scroll Lock';
            languagesWithKeys['pl'][186] = 'Średnik';
            languagesWithKeys['pl'][187] = 'Równość';
            languagesWithKeys['pl'][188] = 'Przecinek';
            languagesWithKeys['pl'][189] = 'Minus';
            languagesWithKeys['pl'][190] = 'Kropka';
            languagesWithKeys['pl'][191] = 'Ukosnik';
            languagesWithKeys['pl'][192] = 'Tylda/Gravis';
            languagesWithKeys['pl'][219] = 'Klamra Lewa';
            languagesWithKeys['pl'][220] = 'Odwrotny Ukośnik';
            languagesWithKeys['pl'][221] = 'Klamra Prawa';
            languagesWithKeys['pl'][222] = 'Apostrof';
        }
    }
}