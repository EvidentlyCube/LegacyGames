package Classes.Scenes{
	import flash.display.Shape;

	public class TLogoScene extends TScene	{
		public var logo: Shape
		public var back: Shape
		public var timer: uint = 0
		public function TLogoScene(): void{
			logo = new Shape
			back = new Shape
			back.graphics.beginFill(0x101010)
			back.graphics.drawRect(0, 0,600, 600)
			back.graphics.endFill()
			logo.graphics.lineStyle(10, 0xFFFFFF)
			logo.graphics.drawCircle(300, 300, 150)
			logo.alpha = 0
		}
		override public function update(): void{
			if (timer == 0){
				logo.alpha += 0.05
				if (logo.alpha > 1){
					timer++
				}
			} else if(timer < 30){
				timer++
			} else {
				logo.alpha -= 0.05;
				if (logo.alpha < 0){
					TD.setScene(TMenuScene);
				}
			}
		}
		override public function add(): void{
			TD.addLayer(back)
			TD.addLayer(logo)
		}
		override public function remove(): void{
			TD.removeLayer(back)
			TD.removeLayer(logo)
		}
	}
}