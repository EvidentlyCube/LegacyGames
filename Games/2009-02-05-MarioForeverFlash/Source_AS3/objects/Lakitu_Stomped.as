
package objects {
	import mx.core.BitmapAsset;
	public class Lakitu_Stomped extends Effect{
		public var GFX:BitmapAsset;
		public var fY:Number;
		public var gravity:Number=0;
		public function Lakitu_Stomped(oX:Number,oY:Number) {
			fY=oY+37;
			var GFXclass:Class=Mario.classGFX.AccessGFX("enemy_lakitu_1");
			GFX = new GFXclass;
			GFX.scaleY=-1;
			GFX.x=oX;
			GFX.y=fY;
			Mario.layerFore.addChild(GFX);
		}
		override public function Update(myID:uint):void {
			gravity+=Mario.gravity;
			fY+=gravity;
			GFX.y=fY;
			if (fY>Mario.levelHei*25+80){
				Mario.layerFore.removeChild(GFX);
				Mario.removeEffect(myID);
			}
		}
	}
}