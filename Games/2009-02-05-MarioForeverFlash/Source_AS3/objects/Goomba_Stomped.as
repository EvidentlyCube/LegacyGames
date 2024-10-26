
package objects {
	import mx.core.BitmapAsset;
	public class Goomba_Stomped extends Effect{
		public var GFX:BitmapAsset;
		public var fY:Number;
		public var fX:Number;
		public var gravity:Number=0;
		public function Goomba_Stomped(oX:Number,oY:Number) {
			timer=50;
			fX=oX;
			fY=oY;
			var GFXclass:Class=Mario.classGFX.AccessGFX("effect_goomba_stomped");
			GFX = new GFXclass;
			GFX.x=oX-2;
			GFX.y=oY-4;
			Mario.layerFore.addChild(GFX);
		}
		override public function Update(myID:uint):void {
			timer--;
			GFX.alpha=timer/25;
			gravity+=Mario.gravity;
			fY+=Math.floor(gravity);
			
			if (Mario.levelColl(fX, fY+20) || Mario.levelColl(fX+20, fY+20)) {
				gravity = 0
				fY = Math.floor(fY / 25) * 25+4;
			}
			GFX.x=fX-2;
			GFX.y=fY-4;
			if (timer==0){
				Mario.layerFore.removeChild(GFX);
				Mario.removeEffect(myID);
			}
		}
	}
}