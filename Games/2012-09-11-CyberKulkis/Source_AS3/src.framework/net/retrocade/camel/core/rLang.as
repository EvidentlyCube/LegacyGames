package net.retrocade.camel.core{
    import flash.external.ExternalInterface;
    import flash.system.Capabilities;
    import flash.utils.ByteArray;
    import flash.utils.Dictionary;

    import net.retrocade.camel.core.rCore;
    import net.retrocade.camel.core.retrocamel_int;
    import net.retrocade.utils.UString;

    use namespace retrocamel_int

    public class rLang{
        /****************************************************************************************************************/
        /**                                                                                                  VARIABLES  */
        /****************************************************************************************************************/

        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Default Language
        // ::::::::::::::::::::::::::::::::::::::::::::::

        /**
         * The default language
         */
        private static var _defaultLanguage:String;

        /**
         * Code of the default language set or found
         */
        public  static function get defaultLanguage():String{
            return _defaultLanguage;
        }



        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Misc
        // ::::::::::::::::::::::::::::::::::::::::::::::

        /**
         * An array of all languages
         */
        private static var _langs:Dictionary;

        /**
         * The selected language
         */
        public static var selected:String;

        /**
         * An array containing replacement codes
         */
        private static var _helperReplacements:Array;

        /****************************************************************************************************************/
        /**                                                                                                  FUNCTIONS  */
        /****************************************************************************************************************/

        /**
         * Initializes the module
         */
        retrocamel_int static function initialize():void{
            _langs = new Dictionary();

            for each(var s:String in rCore.settings.languages){
                _langs[s] = new Dictionary();
            }

            detectLanguageCode();
        }

        /**
         * Retrieves the language code of the user or the browser language setting using JavaScript (if enabled)
         * @return Language code of the user or the browser language setting
         */
        retrocamel_int static function detectLanguageCode(def:String = "en"):void{
            if (rCore.settings.languages.indexOf(def) == -1)
                throw new ArgumentError("Default fallback language is not present in the accepted languages list");

            // We don't detect if it was already detected
            if (_defaultLanguage != "" && _defaultLanguage != null)
                return;

            // Let's try our luck with Capabilities class
            _defaultLanguage = Capabilities.language.toLowerCase().substr(0, 2);

            // The detected language was found in the allowed list
            if (rCore.settings.languages.indexOf(_defaultLanguage) != -1)
                return;

            // If external interface ain't not available we just set the default one matey.
            if (!ExternalInterface.available){
                _defaultLanguage = def;
                return;
            }

            try{
                // Some handy JS detecting
                var code:String;

                _defaultLanguage = String(ExternalInterface.call("(function(){return(navigator.userLanguage);})")).substr(0,2);

                if (rCore.settings.languages.indexOf(_defaultLanguage) != -1)
                    return;




                _defaultLanguage = String(ExternalInterface.call("(function(){return(navigator.systemLanguage);})")).substr(0,2);

                if (rCore.settings.languages.indexOf(_defaultLanguage) != -1)
                    return;



                _defaultLanguage = String(ExternalInterface.call("(function(){return(navigator.language);})")).substr(0,2);

                if (rCore.settings.languages.indexOf(_defaultLanguage) != -1)
                    return;

                _defaultLanguage = def;
            } catch (e:*){

                _defaultLanguage = def;
            }

            return;
        }

        /**
         * Sets a text localization
         * @param lang Language of the localization
         * @param key Key for this string
         * @param text Text to be returned
         */
        public static function set(lang:String, key:String, text:String):void{
            _langs[lang][key.toLowerCase()] = text;
        }

        /**
         * Returns a localized version of string lying under given key
         * @param lang Language to use
         * @param key Key of the string
         * @param rest List of string to replace the "%%" characters
         * @return Localized string
         */
        public static function get(lang:String, key:String, ...rest):String{
            if (lang == null)
                lang = _defaultLanguage;

            if (rest && rest[0] is Array)
                rest = rest[0];

            key = key.toLowerCase();

            _helperReplacements = rest;

            if (_langs[lang][key])
                return _langs[lang][key].replace(/%%/g, getTextReplace);

            return "";
        }

        /**
         * Loads a language file
         * @param cls Class of the .txt file
         * @param code Language code
         */
        public static function loadLanguageFile(cls:Class, code:String):void {
            var fileArray :ByteArray = new cls;
            var fileString:String = fileArray.readUTFBytes(fileArray.length);

            fileString = fileString.replace(/(\x0D\x0A|\x0D)/gm, "\x0A");
            fileString = fileString.replace(/\/\/\/\/\x0A\x20*/gm, " \\n\\n");
            fileString = fileString.replace(/\/\/\/\x0A\x20*/gm, " \\n");
            fileString = fileString.replace(/\/\/\x0A\x20*/gm, " ");

            var lines:Array = fileString.split("\x0A");

            var i:uint = 0;
            var l:uint = lines.length;

            var line     :String;
            var lineBreak:int;

            for (; i < l; i++) {
                line      = lines[i];
                lineBreak = line.indexOf('=');

                if (lineBreak === -1)
                    continue;

                line = line.replace(/(\r|\n)/g, '');
                line = line.replace(/\\n/g, "\n");
                line = line.replace(/\\t/g, "  ");

                set(code, line.substr(0, lineBreak), line.substr(lineBreak + 1));
            }
        }

        private static function getTextReplace(match:String, index:int, full:String):String {
            if (_helperReplacements && _helperReplacements.length)
                return _helperReplacements.shift().toString();
            return "%%"
        }
    }
}