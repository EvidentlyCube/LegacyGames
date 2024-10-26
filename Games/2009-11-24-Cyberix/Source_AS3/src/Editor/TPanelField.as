package Editor{
	import Classes.Scenes.TEditorScene;

	import flash.display.Sprite;
	import flash.events.MouseEvent;

	import mx.core.BitmapAsset;
	public class TPanelField extends Sprite{
		public var layer:uint
		public var id:uint
		public function TPanelField(l:uint,i:uint){
			layer = l
			id = i
			if (id != 0 && id != 70 && id != 200 && id < 500){addChild(new (GiveClass(id)))}
			if (id >= 500){
				var gfx:BitmapAsset = new (GiveClass(id))
				graphics.beginFill(0x000000)
				graphics.drawRect(-1,-1,32,32)
				graphics.endFill()
				gfx.width = 30
				gfx.height = 30
				x = 31 + ((id - 500)%3) * 33
				y = 560 - Math.floor((id - 500) / 3) * 33
				addChild(gfx)
			} else {
				graphics.beginFill(0x000000)
				graphics.drawRect(-1,-1,26,26)
				graphics.endFill()
				x = 31 + (id%20) * 27
				y = 160 + Math.floor(id / 20) * 27
			}
			TEditorScene.panelBottom.addChild(this)
			addEventListener(MouseEvent.CLICK,clicked)
			addEventListener(MouseEvent.MOUSE_OVER,overed)
			addEventListener(MouseEvent.MOUSE_OUT,outed)
			buttonMode = true
		}
		public function clicked(e:MouseEvent):void{
			TEditorScene.setItem(layer,id,GiveClass(id))
			if (id < 500){TEditorScene.pointerItemText = GiveText(id);}
		}
		public function overed(e:MouseEvent):void{
			TEditorScene.setInfo(GiveText(id));
		}
		public function outed(e:MouseEvent):void{
			TEditorScene.setItemText()
		}
	}
}