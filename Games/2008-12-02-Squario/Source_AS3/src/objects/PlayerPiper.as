package objects {
	import flash.display.Shape;
	import flash.media.Sound;
	import mx.core.BitmapAsset;
	/**
	* ...
	* @author Default
	*/
	public class PlayerPiper {
		public var pX:int;
		public var pY:int;
		public var gX:int=0;
		public var gY:int=0;
		public var moveX:int;
		public var moveY:int;
		public var enter:Boolean;
		public var GFX:BitmapAsset;
		public var completed:Boolean=false;
		public function PlayerPiper(peX:int,peY:int,mX:int,mY:int,en:Boolean) {
			pX=peX;
			pY=peY;
			moveX=mX;
			moveY=mY;
			enter=en;
			if (moveX!=0){
				GFX=new (Mario.classGFX.AccessGFX("object_mario"+String(Player.pSize)+"_walk_3"));
				gX=mX>0?0:25;
				gY=Player.pSize>0?0:-21;
				pY-=Player.pSize>0?21:0;
				GFX.scaleX=mX;
			} else {
				GFX=new (Mario.classGFX.AccessGFX("object_mario"+String(Player.pSize)+"_enter"));
				gY=Player.pSize>0?0:-21;
			}
			GFX.x=pX+gX;
			GFX.y=pY+gY
			Mario.layerHide.addChild(GFX);
		}
		public function Update():void{
			pX+=moveX;
			pY+=moveY;
			GFX.x=pX+gX;
			GFX.y=pY+gY;
			if (enter){
				if (Mario.levelColl(pX,pY) &&
					Mario.levelColl(pX+Player.pWid-1,pY) &&
					Mario.levelColl(pX,pY+Player.pHei-1) &&
					Mario.levelColl(pX+Player.pWid-1,pY+Player.pHei-1)){
						completed=true;
					}
			} else {
				if (Mario.levelColl(pX,pY)==false &&
					Mario.levelColl(pX+Player.pWid-1,pY)==false &&
					Mario.levelColl(pX,pY+Player.pHei-1)==false &&
					Mario.levelColl(pX+Player.pWid-1,pY+Player.pHei-1)==false){
						completed=true;
					}
			}
			Mario.centerScreen(pX)
		}
	}
	
}