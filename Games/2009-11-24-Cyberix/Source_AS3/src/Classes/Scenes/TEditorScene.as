package Classes.Scenes{
	import Classes.GFX;
	import Classes.Grid9;
	import Classes.Menu.*;
	import Classes.TLevData;

	import Editor.*;

	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.ui.Keyboard;

	import mx.core.BitmapAsset;
	public class TEditorScene extends TScene{
		public static var layerFloor:Sprite = new Sprite
		public static var layerItems:Sprite = new Sprite
		public static var layerObjects:Sprite = new Sprite
		public static var layerHud:Sprite = new Sprite
		public static var layerBG:Sprite = new Sprite
		public static var layerSize:Shape = new Shape
		public static var layerOvers:Sprite = new Sprite
		public static var panelTop:Sprite
		public static var panelTopGrid:Grid9
		public static var panelBottom:Sprite
		public static var panelBottomGrid:Grid9
		public static var pointerText:TextField
		public static var pointerItemText:String = ""
		public static var pointerItem:Sprite
		public static var display:Boolean = false
		public static var drawX:int = 0
		public static var drawY:int = 0
		public static var drawLayer:uint = 0
		public static var drawID:uint
		public static var drawField:TField = null
		public static var layer0:Array
		public static var layer1:Array
		public static var layer2:Array
		public static var isMouse:Boolean = false
		public static var bgID:uint = 0
		public static var levWid:uint = 25
		public static var levHei:uint = 25
		public static var layAct:Array = new Array(3)
		public static var selWin:TSelectWindow
		public static var madeChanges:Boolean = false

		public function TEditorScene(){
			madeChanges = false;

			if (panelTop == null){
				layAct[0]=1
				layAct[1]=1
				layAct[2]=1

				panelTop = new Sprite
				panelBottom = new Sprite
				pointerItem = new Sprite

				panelTopGrid = new Grid9(TWindow.Grid9DataMenu)
				panelTopGrid.x = 20
				panelTopGrid.y=-70
				panelTopGrid.width = 560
				panelTopGrid.height = 160

				panelBottomGrid = new Grid9(TWindow.Grid9DataMenu)
				panelBottomGrid.x = 20
				panelBottomGrid.y = 110
				panelBottomGrid.width = 560
				panelBottomGrid.height = 500

				pointerItem.graphics.beginFill(0xBBBBBB,0.5)
				pointerItem.graphics.drawRoundRect(0,0,24,24,15,15)
				pointerItem.graphics.endFill()
				pointerItem.graphics.lineStyle(2,0xFFFFFF)
				pointerItem.graphics.drawRoundRect(-1,-1,26,26,15,15)

				var title:TextField = MakeText("Editor Items:",19)
				title.x = 300 - title.width / 2
				title.y = 112

				panelTop.addChild(panelTopGrid)
				panelBottom.addChild(panelBottomGrid)
				panelBottom.addChild(title)
				FillPanels()
			}
			layerBG.addChild(new (GFX.bg0))

			layer0 = new Array(25)
			layer1 = new Array(25)
			layer2 = new Array(25)
			for (var i:uint = 0;i < 25;i++){
				layer0[i]=new Array(25)
				layer1[i]=new Array(25)
				layer2[i]=new Array(25)
			}
			pointerText = MakeText("Some Info",12)

			Game.layerEditor.addChild(layerBG)
			Game.layerEditor.addChild(layerFloor)
			Game.layerEditor.addChild(layerItems)
			Game.layerEditor.addChild(layerObjects)
			Game.layerEditor.addChild(layerOvers)
			Game.layerEditor.addChild(layerSize)
			Game.layerEditor.addChild(layerHud)

			setItem(0,0,null)
			pointerItemText = GiveText(0)
			setInfo(GiveText(0))

			display = true

			layerItems.addChild(pointerItem)
			layerHud.addChild(panelTop)
			layerHud.addChild(panelBottom)
			layerHud.addChild(pointerText)
			layerHud.addChild(TopPanelMonster.helper)
			Game.STG.addEventListener(KeyboardEvent.KEY_DOWN,hitEscape)
		}
		public function hitEscape(e:KeyboardEvent):void{
			var isMenu:* = e.keyCode == Keyboard.ESCAPE || e.keyCode == Keyboard.P;
			if (isMenu && !TopPanelMonster.editing){
				selWin = new TSelectWindow("If you leave, all unsaved data will be lost.\nAre you sure you want to leave?","Yes","No")
				selWin.addEventListener(TWindow.CHOICE1,winYes)
				selWin.addEventListener(TWindow.CHOICE2,winNo)
			}
		}
		public function winYes(e:Event):void{
			selWin.removeEventListener(TWindow.CHOICE1,winYes)
			selWin.removeEventListener(TWindow.CHOICE2,winNo)
			selWin = null
			madeChanges = false
			Game.setScene(TSelfmadeScene)
		}
		public function winNo(e:Event):void{
			selWin.removeEventListener(TWindow.CHOICE1,winYes)
			selWin.removeEventListener(TWindow.CHOICE2,winNo)
			selWin = null
		}
		override public function update():void{
			if (TopPanelMonster.editing || WindowHandler.windowsCount > 0) {
				return;
			}

			if (!display || TopPanelMonster.editing){
				panelTop.y=-150
				panelBottom.y = 500
			} else {
				panelTop.y = 0
				panelBottom.y = 0
			}
			pointerText.x = Game.self.mouseX + 15
			pointerText.y = Game.self.mouseY
			drawX = Math.floor(Game.self.mouseX / 24)
			drawY = Math.floor(Game.self.mouseY / 24)
			if (drawX < 0){drawX = 0}
			if (drawX > 24){drawX = 24}
			if (drawY < 0){drawY = 0}
			if (drawY > 24){drawY = 24}
			pointerItem.x = drawX * 24
			pointerItem.y = drawY * 24
			if (!display && isMouse && !TopPanelMonster.editing && !selWin){
				switch (drawLayer){
					case (0):
						addFloor()
						break;
					case (1):
						addItem()
						break
					case (2):
						addObject()
						break;
				}
			}
			fixSize()
		}
		public function mouseDown(e:MouseEvent):void{
			isMouse = true
		}
		public function mouseUp(e:MouseEvent):void{
			isMouse = false
			if (isMouse == false && display == false && !TopPanelMonster.editing && !selWin && drawLayer == 3){
				teleportDestination()
			}
		}
		public function addFloor():void{
			if (layer0[drawX][drawY]){
				if (layer0[drawX][drawY].type != drawID){
					layer0[drawX][drawY].remove()
					layer0[drawX][drawY]=null
					madeChanges = true
				}
			}
			if (!layer0[drawX][drawY] && drawID != 0){
				layer0[drawX][drawY]=new TField(drawX,drawY,drawID)
				madeChanges = true
			}
		}
		public function addItem():void{

			if (layer1[drawX][drawY]){
				if (layer1[drawX][drawY].type != drawID){
					layer1[drawX][drawY].remove()
					layer1[drawX][drawY]=null
					madeChanges = true
				}
			}
			if (!layer1[drawX][drawY] && drawID != 70){
				layer1[drawX][drawY]=new TField(drawX,drawY,drawID)
				madeChanges = true
			}
		}
		public function addObject():void{
			if (layer2[drawX][drawY]){
				if (layer2[drawX][drawY].type != drawID){
					layer2[drawX][drawY].remove()
					layer2[drawX][drawY]=null
					madeChanges = true
				}
			}
			if (!layer2[drawX][drawY] && drawID != 200){
				layer2[drawX][drawY]=new TField(drawX,drawY,drawID)
				madeChanges = true
			}
		}
		public function teleportDestination():void{
			if (drawField != null){
				drawField.tempx = drawX
				drawField.tempy = drawY
				drawField.Teleportisis()
				drawField = null
				drawLayer = 1
				setItemText()
			}
		}
		public function keyDown(e:KeyboardEvent):void{
			var mx:uint = Math.floor(Game.STG.mouseX / 24)
			var my:uint = Math.floor(Game.STG.mouseY / 24)
			var id:uint
			switch (e.keyCode){
				case (Keyboard.SPACE): display = !display; break;
				case (Keyboard.LEFT): if (TopPanelMonster.editing){return};levWid = Math.max(3,levWid - 1); fixSize();break;
				case (Keyboard.RIGHT): if (TopPanelMonster.editing){return};levWid = Math.min(25,levWid + 1); fixSize();break;
				case (Keyboard.UP): if (TopPanelMonster.editing){return};levHei = Math.max(3,levHei - 1); fixSize();break;
				case (Keyboard.DOWN): if (TopPanelMonster.editing){return};levHei = Math.min(25,levHei + 1); fixSize();break;
				case (49):
					if (TopPanelMonster.editing || selWin){return}
					layAct[0]=1 - layAct[0]
					layerFloor.alpha = 0.4 + 0.8 * layAct[0]
					break;
				case (50):
					if (TopPanelMonster.editing || selWin){return}
					layAct[1]=1 - layAct[1]
					layerItems.alpha = 0.3 + 0.8 * layAct[1]
					break;
				case (51):
					if (TopPanelMonster.editing || selWin){return}
					layAct[2]=1 - layAct[2]
					layerObjects.alpha = 0.3 + 0.8 * layAct[2]
					break;
				case (88):
					if (TopPanelMonster.editing || selWin){return}
					if (layer2[mx][my]!=null && layAct[2]==1){
						layer2[mx][my].remove(true)
						madeChanges = true
						break;
					}
					if (layer1[mx][my]!=null && layAct[1]==1){
						layer1[mx][my].remove(true)
						madeChanges = true
						break;
					}
					if (layer0[mx][my]!=null && layAct[0]==1){
						layer0[mx][my].remove(true)
						madeChanges = true
						break;
					}
					break;
				case(67):
					if (TopPanelMonster.editing || selWin){return}
					if (layer2[mx][my]!=null && layAct[2]==1){
						id = layer2[mx][my].type
						TEditorScene.setInfo(GiveText(id));
						TEditorScene.setItem(2,id,GiveClass(id))
						break;
					}
					if (layer1[mx][my]!=null && layAct[1]==1){
						id = layer1[mx][my].type
						TEditorScene.setInfo(GiveText(id));
						TEditorScene.setItem(1,id,GiveClass(id))
						break;
					}
					if (layer0[mx][my]!=null && layAct[0]==1){
						id = layer0[mx][my].type
						TEditorScene.setInfo(GiveText(id));
						TEditorScene.setItem(0,id,GiveClass(id))
						break;
					}
					break;
			}
		}
		public static function setInfo(txt:String = ""):void{
			pointerText.htmlText = "<font face='fonter' color='#FFFFFF' size='12'>"+txt + "</font>";
		}
		public static function setItemText():void{
			if (drawLayer < 3){
				setInfo(pointerItemText)
			} else if(drawLayer == 3){
				if (drawID == 173){
					setInfo("Release to set\nteleport destination!")
				} else if(drawID == 174){
					setInfo("Release to set\nposition where\ncannon will shot!")
				} else if(drawID == 175){
					setInfo("Click to set\nitem toggle position!")
				}
			} else if(drawLayer == 4){
				setInfo("Select Item Type!")
			}
		}
		public static function setItem(layer:uint,id:uint,gfxc:Class):void{
			display = false;

			if (drawLayer == 4){
				if (id < 70 || id == 173 || id == 174 || id == 175 || id == 186 || (id >= 140 && id < 160) ||id >= 199){
					setInfo("CANNOT USE THIS ITEM!")
					return
				}
				drawField.tempclass = id
				drawLayer = 3
				setItemText()
				return
			}
			if (drawLayer == 3){
				drawField.remove(true)
				drawField = null
				drawLayer = 0
			}
			if (id >= 500){
				layerBG.removeChildAt(0)
				bgID = id - 500
				layerBG.addChild(new gfxc)
				return
			}
			if (drawLayer < 3){
				drawLayer = layer
				drawID = id
				if (pointerItem.numChildren > 0){
					pointerItem.removeChildAt(0)
				}
				if (gfxc != null){
					var gfx:BitmapAsset = new gfxc
					gfx.alpha = 0.5
					pointerItem.addChild(gfx)
				}
				pointerItem.mouseEnabled = false
			}
			setAlphas()
		}
		public static function setAlphas():void{
			return
			switch(drawLayer){
				case(0):
					layerFloor.alpha = 1
					layerItems.alpha = 0.5
					layerObjects.alpha = 0.5
					break;
				case(1):
					layerFloor.alpha = 0.5
					layerItems.alpha = 1
					layerObjects.alpha = 0.5
					break;
				case(1):
					layerFloor.alpha = 0.5
					layerItems.alpha = 0.5
					layerObjects.alpha = 1
					break;
				default:
					layerFloor.alpha = 1
					layerItems.alpha = 1
					layerObjects.alpha = 1
					break;
			}
		}
		override public function add():void{
			Game.STG.addEventListener(KeyboardEvent.KEY_DOWN,keyDown)
			Game.STG.addEventListener(MouseEvent.MOUSE_DOWN,mouseDown)
			Game.STG.addEventListener(MouseEvent.MOUSE_UP,mouseUp)
			Game.addLayer(Game.layerEditor)
		}
		override public function remove():void{
			for (var i:uint = 0;i < 25;i++){
				for (var j:uint = 0;j < 25;j++){
					if (layer0[i][j]!=null){TField(layer0[i][j]).remove(true)}
					if (layer1[i][j]!=null){TField(layer1[i][j]).remove(true)}
					if (layer2[i][j]!=null){TField(layer2[i][j]).remove(true)}
				}
			}
			Game.clearLayer(Game.layerEditor)
			Game.clearLayer(layerBG)
			Game.clearLayer(layerFloor)
			Game.clearLayer(layerItems)
			Game.clearLayer(layerObjects)
			Game.clearLayer(layerHud)
			Game.clearLayer(layerOvers)
			Game.STG.removeEventListener(KeyboardEvent.KEY_DOWN,keyDown)
			Game.STG.removeEventListener(MouseEvent.MOUSE_DOWN,mouseDown)
			Game.STG.removeEventListener(MouseEvent.MOUSE_UP,mouseUp)
			Game.STG.removeEventListener(KeyboardEvent.KEY_DOWN,this.hitEscape)
			drawLayer = 0
			drawID = 0
			Game.removeLayer(Game.layerEditor)
		}
		private function fixSize():void{
			layerSize.graphics.clear()
			if (levWid < 25 || levHei < 25){
				layerSize.graphics.moveTo(levWid * 24,0)
				layerSize.graphics.lineStyle(2,0xFFFFFF)
				layerSize.graphics.lineTo(levWid * 24,levHei * 24)
				layerSize.graphics.lineTo(0,levHei * 24)
			}
		}
	}
}