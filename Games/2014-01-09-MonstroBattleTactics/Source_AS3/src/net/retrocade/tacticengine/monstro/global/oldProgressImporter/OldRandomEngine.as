package net.retrocade.tacticengine.monstro.global.oldProgressImporter {
	public class OldRandomEngine {
		private var _seed:uint = 1;

		public function getUint():uint {
			_seed = (_seed * 16807) % 0x7FFFFFFF;

			return _seed;
		}

		public function getNumber():Number{
			return getUint() / uint.MAX_VALUE;
		}


		public function getUintRange(rangeFrom:uint, rangeTo:uint):uint {
			if (rangeTo < rangeFrom){
				var temp:uint = rangeTo;
				rangeTo = rangeFrom;
				rangeFrom = temp;
			}

			return rangeFrom + getNumber() * (rangeTo - rangeFrom);
		}

		public function setSeed(seed:String):void {
			var tempSeed:uint = parseInt(seed);

			if (tempSeed === 0){
				throw new Error("Seed cannot be 0!");
			}

			_seed = tempSeed;
		}
	}
}
