package Classes.Menu{
	import Classes.Grid9;
	import Classes.MenuButton;

	import Editor.MakeText;

	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.system.*;
	import flash.text.TextField;
	public class TEnterWindow extends TWindow{
		private var title:TextField
		private var content:TextField
		private var textInput:TextField
		private var enterBg:Grid9
		private var close:MenuButton
		private var bg:Grid9
		public var result:String

		public function TEnterWindow(mess:String,ent:String = "",wid:uint = 300,chLimit:uint = 0){
			title = MakeText("<p align='center'>Attention!</p>",22)
			content = MakeText("<p align='center'>"+mess + "</p>",18)
			content.y = 40
			textInput = TMenu.makeInputField(15, content.y + content.height + 15,wid - 10,30,ent,14)
			textInput.maxChars = chLimit
			enterBg = new Grid9(TWindow.Grid9DataTextfield)
			enterBg.y = textInput.y - 5
			enterBg.width = textInput.width
			enterBg.height = textInput.height
			close = new MenuButton("Close",18)
			close.addEventListener(MouseEvent.CLICK,closed)

			bg = new Grid9(TWindow.Grid9DataMenu)
			bg.width = Math.max(150,content.width + 20,textInput.width + 20)
			bg.height = Math.max(100,content.height + 150)

			addChild(bg)

			x = 300 - width / 2
			y = 300 - height / 2
			title.x = width / 2-title.width / 2
			content.x = width / 2-content.width / 2
			close.x = width / 2-close.width / 2
			close.y = height - close.height - 5
			enterBg.x = textInput.x - 5

			addChild(title)
			addChild(content)
			addChild(close)
			addChild(enterBg)
			addChild(textInput)
			WindowHandler.newWindow(this)

			Game.STG.addEventListener(KeyboardEvent.KEY_DOWN, function(e: KeyboardEvent): void {
				if (e.keyCode === Keyboard.ENTER) {
					closed(null);
				}
			}, false, 0, true);
			Game.STG.focus = textInput;
		}
		private function closed(e:MouseEvent):void{
			WindowHandler.popWindow()
			result = textInput.text
			this.dispatchEvent(new Event(TWindow.CLOSED))
			close.removeEventListener(MouseEvent.CLICK,closed)
		}
	}
}