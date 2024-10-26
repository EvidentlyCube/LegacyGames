/**
* ...
* @author Default
* @version 0.1
*/

package objects {
	import flash.display.*;
	import flash.media.Sound;
	import mx.core.BitmapAsset;
	public class Coin extends Obj{
		public var frame:uint=0;
		public var wait:uint=0;
		private var GFX:Array=new Array(3);
		private var SFXCoin:Sound=new (Mario.classSFX.accessSFX("coin"));
		public function Coin(typeX:Number,typeY:Number){
			oX=typeX+4;
			oY=typeY+2;
			GFX[0]=new (Mario.classGFX.AccessGFX("object_coin_1"));
			GFX[1]=new (Mario.classGFX.AccessGFX("object_coin_2"));
			GFX[2]=new (Mario.classGFX.AccessGFX("object_coin_3"));
			GFX[0].x=GFX[1].x=GFX[2].x=oX-4;
			GFX[0].y=GFX[1].y=GFX[2].y=oY-2;
			Mario.layerFore.addChild(GFX[0]);
		}
		override public function Update(myID:uint):void{
			wait++;
			if (wait==4){
				Mario.layerFore.removeChild(GFX[frame]);
				frame=(frame+1)%3
				Mario.layerFore.addChild(GFX[frame]);
				wait=0;
			}
			if (Mario.playerCollide(oX, oY, 16, 22)){
				Mario.Hud.Coins++;
				Mario.Hud.RedrawCoins();
				Mario.layerFore.removeChild(GFX[frame]);
				Mario.removeObject(myID);
				if (Mario.sounds){SFXCoin.play();}
			}
		}
	}
}