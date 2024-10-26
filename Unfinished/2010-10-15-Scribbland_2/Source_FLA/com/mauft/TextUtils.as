// ActionScript file

package com.mauft{
    
    public class TextUtils{
        public function TextUtils(){ new Error("Can't instantiate TextUtils object - please use static methods only!") }
        
        /**
         * If the <code>string</code>'s length is smaller than <code>length</code>, <code>filler</code> will
         * be added at the string's start to make it as long.
         * <p>Keep in mind that if filler will be a string of more than one characters the resulting
         * string can be bigger than length.
         */
        public static function extendFromLeft(string:String, length:Number, filler:String="0"):String{
            while (string.length < length){
                string = filler + string;
            }
           
            return string;
        }
        
        /**
         * If the <code>string</code>'s length is smaller than <code>length</code>, <code>filler</code> will
         * be added at the string's end to make it as long.
         * <p>Keep in mind that if filler will be a string of more than one characters the resulting
         * string can be bigger than length.
         */
        public static function extendFromRight(string:String, length:Number, filler:String="0"):String{
            while (string.length < length){
                string += filler;
            }
           
            return string;
        }
        
        /**
         * Returns the first occurence of a number in a string.
         */
        public static function numberFromString(string:String):Number{
            var value   :String  = "";
            var dotFound:Boolean = false;
            var charCode:int     = NaN;
            var l       :int     = string.length;
            
            for (var i:int = 0; i < l; i++){
                charCode = string.charCodeAt(i);
                
                if (charCode >= 48 || charCode <= 57){
                    value += String.fromCharCode(charCode);
                    
                } else if (charCode == 46){
                    if (dotFound){
                        break;
                    } else {
                        value    += String.fromCharCode(charCode);
                        dotFound  = true;
                    }
                    
                } else if (value.length > 0){
                    break;
                    
                }
            }
            
            return parseFloat(value);
        }
        
        /**
         * Returns the first occurence of a number in a string as int.
         */
        public static function intFromString(string:String):int{
            var value   :String  = "";
            var charCode:int     = NaN;
            var l       :int     = string.length;
            
            for (var i:int = 0; i < l; i++){
                charCode = string.charCodeAt(i);
                
                if (charCode >= 48 || charCode <= 57){
                    value += String.fromCharCode(charCode);
                    
                } else if (value.length > 0){
                    break;
                    
                }
            }
            
            return parseInt(value);
        }
        
        /**
         * Formats time from int in milliseconds to string
         */
        public static function styleTime(time:int, hours:Boolean = true, minutes:Boolean = true, seconds:Boolean = true, milliseconds:Boolean = true):String{
            var output:String = "";
            var mil:int = time % 1000;
            
            time = (time - mil) / 1000;
            
            var sec:int = time % 60;
            
            time = (time - sec) / 60;
            
            var min:int = time % 60;
            
            time = (time - min) / 60;
            
            var hou:int = time;
            
            if (!hours){
                min += hou * 60;
            } else {
                if (hou < 10){ output += "0"; }
                output += hou.toString() + ":";
            }
            
            if (!minutes){
                sec += min * 60;
            } else {
                if (min < 10){ output += "0"; }
                output += min.toString() + ":";
            }
            
            if (!seconds){
                mil += sec * 1000;
            } else {
                if (sec < 10){ output += "0"; }
                output += sec.toString() + ":";
            }
            
            if (milliseconds){
                if (mil < 100){ output += "0"; }
                if (mil < 10){ output += "0"; }
                output += mil.toString() + ":";
            }
            
            return output.substr(0, output.length - 1);
            
        }
        
    }
}