package objects {
	import flash.media.Sound;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	
	import mx.core.BitmapAsset;
	
	/**
	* ...
	* @author $(DefaultUser)
	*/
	public class GameOver extends Obj{
		private var timer:uint=0;
		private var sel:int=1;
		private var gfx1:BitmapAsset;
		private var gfx3:BitmapAsset;
		private var gfx4:BitmapAsset;
		private var SFXOver:Sound=new (Mario.classSFX.accessSFX("gameover"));
		public static var isGO:Boolean=false;
		public function GameOver() {
			isGO=true;
			gfx1=new (Mario.classGFX.AccessGFX("gameover"));
			gfx3=new (Mario.classGFX.AccessGFX("continue"));
			gfx4=new (Mario.classGFX.AccessGFX("quit"));
			gfx1.x=400/2-gfx1.width/2;
			gfx1.y=50;
			Mario.layerGover.addChild(gfx1);
			if (Mario.music){SFXOver.play()}
		}
		override public function Update(myID:uint):void{
			timer++;
			if (timer==180){
				gfx3.x=400/2-gfx3.width/2;
				gfx3.y=280;
				Mario.layerGover.addChild(gfx3);

				gfx4.x=400/2-gfx4.width/2;
				gfx4.y=320;
				Mario.layerGover.addChild(gfx4);
			}
			if (timer > 180){
				if (Mario.isKeyPressed(1)){
					sel++;
					if (sel==3){sel=1}
				} else if (Mario.isKeyPressed(3)) {
					sel--;
					if (sel==0){sel=2}
				}
				if (Mario.isKeyPressed(4) || Mario.isKeyPressed(6) || Mario.isKeyPressed(7)){
					if (sel==1){
						isGO=false;
						Mario.Hud.Lives=2;
						Mario.Hud.Pnts=0;
						Mario.checkPoint=0;
						Mario.Hud.RedrawPnts();
						Mario.levelid=Math.max(Mario.levelid-1,Math.floor(Mario.levelid/4)*4);
						Mario.clearLevel();
						Mario.decreaseI=1
					} else if (sel==2){
						isGO=false;
						Mario.clearLevel(false);
						Mario.TScreen=new TitleScreen;
						Mario.sequence=4;
						Mario.decreaseI=1;
						Mario.stepping=true
					}
				}
			}
			if (sel==1){
				gfx3.alpha=1;
				gfx4.alpha=0.5
			} else {
				gfx3.alpha=0.5;
				gfx4.alpha=1
			}
		}
		
	}
	
}