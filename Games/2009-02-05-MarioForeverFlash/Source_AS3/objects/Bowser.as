package objects{
	import mx.core.BitmapAsset
	import flash.media.Sound;
	/**
	* ...
	* @author $(DefaultUser)
	*/
	public class Bowser extends Enemy{
		public var GFX:Array=new Array(4)
		public var fl:uint
		public var ham:uint
		public var hamno:uint
		public var hampau:uint
		public var waiter:uint
		public var action:uint=0
		public var moveTo:uint
		public var moveWait:uint=0
		public var border:uint
		public var scroll:uint=0
		public var frame:uint=0
		public var frameTime:uint=0
		public var hp:int
		public var firehp:uint=6
		public var damageWait:uint=0
		public var hammerer1:uint=0
		public var hammerer2:uint=0
		public var musicFundo:uint=0
		private var SFXBump:Sound=new (Mario.classSFX.accessSFX("bump"));
		private var SFXStomp:Sound=new (Mario.classSFX.accessSFX("bowser_hit"));
		private var SFXGrowl:Sound=new (Mario.classSFX.accessSFX("growl"));
		private var SFXKill:Sound=new (Mario.classSFX.accessSFX("bowser_kill"));
		private var SFXRadish:Sound=new (Mario.classSFX.accessSFX("radish"));
		public function Bowser(x:uint,y:uint,borderx:uint,hape:uint,flame:uint,hammer:uint,hammerno:uint,hammerpause:uint){
			GFX[0]=new (Mario.classGFX.AccessGFX("bowser_1"));
			GFX[1]=new (Mario.classGFX.AccessGFX("bowser_2"));
			GFX[2]=new (Mario.classGFX.AccessGFX("bowser_3"));
			GFX[3]=new (Mario.classGFX.AccessGFX("bowser_4"));
			fl=flame
			ham=hammer
			hamno=hammerno
			hampau=hammerpause
			border=borderx
			moveTo=eX=x
			eWid=40
			eHei=46
			eY=y
			hp=hape
			Mario.layerFore.addChild(GFX[frame])
		}
		override public function Update(myID:uint):void{
			if (hp<=0){
				Mario.layerFore.removeChild(GFX[frame])
				Mario.removeEnemy(myID)
				Mario.instEffects.push(new Enemy_Fall(eX-5,eY-10,dir,GFX[frame]))
				Mario.instObjects.push(new BowserKilled())
				if (Mario.sounds){SFXKill.play()}
				Mario.classSFX.Play(-1)
				return;
			}
			if (musicFundo>0){
				musicFundo++
				Mario.checkPoint=Mario.levelid
				if (musicFundo==150){
					if (Mario.music){
						Mario.classSFX.Play(5)
					}
				}
			}
			if (scroll==0){
				if (Player.pX>border-200){
					scroll=1
					if (Mario.music){
						musicFundo=1
						Mario.classSFX.Play(4)
						Mario.musika=5;
					}
					Mario.scrollEdge=Player.pX-200
					Mario.centerScreen(Player.pX)
					Mario.scrolling=false
				}
			} else if (scroll==1){
				if (Mario.scrollEdge<border){
					Mario.scrollEdge++;
					Mario.centerScreen(Mario.scrollEdge+200)
					if (Player.pX+Math.round(Player.speed/100)<Mario.scrollEdge+2){
						Player.pX=Mario.scrollEdge+2
						Player.speed=Math.max(0,Player.speed)
						if (Mario.playerControllable && (Mario.levelColl(Player.pX+Player.pWid-1,Player.pY) || Mario.levelColl(Player.pX+Player.pWid-1,Player.pY+Player.pHei-1))){
							Mario.hitPlayer(true)
						}
					}
				} else {
					scroll=2
				}
			}
			gravity+=Mario.gravity/3
			eY += Math.round(gravity);
			if (gravity>0){
				if (Mario.levelColl(eX, eY+eHei-1) || Mario.levelColl(eX+eWid-1, eY+eHei-1)) {
					gravity = 0
					eY = Math.floor(eY / 25) * 25 + 4;
					if (Math.random()<0.05){
						gravity=-4
					}
				}
			}
			if (moveTo==eX && moveWait==0){
				switch(Math.floor(Math.random()*2)){
					case(0):
						moveTo=border+25+Math.floor(Math.random()*310)
					case(1):
						moveWait=Math.floor(Math.random()*40)
				}
			} else if(moveWait>0){
				moveWait--
			} else {
				eX+=Mario.Sign(moveTo-eX)*Math.min(2,Math.abs(moveTo-eX))
			}
			if (Mario.playerCollide(eX, eY, eWid, eHei)){
				if (Player.pY-Player.gravity+Player.pHei<=eY+5){
					if (Player.hitStomp==false){
						Mario.stompSetDistance(myID,eX);
					}
				} else {
					Mario.hitPlayer();
				}
			}
			if (action==0){
				frameTime++
				if (frameTime>15){
					if (frame==0){
						changeFrame(1)
					} else {
						changeFrame(0)
					}
					frameTime=0
					if (Math.random()*50<fl+ham){
						if (Math.random()*fl>=Math.random()*ham){
							action=1
							changeFrame(3)
							waiter=0
						} else {
							action=2
							changeFrame(3)
							waiter=0
							hammerer1=hamno
						}
					}
				}
			} else if (action==1){
				if (waiter<80){
					waiter++
				} else if (waiter==80){
					waiter++
					changeFrame(2)
					if (Mario.sounds){SFXGrowl.play()}
					Mario.instEffects.push(new BowserFlame(eX+5+20*dir,eY+10,dir,Player.pY+30-Player.pHei))
				} else if (waiter<100){
					waiter++
				}else if (waiter==100){
					changeFrame(0)
					action=0
				}
			} else if (action==2){
				if (waiter<80){
					waiter++
				} else if (waiter==80){
					if (hammerer2==0){
						if (hammerer1>0){
							changeFrame(2)
							var radish:Fireball=new Fireball(eX+5+(dir==1?30:0),eY+10,dir,true)
							radish.dir=dir*3
							radish.gravity=0
							Mario.instObjects.push(radish)
							if (Mario.sounds){SFXRadish.play()}
							hammerer1--;
						} else {
							changeFrame(0)
							action=0
						}
						hammerer2=hampau
					} else {
						hammerer2--;
					}
				} else if (waiter<100){
					waiter++
				}else if (waiter==100){
					changeFrame(0)
					action=0
				}
			}
			if (damageWait>0){damageWait--;}
			gfxPosition()
		}
		private function changeFrame(fra:uint):void{
			Mario.layerFore.removeChild(GFX[frame])
			frame=fra
			Mario.layerFore.addChild(GFX[frame])
		}
		private function gfxPosition():void{
			dir=Player.pX>eX?1:-1
			GFX[frame].scaleX=dir
			GFX[frame].x=eX-5+(dir==-1?50:0)
			GFX[frame].y=eY-10
			GFX[frame].alpha=Math.abs(Math.cos(damageWait*Math.PI/30))
		}
		override public function Fire(myID:uint,dir:int):Boolean{
			return false;
		}
		override public function Stomp(myID:uint):void{
			if (damageWait==0){
				Player.Bounce(eY);
				hp--
				damageWait=120
				firehp=6
				if (Mario.sounds){SFXStomp.play();}
			}
		}
		override public function FireballHit(myID:uint,dir:int):Boolean{
			if (damageWait==0){
				firehp--
				if (firehp==0){
					hp--
					damageWait=120
					firehp=6
				}
			}
			if (Mario.sounds){SFXBump.play();}
			return true;
		}
	}
	
}