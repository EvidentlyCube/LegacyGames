package net.retrocade.tacticengine.monstro.levelSelector {
	import flash.geom.Rectangle;

	import net.retrocade.tacticengine.monstro.global.core.MonstroLoadedGfx;

	import starling.display.Image;
	import starling.textures.Texture;

	public class LevelSelectionBackground extends Image{
		public function LevelSelectionBackground(backgroundIndex:uint) {
			super(createTexture(backgroundIndex % 6));
		}

		private static function createTexture(backgroundIndex:uint):Texture {
			var x:uint = (backgroundIndex % 2) * 1024;
			var y:uint = (backgroundIndex / 2 | 0) * 528;

			return Texture.fromTexture(MonstroLoadedGfx.mapBackgrounds, new Rectangle(x, y, 1025, 528))
		}

		public function fitToParchment(parchment:Image):void{
			width = parchment.width - (29 + 29) * parchment.scaleX;
			height = parchment.height - (93 + 68) * parchment.scaleY;
			x = parchment.x + 29 * parchment.scaleY;
			y = parchment.y + 93 * parchment.scaleY;
		}

		override public function dispose():void {
			super.dispose();
		}
	}
}
