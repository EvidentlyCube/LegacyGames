package com.mauft.DataVault{
	import com.mauft.Serializer;

	import flash.net.SharedObject;

	public class Vault	{
		private static var array:Object=new Object;
		public function Vault(){}
		public static function setValue(name:String, value:Number):void{
			if (!array[name]){array[name]=new Safe()}
			(array[name] as Safe).change(value)
		}
		public static function retrieveValue(name:String):Number{
			if (array[name]){
				return (array[name] as Safe).retrieve()
			} else {
				return 0;
			}
		}
		public static function removeValue(name:String):void{
			delete array[name];
		}
		internal static function addSafe(name:String, s:Safe):void{
			array[name]=s;
		}
		public static function saveVault():void{
			var s:SharedObject=SharedObject.getLocal("sl_2009_11_05")
			for (var i:uint=1; i<=20; i++){
				if (array["score_"+i.toString()]){
					s.data["data_crunch_"+i.toString()]=Serializer.serializeToString(array["score_"+i.toString()])
				}
			}
			s.flush();
		}
		public static function loadVault():void{
			var s:SharedObject=SharedObject.getLocal("sl_2009_11_05")
			for (var i:uint=1; i<=20; i++){
				if (s.data["data_crunch_"+i.toString()]){
					array["score_"+i.toString()]=Serializer.readObjectFromStringBytes(s.data["data_crunch_"+i.toString()]) as Safe
				} else {
					break
				}
			}
		}
	}
}