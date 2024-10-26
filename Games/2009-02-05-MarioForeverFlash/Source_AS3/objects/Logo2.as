package objects 
{
	import flash.display.Sprite;
	import mx.core.BitmapAsset;
	/**
	* ...
	* @author $(DefaultUser)
	*/
	public class Logo2 	{
		[Embed(source="../logo.png")]	private var LOGO:Class;
		public var GFX:Sprite=new Sprite
		public var GFX2:BitmapAsset
		public var timer:uint
		public function Logo2(){
			GFX2=new LOGO;
			GFX.graphics.beginFill(0x000070)
			GFX.graphics.drawRect(0,0,400,375)
			GFX.graphics.endFill()
			GFX2.alpha=0
			GFX.addChild(GFX2)
		}
		public function Update():void{
			timer++
			if (timer<150){
				GFX2.alpha=Math.min(GFX2.alpha+0.05,1)
			} else {
				GFX2.alpha-=0.1
			}
		}
	}
	
}