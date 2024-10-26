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
	internal class Safe_2 extends Safe{
		public var floorSin25:Number;
		public var ceilCos30:Number;
		public var atan2plus1:Number;
		public var module23:Number;
		public var stringedFloorSquare:String;
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
			floorSin25=Math.floor(Math.sin(unchanged)*25)
			ceilCos30=Math.ceil(Math.cos(unchanged)*30)
			atan2plus1=Math.floor(Math.atan2(unchanged, unchanged+1)*50)
			module23=unchanged%23
			stringedFloorSquare=Math.floor(Math.sqrt(unchanged)).toString()
		}
		override protected function check():Boolean{
			if (floorSin25!=Math.floor(Math.sin(unchanged)*25)
			|| ceilCos30!=Math.ceil(Math.cos(unchanged)*30)
			|| atan2plus1!=Math.floor(Math.atan2(unchanged, unchanged+1)*50)
			|| module23!=unchanged%23
			|| stringedFloorSquare!=Math.floor(Math.sqrt(unchanged)).toString()){
				change(0, true)
				Vault.fakeValue()
				return false
			} else {
				return true;
			}
		}
	}
}