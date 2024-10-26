package Classes.Menu{
	import Classes.Grid9;
	import Classes.MenuButton;

	import Editor.MakeText;

	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	public class TProcessingWindow extends TWindow{
		private var title:TextField
		private var content:TextField
		private var bg:Grid9
		public function TProcessingWindow(mess:String){
			title = MakeText("<p align='center'>Processing!</p>",22)

			content = MakeText("<p align='center'>"+mess + "</p>",18)
			content.selectable = true
			content.y = 40

			bg = new Grid9(TWindow.Grid9DataMenu)
			bg.width = Math.max(150,content.width + 20)
			bg.height = Math.max(100,content.height + 150)

			addChild(bg)

			x = 300 - width / 2
			y = 300 - height / 2
			title.x = width / 2-title.width / 2
			content.x = width / 2-content.width / 2

			addChild(title)
			addChild(content)
			WindowHandler.newWindow(this)
		}
	}
}