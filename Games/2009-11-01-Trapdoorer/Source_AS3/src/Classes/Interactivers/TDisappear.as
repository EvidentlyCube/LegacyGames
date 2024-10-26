package Classes.Interactivers{
	import mx.core.BitmapAsset;

	public class TDisappear extends TEffect{
		public function TDisappear(_x: int, _y: int, g: Class){
			addChild(new g)
			x=_x
			y=_y
			TD.layerEffects.addChild(this)
		}
		override public function update(): void{
			alpha -= 0.05
			if (alpha <= 0){
				TD.layerEffects.removeChild(this)
			}
		}
	}
}