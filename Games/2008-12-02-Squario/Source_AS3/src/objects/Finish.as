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
			GFXArr.x=fX;
			GFXArr.y=fY;
			Mario.layerEffects.addChild(GFXArr);
		}
		public function Update(myID:uint):void{
			if (!collected){
				if (Mario.playerCollide(fX+20,fY+20,500,5)){
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