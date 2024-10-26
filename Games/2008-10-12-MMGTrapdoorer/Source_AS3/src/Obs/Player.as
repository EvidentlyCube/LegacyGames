package Obs{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.media.Sound;
	import mx.core.BitmapAsset;
	/**
	 * ...
	 * @author DefaultUser (Tools -> Custom Arguments...)
	 */
	public class Player {
		[Embed(source = "/../assets/gfx/gfx4.png")] private var GFC:Class;
		[Embed(source = "/../assets/sfx/jump.mp3")] private var S1:Class;
		[Embed(source = "/../assets/sfx/complete.mp3")] private var S2:Class;
		[Embed(source = "/../assets/sfx/jump2.mp3")] private var S3:Class;
		public static var x:uint=0
		public static var y:uint=0
		public static var z:Number=2
		public static var state:uint=3
		public static var PI:Number
		public static var movex:int=0
		public static var movey:int=0
		public static var movestate:int
		public static var GFX:Sprite=new Sprite
		public static var SFX1:Sound
		public static var SFX2:Sound
		public static var SFX3:Sound
		public static var pipe:Boolean=false
		public function Player() {
			var GFC2:BitmapAsset=new GFC;
			GFX.addChild(GFC2)
			GFC2.x=-15
			GFC2.y=-15
			PI=Math.PI
			SFX1=new S1
			SFX2=new S2
			SFX3=new S3
			Initia()
		}
		public static function Initia():void{
			GFX.x = x+15
			GFX.y = y+15
			Game.layertop.addChildAt(GFX, 0)
			GFX.alpha=0
		}
		public static function Update():void{
			switch (state){
				case 0:
					GFX.alpha=Math.sin(PI*z/2)
					GFX.scaleX=z
					GFX.scaleY=z
					GFX.x=x+15
					GFX.y=y+15
					if (z>0) {z-=0.1} else {state=3;Game.fillLevel(Game.lid);pipe=false;return;}
					if (z<=1){
						if (Game.At(x/30,y/30)!=null){
							state=1
							GFX.alpha=1
							GFX.scaleX=1
							GFX.scaleY=1
							z=1
						} else {
							if (pipe==false){
								if (Sounder.on){SFX3.play()}
								pipe=true
							}
						}
					}
					break;
				case 2:
					x+=Game.Sign(movex)*5
					y+=Game.Sign(movey)*5
					movex-=Game.Sign(movex)*5
					movey-=Game.Sign(movey)*5
					movestate-=5
					z=1+Math.sin((PI/30)*movestate)/3
					GFX.scaleX=z
					GFX.scaleY=z
					GFX.x=x+15
					GFX.y=y+15
					if (movestate==0){
						if (Game.At(x/30,y/30)!=null){
							if ((Game.At(x/30,y/30)).type==3 && Block.count==0){
								gotoNextLevel();
								return;
							}
							state=1
							GFX.alpha=1
							GFX.scaleX=1
							GFX.scaleY=1
							z=1
						} else {
							state=0
						}
					}
					break;
			}
		}

		public static function gotoNextLevel(): void {
			Game.lid++;
			Game.fillLevel(Game.lid)
			state=3
			z=2
			GFX.alpha=0
			GFX.scaleX=z
			GFX.scaleY=z
			GFX.x=x+15
			GFX.y=y+15
			if (Sounder.on){SFX2.play()}
		}
		public static function Clicked(mx:uint,my:uint, skipJumpAnimation: Boolean = false):void{
			while (skipJumpAnimation && state === 2) {
				Update();
			}

			switch (state) {
				case 3:
					state=0
					x=mx*30
					y=my*30
					z=2
					if (Sounder.on){SFX3.play()}
					break;
				case 1:
					if (Math.abs(mx-x/30)<=1 && Math.abs(my-y/30)<=1){
						state=2
						movex=mx*30-x
						movey=my*30-y
						movestate=30
						if (Sounder.on){SFX1.play()}
						if (movex!=0 || movey!=0){
							var blo:Block=Game.At(x/30,y/30)
							if (blo!=null){blo.Hit()}
						}
					}
			}
		}
	}

}