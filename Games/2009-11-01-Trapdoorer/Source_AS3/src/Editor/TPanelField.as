package Editor{
	import Classes.SFX;
	import Classes.Scenes.TEditorScene;

	import flash.display.Sprite;
	import flash.events.MouseEvent;
	public class TPanelField extends Sprite{
		public var layer: uint
		public var id: uint
		public function TPanelField(l: uint, i: uint){
			layer = l
			id = i
			if (id!=0){addChild(new (GiveClass(id)))}

			graphics.beginFill(0x000000)
			graphics.drawRect(-1, -1, 27, 27)
			graphics.endFill()
			x = 163+(id%10)*28
			y = 140+Math.floor(id/10)*28

			TEditorScene.panel.addChild(this)
			addEventListener(MouseEvent.CLICK, clicked)
			addEventListener(MouseEvent.MOUSE_OVER, overed)
			addEventListener(MouseEvent.MOUSE_OUT, outed)
			buttonMode = true
		}
		public function clicked(e: MouseEvent): void{
			SFX.Play("click2")
			TEditorScene.setItem(id, GiveClass(id))
			TEditorScene.pointerItemText = GiveText(id)
		}
		public function overed(e: MouseEvent): void{
			TEditorScene.setInfo(GiveText(id));
		}
		public function outed(e: MouseEvent): void{
			TEditorScene.setItemText()
		}
	}
}