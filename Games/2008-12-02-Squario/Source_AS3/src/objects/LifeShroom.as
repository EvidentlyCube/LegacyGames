/**
* ...
* @author Default
* @version 0.1
*/

package objects {
	import flash.display.*;
	import flash.media.Sound;
	import mx.core.BitmapAsset;
	public class LifeShroom extends Obj{
		public var oWid:uint=21;
		public var oHei:uint=21;
		public var dir:int;
		public var gravity:Number=0;
		public var seq:Boolean=false;
		public var GFX:BitmapAsset;
		private var SFX:Sound=new (Mario.classSFX.accessSFX("life"));
		public function LifeShroom(Xpos:uint, Ypos:uint){
			oX=Xpos;
			oY=Ypos;
			var GFXclass:Class=Mario.classGFX.AccessGFX("object_lifeshroom");
			GFX = new GFXclass;
			GFX.x=oX;
			GFX.y=oY;
			Mario.layerHide.addChild(GFX);
		}
		override public function Update(myID:uint):void{
			if (seq){
				oX += dir;
				if (dir > 0) {
					if (Mario.levelColl(oX+oWid-1, oY) || Mario.levelColl(oX+oWid-1, oY+oHei-1)) {
						dir*=-1;
						oX += dir;
					}
				} else {
					if (Mario.levelColl(oX, oY) || Mario.levelColl(oX, oY+oHei-1)) {
						dir*=-1
						oX += dir;
					}
				}
				gravity += Mario.gravity;
				if (gravity > 10) {gravity = 10;}
				oY += Math.round(gravity);
				if (gravity>0){
					if (Mario.levelColl(oX, oY+oHei-1) || Mario.levelColl(oX+oWid-1, oY+oHei-1)) {
						gravity = 0
						oY = Math.floor(oY / 25) * 25+4
					}
				}
				if (Mario.playerCollide(oX, oY, oWid, oHei)){
					Mario.instEffects.push(new Points(oX+10,oY-5,"1up"));
					if(Mario.sounds){SFX.play();}
					Mario.layerFore.removeChild(GFX);
					Mario.removeObject(myID);
				}
				GFX.x=oX-2;
				GFX.y=oY-4;
			} else {
				oY-=0.5;
				GFX.x=oX;
				GFX.y=oY;
				if (Mario.levelColl(oX+12,oY+24)==false){
					Mario.instEffects.push(new Points(oX+10,oY-5,"1000"));
					Mario.layerHide.removeChild(GFX)
					oX+=2;
					oY+=4;
					var GFXclass:Class=Mario.classGFX.AccessGFX("object_lifeshroom");
					GFX = new GFXclass;
					GFX.x=oX-2;
					GFX.y=oY-4;
					Mario.layerFore.addChild(GFX);
					dir=Player.pX-oX>0?1:-1;
					seq=true;
				}
			}
			if (oY>Mario.levelHei*25+250){
				Mario.layerFore.removeChild(GFX);
				Mario.removeObject(myID);
			}
		}
	}
}