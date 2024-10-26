package objects {
	import flash.display.*;
	import mx.core.BitmapAsset;
	public class Coin_Boom extends Effect {
		public var fX:Number;
		public var fY:Number;
		public var frame:uint=0;
		public var wait:uint=0;
		public var GFX:Array=new Array(3);
		public function Coin_Boom(oX:Number,oY:Number){
			fX=oX;
			fY=oY;
			GFX[0]=new (Mario.classGFX.AccessGFX("effect_coin_boom_1"));
			GFX[1]=new (Mario.classGFX.AccessGFX("effect_coin_boom_2"));
			GFX[2]=new (Mario.classGFX.AccessGFX("effect_coin_boom_3"));
			GFX[0].x=fX;
			GFX[0].y=fY;
			Mario.layerFore.addChild(GFX[0]);
		}
		override public function Update(myID:uint):void{
			fY+=0.2;
			wait++;
			if (wait==8){
				Mario.layerFore.removeChild(GFX[frame]);	
				frame++;
				Mario.layerFore.addChild(GFX[frame]);
				wait=0;
			}
			GFX[frame].x=fX;
			GFX[frame].y=fY;
			GFX[frame].alpha=1-(frame*8+wait)/24;
			if (frame==2 && wait==7){
				Mario.layerFore.removeChild(GFX[frame]);
				Mario.removeEffect(myID);
			}
		}
	}
	
}