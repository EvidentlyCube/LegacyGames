package Classes.Menu{
	import Classes.Grid9;
	import Classes.MenuButton;

	import Editor.MakeText;

	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	public class TAlertWindow extends TWindow{
		private var title:TextField
		private var content:TextField
		private var close:MenuButton
		private var bg:Grid9
		public function TAlertWindow(mess:String,butt:String = "Close"){
			title = MakeText("<p align='center'>Attention!</p> ",22)

			content = MakeText("<p align='center'>"+mess + "</p> ",18)
			content.y = 40
			close = new MenuButton(butt,18)
			close.addEventListener(MouseEvent.CLICK,closed)

			bg = new Grid9(TWindow.Grid9DataMenu)
			bg.width = Math.max(150,content.width + 20)
			bg.height = Math.max(100,content.height + 150)

			addChild(bg)

			x = 300 - width / 2
			y = 300 - height / 2
			title.x = width / 2-title.width / 2
			content.x = width / 2-content.width / 2
			close.x = width / 2-close.width / 2
			close.y = height - close.height - 5

			addChild(title)
			addChild(content)
			addChild(close)
			WindowHandler.newWindow(this)
		}
		private function closed(e:MouseEvent):void{
			WindowHandler.popWindow()
			this.dispatchEvent(new Event(TWindow.CLOSED))
			close.removeEventListener(MouseEvent.CLICK,closed)
		}
	}
}