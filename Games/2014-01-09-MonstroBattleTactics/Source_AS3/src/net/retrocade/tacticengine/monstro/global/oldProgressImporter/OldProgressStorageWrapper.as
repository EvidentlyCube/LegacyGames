package net.retrocade.tacticengine.monstro.global.oldProgressImporter {
	import com.newgrounds.crypto.MD5;

	import net.retrocade.functions.printf;

	import net.retrocade.tacticengine.monstro.global.enum.EnumCampaignType;

	import net.retrocade.utils.UtilsSecure;

	public class OldProgressStorageWrapper {

		private var _storageObject:Object;

		public function OldProgressStorageWrapper(object:Object){
			_storageObject = object;
		}
		
		public function has(key:String):Boolean{
			key = encodeKey(key);

			return _storageObject.hasOwnProperty(key);
		}

		public function isLevelCompleted(levelIndex:int, campaign:EnumCampaignType):Boolean{
			return read(printf("level_%%_%%", levelIndex, campaign.id), "FALSE") === "TRUE";
		}

		private function read(key:String, def:String):String{
			key = encodeKey(key);

			if (_storageObject.hasOwnProperty(key)){
				var value:String = _storageObject[key];
				value = decodeValue(value);
				return value;
			} else {
				return def;
			}
		}

		private function encodeKey(key:String):String{
			return MD5.hash(key);
		}

		private function decodeValue(value:String):String{
			return UtilsSecure.rotComplexBackwards(value);
		}
	}
}
