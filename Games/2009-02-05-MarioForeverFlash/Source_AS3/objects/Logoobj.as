package objects {
	import flash.display.*
	import mx.core.BitmapAsset;
	/**
	* ...
	* @author $(DefaultUser)
	*/
	public class Logoobj extends Sprite{
		public var black:Sprite=new Sprite
		public var a:Number=0
		public var gfx:BitmapAsset;
		[Embed(source="../logo3.png")] private var logx:Class;
		public function Logoobj(){
			gfx=new logx;
			addChild(gfx)
			addChild(black)
			black.graphics.beginFill(0x000000)
			black.graphics.drawRect(0,0,400,375)
			black.graphics.endFill()
		}
		public function Step():void{
			a+=0.05
			black.alpha=1-a/2
			if (a>8){
				black.alpha=a-8
			}
		}
	}
	
}