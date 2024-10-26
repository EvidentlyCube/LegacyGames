package com.mauft.DataVault{
	import com.mauft.PlatformerEngine.Engine;
	
	public class Safe{
		public var unchanged:Number=0
		public var module10:Number=0
		public var module13:Number=0
		public var module3571:Number=0
		public var squareFloor:Number=0
		public var stringed:String="0"
		public function Safe(){}
		internal function retrieve():Number{
			if (check()){
				return unchanged;
			} else {
				return 0;
			}
		} 
		internal function change(newNum:Number):void{
			if (check()){
				unchanged=newNum
				module10=newNum%10
				module13=newNum%13
				module3571=newNum%3571
				squareFloor=Math.floor(Math.sqrt(newNum))
				stringed=newNum.toString()
			}
		}
		private function check():Boolean{
			if (module10!=unchanged%10
			|| module13!=unchanged%13
			|| module3571!=unchanged%3571
			|| squareFloor!=Math.floor(Math.sqrt(unchanged))
			|| stringed!=unchanged.toString()){
				unchanged=0
				module10=0
				module13=0
				module3571=0
				squareFloor=0
				stringed="0"
				Engine.EndLevel()
				Engine._gamefield.gotoAndStop(3)
				return false;
			} else {
				return true;
			}
		}
		public function deserialize(name:String):void{
			Vault.addSafe(name, this)
		}
	}
}