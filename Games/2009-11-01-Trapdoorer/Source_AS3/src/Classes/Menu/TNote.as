package Classes.Menu{
	import Classes.Grid9;

	import Editor.MakeText;
	import Editor.MakeText3;

	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	public class TNote extends Sprite{
		private var _headerTextField: TextField
		private var _bodyTextField: TextField
		private var _image: DisplayObject
		private var _background: Grid9
		private var _isHiding: Boolean = false
		private var _isFast: Boolean = false

		public function hide(): void {
			_isHiding = true;
			_isFast = true;
			alpha = Math.min(alpha, 1);
		}
		public function TNote(captionText: String, bodyText: String, image: DisplayObject = null){
			mouseEnabled = false;
			mouseChildren = false;
			_headerTextField = MakeText(captionText)
			_image = image
			_background = new Grid9(TWindow.Grid9DataMenu)
			_background.width = 200
			_background.height = 100
			_headerTextField.x = 100-_headerTextField.width/2
			addChild(_background)
			addChild(_headerTextField)
			if (_image){
				_image.x = 10
				_image.y = 25
				addChild(_image)
				_bodyTextField = MakeText3(bodyText, 12, "justify", 170-_image.width)
				_bodyTextField.x = image.width+15
				_bodyTextField.y = 25
			} else {
				_bodyTextField = MakeText3(bodyText, 12, "center", 170)
				_bodyTextField.x = 15
				_bodyTextField.y = 25
			}
			addChild(_bodyTextField)
			alpha = 0
			x = 400
			y = 500

			this.addEventListener(Event.ENTER_FRAME, step)

			for (var i: Number = 0; i < TD.notes.numChildren; i++) {
				var child:* = TD.notes.getChildAt(i);

				if (child is TNote) {
					child.hide();
				}
			}
			TD.notes.addChild(this)
		}
		private function step(e: Event): void{
			if (!_isHiding){
				alpha += 0.05
				if (alpha > 2){_isHiding = true}
			} else {
				alpha -= 0.05

				if (_isFast) {
					alpha -= 0.1;
				}

				if (alpha < 0){
					removeEventListener(Event.ENTER_FRAME, step)
					parent.removeChild(this)
				}
			}
		}
	}
}