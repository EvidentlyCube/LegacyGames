package Classes{
	import LoadingDir.Loading;

	import flash.display.BlendMode;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;

	import mx.core.BitmapAsset;

	public class PagingButton extends Sprite{
		private var back: BitmapAsset
		private var fore: BitmapAsset
		private var anim: int = 0
		public function PagingButton(b: Class){
			back = new b

			fore = new b
			fore.blendMode = BlendMode.ADD
			fore.alpha = 0
			this.buttonMode = true
			this.tabEnabled = false
			addEventListener(MouseEvent.MOUSE_OVER, mouseOver)
			addEventListener(MouseEvent.MOUSE_OUT, mouseOut)
			addEventListener(MouseEvent.CLICK, mouseClick)

			addChild(back)
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