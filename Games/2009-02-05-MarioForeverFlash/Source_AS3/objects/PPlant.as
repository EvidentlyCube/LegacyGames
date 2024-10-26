/**
* ...
* @author Default
* @version 0.1
*/
package objects {
	import flash.display.*;
	import mx.core.BitmapAsset;
	public class PPlant extends Enemy{
		private var frame:uint=0;
		private var timer:uint=0;
		private var wait:uint=0;
		private var GFX:Array=new Array(2);
		public function PPlant(Xpos:uint,Ypos:uint,d:int=1) {
			bounce=false;
			eX = Xpos+14;
			eY = Ypos;
			eWid = 20;
			dir=d
			eHei = 32;
			GFX[0]=new (Mario.classGFX.AccessGFX("enemy_pplant_1"));
			GFX[1]=new (Mario.classGFX.AccessGFX("enemy_pplant_2"));
			GFX[0].x=eX-2;
			GFX[0].y=eY-2+(dir==-1?38:0);
			GFX[0].scaleY=GFX[1].scaleY=dir
			Mario.layerHide.addChild(GFX[0]);
		}
		override public function Update(myID:uint):void{
			if (active){
				if (dir==1){
					if (timer<100){
						timer++;
					} else if (timer==100){
						if (Player.pX-eX<-72 || Player.pX-eX>50){timer=101;}
					} else if (timer==101){
						eY--;
						if (Mario.levelColl(eX,eY+eHei-1)==false){
							timer=102;
						}
					} else if (timer<160){
						timer++;
					} else if (timer==160){
						eY++;
						if (Mario.levelColl(eX,eY-3)){
							timer=0;
						}
					}
				} else {
					if (timer<100){
						timer++;
					} else if (timer==100){
						if (Player.pX-eX<-72 || Player.pX-eX>50){timer=101;}
					} else if (timer==101){
						eY++;
						if (Mario.levelColl(eX,eY)==false){
							timer=102;
						}
					} else if (timer<160){
						timer++;
					} else if (timer==160){
						eY--;
						if (Mario.levelColl(eX,eY+eHei+3)){
							timer=0;
						}
					}
				}
				if (Mario.playerCollide(eX, eY, eWid, eHei)){
					Mario.hitPlayer();
				}
				
				wait++;
				if (wait==15){
					Mario.layerHide.removeChild(GFX[frame]);
					frame=1-frame;
					Mario.layerHide.addChild(GFX[frame]);
					wait=0;
				}
				GFX[frame].x=eX-2;
				GFX[frame].y=eY-2+(dir==-1?38:0);
			} else {
				if (Player.pX+250>eX && Player.pX-250<eX){
					active=true;
					timer=100;
				}
			}
		}
		override public function Fire(myID:uint,dir:int):Boolean {
			Mario.layerHide.removeChild(GFX[frame]);
			Mario.removeEnemy(myID);
			return true;
		}
	}
}
