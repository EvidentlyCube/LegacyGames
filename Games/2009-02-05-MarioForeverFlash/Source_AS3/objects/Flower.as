/**
* ...
* @author Default
* @version 0.1
*/

package objects {
	import flash.display.*;
	import mx.core.BitmapAsset;
	public class Flower extends Obj{
		public var oWid:uint=25;
		public var oHei:uint=25;
		public var seq:Boolean=false;
		public var frame:uint=0;
		public var wait:uint=0
		public var GFX:Array=new Array(4);
		public function Flower(Xpos:uint, Ypos:uint){
			oX=Xpos;
			oY=Ypos;
			GFX[0]=new (Mario.classGFX.AccessGFX("object_flower_1"));
			GFX[1]=new (Mario.classGFX.AccessGFX("object_flower_2"));
			GFX[2]=new (Mario.classGFX.AccessGFX("object_flower_3"));
			GFX[3]=new (Mario.classGFX.AccessGFX("object_flower_4"));
			GFX[0].x=oX;
			GFX[0].y=oY;
			Mario.layerHide.addChild(GFX[0]);
		}
		override public function Update(myID:uint):void{
			if (seq==false){
				oY-=0.5;
				if (Mario.levelColl(oX+12,oY+24)==false){
					seq=true;
				}
			}
			wait++;
			if (wait==2){
				Mario.layerHide.removeChild(GFX[frame]);
				frame=(frame+1)%4;
				Mario.layerHide.addChild(GFX[frame]);
				wait=0;
			}
			GFX[frame].x=oX;
			GFX[frame].y=oY;
			if (seq){
				if (Mario.playerCollide(oX, oY, oWid, oHei)){
					Mario.instEffects.push(new Points(oX+12,oY-5,"1000"));
					Mario.playerBonus(1);
					Mario.layerHide.removeChild(GFX[frame]);
					Mario.removeObject(myID);
				}
			}
		}
	}
}