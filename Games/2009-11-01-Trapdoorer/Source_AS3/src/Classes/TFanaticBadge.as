package Classes{
	import Classes.Interactivers.TPlayer;
	import Classes.Menu.TAlertWindow;
	import Classes.Menu.WindowHandler;

	import LoadingDir.Loading;

	import flash.display.BlendMode;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;

	import mx.core.BitmapAsset;
	public class TFanaticBadge extends Sprite{
		[Embed("../../assets/gfx/by_maurycy/ui/Fanatic.png")] private var gfan: Class;

		private var badge: Sprite = new Sprite
		private var shine: Sprite = new Sprite
		public function TFanaticBadge(){
			badge.addChild(new gfan)
			shine.addChild(new TPlayer.g)
			badge.x = 290-badge.width/2
			badge.y = 245
			shine.width = 38
			shine.height = 38
			shine.x = badge.x+35
			shine.y = badge.y+18
			shine.alpha = 0
			shine.blendMode = BlendMode.ADD

			this.addEventListener(Event.ENTER_FRAME, step)
			shine.addEventListener(MouseEvent.ROLL_OVER, shineOver)
			addChild(badge)
			addChild(shine)
		}
		private function shineOver(e: MouseEvent): void{
			shine.alpha = 0.6
		}
		private function step(e: Event): void{
			if (shine.alpha > 0){
				shine.alpha -= 0.03
			}
		}
	}
}