/**
* ...
* @author Default
* @version 0.1
*/

package objects {
	import flash.display.*;
	import flash.media.Sound;
	import mx.core.BitmapAsset;
	public class PlayerFinish{
		public var pX:int;
		public  var pY:int;
		public const PLAYER_SPEED:Number = 12;
		private var gravity:Number = 0;
		public var speed:Number = 0;
		public var GFX:BitmapAsset;
		private var frame:uint = 0;
		private var timer:int=0;
		private var SFXPoint:Sound=new (Mario.classSFX.accessSFX("points"));
		public function PlayerFinish(iX:Number,iY:Number,grav:Number,spd:Number,frm:uint):void{
			pX=iX;
			pY=iY;
			speed=spd;
			frame=frm;
			gravity=grav;
			if (Player.crouch>0){
				Player.pHei+=25;
				pY-=21;
			}
			if (Mario.levelColl(pX,pY+Player.pHei) || Mario.levelColl(pX+Player.pWid,pY+Player.pHei)){
				GFX = new (Mario.classGFX.AccessGFX("object_mario"+String(Player.pSize)+"_walk_"+String(Math.ceil(frame/456))));
			} else {
				GFX = new (Mario.classGFX.AccessGFX("object_mario"+Player.pSize+"_jump"));
			}
			GFX.x=pX-3;
			GFX.y=pY-3-(Player.pSize==0?21:0);
			Mario.layerFore.addChild(GFX);
		}
		public function Update(myID:uint):void {
			Mario.classSFX.Play();
			if (speed>200){
				speed-=PLAYER_SPEED;
			} else if (speed<185){
				speed+=PLAYER_SPEED;
			}
			pX+=Math.round(speed/100);
			Mario.layerFore.removeChild(GFX);
			if (Mario.levelColl(pX,pY+Player.pHei)==false && Mario.levelColl(pX+Player.pWid,pY+Player.pHei)==false){
				gravity+=Mario.gravity;
				pY+=gravity
				frame=400;
				GFX = new (Mario.classGFX.AccessGFX("object_mario"+Player.pSize+"_jump"));
			} else {
				pY = Math.floor(pY / 25) * 25 + (Player.pSize > 0?5:1);
				frame=(frame+Math.abs(speed/3))%1367+1;
				GFX = new (Mario.classGFX.AccessGFX("object_mario"+String(Player.pSize)+"_walk_"+String(Math.ceil(frame/456))));
			}
			GFX.x=pX-3;
			GFX.y=pY-3-21;
			Mario.layerFore.addChild(GFX);
			if (timer>150){
				if (Mario.Hud.Time>0){
					Mario.Hud.Time--;
					Mario.Hud.Pnts+=100;
				}
				if (Mario.Hud.Time>4){
					Mario.Hud.Time-=4;
					if (Mario.sounds){SFXPoint.play()}
					Mario.Hud.Pnts+=20;
				}
				Mario.Hud.RedrawPnts();
				Mario.Hud.RedrawTime();
				if (Mario.Hud.Time==0){
					timer++;
				}
				if (timer==300){
					Mario.levelid++
					Mario.clearLevel();
				}
			} else {
				timer++;
			}
		}		
	}
}