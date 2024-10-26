package Classes.Scenes{
	import Classes.Grid9;
	import Classes.Interactivers.TPlayer;
	import Classes.Menu.TSelectWindow;
	import Classes.Menu.TWindow;
	import Classes.Menu.WindowHandler;
	import Classes.SFX;

	import Editor.*;

	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.ui.Keyboard;

	import mx.core.BitmapAsset;
	public class TEditorScene extends TScene{
		public static var layerBlocks: Sprite = new Sprite
		public static var layerHud: Sprite = new Sprite
		public static var layerSize: Shape = new Shape
		public static var layerOvers: Sprite = new Sprite
		public static var panel: Sprite
		public static var panelGrid: Grid9
		public static var pointerText: TextField
		public static var pointerItemText: String=""
		public static var pointerItem: Sprite
		public static var display: Boolean = false
		public static var drawX: int = 0
		public static var drawY: int = 0
		public static var drawID: uint
		public static var offX: int = 0
		public static var offY: int = 0
		public static var drawField: TField = null
		public static var layer: Array
		public static var isMouse: Boolean = false
		public static var bgID: uint = 0
		public static var levWid: uint = 25
		public static var levHei: uint = 25
		public static var wantToExitWindow: TSelectWindow
		public static var madeChanges: Boolean = false
		public static var pla: BitmapAsset
		public function TEditorScene(){
			if (panel == null){
				pla = new TPlayer.g
				panel = new Sprite
				pointerItem = new Sprite


				panelGrid = new Grid9(TWindow.Grid9DataMenu)
				panelGrid.x = 20
				panelGrid.y = 20
				panelGrid.width = 560
				panelGrid.height = 560

				pointerItem.graphics.beginFill(0xBBBBBB, 0.5)
				pointerItem.graphics.drawRoundRect(0, 0,24, 24, 15, 15)
				pointerItem.graphics.endFill()
				pointerItem.graphics.lineStyle(2, 0xFFFFFF)
				pointerItem.graphics.drawRoundRect(-1, -1, 26, 26, 15, 15)

				var title: TextField = MakeText("Editor Items: ", 19)
				title.x = 300-title.width/2
				title.y = 112

				panel.addChild(panelGrid)
				panel.addChild(title)
				FillPanels()
				layerBlocks.graphics.beginFill(0x222222)
				layerBlocks.graphics.drawRect(-50, -50, 1350, 50)
				layerBlocks.graphics.drawRect(-50, 0,50, 1300)
				layerBlocks.graphics.drawRect(1250, 0,50, 1300)
				layerBlocks.graphics.drawRect(0, 1250, 1250, 50)
				layerBlocks.graphics.beginFill(0xFFFFFF, 0.15)
				layerBlocks.graphics.drawRect(325, 325, 600, 600)
				layerBlocks.graphics.drawRect(600, 600, 50, 50)
			}
			pla.visible = false
			pla.x = -25
			pla.y = -25
			pla.scaleX = 0.5
			pla.scaleY = 0.5
			layer = new Array(50)
			for (var i: uint = 0;i < 50;i++){
				layer[i]=new Array(50)
			}
			pointerText = MakeText("Some Info", 12)

			TD.layerEditor.addChild(layerBlocks)
			TD.layerEditor.addChild(layerOvers)
			TD.layerEditor.addChild(layerSize)
			TD.layerEditor.addChild(layerHud)

			layerBlocks.x = -325
			layerBlocks.y = -325

			setItem(0, null)
			pointerItemText = GiveText(0)
			setInfo(GiveText(0))
			layerOvers.addChild(pla)
			layerHud.addChild(pointerItem)
			layerHud.addChild(panel)
			layerHud.addChild(pointerText)
			TD.STG.addEventListener(KeyboardEvent.KEY_DOWN, hitEscape)
			display = true
		}
		public function hitEscape(e: KeyboardEvent): void{
			if (e.keyCode !== Keyboard.ESCAPE) {
				return;
			}
			if (!TopPanelMonster.editing && WindowHandler.winCount === 0){
				if (madeChanges) {
					wantToExitWindow = new TSelectWindow("If you leave, all unsaved data will be lost.\nAre you sure you want to leave?", "Yes", "No")
					wantToExitWindow.addEventListener(TWindow.CHOICE1, onWantToQuitYes)
					wantToExitWindow.addEventListener(TWindow.CHOICE2, onWantToQuitNo)
				} else {
					onWantToQuitYes(null);
				}
			}
		}

		public function clearAreYouSureQuitWindow(): void {
			if (!wantToExitWindow) {
				return;
			}

			wantToExitWindow.removeEventListener(TWindow.CHOICE1, onWantToQuitYes)
			wantToExitWindow.removeEventListener(TWindow.CHOICE2, onWantToQuitNo)
			wantToExitWindow.kill();
			wantToExitWindow = null;
		}
		public function onWantToQuitYes(e: Event): void{
			clearAreYouSureQuitWindow();

			madeChanges = false
			TD.setScene(TSelfmadeScene)
		}
		public function onWantToQuitNo(e: Event): void{
			clearAreYouSureQuitWindow();
			wantToExitWindow = null
		}
		override public function update(): void{
			// Freeze when window is open
			if (WindowHandler.winCount > 0) {
				isMouse = false;
				return;
			}

			if (!display || TopPanelMonster.editing){
				panel.y = 600
			} else {
				panel.y = 0
			}
			var tx: Number = TD.self.mouseX/600
			var ty: Number = TD.self.mouseY/600
			layerBlocks.x -= offX*10
			layerBlocks.y -= offY*10
			if (layerBlocks.x > 50){layerBlocks.x = 50}
			if (layerBlocks.x < -700){layerBlocks.x = -700}
			if (layerBlocks.y > 50){layerBlocks.y = 50}
			if (layerBlocks.y < -700){layerBlocks.y = -700}
			layerOvers.x = layerBlocks.x
			layerOvers.y = layerBlocks.y
			/*
			0 -> 0
			1  -> -650
			*/

			pointerText.x = TD.self.mouseX+15
			pointerText.y = TD.self.mouseY
			drawX = Math.floor((TD.self.mouseX-layerBlocks.x)/25)
			drawY = Math.floor((TD.self.mouseY-layerBlocks.y)/25)
			if (drawX < 0){drawX = 0}
			if (drawX > 49){drawX = 49}
			if (drawY < 0){drawY = 0}
			if (drawY > 49){drawY = 49}
			pointerItem.x = drawX*25+layerBlocks.x
			pointerItem.y = drawY*25+layerBlocks.y
			if (!display && isMouse && !TopPanelMonster.editing && !wantToExitWindow){
				addBlock()
			}
			if (TD.layerEditor.alpha < 1){TD.layerEditor.alpha += 0.1}
			if (TD.layerFader.alpha > 0){TD.layerFader.alpha -= 0.1}
		}
		public function mouseDown(e: MouseEvent): void{
			isMouse = true
		}
		public function mouseUp(e: MouseEvent): void{
			isMouse = false
		}
		public function addBlock(): void{
			if (layer[drawX][drawY]){
				if (layer[drawX][drawY].type!=drawID){
					layer[drawX][drawY].remove()
					layer[drawX][drawY]=null
					madeChanges = true
					if (drawID == 0){
						SFX.Play("over2")
					}
				}
			}
			if (!layer[drawX][drawY] && drawID!=0){
				SFX.Play("over2")
				layer[drawX][drawY]=new TField(drawX, drawY, drawID)
				madeChanges = true
			}
		}
		public function keyDown(e: KeyboardEvent): void{
			if (TopPanelMonster.editing || wantToExitWindow){return}
			var mx: uint = drawX
			var my: uint = drawY
			var id: uint
			switch (e.keyCode){
				case (Keyboard.SPACE): display = true; break;
				case(Keyboard.LEFT):
					offX = -1
					break;
				case(Keyboard.RIGHT):
					offX = 1
					break;
				case(Keyboard.UP):
					offY = -1
					break;
				case(Keyboard.DOWN):
					offY = 1
					break;
				case (83):
					SFX.Play("click2")
					if (pla.visible = true){
						if (mx == pla.x/25 && my == pla.y/25){
							pla.visible = false
							pla.x = -25
							pla.y = -25
							madeChanges = true
							return
						}
					}
					pla.visible = true
					pla.x = mx*25
					pla.y = my*25
					madeChanges = true
					break;
				case (88):
					if (layer[mx][my]!=null){
						layer[mx][my].remove(true)
						madeChanges = true
						SFX.Play("over2")
					}
					break;
				case(67):
					if (layer[mx][my]!=null){
						id = layer[mx][my].type
						TEditorScene.setInfo(GiveText(id));
						TEditorScene.setItem(id, GiveClass(id))
						break;
					}
					break;
			}
		}
		public function keyUp(e: KeyboardEvent): void{
			switch (e.keyCode){
				case (Keyboard.SPACE): display = false; break;
				case(Keyboard.LEFT):
					offX = 0
					break;
				case(Keyboard.RIGHT):
					offX = 0
					break;
				case(Keyboard.UP):
					offY = 0
					break;
				case(Keyboard.DOWN):
					offY = 0
					break;
			}
		}
		public static function setInfo(txt: String=""): void{
			pointerText.htmlText="<font face='fonter' color='#FFFFFF' size='12'>"+txt+"</font>";
		}
		public static function setItemText(): void{
			setInfo(pointerItemText)
		}
		public static function setItem(id: uint, gfxc: Class): void{
			drawID = id
			if (pointerItem.numChildren > 0){
				pointerItem.removeChildAt(0)
			}
			if (gfxc!=null){
				var gfx: BitmapAsset = new gfxc
				gfx.alpha = 0.5
				pointerItem.addChild(gfx)
			}
			pointerItem.mouseEnabled = false
			display = false;
		}
		override public function add(): void{
			TD.STG.addEventListener(KeyboardEvent.KEY_DOWN, keyDown)
			TD.STG.addEventListener(KeyboardEvent.KEY_UP, keyUp)
			TD.STG.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown)
			TD.STG.addEventListener(MouseEvent.MOUSE_UP, mouseUp)
			TD.addLayer(TD.layerBg)
			TD.addLayer(TD.layerEditor)
			TD.addLayer(TD.layerFader)
			TD.layerFader.alpha = 1
			TD.layerEditor.alpha = 0
		}
		override public function remove(): void{
			TD.removeLayer(TD.layerFader)
			TD.layerFaderData.fillRect(new Rectangle(0, 0,600, 600), 0x00000000)
			//TD.layerFaderData.draw(TD.layerEditor)
			for (var i: uint = 0;i < 50;i++){
				for (var j: uint = 0;j < 50;j++){
					if (layer[i][j]!=null){TField(layer[i][j]).remove(true)}
				}
			}
			TD.clearLayer(TD.layerEditor)
			TD.clearLayer(layerBlocks)
			TD.clearLayer(layerHud)
			TD.clearLayer(layerOvers)
			TD.STG.removeEventListener(KeyboardEvent.KEY_DOWN, keyDown)
			TD.STG.removeEventListener(KeyboardEvent.KEY_UP, keyUp)
			TD.STG.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDown)
			TD.STG.removeEventListener(MouseEvent.MOUSE_UP, mouseUp)
			TD.STG.removeEventListener(KeyboardEvent.KEY_DOWN, this.hitEscape)
			drawID = 0
			TD.removeLayer(TD.layerBg)
			TD.removeLayer(TD.layerEditor)

		}
	}
}