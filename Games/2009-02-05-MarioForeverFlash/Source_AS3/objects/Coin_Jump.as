package objects {
	import flash.display.*;
	import mx.core.BitmapAsset;
	public class Coin_Jump extends Effect {
		public var fX:Number;
		public var fY:Number;
		public var speed:Number=10;
		public var frame:uint=1;
		public var GFX:BitmapAsset;
		public function Coin_Jump(oX:Number,oY:Number){
			fX=oX;
			fY=oY;
			var GFXclass:Class=Mario.classGFX.AccessGFX("effect_coin_jump_1");
			GFX = new GFXclass;
			GFX.x=fX;
			GFX.y=fY;
			Mario.layerFore.addChild(GFX);
		}
		override public function Update(myID:uint):void{
			frame=(frame+1)%12+1;
			fY-=speed;
			speed-=Mario.gravity;
			Mario.layerFore.removeChild(GFX);
			var GFXclass:Class=Mario.classGFX.AccessGFX("effect_coin_jump_"+Math.ceil(frame/3));
			GFX = new GFXclass;
			GFX.x=fX;
			GFX.y=fY;
			Mario.layerFore.addChild(GFX);
			if (speed<2){
				Mario.instEffects.push(new Points(fX+7,fY+130,"200"));
				Mario.instEffects.push(new Coin_Boom(fX-10,fY));
				Mario.layerFore.removeChild(GFX);
				Mario.removeEffect(myID);
			}
		}
	}
	
}