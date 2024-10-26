/*
Copyright (c) 2009 Maurycy Zarzycki, Mauft.com

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.
*/
package com.mauft.DataVault{
    import flash.events.EventDispatcher;
    
    /**
     * <p>Vault is a static class which can be used to store sensitive numeric data
     * in a way to prevent memory-editing programs from changing it by using
     * multiple obfuscation techniques.</p>
     * <p>When a variable is detected to be modified, the function calls the preset
     * callback function, and if no function is set, it will throw an error.</p> 
     */
    final public class Vault{
        private static var array:Object = new Object;
        private static var modifiedVariableCallback:Function;
        
        /**
         * @private
         */
        public function Vault(){ new Error("Can't instantiate Vault object - please use static methods only!") }
        
        /**
         * Sets the value of <code>name</code> variable in vault
         * to <code>value</code> and returns the new value. 
         * If the variable already exists its value will be changed.
         * 
         * @param name (String) Name of the variable you want to set.
         * @param name (Number) Value you want to set the variable to.
         * 
         * @return The new value of variable.
         * 
         * @see com.mauft.DataVault#removeValue removeValue()
         * @see com.mauft.DataVault#retrieveValue retrieveValue()
         */
        public static function setVal(name:String, value:Number):Number{
            if (!array[name]){
                array[name] = generateSafe();
                return array[name].change(value, true);
            } else {
                return array[name].change(value);
            }
        }
        
        /**
         * Adds the value of <code>name</code> variable in vault
         * by <code>value</code> and returns the new value. 
         * If the variable doesn't exists it will be treated
         * as if equal to 0.
         * 
         * @param name (String) Name of the variable you want to set.
         * @param name (Number) Value you want to set the variable to.
         * 
         * @return The new value of variable.
         * 
         * @see com.mauft.DataVault#removeValue removeValue()
         * @see com.mauft.DataVault#retrieveValue retrieveValue()
         */
        public static function addVal(name:String, value:Number):Number{
            return setVal(name, getVal(name) + value);
        }
        
        /**
         * Multiplies the value of <code>name</code> variable in vault
         * by <code>value</code> and returns the new value. 
         * If the variable doesn't exists it will be treated
         * as if equal to 0.
         * 
         * @param name (String) Name of the variable you want to set.
         * @param name (Number) Value you want to set the variable to.
         * 
         * @return The new value of variable.
         * 
         * @see com.mauft.DataVault#removeValue removeValue()
         * @see com.mauft.DataVault#retrieveValue retrieveValue()
         */
        public static function mulVal(name:String, value:Number):Number{
            return setVal(name, getVal(name) * value);
        }
        
        /**
         * Returns the value of <code>name</code> variable in vault.
         * If the variable doesn't exist it returns 0.
         * 
         * @param name (String) Name of the variable you want to return.
         * 
         * @return If variable exists returns its value;
         * Otherwise returns 0.
         * 
         * @see com.mauft.DataVault#removeValue removeValue()
         * @see com.mauft.DataVault#setValue setValue()
         */
        public static function getVal(name:String):Number{
            if (array[name]){
                return (array[name] as Safe).get();
            } else {
                return 0;
            }
        }
        
        /**
         * Removes the variable <code>name</code> from vault.
         * If the variable doesn't exist it returns 0.
         * 
         * @param name (String) Name of the variable you want to remove.
         * 
         * @see com.mauft.DataVault#retrieveValue retrieveValue()
         * @see com.mauft.DataVault#setValue setValue()
         */
        public static function removeValue(name:String):void{
            delete array[name]; 
        }
        
        /**
         * Deprecated! Please use setVal instead.
         */
        public static function setValue(name:String, value:Number):void{
            setVal(name, value);
        }
        
        /**
         * Deprecated! Please use getVal instead.
         */
        public static function retrieveValue(name:String):Number{
            return getVal(name);
        }
        
        /**
         * It sets the callback function which is called when a variable is
         * detected to be modified.
         * 
         * @param fun A function which takes no parameters.
         */
        public static function setCallback(fun:Function):void{
            modifiedVariableCallback=fun;
        }
        
        public static function getSafeAsString(name:String):String{
            return Safe( array[name] ).safeToString();
        }
        
        public static function setSafeFromString(name:String, string:String):void{
            var safe:Safe;
            
            switch(string.charAt(0)){
                case("0"): safe = new Safe_0; break;
                case("1"): safe = new Safe_1; break;
                case("2"): safe = new Safe_2; break;
            }
            
            safe.stringToSafe(string);
            
            array[name] = safe;
            
            safe.check();
        }
        
        public static function forceValue(name:String, value:Number):Number{
            if (!array[name]){
                array[name] = generateSafe();
                return array[name].change(value, true);
            } else {
                return array[name].change(value, true);
            }
        }
        
        /**
         * @private
         */
        internal static function fakeValue():void{
            if (modifiedVariableCallback!=null){
                modifiedVariableCallback();
            } else {
                new Error("A modified variable has been detected, but no callback was set!");
            }
        }
        /**
         * @private
         */
        private static function generateSafe():Safe{
            switch(Math.floor(Math.random())){
                case(0):return new Safe_0();
                case(1):return new Safe_1();
                case(2):return new Safe_2();
            }
            return new Safe_0;
        }
    }
}
