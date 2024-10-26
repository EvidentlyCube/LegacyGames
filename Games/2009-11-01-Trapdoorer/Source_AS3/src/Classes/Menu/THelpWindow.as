package Classes.Menu{
	import Classes.Grid9;
	import Classes.MenuButton;
	import Classes.Scenes.TScene;

	import flash.events.Event;
	import flash.events.MouseEvent;
	public class THelpWindow extends TWindow{
		[Embed("../../../assets/gfx/by_maurycy/ui/Help.png")] private var g: Class;
		private var close: MenuButton
		private var bg: Grid9
		public function THelpWindow(){
			addChild(new g)
			x = 50
			y = 50

			close = new MenuButton("Close", 18)
			close.addEventListener(MouseEvent.CLICK, closed)

			close.x = 250-close.width/2+10
			close.y = 450

			TScene.paused = true

			addChild(close)
			WindowHandler.newWindow(this)
		}
		private function closed(e: MouseEvent): void{
			TScene.paused = false
			WindowHandler.popWindow()
			this.dispatchEvent(new Event(TWindow.CLOSED))
			close.removeEventListener(MouseEvent.CLICK, closed)
		}
	}
}