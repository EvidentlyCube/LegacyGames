package Obs{
	import flash.display.Sprite;
	import mx.core.BitmapAsset;
	/**
	 * ...
	 * @author DefaultUser (Tools -> Custom Arguments...)
	 */
	public class BloEff {
		public var GFX:Sprite = new Sprite;
		public var rot:Number
		public function BloEff(ix:uint,iy:uint,gf:BitmapAsset){
			GFX.x = ix+15;
			GFX.y = iy+15;
			GFX.addChild(gf);
			gf.x = -15;
			gf.y = -15;
			rot=(Math.random()-0.5)*20
			Game.layerback.addChild(GFX)
			Game.effects.push(this)
		}
		public function Update():void {
			GFX.rotation += rot;
			GFX.alpha -= 0.04;
			GFX.scaleX -= 0.04;
			GFX.scaleY -= 0.04;
			if (GFX.alpha <= 0) {
				var inde:uint = Game.effects.indexOf(this)
				Game.effects.splice(inde, 1)
				Game.layerback.removeChild(GFX)
			}
		}
	}
	
}