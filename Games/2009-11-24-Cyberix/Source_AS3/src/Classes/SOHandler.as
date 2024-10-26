package Classes{
	import flash.display.Sprite;
	import flash.net.SharedObject;
	import flash.system.Security;
	public class SOHandler extends Sprite{
		public static var so:SharedObject
		public function SOHandler(){
			so = SharedObject.getLocal("PacomixData")
		}
		public function setVar(value:Object,variableName:String):void{
			so.data[variableName]=value
			so.flush()
		}
		public function getVar(variableName:String):Object{
			return so.data[variableName]
		}

	}
}