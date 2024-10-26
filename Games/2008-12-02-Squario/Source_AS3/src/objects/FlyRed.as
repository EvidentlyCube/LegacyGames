/**
* ...
* @author Default
* @version 0.1
*/
package objects {
	import flash.display.*;
	import flash.media.Sound;
	import mx.core.BitmapAsset;
	public class FlyRed extends Enemy{
		private var frame:uint=0;
		private var wait:uint=0;
		private var starty:uint;
		private var ydir:Number;
		private var GFX:Array=new Array(2);
		private var SFXStomp:Sound=new (Mario.classSFX.accessSFX("stompduck"));
		public function FlyRed(Xpos:uint,Ypos:uint) {
			eX = Xpos;
			eY = Ypos;
			starty=eY;
			eWid = 21;
			dir=Player.pX>eX?1:-1;
			ydir=0.1
			eHei = 21;
			GFX[0]=new (Mario.classGFX.AccessGFX("enemy_fly_red_1"));
			GFX[1]=new (Mario.classGFX.AccessGFX("enemy_fly_red_2"));
			GFX[0].x=eX-3;
			GFX[0].y=eY-5;
			Mario.layerFore.addChild(GFX[0]);
		}
		override public function Update(myID:uint):void{
			if (active){
				var GFXclass:Class;
				dir=Player.pX>eX?1:-1;
				gravity+=ydir
				eY+=gravity
				gravity=gravity>2?2:(gravity<-2?-2:gravity)
				if (eY>starty+100){ydir=-0.1;}
				if (eY<starty){ydir=0.1;}
				wait++;
				if (wait==15){
					Mario.layerFore.removeChild(GFX[frame]);
					frame=1-frame;
					Mario.layerFore.addChild(GFX[frame]);
					wait=0;
				}
				GFX[frame].scaleX=dir;
				GFX[frame].x=eX-2+(dir==1?0:24);
				GFX[frame].y=eY-16;
				if (Mario.playerCollide(eX, eY, eWid, eHei)){
					if (Player.pY-Player.gravity+Player.pHei<=eY+5){
						if (Player.hitStomp==false){
							Mario.stompSetDistance(myID,eX);
						}
					} else {
						Mario.hitPlayer();
					}
				}
			} else {
				if (Player.pX+250>eX && Player.pX-250<eX){
					active=true;
				}
			}
			if (eY>Mario.levelHei*25+250){Fire(myID,1);}
		}
		override public function Fire(myID:uint,dir:int):Boolean {
			Mario.layerFore.removeChild(GFX[frame]);
			Mario.removeEnemy(myID);
			alive=false;
			Mario.instEffects.push(new Enemy_Fire(eX-2,eY-1,Mario.Sign(dir)*3,Mario.classGFX.AccessGFX("enemy_fly_red_1")));
			return true
		}
		override public function Stomp(myID:uint):void {
			Mario.layerFore.removeChild(GFX[frame]);
			Mario.removeEnemy(myID);
			alive=false;
			Mario.instEnemies.push(new TroopaRed(eX,eY));
			Player.hitStomp=true;
			Player.Bounce(eY);
			if (Mario.sounds){SFXStomp.play();}
		}
	}
}
