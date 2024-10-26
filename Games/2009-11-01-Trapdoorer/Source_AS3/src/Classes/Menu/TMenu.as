package Classes.Menu{
	import Classes.Grid9;

	import flash.display.Sprite;
	import flash.filters.DropShadowFilter;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
    import flash.text.TextFormat;

	public class TMenu extends Sprite{
		public function TMenu(){}
		public function drawMenu(wid: uint, hei: uint): void{
			if (wid > 600){wid = 600} else if (wid < 150){wid = 150}
			if (hei > 600){hei = 600} else if (hei < 100){hei = 100}
			graphics.beginFill(0xAAAAAA)
			graphics.drawRoundRect(0, 0,wid, hei, 24, 24)
			graphics.endFill()
		}
		public static function makeInputField(x: int = 0, y: int = 0, width: uint = 250, height: uint = 30, text: String="Type it Here", size: uint = 20): TextField{
			var format: TextFormat = new TextFormat();
			format.font = "fonter";
			format.size = size;

			var textInput: TextField = new TextField;
			textInput.defaultTextFormat = format;
			textInput.embedFonts = true
			textInput.type = TextFieldType.INPUT
			textInput.autoSize = TextFieldAutoSize.NONE
			textInput.width = width
			textInput.height = height
			textInput.textColor = 0xEEEEEE
			textInput.text=text
			textInput.x = x
			textInput.y = y
			textInput.tabEnabled = false

			textInput.filters = [new DropShadowFilter(2, 45, 0,1, 3,3, 1)]

			return textInput;
		}
		protected function makeBack(tf: TextField): Grid9{
			var g: Grid9 = new Grid9(TWindow.Grid9DataTextfield)
			g.x = tf.x
			g.y = tf.y
			g.width = tf.width
			g.height = tf.height
			return g;
		}
	}
}