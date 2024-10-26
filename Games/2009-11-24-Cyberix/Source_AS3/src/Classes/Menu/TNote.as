package Classes.Menu{
	import Classes.Grid9;

	import Editor.MakeText;
	import Editor.MakeText3;

	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	public class TNote	 extends Sprite{
		private var capt:TextField
		private var cont:TextField
		private var imag:DisplayObject
		private var bg:Grid9
		private var isHiding:Boolean = false
		public function TNote(caption:String, text:String, image:DisplayObject = null){
			capt = MakeText(caption)
			imag = image
			bg = new Grid9(TWindow.Grid9DataMenu)
			bg.width = 200
			bg.height = 100
			capt.x = 100 - capt.width / 2
			addChild(bg)
			addChild(capt)
			if (imag){
				imag.x = 10
				imag.y = 44
				addChild(imag)
				cont = MakeText3(text,12,"justify",170 - imag.width)
				cont.x = image.width + 15
				cont.y = 44
			} else {
				cont = MakeText3(text,12,"justify",170)
				cont.x = 15
				cont.y = 44
			}
			addChild(cont)
			alpha = 0
			x = 400
			y = 500
			this.addEventListener(Event.ENTER_FRAME,step)
			Game.notes.addChild(this)
		}
		private function step(e:Event):void{
			if (!isHiding){
				alpha += 0.05
				if (alpha > 3){isHiding = true}
			} else {
				alpha -= 0.05
				if (alpha < 0){
					removeEventListener(Event.ENTER_FRAME,step)
					parent.removeChild(this)
				}
			}
		}
	}
}