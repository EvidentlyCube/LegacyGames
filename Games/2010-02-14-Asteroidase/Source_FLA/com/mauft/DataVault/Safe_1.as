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
	 * @private
	 * Safe is a parent class for sub-safe classes which are used to store and obfuscate a sensitive data
	 * for the Vault class.
	 */
	internal class Safe_1 extends Safe{
		public var module71:Number;
		public var random100:Number;
		public var firstCharCode:String;
		public var module71squareFloor:Number;
		public var stringedPlus1:String;
		override internal function retrieve():Number{
			check();
			return unchanged;
		} 
		override internal function change(newNum:Number, skipCheck:Boolean=false):void{
			if (!skipCheck){
				if (!check()){
					return;
				}
			}
			unchanged=newNum
			module71=unchanged%71
			random100=unchanged+Math.random()*100
			firstCharCode=unchanged.toString().charCodeAt(0).toString()
			module71squareFloor=Math.floor(Math.sqrt(unchanged%71))
			stringedPlus1=unchanged.toString()+"1"
		}
		override protected function check():Boolean{
			if (module71!=unchanged%71
			|| random100<unchanged
			|| random100>unchanged+100
			|| firstCharCode!=unchanged.toString().charCodeAt(0).toString()
			|| module71squareFloor!=Math.floor(Math.sqrt(unchanged%71))
			|| stringedPlus1!=unchanged.toString()+"1"){
				change(0, true)
				Vault.fakeValue()
				return false
			} else {
				return true;
			}
		}
	}
}