package Classes.Scenes{
	import Classes.Interactivers.TEndFall;
	import Classes.Interactivers.TPlayer;
	import Classes.Items.TNormal;
	import Classes.Menu.TAchievementsPanel;

	import flash.display.GradientType;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;

	import mx.core.BitmapAsset;
	public class TCreditsScene	 extends TScene{
		private var shade: Shape
		private var pla: Sprite
		private var plaY: uint
		private var g: Sprite = new Sprite
		private var line: Sprite = new Sprite
		public static var fall: Sprite = new Sprite
		private var txt: TextField

		public var isSpeedUp: Boolean = false;
		public function TCreditsScene(){
			shade = new Shape
			var m: Matrix = new Matrix
			m.createGradientBox(500, 600, 0,100, 0)
			shade.graphics.beginGradientFill(GradientType.LINEAR,[0, 0],[0, 1],[0, 5],m)
			shade.graphics.drawRect(100, 0,500, 600)

			var p: BitmapAsset = new (TPlayer.g)
			p.x = -25
			p.y = -25
			pla = new Sprite
			pla.x = 55
			pla.y = 525
			pla.addChild(p)

			txt = new TextField
			txt.x = 120
			txt.y = 700
			txt.width = 470
			txt.height = 2000
			txt.autoSize = TextFieldAutoSize.NONE
			txt.selectable = false
			txt.embedFonts = true
			txt.textColor = 0xFFFFFF
			txt.htmlText="<p align='center'><font face='fonter' size='22'>Trapdoorer, February 2009</font>\n\n" +
					"<font face='fonter' size='22'>Maurycy Zarzycki:\n Mauft.com\n\n\n\n" +
					"Roland Ariëns, Roland Berrier:\nAnother Game Studio\n\n\n\n" +
					"<font size='30'>Game Design & Idea:</font>\n" +
					"Maurycy Zarzycki\n\n" +
					"<font size='30'>Programming:</font>\n" +
					"Maurycy Zarzycki\n\n" +
					"<font size='30'>Sound Effects</font>\n" +
					"Public Domain\n" +
					"Maurycy Zarzycki\n\n" +
					"<font size='30'>Music:</font>\n" +
					"Croaker\n\n" +
					"<font size='30'>Level Design:</font>\n" +
					"Roland Ariëns\n" +
					"Roland Berrier\n" +
					"Maurycy Zarzycki\n\n" +
					"<font size='30'>Special Thanks To:</font>\n" +
					"Cage - for constructively\ncriticizing graphics\n\n\n\n" +
					"</font><font face='fonter' size='26'>THANK YOU\nFOR PLAYING\n\n\n\n\n\n\n\n\n\n\n\n</font>" +
					"<font face='fonter' size='12'>Trapdoorer; Mauft.com, Another Game Studio, February 2009</font>"

			for(var i: uint = 1;i < 26;i++){
				var k: BitmapAsset = new (TNormal.g_normal)
				k.x = 42.5
				k.y = 512.5-i*25
				line.addChild(k)
			}

			g.addChild(shade)
			g.addChild(fall)
			g.addChild(line)
			g.addChild(pla)
			g.addChild(txt)
			g.alpha = 0
			update()

			TD.STG.addEventListener(KeyboardEvent.KEY_DOWN, function(e: KeyboardEvent): void {
				isSpeedUp = true;
			})
			TD.STG.addEventListener(KeyboardEvent.KEY_UP, function(e: KeyboardEvent): void {
				isSpeedUp = false;
			})
			TD.STG.addEventListener(MouseEvent.MOUSE_DOWN, function(e: MouseEvent): void {
				isSpeedUp = true;
			})
			TD.STG.addEventListener(MouseEvent.MOUSE_UP, function(e: MouseEvent): void {
				isSpeedUp = false;
			})
		}
		override public function update(): void{
			if (txt.y > -1270){
				txt.y -= 0.5
				if (isSpeedUp) {
					txt.y -= 8;
				}
				if(g.alpha < 1){g.alpha += 0.02}
			} else {
				if(g.alpha > 0){
					g.alpha -= 0.0015
					if (isSpeedUp) {
						g.alpha -= 0.01;
					}
				} else {
					TD.setScene(TMenuScene)
				}
			}
			if (TD.layerBg.alpha < 1){TD.layerBg.alpha += 0.02}
			pla.scaleX = pla.scaleY = 0.5+Math.sin(plaY/7.96)/2
			plaY++;
			var i: uint
			for(i = 0;i < line.numChildren;i++){
				var k: BitmapAsset = line.getChildAt(i) as BitmapAsset
				k.y++
			}
			for(i = 0;i < fall.numChildren;i++){
				var c: TEndFall = fall.getChildAt(i) as TEndFall
				c.update()
			}

			if (plaY == 25){
				plaY = 0
				line.removeChildAt(0)
				new TEndFall(42.5, 512.5)
				var l: BitmapAsset = new (TNormal.g_normal)
				l.x = 42.5
				l.y = 512.5-25*25
				line.addChild(l)
			}
		}
		override public function add(): void{
			TD.addLayer(TD.layerBg)
			TD.addLayer(g)
		}
		override public function remove(): void{
			TD.removeLayer(TD.layerBg)
			TD.removeLayer(g)
			TD.clearLayer(fall)
			TD.layerFaderData.fillRect(new Rectangle(0, 0,600, 600), 0x00000000)
			TAchievementsPanel.awardAchievement(5)
		}
	}
}