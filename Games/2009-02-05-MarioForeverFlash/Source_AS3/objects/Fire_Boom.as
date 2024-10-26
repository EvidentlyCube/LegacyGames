
package objects {
	import flash.display.Sprite;
	import mx.core.BitmapAsset;
	public class Fire_Boom extends Effect{
		public var GFX:Sprite;
		public function Fire_Boom(oX:Number,oY:Number) {
			timer=0;
			var GFXclass:Class=Mario.classGFX.AccessGFX("effect_fire_boom");
			var GFX2:BitmapAsset=new GFXclass();
			GFX2.x=-12.5;
			GFX2.y=-12.5;
			GFX = new Sprite();
			GFX.x=oX;
			GFX.y=oY;
			GFX.addChild(GFX2);
			Mario.layerFore.addChild(GFX);
		}
		override public function Update(myID:uint):void {
			timer++;
			GFX.alpha=1.5-timer/10;
			GFX.scaleX=timer/10;
			GFX.scaleY=timer/10;
			if (timer==10){
				Mario.layerFore.removeChild(GFX);
				Mario.removeEffect(myID);
			}
		}
	}
}