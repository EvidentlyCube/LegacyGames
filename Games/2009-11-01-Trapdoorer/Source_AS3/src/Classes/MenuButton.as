package Classes{
	import Classes.Menu.TWindow;

	import Editor.MakeText;

	import LoadingDir.Loading;

	import flash.display.BlendMode;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;

	public class MenuButton extends Sprite{
		private var text: TextField
		private var back: Grid9
		private var fore: Grid9
		private var anim: int = 0
		public function MenuButton(txt: String="", txtSize: uint = 18, wid: uint = 0, hei: uint = 0){
			text = MakeText(txt, txtSize-2)
			text.x = 0
			text.y = 0

			back = new Grid9(TWindow.Grid9DataButton, 1)
			back.x = -11
			back.y = -2
			back.width = text.width+24
			back.height = text.height+12

			fore = new Grid9(TWindow.Grid9DataButton, 0)
			fore.x = -11
			fore.y = -2
			fore.width = text.width+24
			fore.height = text.height+12
			fore.blendMode = BlendMode.SCREEN
			fore.alpha = 0
			fore.buttonMode = true
			fore.tabEnabled = false
			fore.addEventListener(MouseEvent.MOUSE_OVER, mouseOver)
			fore.addEventListener(MouseEvent.MOUSE_OUT, mouseOut)
			fore.addEventListener(MouseEvent.CLICK, mouseClick)
			if (wid > 0){
				back.width = wid
				fore.width = wid
				text.x = back.width/2-text.width/2-12
			}
			if (hei > 0){
				back.height = hei
				fore.height = hei
			}

			addChild(back)
			addChild(text)
			addChild(fore)
		}
		private function update(e: Event): void{
			if (anim > 0){
				fore.alpha += 0.1
				if (fore.alpha >= 1){
					fore.alpha = 1
					anim = 0
					unhookFromStage()
				}
			} else if (anim < 0){
				fore.alpha -= 0.1
				if (fore.alpha <= 0){
					fore.alpha = 0
					anim = 0
					unhookFromStage()
				}
			}
		}
		private function mouseClick(e: MouseEvent): void{
			SFX.Play("click")
		}
		private function mouseOver(e: MouseEvent): void{
			if (anim == 0){hookToStage()}
			SFX.Play("over")
			anim = 1
		}
		private function mouseOut(e: MouseEvent): void{
			if (anim == 0){hookToStage()}
			anim = -1
		}
		private function hookToStage(): void{
			Loading.self.stage.addEventListener(Event.ENTER_FRAME, update)
		}
		private function unhookFromStage(): void{
			Loading.self.stage.removeEventListener(Event.ENTER_FRAME, update)
		}
		public function clear(): void{
			fore.removeEventListener(MouseEvent.MOUSE_OVER, mouseOver)
			fore.removeEventListener(MouseEvent.MOUSE_OUT, mouseOut)
			if (anim!=0){
				unhookFromStage()
			}
		}
	}
}