package objects 
{
	import flash.display.Sprite;
	import mx.core.BitmapAsset;
	/**
	* ...
	* @author DefaultUser (Tools -> Custom Arguments...)
	*/
	public class Hammer extends Obj{
		private var Troopa:HammerTroopa
		private var GFX:Sprite=new Sprite;
		private var waiter:uint=0
		private var movX:Number=0
		private var movY:Number=0
		public function Hammer(Troop:HammerTroopa){
			Troopa=Troop;
			var GFX2:BitmapAsset=new (Mario.classGFX.AccessGFX("effect_hammer"));
			GFX2.x=-10
			GFX2.y=-6
			GFX.addChild(GFX2)
			oY=0
			oX=0
			Mario.layerEffects.addChild(GFX)
		}
		override public function Update(myID:uint):void{
			waiter++
			if (waiter<30){
				SetPos();
			} else if (waiter==30){
				SetPos();
				oX=GFX.x-4
				oY=GFX.y-4
				movX=Troopa.dir*(Math.random()+1)*2
				movY=-(Math.random()+1*6)
			} else {
				oX+=movX
				oY+=movY
				GFX.rotation+=movX/2
				GFX.x=oX+4
				GFX.y=oY+4
				movY+=Mario.gravity
				if (Mario.playerCollide(oX,oY,8,8)){
					Mario.hitPlayer()
				}
			}
			if (oY>Mario.levelHei*25+250 || oY<-200 || (Troopa.dead==true && waiter<100)){
				Mario.removeObject(myID)
				Mario.layerEffects.removeChild(GFX)
			}
		}
		public function SetPos():void{
			if (Troopa.dir==1){
				if (Troopa.frame==0){
					GFX.rotation=0
					GFX.x=Troopa.eX+16
					GFX.y=Troopa.eY-2
				} else {
					GFX.rotation=90;
					GFX.x=Troopa.eX+28
					GFX.y=Troopa.eY+22
				}
			} else {
				if (Troopa.frame==0){
					GFX.rotation=0
					GFX.x=Troopa.eX+2
					GFX.y=Troopa.eY-2
				} else {
					GFX.rotation=-90;
					GFX.x=Troopa.eX-8
					GFX.y=Troopa.eY+22
				}
			}
		}
	}
	
}