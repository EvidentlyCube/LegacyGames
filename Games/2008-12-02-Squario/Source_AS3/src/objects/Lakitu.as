/**
* ...
* @author Default
* @version 0.1
*/
package objects {
	import flash.display.*;
	import flash.media.Sound;
	public class Lakitu extends Enemy{
		private var frame:uint=0;
		private var wait:uint=0;
		private var moveX:Number=0;
		private var GFX:Array=new Array(2);
		private var SFXStomp:Sound=new (Mario.classSFX.accessSFX("stomp"));
		public function Lakitu(Xpos:uint,Ypos:uint) {
			bounce=false;
			eX = Xpos;
			eY = Ypos;
			eWid = 22;
			eHei = 22;
			gravity=-4;
			GFX[0]=new (Mario.classGFX.AccessGFX("enemy_lakitu_1"));
			GFX[1]=new (Mario.classGFX.AccessGFX("enemy_lakitu_2"));
			GFX[0].x=eX-2;
			GFX[0].y=eY-12;
			Mario.layerFore.addChild(GFX[0]);
		}
		override public function Update(myID:uint):void{
			if (Player.pX+Player.speed/10>eX){
				moveX=Math.min(moveX+0.3,6)
			} else {
				moveX=Math.max(moveX-0.3,-6)
			}
			eX+=Math.round(moveX);
			if (wait<250){wait++;}
			var GFXclass:Class
			if (wait==250){
				if (Mario.levelColl(eX,eY-10)==false &&
			Mario.levelColl(eX,eY+10)==false &&
			Mario.levelColl(eX+20,eY-10)==false &&
			Mario.levelColl(eX+20,eY+10)==false){
					Mario.layerFore.removeChild(GFX[frame]);
					frame=0;
					wait=0;
					if (Mario.levelid==13){
						wait=50+Math.random()*50
					}
					Mario.layerFore.addChild(GFX[frame]);
					Mario.instEnemies.push(new SpinyShell(eX,eY-10));
				}
			} else if (wait==150){
				Mario.layerFore.removeChild(GFX[frame]);
				frame=1
				Mario.layerFore.addChild(GFX[frame]);
			}
			GFX[frame].x=eX-2;
			GFX[frame].y=eY-2;
			if (Mario.playerControllable && Mario.Collide(eX, eY, eWid, eHei, Player.pX, Player.pY+Player.pHei-1, Player.pWid, 1)){
				if (Player.Falls()){
					if (Player.hitStomp==false){
						Mario.stompSetDistance(myID,eX);
					}
				}
			}
		}
		override public function Fire(myID:uint,dir:int):Boolean {
			eX+=3000
			Mario.instEffects.push(new Enemy_Fire(eX-2,eY-12,Mario.Sign(dir)*3,Mario.classGFX.AccessGFX("enemy_lakitu_1")));
			return true
		}
		override public function Stomp(myID:uint):void {
			Mario.instEffects.push(new Points(eX+10,eY-5,"1000"));
			Player.hitStomp=true;
			Player.Bounce(eY);
			Mario.instEffects.push(new Lakitu_Stomped(eX,eY));
			eX+=3000
			if (Mario.sounds){SFXStomp.play()}
		}
	}
}
