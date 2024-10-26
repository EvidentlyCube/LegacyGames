package  Obs
{
	import mx.core.BitmapAsset;
	/**
	 * ...
	 * @author DefaultUser (Tools -> Custom Arguments...)
	 */
	public class Pointer{
		[Embed(source = "/../assets/gfx/gfx5.png")] private var GFC:Class;
		public static var GFX:BitmapAsset
		public static var x:int = 0
		public static var y:int = 0
		public function Pointer(){
			GFX = new GFC;
			Game.layertop.addChild(GFX)
		}
		public static function Initia():void {

			GFX.x = 30 * x
			GFX.y = 30*y
		}
		public static function Update(mx:uint, my:uint):void {
			x = Math.floor(mx / 30)
			y=Math.floor(my/30)
			GFX.x = 30 * x
			GFX.y = 30 * y
		}
	}

}