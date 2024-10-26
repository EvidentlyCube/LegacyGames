/**
* ...
* @author Default
* @version 0.1
*/
package objects {
	import flash.display.*;
	import flash.media.Sound;
	import mx.core.BitmapAsset;
	public class Goomba extends Enemy{
		private var frame:uint=0;
		private var GFX:BitmapAsset;
		private var SFXStomp:Sound=new (Mario.classSFX.accessSFX("stomp"));
		public function Goomba(Xpos:uint,Ypos:uint) {
			eX = Xpos;
			eY = Ypos;
			eWid = 21;
			dir=Player.pX>eX?1:-1;
			eHei = 21;
			var GFXclass:Class=Mario.classGFX.AccessGFX("enemy_goomba");
			GFX = new GFXclass;
			GFX.x=eX-2+(frame>15?25:0);
			GFX.y=eY-4;
			Mario.layerFore.addChild(GFX);
		}
		override public function Update(myID:uint):void{
			if (active){
				stomped=false;
				eX += dir;
				if (dir > 0) {
					if (Mario.enemyBounce(myID, eX+eWid-1, eY, 2, eHei)==false){
						if (Mario.levelColl(eX+eWid-1, eY) || Mario.levelColl(eX+eWid-1, eY+eHei-1)) {
							dir*=-1;
							eX += dir;
						}
					} else { 
						dir*=-1;
						eX += dir;
					}
				} else {
					if (Mario.enemyBounce(myID, eX, eY, 2, eHei)==false){
						if (Mario.levelColl(eX, eY) || Mario.levelColl(eX, eY+eHei-1)) {
							dir*=-1
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
				if (gravity>0){
					if (Mario.levelColl(eX, eY+eHei-1) || Mario.levelColl(eX+eWid-1, eY+eHei-1)) {
						gravity = 0
						eY = Math.floor(eY / 25) * 25 + 4;
					}
				}
				if (Mario.playerCollide(eX, eY, eWid, eHei)){
					if (Player.Falls()){
						if (Player.hitStomp==false){
							Mario.stompSetDistance(myID,eX);
						}
					} else {
						Mario.hitPlayer();
					}
				}
				frame=(frame+1)%30;
				if (frame>15){GFX.scaleX=-1;} else {GFX.scaleX=1;}
				GFX.x=eX-2+(frame>15?25:0);
				GFX.y=eY-4;
			} else {
				if ((Player.pX+250>eX && Player.pX-250<eX) || Mario.scrollEdge+400>eX){
					active=true;
				}
			}
			if (eY>Mario.levelHei*25+250){Fire(myID,1);}
		}
		override public function Fire(myID:uint,dir:int):Boolean {
			Mario.layerFore.removeChild(GFX);
			Mario.removeEnemy(myID);
			Mario.instEffects.push(new Enemy_Fire(eX-2,eY-4,Mario.Sign(dir)*3,Mario.classGFX.AccessGFX("enemy_goomba")));
			return true;
		}
		override public function Stomp(myID:uint):void {
			Mario.instEffects.push(new Points(eX+10,eY-5,"100"));
			Player.hitStomp=true;
			Player.Bounce(eY);
			Mario.layerFore.removeChild(GFX);
			Mario.removeEnemy(myID);
			Mario.instEffects.push(new Goomba_Stomped(eX,eY));
			if (Mario.sounds){SFXStomp.play();}
		}
	}
}
