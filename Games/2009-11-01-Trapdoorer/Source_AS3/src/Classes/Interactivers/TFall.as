package Classes.Interactivers{
	import mx.core.BitmapAsset;

	public class TFall extends TEffect{
		private var rot: Number
		public function TFall(_x: int, _y: int, g: Class){
			var b: BitmapAsset = new g
			b.x = -12.5
			b.y = -12.5
			addChild(b)
			x=_x+12.5
			y=_y+12.5
			rot = Math.random()*10-5
			TD.layerEffects.addChild(this)
		}
		override public function update(): void{
			alpha -= 0.05
			rotation += rot
			scaleX -= 0.05
			scaleY -= 0.05
			if (alpha <= 0){
				TD.layerEffects.removeChild(this)
			}
		}
	}
}