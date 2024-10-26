package  {
    import net.retrocade.camel.rLang;
    import net.retrocade.standalone.Text;
    import net.retrocade.utils.UString;

    /**
     * Retrieves the localization of text in the current language.
     * This function creates a key based on the text passed and uses
     * this key to retrieve the localization
     * @param text Text of which to create key
     * @param rest List of paramteres to supplement in the string
     */
    public function __(text:String, ...rest):String {
        var trimText:String = UString.trim(text);

        var key:String = trimText.charAt(0) +
                         trimText.charAt(trimText.length / 2 | 0) +
                         trimText.charAt(Math.max(trimText.length - 2, 0)) +
                         trimText.charAt(Math.max(trimText.length - 1, 0)) +
                         trimText.charCodeAt(trimText.length / 3) +
                         trimText.length;

        var locale:String = rLang.get(rLang.selected, key, rest);

        if (locale == null || locale == "") {
            if (!$__vars.tracedLocales[key]){
                trace(key + "=" + text);
                $__vars.tracedLocales[key] = true;
            }

            locale = rLang.get('en', key, rest);
            if (locale == null || locale == "")
                return text;
        }

        return locale;
    }
}

class $__vars {
    public static var tracedLocales:Array = [];
}