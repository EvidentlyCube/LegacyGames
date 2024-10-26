package net.retrocade.retrocamel.locale {
    public class RetrocamelLocaleParserJavaProperties extends RetrocamelLocaleParserAbstract {
        public static function parse(textContainer:*, languageCode:String):void {
            var fileString:String = getText(textContainer);

            var props:Array = [];
            var lines:Array;
            var linesCount:int;
            var i:int;
            var s:String;
            var multiline:Boolean = false;

            const CR:String = String.fromCharCode(13);
            const LF:String = String.fromCharCode(10);
            const hasCR:Boolean = fileString.indexOf(CR) > -1;
            const hasLF:Boolean = fileString.indexOf(LF) > -1;

            // remove tabs
            fileString = fileString.replace(new RegExp(String.fromCharCode(3), "g"), "");

            // split into lines (depending on the line-end type, will split on CRLF, CR, or LF)
            lines = fileString.split((hasCR && hasLF) ? CR + LF : hasCR ? CR : LF);
            linesCount = lines.length;

            // build into array with each property
            for (i = 0; i < linesCount; i++) {
                s = stripWhitespace(String(lines[i]));

                if (s.length > 1 && s.charAt(0) != "#" && s.charAt(0) != "!") { //Ignore comments and empty lines
                    // if it's a multiline var, add this to the last one
                    if (multiline) {
                        props[props.length - 1] = String(props[props.length - 1]).substr(0, -1) + s;
                    } else {
                        props.push(s);
                    }

                    //does the property extend over more than one line?
                    multiline = s.charAt(s.length - 1) == "\\";
                }
            }

            // parse into name / value pairs
            i = props.length;
            var splitIndex:int;
            var name:String;
            while (--i > -1) {
                s = props[i];
                splitIndex = getSplitIndex(s);

                if (splitIndex == -1) {
                    props.splice(i, 1);
                    continue;
                }

                // extract and clean whitespace
                name = s.substring(0, splitIndex);
                name = stripWhitespace(name);

                fileString = s.substring(splitIndex + 1);
                fileString = stripWhitespace(fileString);
                fileString = fileString.replace(/\\n/g, "\n");

                trace("!"+name+":"+fileString+"!");
                RetrocamelLocale.set(languageCode, name, fileString);
            }
        }

        private static function getSplitIndex(value:String):int {
            const s:Array = ["=", ":"]; // can split on '=' or ':'
            var n:int = 2;
            var index1:int;
            var index2:int = value.length;
            while (--n > -1) {
                index1 = value.indexOf(s[n]);
                if (index1 > -1 && index1 < index2) {
                    index2 = index1;
                }
            }
            return (index2 == value.length - 1) ? -1 : index2;
        }

        private static function stripWhitespace(value:String):String {
            // strip empty space left and right, and consecutive spaces
            return value.replace(/^[ \s]+|[ \s]+$/g, "");
        }
    }
}
