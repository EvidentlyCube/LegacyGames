package Classes.Interactivers{
	import Classes.Items.TNormal;
	import Classes.Scenes.TCreditsScene;

	import mx.core.BitmapAsset;

	public class TEndFall extends TEffect{
		private var rot: Number
		public function TEndFall(_x: int, _y: int){
			var b: BitmapAsset = new (TNormal.g_normal)
			b.x = -12.5
			b.y = -12.5
			addChild(b)
			x=_x+12.5
			y=_y+12.5
			rot = Math.random()*10-5
			TCreditsScene.fall.addChild(this)
		}
		override public function update(): void{
			y++
			alpha -= 0.02
			rotation += rot
			scaleX -= 0.02
			scaleY -= 0.02
			if (alpha <= 0){

				TCreditsScene.fall.removeChild(this)
			}
		}
	}
}