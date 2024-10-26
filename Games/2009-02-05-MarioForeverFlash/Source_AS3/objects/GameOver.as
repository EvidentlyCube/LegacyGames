package objects {
	import flash.text.TextField;
	import mx.core.BitmapAsset
	import flash.media.Sound;
	
	/**
	* ...
	* @author $(DefaultUser)
	*/
	public class GameOver extends Obj{
		private var timer:uint=0
		private var sel:uint=0
		private var gfx1:BitmapAsset
		private var gfx2:BitmapAsset
		private var gfx3:BitmapAsset
		private var SFXOver:Sound=new (Mario.classSFX.accessSFX("gameover"));
		public function GameOver() {
			gfx1=new (Mario.classGFX.AccessGFX("gameover"));
			gfx2=new (Mario.classGFX.AccessGFX("continue"));
			gfx3=new (Mario.classGFX.AccessGFX("quit"));
			gfx1.x=400/2-gfx1.width/2
			gfx1.y=375/2-gfx1.height/2
			Mario.layerGover.addChild(gfx1)
			SFXOver.play()
		}
		override public function Update(myID:uint):void{
			timer++
			if (timer==180){
				gfx2.x=400/2-gfx2.width/2
				gfx2.y=230
				Mario.layerGover.addChild(gfx2)
				gfx3.x=400/2-gfx3.width/2
				gfx3.y=250
				Mario.layerGover.addChild(gfx3)
			}
			if (timer>180){
				if (Mario.isKeyPressed(1) || Mario.isKeyPressed(3)){
					sel=1-sel
				}
				if (Mario.isKeyPressed(4)){
					if (sel==0){
						Mario.Hud.Lives=2
						Mario.Hud.Pnts=0
						Mario.checkPoint=0
						Mario.Hud.RedrawPnts();
						Mario.levelid=Math.max(Mario.levelid-1,Math.floor(Mario.levelid/4)*4)
						Mario.clearLevel()
						Mario.decreaseI=1
					} else {
						Mario.clearLevel(false)
						Mario.TScreen=new TitleScreen;
						Mario.sequence=4
						Mario.decreaseI=1
						Mario.stepping=true
					}
				}
			}
			if (sel==0){
				gfx2.alpha=1
				gfx3.alpha=0.5
			} else {
				gfx2.alpha=0.5
				gfx3.alpha=1
			}
		}
		
	}
	
}