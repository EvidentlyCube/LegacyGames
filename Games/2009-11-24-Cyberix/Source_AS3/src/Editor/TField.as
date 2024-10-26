package Editor{
	import Classes.Scenes.TEditorScene;

	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	import mx.core.BitmapAsset;
	public class TField extends Sprite{
		public var type:uint
		public var tempx:uint
		public var tempy:uint
		public var tempgfx:Sprite
		public var tempclass:uint
		public var tempover:Sprite
		public function TField(fx:uint,fy:uint,ft:uint,chan:Boolean = true){
			x = fx * 24
			y = fy * 24
			type = ft
			if (type != 0 && type != 70 && type != 200){addChild(new (GiveClass(type)))}
			var f:TField
			if (type == 186){
				f = TEditorScene.layer2[x / 24][y / 24]
				if (f != null && f.type == 206){
					f.remove(true)
				}
			} else if (type == 206){
				f = TEditorScene.layer1[x / 24][y / 24]
				if (f != null && f.type == 186){
					f.remove(true)
				}
			}
			if (chan){
				switch (type){
					case(173):
					case(174):
						TEditorScene.drawLayer = 3
						TEditorScene.setItemText()
						TEditorScene.drawField = this
						break;
					case(175):
						TEditorScene.drawLayer = 4
						TEditorScene.setItemText()
						TEditorScene.drawField = this
					break
				}
			}
			if (type < 70){
				TEditorScene.layerFloor.addChild(this)
			} else if (type < 200){
				TEditorScene.layerItems.addChild(this)
			} else {
				TEditorScene.layerObjects.addChild(this)
			}
		}
		override public function toString():String{
			var result:String = ""
			if (type < 200){
				result += NumToText(type - 140)
			} else if(type >= 200){
				result += NumToText(type - 200)
			}
			switch (type){
				case(173):
				case(174):
					result += NumToText(tempx,1)
					result += NumToText(tempy,1)
					break;
				case(175):
					result += NumToText(tempclass,2)
					result += NumToText(tempx,1)
					result += NumToText(tempy,1)
					break;
			}
			return result;
		}
		public function remove(deArray:Boolean = false):void{
			if (type < 70){
				TEditorScene.layerFloor.removeChild(this)
				if (deArray){
					TEditorScene.layer0[x / 24][y / 24]=null
				}
			} else if (type < 200){
				TEditorScene.layerItems.removeChild(this)
				if (deArray){
					TEditorScene.layer1[x / 24][y / 24]=null
				}
			} else {
				TEditorScene.layerObjects.removeChild(this)
				if (deArray){
					TEditorScene.layer2[x / 24][y / 24]=null
				}
			}
			if ((type == 173 || type == 174 || type == 175) && tempgfx != null){
				TEditorScene.layerOvers.removeChild(tempgfx)
				TEditorScene.layerHud.removeChild(tempover)
				tempover.removeEventListener(MouseEvent.MOUSE_OUT,hide)
				tempover.removeEventListener(MouseEvent.MOUSE_OVER,show)
			}
		}
		public function Teleportisis():void{
			if (type == 175){
				Buttonize();
				return;
			}
			tempover = new Sprite
			tempover.graphics.beginFill(0xFFFFFF,0)
			tempover.graphics.drawRect(x,y,24,24)
			TEditorScene.layerHud.addChildAt(tempover,0)
			tempgfx = new Sprite
			tempgfx.graphics.beginFill(0x8888FF,0.8)
			tempgfx.graphics.drawRect(tempx * 24,tempy * 24,24,24)
			tempgfx.graphics.endFill()
			TEditorScene.layerOvers.addChild(tempgfx)
			tempgfx.visible = false
			tempover.addEventListener(MouseEvent.MOUSE_OUT,hide)
			tempover.addEventListener(MouseEvent.MOUSE_OVER,show)
		}
		public function Buttonize():void{
			tempover = new Sprite
			tempover.graphics.beginFill(0xFFFFFF,0)
			tempover.graphics.drawRect(x,y,24,24)
			TEditorScene.layerHud.addChildAt(tempover,0)
			tempgfx = new Sprite
			tempgfx.graphics.beginFill(0x8888FF,1)
			tempgfx.graphics.drawRect(tempx * 24,tempy * 24,24,24)
			tempgfx.graphics.endFill()
			if (tempclass != 0 && tempclass != 70){
				var g:BitmapAsset = new (GiveClass(tempclass))
				g.x = tempx * 24
				g.y = tempy * 24
				g.alpha = 0.6
				tempgfx.addChild(g)
			}
			TEditorScene.layerOvers.addChild(tempgfx)
			tempgfx.alpha = 0.8
			tempgfx.visible = false
			tempover.addEventListener(MouseEvent.MOUSE_OUT,hide)
			tempover.addEventListener(MouseEvent.MOUSE_OVER,show)
		}
		public function show(e:MouseEvent):void{
			tempgfx.visible = true
		}
		public function hide(e:MouseEvent):void{
			tempgfx.visible = false
		}
	}
}