package objects {
	import mx.core.BitmapAsset;
	import flash.display.Shape;
	import flash.display.Sprite;
	
	/**
	* ...
	* @author Default
	*/
	public class WaitScreen {
		public var GFX:Sprite = new Sprite();
		public var Back:Shape = new Shape();
		public var seq:uint=0;
		public var GFXHEAD:BitmapAsset;
		public var GFXX:BitmapAsset;
		public var GFXL1:BitmapAsset;
		public var GFXL2:BitmapAsset;
		public var timer:uint=0;
		public function WaitScreen() {
			Back.graphics.beginFill(0x000000);
			Back.graphics.drawRect(0,0,400,375);
			GFX.addChild(Back);
		}
		public function update():uint{
			switch(seq){
				case(0):
					Mario.Hud.RedrawWorld()
					Mario.classSFX.Play()
					var GFXclass:Class=Mario.classGFX.AccessGFX("font_head");
					GFXHEAD=new GFXclass();
					GFXclass=Mario.classGFX.AccessGFX("font_x");
					GFXX=new GFXclass();
					GFXHEAD.x=171;
					GFXHEAD.y=180;
					GFXX.x=200;
					GFXX.y=191;
					GFX.addChild(GFXHEAD)
					GFX.addChild(GFXX)
					setVar(Mario.Hud.Lives);
					seq=1
					return 0;
					break;
				case(1):
					timer++;
					if (timer==50){
						timer=0;
						seq=2;
					}
					return 1;
					break;
				case(2):
					clearAll();
					seq=0;
					if (Mario.music){Mario.classSFX.Play(Mario.musika)}
					Mario.self.ingameStep()
					return 2;
					break;
			}
			return 1;
		}
		public function setVar(Livs:uint):void{
			var GFXclass:Class=Mario.classGFX.AccessGFX("font_"+Math.floor(Livs/10));
			GFXL1=new GFXclass();
			GFXclass=Mario.classGFX.AccessGFX("font_"+(Livs%10));
			GFXL2=new GFXclass();
			GFXL1.x=217;
			GFXL1.y=190;
			GFXL2.x=229;
			GFXL2.y=190;
			GFX.addChild(GFXL1);
			GFX.addChild(GFXL2);
		}
		public function clearAll():void{
			GFX.removeChild(GFXL1);
			GFX.removeChild(GFXL2);
			GFX.removeChild(GFXHEAD);
			GFX.removeChild(GFXX);
		}
		
	}
	
}