package objects 
{
	import flash.media.Sound;
	import mx.core.BitmapAsset;
	/**
	* ...
	* @author DefaultUser (Tools -> Custom Arguments...)
	*/
	public class Cannon extends Obj{
		private var GFX:BitmapAsset;
		private var wait:uint;
		private var SFX:Sound=new (Mario.classSFX.accessSFX("cannon"))
		public function Cannon(x:uint,y:uint){
			oX=x
			oY=y
			wait=60+Math.floor(Math.random()*100)
			GFX=new (Mario.classGFX.AccessGFX("Wall_T"));
			GFX.x=oX
			GFX.y=oY
			Mario.layerEffects.addChild(GFX)
			Mario.changeLevel(oX/25,oY/25,"x")
		}
		override public function Update(myID:uint):void{
			wait--
			if (wait==0){
				if (Player.pX<oX-100 || Player.pX>oX+100 && Math.abs(Player.pX-oX)<300){
					Mario.instEnemies.push(new Bullet(oX+2,oY+3))
					if (Mario.sounds){SFX.play()}
				}
				wait=60+Math.floor(Math.random()*100)
			}
		}
		
	}
	
}