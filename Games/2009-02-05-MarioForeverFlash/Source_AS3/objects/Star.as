/**
* ...
* @author Default
* @version 0.1
*/

package objects {
	import flash.display.*;
	import mx.core.BitmapAsset;
	public class Star extends Obj{
		public var oWid:uint=21;
		public var oHei:uint=21;
		public var dir:int;
		public var gravity:Number=0;
		public var seq:Boolean=false;
		public var GFX:Array=new Array(4)
		public var wait:uint=0
		public var frame:uint=0
		public function Star(Xpos:uint, Ypos:uint){
			oX=Xpos;
			oY=Ypos;
			GFX[0]=new (Mario.classGFX.AccessGFX("object_star_1"));
			GFX[1]=new (Mario.classGFX.AccessGFX("object_star_2"));
			GFX[2]=new (Mario.classGFX.AccessGFX("object_star_3"));
			GFX[3]=new (Mario.classGFX.AccessGFX("object_star_4"));
			GFX[0].x=oX;
			GFX[0].y=oY;
			Mario.layerHide.addChild(GFX[0]);
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
				gravity += Mario.gravity/2;
				if (gravity > 10) {gravity = 10;}
				oY += Math.round(gravity);
				if (gravity>0){
					if (Mario.levelColl(oX, oY+oHei-1) || Mario.levelColl(oX+oWid-1, oY+oHei-1)) {
						gravity = -5
						oY = Math.floor(oY / 25) * 25+4
					}
				}
				if (Mario.playerCollide(oX, oY, oWid, oHei)){
					Player.starMe()
					Mario.layerFore.removeChild(GFX[frame]);
					Mario.removeObject(myID);
					return
				}
				wait++
				if (wait==3){
					Mario.layerFore.removeChild(GFX[frame])
					frame=(frame+1)%4
					Mario.layerFore.addChild(GFX[frame])
					wait=0
				}
				GFX[frame].x=oX-2;
				GFX[frame].y=oY-4;
			} else {
				oY-=0.5;
				wait++
				if (wait==3){
					Mario.layerHide.removeChild(GFX[frame])
					frame=(frame+1)%4
					Mario.layerHide.addChild(GFX[frame])
					wait=0
				}
				GFX[frame].x=oX;
				GFX[frame].y=oY;
				if (Mario.levelColl(oX+12,oY+24)==false){
					Mario.instEffects.push(new Points(oX+10,oY-5,"1000"));
					Mario.layerHide.removeChild(GFX[frame])
					oX+=2;
					oY+=4;
					GFX[frame].x=oX-2;
					GFX[frame].y=oY-4;
					Mario.layerFore.addChild(GFX[frame]);
					dir=Player.pX-oX>0?1:-1;
					seq=true;
				}
			}
			if (oY>Mario.levelHei*25+250){
				Mario.layerFore.removeChild(GFX[frame]);
				Mario.removeObject(myID);
			}
		}
	}
}