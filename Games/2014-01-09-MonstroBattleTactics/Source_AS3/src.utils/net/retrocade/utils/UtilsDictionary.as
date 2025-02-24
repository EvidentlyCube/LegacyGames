package net.retrocade.utils {
	import flash.utils.Dictionary;

	public class UtilsDictionary {
		public static function countKeys(myDictionary:Dictionary):int{
			var count:int = 0;
			for (var key:* in myDictionary) {
				count++;
			}
			return count;
		}
	}
}
