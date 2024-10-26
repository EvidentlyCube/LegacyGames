package objects {
	import flash.media.Sound;
	import mx.core.BitmapAsset
	/**
	* ...
	* @author Default
	*/
	public class Pipein{
		public var oX:int;
		public var oY:int;
		public var endX:int;
		public var endY:int;
		public var dirin:int;
		public var dirout:int;
		public var seq:int=0;
		public var obje:PlayerPiper;
		public var lockX:uint=0
		public var scroll:Boolean
		public var backid:uint=0
		public static var BGon:Boolean=false
		public static var BG:BitmapAsset
		public var SFXPupupu:Sound=new (Mario.classSFX.accessSFX("powerdown"))
		public function Pipein(obX:int,obY:int,
								eX:int,eY:int,
								dri:int,dro:int,
								Bid:uint=0,scroll:Boolean=true,
								lX:uint=0) {
			backid=Bid
			this.scroll=scroll
			lockX=lX
			oX=obX;
			oY=obY;
			endX=eX;
			endY=eY;
			dirin=dri;
			dirout=dro;
		}
		public function Update(myID:uint):void{
			
			switch(seq){
				case(0):
					if (Mario.playerCollide(oX-2,oY-2,6,6)){
						if (Mario.isKeyDown(dirin)){
							if (Player.crouch){
								Player.pHei=45;
								Player.pY-=21;
								Player.crouch=0;
							}
							Enter();
						}
					}
					break;
				case(1):
					if (obje.completed){
						Mario.layerHide.removeChild(obje.GFX);
						seq=2;
					} else {obje.Update();}
					break;
				case(30):
					Leave();
					break;
				case(31):
					if (obje.completed){
						seq=0;
						Player.ResetPlayer(obje.pX,obje.pY);
						Mario.playerControllable=true;
						Mario.layerHide.removeChild(obje.GFX);
					} else {obje.Update();}
					break;
				default:seq++;
			}
		}
		public function Enter():void{
			Mario.playerControllable=false;
			Mario.layerFore.removeChild(Player.GFX2);
			Mario.Hud.debugtext.text=String(dirin);
			if (Mario.sounds){SFXPupupu.play()}
			switch(dirin){
				case(0):
					obje=new PlayerPiper(oX-12,oY-Player.pHei,1,0,true);
					break;
				case(1):
					Player.pX=oX-12
					obje=new PlayerPiper(Player.pX,oY-Player.pHei,0,1,true);
					break;
				case(2):
					obje=new PlayerPiper(oX-12,oY-Player.pHei,-1,0,true);
					break;
				case(3):
					Player.pX=oX-12
					obje=new PlayerPiper(Player.pX,oY-Player.pHei,0,-1,true);
					break;
			}
			if (Mario.scrolling){
				Mario.centerScreen(Player.pX);
			}
			seq=1;
		}
		public function Leave():void{
			if (Mario.sounds){SFXPupupu.play()}
			switch(dirout){
				case(0):
					obje=new PlayerPiper(endX-12,endY,1,0,false);
					break;
				case(1):
					Player.pX=endX-12
					obje=new PlayerPiper(Player.pX,endY-Player.pHei,0,1,false);
					break;
				case(2):
					Player.pX=endX
					obje=new PlayerPiper(Player.pX,endY,-1,0,false);
					break;
				case(3):
					Player.pX=endX-12
					obje=new PlayerPiper(endX-12,endY,0,-1,false);
					break;
				case (4):
					Mario.playerControllable=true;
					Mario.levelid++;
					Mario.clearLevel()
					Mario.decreaseI=1
			}
			if (backid==0){
				if (BGon){
					Mario.layerPipe.removeChild(BG)
					BGon=false
				}
			} else {
				if (BGon){
					Mario.layerPipe.removeChild(BG)
					BGon=false
				}
				BG=new (Mario.classGFX.AccessGFX("back_"+backid));
				Mario.layerPipe.addChild(BG)
				BGon=true
			}
			if (scroll){
				Mario.scrolling=true
				Mario.centerScreen(Player.pX);
			} else {
				Mario.scrolling=false
				//Mario.layerBack.x=-lockX;
				Mario.layerHide.x=-lockX;
				Mario.layerWall.x=-lockX;
				Mario.layerFore.x=-lockX;
				Mario.layerEffects.x=-lockX;
			}
			seq=31;
		}
	}
}