package Classes.Scenes{
	import Classes.Menu.WindowHandler;

	import Editor.GiveClass;

	import flash.display.GradientType;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.ui.Keyboard;

	import mx.core.BitmapAsset;
	public class TCreditsScene	 extends TScene{
		private var shade:Shape
		private var pla:Sprite
		private var plaY:uint
		private var g:Sprite = new Sprite
		private var lineItemsContainer:Sprite = new Sprite
		public static var fall:Sprite = new Sprite
		private var txt:TextField
		private var _isSpeedingUp: Boolean = false;
		public function TCreditsScene(){
			shade = new Shape
			var m:Matrix = new Matrix
			m.createGradientBox(500,600,0,100,0)
			shade.graphics.beginGradientFill(GradientType.LINEAR,[0,0],[0,1],[0,5],m)
			shade.graphics.drawRect(100,0,500,600)

			txt = new TextField
			txt.x = 120
			txt.y = 700
			txt.width = 470
			txt.height = 2000
			txt.autoSize = TextFieldAutoSize.NONE
			txt.selectable = false
			txt.embedFonts = true
			txt.textColor = 0xFFFFFF
			txt.htmlText = "<p align='center'><font face='fonter' size='22'>Cyberix, September 2009</font>\n\n" +
					"<font face='fonter' size='22'>Maurycy Zarzycki:\n Mauft.com\n\n\n\n" +
					"Aleksander Kowalczyk:\nkowalczyk.mauft.com\n\n\n\n" +
					"Original game idea:\n" +
					"Pacomix 2 by Crazy Boys\n\n" +
					"<font size='30'>Game Design</font>\n" +
					"Maurycy Zarzycki\n\n" +
					"<font size='30'>All Graphics</font>\n" +
					"Aleksander Kowalczyk\n\n" +
					"<font size='30'>Programming</font>\n" +
					"Maurycy Zarzycki\n\n" +
					"<font size='30'>Sound Effects</font>\n" +
					"Public Domain\n" +
					"Maurycy Zarzycki\n\n" +
					"<font size='30'>Music</font>\n" +
					"GliTch 1996\n" +
					"chromag 1996\n" +
					"Bionic 1997\n\n" +
					"<font size='30'>Level Design</font>\n" +
					"Crazy Boys\n" +
					"Maurycy Zarzycki\n\n" +
					"<font size='30'>Special Thanks To:</font>\n" +
					"Crazy Boys - For creating one of the\n" +
					"greatest action-puzzler hybrid,\n" +
					"Pacomix 2, for Amiga!\n" +
					"I wish I could have contacted you!\n\n\n\n" +
					"</font><font face='fonter' size='26'>THANK YOU\nFOR PLAYING\n\n\n\n\n\n\n\n\n\n\n\n</font>" +
					"<font face='fonter' size='12'>Pacomix; Mauft.com, A. Kowalczyk, September 2009</font>"

			for(var i:uint = 0; i < 27; i++){
				var item:BitmapAsset = new (Editor.GiveClass(999));
				item.x = 0
				item.y = 600 - i * 24
				lineItemsContainer.addChild(item)

				item = new (Editor.GiveClass(999));
				item.x = 25
				item.y = 600 - i * 24
				lineItemsContainer.addChild(item)

				item = new (Editor.GiveClass(999));
				item.x = 50
				item.y = 600 - i * 24
				lineItemsContainer.addChild(item)

				item = new (Editor.GiveClass(999));
				item.x = 75
				item.y = 600 - i * 24
				lineItemsContainer.addChild(item)
			}
			for (i = 0; i < 100; i++) {
				updateLines();
			}
			lineItemsContainer.x = 2
			g.addChild(shade)
			g.addChild(fall)
			g.addChild(lineItemsContainer)
			g.addChild(txt)
			g.alpha = 0
			update()
			Game.STG.addEventListener(KeyboardEvent.KEY_DOWN,onKeyDown)
			Game.STG.addEventListener(KeyboardEvent.KEY_UP,onKeyUp)
			Game.STG.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDown)
			Game.STG.addEventListener(MouseEvent.MOUSE_UP,onMouseUp)
		}
		override public function update():void{
			if (WindowHandler.windowsCount){return}
			var i:int
			for (i = Game.layerMenuBg.numChildren - 1;i >= 0;i--){
				var child:* = Game.layerMenuBg.getChildAt(i)
				child.Update()
			}
			if (txt.y>-1450){
				if (_isSpeedingUp) {
					txt.y -= 8;
				}
				txt.y -= 0.5
				if(g.alpha < 1){g.alpha += 0.02}
			} else {
				if(g.alpha > 0){
					g.alpha -= 0.0015
				} else {
					Game.STG.removeEventListener(KeyboardEvent.KEY_DOWN,onKeyDown)
					Game.STG.removeEventListener(KeyboardEvent.KEY_UP,onKeyUp)
					Game.STG.removeEventListener(MouseEvent.MOUSE_DOWN,onMouseDown)
					Game.STG.removeEventListener(MouseEvent.MOUSE_UP,onMouseUp)
					Game.setScene(TMenuScene)
				}
			}
			if (Game.layerBg.alpha < 1){Game.layerBg.alpha += 0.02}

			updateLines();
		}

		private function updateLines(): void {
			for(var i:Number = 0;i < lineItemsContainer.numChildren;i++){
				var item:BitmapAsset = lineItemsContainer.getChildAt(i) as BitmapAsset
				item.y += item.x / 25 + 1
			}

			for(i = lineItemsContainer.numChildren - 1;i >= 0;i--){
				item = lineItemsContainer.getChildAt(i) as BitmapAsset

				if (item.y > 600){
					lineItemsContainer.removeChild(item)
					var d:BitmapAsset = new (Editor.GiveClass(999));
					d.x = item.x
					d.y=item.y - 600 - 24;
					lineItemsContainer.addChild(d)
				}
			}
		}
		private function onKeyDown(e:KeyboardEvent):void{
			if (e.keyCode === Keyboard.SPACE) {
				_isSpeedingUp = true;
			}
			if (e.keyCode == Keyboard.ESCAPE || e.keyCode === Keyboard.P){
				txt.y=-1200
			}
		}
		private function onKeyUp(e:KeyboardEvent):void{
			if (e.keyCode === Keyboard.SPACE) {
				_isSpeedingUp = false;
			}
		}

		private function onMouseDown(e:MouseEvent): void {
			_isSpeedingUp = true;
		}
		private function onMouseUp(e:MouseEvent): void {
			_isSpeedingUp = false;
		}
		override public function add():void{
			Game.addLayer(Game.layerMenuBg)
			//Game.addLayer(Game.layerBg)
			Game.addLayer(g)
		}
		override public function remove():void{
			Game.removeLayer(Game.layerMenuBg)
			//Game.removeLayer(Game.layerBg)
			Game.removeLayer(g)
			Game.clearLayer(fall)
			//Game.layerFaderData.fillRect(new Rectangle(0,0,600,600),0x00000000)
		}
	}
}