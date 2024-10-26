package objects {
	import flash.media.Sound;
	import mx.core.BitmapAsset;
	/**
	* ...
	* @author Default
	*/
	public class Finish {
		public var fX:int;
		public var fY:int;
		public var bX:int;
		public var bY:int;
		public var dir:int=2;
		public var collected:Boolean=false;
		public var GFXArr:BitmapAsset;
		public var GFXBack:BitmapAsset;
		public var GFXBar:BitmapAsset;
		public var GFXFore:BitmapAsset;
		public var SFXComplete:Sound=new (Mario.classSFX.accessSFX("level_complete"));
		public function Finish(obX:int,obY:int){
			fX=obX;
			fY=obY;
			bX=obX+114;
			bY=0;
			GFXArr=new (Mario.classGFX.AccessGFX("finish_4"));
			GFXBack=new (Mario.classGFX.AccessGFX("finish_1"));
			GFXFore=new (Mario.classGFX.AccessGFX("finish_2"));
			GFXBar=new (Mario.classGFX.AccessGFX("finish_3"));
			GFXArr.x=fX;
			GFXArr.y=fY;
			GFXBack.x=fX+100;
			GFXBack.y=fY-200;
			GFXFore.x=fX+150;
			GFXFore.y=fY-200;
			GFXBar.x=bX;
			GFXBar.y=fY-bY;
			Mario.layerEffects.addChild(GFXArr);
			Mario.layerWall.addChild(GFXBack);
			Mario.layerEffects.addChild(GFXFore);
			Mario.layerFore.addChild(GFXBar);
		}
		public function Update(myID:uint):void{
			if (!collected){
				bY+=dir;
				if (bY==190){dir=-2;}
				if (bY==0){dir=2;}
				GFXBar.x=bX+2;
				GFXBar.y=fY-bY;
				if (Mario.playerCollide(bX,fY-bY,37,12)){
					collected=true;
					Mario.instEffects.push(new Enemy_Fire(bX,fY-bY,3,Mario.classGFX.AccessGFX("finish_3")));
					Mario.layerFore.removeChild(GFXBar);
					var czap:uint=Math.round(bY*6/190)
					Mario.instEffects.push(new Points(bX,fY-bY,Mario.givePointShell(czap)));
					Swap();
				} else if (Mario.playerCollide(fX+20,fY+20,500,5)){
					collected=true;
					Swap();
				}
			}
		}
		private function Swap():void{
			Mario.playerControllable=false;
			Mario.layerFore.removeChild(Player.GFX2);
			Mario.instEffects.unshift(new PlayerFinish(Player.pX,Player.pY,Player.gravity,Player.speed,Player.frame));
			Mario.classSFX.Play(-1)
			if (Mario.music){SFXComplete.play();}
		}
	}
	
}