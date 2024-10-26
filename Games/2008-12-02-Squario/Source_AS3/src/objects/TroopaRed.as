/**
* ...
* @author Default
* @version 0.1
*/
package objects {
	import flash.display.*;
	import mx.core.BitmapAsset;
	import flash.media.Sound;
	public class TroopaRed extends Enemy{
		private var Mode:uint=0;
		private var frame:uint=0;
		private var fall:Boolean=false;
		private var wait:uint=0;
		private var waiter:uint=0;
		private var num:uint=0;
		private var GFX:Array=new Array(6);
		private var SFXStomp:Sound=new (Mario.classSFX.accessSFX("stompduck"));
		public function TroopaRed(Xpos:uint,Ypos:uint) {
			eX = Xpos;
			eY = Ypos;
			eWid = 21;
			dir=Player.pX>eX?1:-1;
			eHei = 21;
			GFX[0]=new (Mario.classGFX.AccessGFX("enemy_koopa_red_1"));
			GFX[1]=new (Mario.classGFX.AccessGFX("enemy_koopa_red_2"));
			GFX[2]=new (Mario.classGFX.AccessGFX("enemy_shell_red_1"));
			GFX[3]=new (Mario.classGFX.AccessGFX("enemy_shell_red_2"));
			GFX[4]=new (Mario.classGFX.AccessGFX("enemy_shell_red_3"));
			GFX[5]=new (Mario.classGFX.AccessGFX("enemy_shell_red_4"));
			GFX[0].x=eX-3;
			GFX[0].y=eY-5;
			Mario.layerFore.addChild(GFX[0]);
		}
		override public function Update(myID:uint):void{
			if (active){
				var GFXclass:Class;
				if (Mode==0){
					eX += dir;
					if (dir > 0) {
						if (Mario.enemyBounce(myID, eX+eWid-1, eY, 2, eHei)==false){
							if (Mario.levelColl(eX+eWid-1, eY) || Mario.levelColl(eX+eWid-1, eY+eHei-1)) {
								dir*=-1;
								eX += dir;
							} else if (gravity<1 && Mario.levelColl(eX+eWid,eY+eHei)==false){
								dir*=-1;
								eX += dir;
							}
						} else { 
							dir*=-1;
							eX += dir;
						}
					} else {
						if (Mario.enemyBounce(myID, eX-1, eY, 2, eHei)==false){
							if (Mario.levelColl(eX-1,eY+eHei)==false || Mario.levelColl(eX, eY) || Mario.levelColl(eX, eY+eHei-1)) {
								dir*=-1
								eX += dir;
							} else if (gravity>1 && Mario.levelColl(eX-1,eY+eHei)==false){
								dir*=-1;
								eX += dir;
							}
						} else { 
							dir*=-1;
							eX += dir;
						}
					}
					gravity += Mario.gravity;
					if (gravity > 10) {gravity = 10;}
					eY += Math.round(gravity);
					if (gravity>1){fall=true;}
					if (gravity>0){
						if (Mario.levelColl(eX, eY+eHei-1) || Mario.levelColl(eX+eWid-1, eY+eHei-1)) {
							gravity = 0
							eY = Math.floor(eY / 25) * 25 + 4
							if (fall){
								dir=Player.pX>eX?1:-1;
								fall=false;
							}
						}
					}
					wait++
					if (wait==15){
						Mario.layerFore.removeChild(GFX[frame]);
						frame=(frame+1)%2
						Mario.layerFore.addChild(GFX[frame]);
						wait=0;
					}
					GFX[frame].scaleX=dir;
					GFX[frame].x=eX-2+(dir==1?0:25);
					GFX[frame].y=eY-16;
					if (Mario.playerCollide(eX, eY, eWid, eHei)){
						if (Player.Falls()){
							if (Player.hitStomp==false){
								Mario.stompSetDistance(myID,eX);
							}
						} else {
							Mario.hitPlayer();
						}
					}
				}
			} else {
				if (Player.pX+250>eX && Player.pX-250<eX){
					active=true;
				}
			}
			if (eY>Mario.levelHei*25+250){Fire(myID,1);}
		}
		private function makeShell():void {
			Mario.layerFore.removeChild(GFX[frame]);
			frame=2
			GFX[frame].x=eX-2;
			GFX[frame].y=eY-1;
			Mario.layerFore.addChild(GFX[frame]);
		}
		override public function Fire(myID:uint,dir:int):Boolean {
			Mario.layerFore.removeChild(GFX[frame]);
			Mario.removeEnemy(myID);
			alive=false;
			Mario.instEffects.push(new Enemy_Fire(eX-2,eY-1,Mario.Sign(dir)*3,Mario.classGFX.AccessGFX("enemy_shell_red_1")));
			return true
		}
		override public function Stomp(myID:uint):void {
			Player.hitStomp=true;
			Player.Bounce(eY);
			if (Mario.sounds){SFXStomp.play();}
		}
	}
}
