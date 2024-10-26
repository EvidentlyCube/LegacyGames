/**
* ...
* @author Default
* @version 0.1
*/

package objects {
	import flash.display.*;
	import flash.geom.ColorTransform;
	import flash.media.Sound;
	import mx.core.BitmapAsset;
	public class Player{
		public static var pSize:uint=0;
		public static var pWid:uint=22;
		public static var pHei:uint=24;
		public static var pX:int;
		public static var pY:int;
		public static const PLAYER_SPEED:Number = 12;
		public static const PLAYER_MAXSPEED:Number = PLAYER_SPEED*38;
		public static var hitStomp:Boolean=false;
		public static var hitHead:Boolean=false;
		public static var dir:int=1;
		public static var gravity:Number = 0;
		public static var speed:Number = 0;
		private static var jumper:uint = 0;
		public static var GFX:BitmapAsset;
		public static var GFX2:Sprite=new Sprite
		private static var maxJumper:uint = 0;
		public static var frame:uint = 0;
		private static var seq:uint=0;
		public static var crouch:uint=0;
		public static var sequence:int=0;
		public static var sequenceFrame:uint=0;
		public static var shield:uint=0;
		public static var fired:uint=0;
		public static var elev:Elevator;
		public static var starred:uint=0
		public static var trans:ColorTransform=new ColorTransform()
		private var SFXJump:Sound=new (Mario.classSFX.accessSFX("jump"));
		private var SFXRadish:Sound=new (Mario.classSFX.accessSFX("radish"));
		public static var SFXPowerup:Sound=new (Mario.classSFX.accessSFX("powerup"));
		public static var SFXPowerdown:Sound=new (Mario.classSFX.accessSFX("powerdown"));
		public static var SFXDeath:Sound=new (Mario.classSFX.accessSFX("death"));
		private var SFXBump:Sound=new (Mario.classSFX.accessSFX("bump"));
		public var SFXKick:Sound=new (Mario.classSFX.accessSFX("kick"));
		public function Player(iX:Number,iY:Number):void{
			
			pX=iX;
			pY=iY;
			var GFXclass:Class=Mario.classGFX.AccessGFX("object_mario0_walk_1");
			GFX = new GFXclass;
			GFX.x=pX-2;
			GFX.y=pY-3;
			GFX2.addChild(GFX);
			Mario.layerFore.addChild(GFX2)
		}
		public function Update():void {
			//KEYBOARD TESTS
			seq=0;
			if (pSize>0){
				if (Mario.isKeyDown(1)){
					if (crouch==0){
						pHei=24;
						pY+=21;
						crouch=1;
					}
				} else if (crouch==1 && (Mario.levelColl(pX,pY+pHei) || Mario.levelColl(pX+pWid-1,pY+pHei))){
					pHei=45;
					pY-=21;
					crouch=2;
				}
			} else {crouch=0;}
			if (crouch==0){
				if (Mario.isKeyDown(0)) {
					dir=1;
					if (speed>-10) {
						if (speed<PLAYER_MAXSPEED){
							speed+=PLAYER_SPEED;
						}
					} else {
						dir=-1;
						seq=1;
						speed+=PLAYER_SPEED*2;
					}
				} else if (Mario.isKeyDown(2)){
					dir=-1;
					if (speed<10) {
						if (speed>-PLAYER_MAXSPEED){
							speed-=PLAYER_SPEED;
						}
					} else {
						dir=1;
						seq=1;
						speed-=PLAYER_SPEED*2;
					}
				} else {
					if (speed>2){
						speed-=PLAYER_SPEED/2;
					}else if (speed<-2){
						speed+=PLAYER_SPEED/2;
					}
				}
			} else if (Mario.levelColl(pX, pY+pHei)==false && Mario.levelColl(pX+pWid-1, pY+pHei)==false){
				if (Mario.isKeyDown(0)) {
					dir=1;
					if (speed>-10) {
						if (speed<PLAYER_MAXSPEED){
							speed+=PLAYER_SPEED;
						}
					} else {
						dir=-1;
						seq=1;
						speed+=PLAYER_SPEED*2;
					}
				} else if (Mario.isKeyDown(2)){
					dir=-1;
					if (speed<10) {
						if (speed>-PLAYER_MAXSPEED){
							speed-=PLAYER_SPEED;
						}
					} else {
						dir=1;
						seq=1;
						speed-=PLAYER_SPEED*2;
					}
				} else {
					if (speed>2){
						speed-=PLAYER_SPEED/2;
					}else if (speed<-2){
						speed+=PLAYER_SPEED/2;
					}
				}
			} else {
				if (Mario.isKeyDown(0)) {
					dir=1;
				} else if (Mario.isKeyDown(2)){
					dir=-1;
				}
				if (speed>2){
					speed-=PLAYER_SPEED;
				}else if (speed<-2){
					speed+=PLAYER_SPEED;
				}
			}
			if (Mario.isKeyPressed(4) && (elev!=null || Mario.levelColl(pX, pY+pHei+1) || Mario.levelColl(pX+pWid-1, pY+pHei+1))) {
				gravity = -7;
				jumper = 1;
				maxJumper = 16-3+Math.min(3, Math.abs(speed/100));
				if (elev){elev.free();}
				if (Mario.sounds){SFXJump.play();}
			}
			if (Mario.isKeyDown(4) && jumper<maxJumper && jumper>0){
				jumper++;
				gravity = -7;
			} else {jumper=20;}
			if (crouch<2){
				//Horizontal Movement
				pX += Math.round(speed/100);
				if (speed > 0) {
					if (Mario.levelColl(pX+pWid-1, pY) || Mario.levelColl(pX+pWid-1, pY+pHei-1) || Mario.levelColl(pX+pWid-1, pY+(pHei-1)/2)) {
						speed = 0;
						pX = Math.floor(pX / 25) * 25+25-pWid;
					}
				} else {
					if (Mario.levelColl(pX, pY) || Mario.levelColl(pX, pY+pHei-1) || Mario.levelColl(pX, pY+(pHei-1)/2)) {
						speed = 0;
						pX = Math.floor(pX / 25) * 25+25;
					}
				}
				//Vertical Movement
				if (gravity > 10) {gravity = 10;}
				if (elev==null && Mario.levelColl(pX, pY+pHei)==false && Mario.levelColl(pX+pWid-1, pY+pHei)==false){
					gravity += Mario.gravity;
					seq=2;
				} else if (gravity>=0){gravity=0;}
				pY += Math.round(gravity)
				if (gravity>0){
					if (Mario.levelColl(pX, pY+pHei-1) || Mario.levelColl(pX+pWid-1, pY+pHei-1)) {
						jumper = 0;
						gravity = 0;
						pY = Math.floor(pY / 25) * 25 + (crouch==0?(pSize > 0?5:1):1);
						seq=0;
					}
				} else {
					if (Mario.levelColl(pX, pY) || Mario.levelColl(pX+pWid-1, pY)) {
						jumper = 0;
						gravity = 0;
						Player.hitHead=true;
						if (Mario.sounds){SFXBump.play();}
						pY = Math.floor(pY / 25) * 25+25;
					}
				}
			} else{
				if (Mario.levelColl(pX, pY+pHei-1) ||
					Mario.levelColl(pX+pWid-1, pY) ||
					Mario.levelColl(pX+pWid-1, pY+pHei-1) ||
					Mario.levelColl(pX, pY)){
						pX+=2;
					} else {crouch=0;}
			}
			var GFXclass:Class;
			var size:uint=pSize;
			var visible:uint=0;
			if (sequence!=0){
				sequenceFrame--;
				if (sequenceFrame%2==1){
					switch(sequence){
						case(-2):size=2;break;
						case(-1):size=1;break;
						case(1):size=0;break;
						case(2):size=1;break;
					}
				} 
				if (sequenceFrame==0){
					sequence=0;
				}
			} else if (shield>0){
				visible=shield%2;
				shield--;
			}
			if (crouch==1){
				GFXclass=Mario.classGFX.AccessGFX("object_mario"+size+"_crouch");
			} else if (pSize==2 && Mario.isKeyPressed(5) && Mario.radishNO<2){
				Mario.instObjects.push(new Fireball(pX+(dir==1?22:0),pY+10,dir));
				Mario.radishNO++;
				if (Mario.sounds){SFXRadish.play();}
				GFXclass=Mario.classGFX.AccessGFX("object_mario2_fire");
				fired=4;
			} else if (fired>0){
				GFXclass=Mario.classGFX.AccessGFX("object_mario2_fire");
				fired--;
			} else {
				switch(seq){
					case(0):
						frame=(frame+Math.abs(speed/3))%1367+1;
						if (Math.abs(speed)<10){
							frame=400;
						}
						GFXclass=Mario.classGFX.AccessGFX("object_mario"+String(size)+"_walk_"+String(Math.ceil(frame/456)));
						break;
					case(1):
						GFXclass=Mario.classGFX.AccessGFX("object_mario"+String(size)+"_brake");
						break;
					case(2):
						GFXclass=Mario.classGFX.AccessGFX("object_mario"+String(size)+"_jump");
						break;
				}
			}
			GFX2.removeChild(GFX);
			GFX = new GFXclass;
			GFX.scaleX=dir;
			GFX.x=pX-(dir==-1?-25:3)+visible*1000;
			GFX.y=pY-3-(pSize==0 || crouch==1?21:0);
			if (starred>0){
				Mario.enemyStarHit(pX,pY,pWid,pHei,dir)
				if (starred>100 || starred%5==0){
					trans.greenOffset=(Math.random()-0.5)*400
					trans.redOffset=(Math.random()-0.5)*400
					trans.blueOffset=(Math.random()-0.5)*00
				}
				starred--;
				if (starred==0){
					Mario.classSFX.Play(Mario.musika)
				}
			} else {
				trans.greenOffset=0
				trans.redOffset=0
				trans.blueOffset=0
			}
			GFX2.transform.colorTransform=trans
			GFX2.addChild(GFX);
			if (pY>Mario.levelHei*25+25){
				Mario.hitPlayer(true);
			}
			if (Mario.scrolling){Mario.scrollX=Math.min(200-Player.pX,-Mario.scrollEdge)}
		}		
		public static function Reset():void{
			Player.hitStomp=false;
			Player.hitHead=false;
		}
		public static function Bounce(enemyY:int):void{
			Player.pY=enemyY-Player.pHei;
			Player.gravity = -7;
			Player.jumper = 1;
			CeilPull();
			GFX.x=pX-(dir==-1?-25:3);
			GFX.y=pY-3-(pSize==0 || crouch==1?21:0);
		}
		public static function CeilPull():void{
			if (Mario.levelColl(pX,pY) || Mario.levelColl(pX+pWid-1,pY)){
				var kY:uint=Math.floor(pY / 25) * 25+25;
				if (Mario.levelColl(pX,kY+pHei-1) || Mario.levelColl(pX+pWid-1,kY+pHei-1)){
					crouch=2
				} else {
					pY = kY;
				}
			}
		}
		public static function Falls():Boolean{
			if (Player.gravity>1){return true;}
			return false;
		}
		public static function ResetPlayer(xX:Number,xY:Number):void{
			pX=xX;
			pY=xY;
			speed=0;
			gravity=0;
			jumper=0;
			GFX.x=pX-(dir==-1?-25:3);
			GFX.y=pY-3-(pSize==0 || crouch==1?21:0);
			if (Mario.levelColl(pX,pY+pHei-1) || Mario.levelColl(pX+pWid-1,pY+pHei-1)){
				Player.pY-=25
			}
			Mario.layerFore.addChild(GFX2)
		}
		public static function ResetGraphic():void{
			GFX.scaleX=dir;
			GFX.x=pX-(dir==-1?-25:3);
			GFX.y=pY-3-(pSize==0 || crouch==1?21:0);
		}
		public static function starMe():void{
			starred=400
			Mario.classSFX.Play(3)
		}
	}
}