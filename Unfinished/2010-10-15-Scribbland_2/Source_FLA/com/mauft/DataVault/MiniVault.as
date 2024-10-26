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
    
    /**
     * A local vault object which can be referenced directly and holds only one variable
     * @author Skell 
     */
    public class MiniVault{
        
        
        /**
         * A private variable holding the safe
         * @private
         */
        private var safe:Safe;
        
         
        /**
         * Creates a new MiniVault.
         * @param safeString If set it creates a safe from the specified string. 
         */
        public function MiniVault(safeString:String = ""){
            if (safeString != ""){
                setFromString(safeString);
            } else {
                resetSafe();
            }
            
            safe.set(0, true);
        }
        
        /**
         * Increases the stored variable by number and return its new value
         * @param number A value by which the stored variable is to be increased
         * @return New stored value
         */
        public function add(number:Number):Number{
            return safe.set(safe.get() + number);
        }

        
        /**
         * Multiplies the stored variable by number and return its new value
         * @param number A value by which the stored variable is to be Multiplied
         * @return New stored value
         */
        public function mul(number:Number):Number{
            return safe.set(safe.get() * number);
        }
        
        /**
         * Sets the stored variable to number
         * @param number Value to which set the variable
         * @return New stored value
         */
        public function set(number:Number):Number{
            return safe.set(number);
        }
        
        
        public function get():Number{
            return safe.get();
        }
        
        public function force(number:Number):Number{
            return safe.set(number, true);
        }
        
        public function resetSafe():void{
            switch(Math.floor(Math.random())){
                case(0): safe = new Safe_0();
                case(1): safe = new Safe_1();
                case(2): safe = new Safe_2();
            }
        }
        
        public function setFromString(string:String):void{
            switch(string.charAt(0)){
                case(0): safe = new Safe_0; break;
                case(1): safe = new Safe_1; break;
                case(2): safe = new Safe_2; break;
            }
            
            safe.stringToSafe(string);
            safe.check();
        }
    }
}