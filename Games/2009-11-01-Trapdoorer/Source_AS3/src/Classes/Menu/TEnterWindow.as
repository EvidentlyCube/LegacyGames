package Classes.Menu{
	import Classes.Grid9;
	import Classes.MenuButton;

	import Editor.MakeText;

	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.system.*;
	import flash.text.TextField;
	public class TEnterWindow extends TWindow{
		private var titleTextField: TextField
		private var descriptionTextField: TextField
		private var textInput: TextField
		private var textInputBackground: Grid9
		private var closeButton: MenuButton
		private var windowBackground: Grid9

		public var result: String

		public function TEnterWindow(mess: String, ent: String="", wid: uint = 300, chLimit: uint = 0){
			titleTextField = MakeText("<p align='center'>Attention!</p>", 24)
			titleTextField.y = 5
			descriptionTextField = MakeText("<p align='center'>"+mess+"</p>", 18)
			descriptionTextField.y = 40
			textInput = TMenu.makeInputField(0, descriptionTextField.y+descriptionTextField.height+10, wid, 30, ent, 18)
			textInput.maxChars = chLimit
			textInputBackground = new Grid9(TWindow.Grid9DataTextfield)
			textInputBackground.y = textInput.y
			textInputBackground.width = textInput.width
			textInputBackground.height = textInput.height
			closeButton = new MenuButton("Close", 18)
			closeButton.addEventListener(MouseEvent.CLICK, closed)

			windowBackground = new Grid9(TWindow.Grid9DataMenu)
			windowBackground.width = Math.max(150, descriptionTextField.width+20, textInput.width+20)
			windowBackground.height = Math.max(100, descriptionTextField.height+150)

			addChild(windowBackground)

			x = 300-width/2
			y = 300-height/2
			titleTextField.x = width/2-titleTextField.width/2
			descriptionTextField.x = width/2-descriptionTextField.width/2
			closeButton.x = width/2-closeButton.width/2
			closeButton.y = height-closeButton.height-5
			textInput.x = width/2-textInput.width/2
			textInputBackground.x = textInput.x

			addChild(titleTextField)
			addChild(descriptionTextField)
			addChild(closeButton)
			addChild(textInputBackground)
			addChild(textInput)
			WindowHandler.newWindow(this)
		}
		private function closed(e: MouseEvent): void{
			WindowHandler.popWindow()
			result = textInput.text
			this.dispatchEvent(new Event(TWindow.CLOSED))
			closeButton.removeEventListener(MouseEvent.CLICK, closed)
		}
	}
}