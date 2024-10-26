package Classes.Scenes{
	import Classes.Menu.TAchievementsPanel;

	import Editor.MakeText2;

	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.ui.Keyboard;

	import mx.core.BitmapAsset;

	public class TIntroScene extends TScene{
		[Embed("../../../assets/gfx/by_maurycy/ui/Tile.png")] private var g0: Class;
		[Embed("../../../assets/gfx/by_maurycy/ui/TilePla.png")] private var g1: Class;
		private var l: Sprite
		private var tile1: BitmapAsset
		private var tile2: BitmapAsset
		private var tile3: BitmapAsset
		private var pla1: BitmapAsset
		private var pla2: BitmapAsset
		private var pla3: BitmapAsset
		private var text1: TextField
		private var text2: TextField
		private var text3: TextField
		private var text4: TextField
		private var text5: TextField
		private var text6: TextField
		private var text7: TextField
		private var state: uint = 0
		private var wait: uint = 0
		private var mul: uint = 1
		private var award: Boolean = true
		public function TIntroScene()	{
			l = new Sprite
			tile1 = new g0
			tile2 = new g0
			tile3 = new g0
			pla1 = new g1
			pla2 = new g1
			pla3 = new g1
			tile1.x = 213
			tile1.y = 175
			tile1.alpha = 0
			tile2.x = 176
			tile2.y = 285
			tile2.alpha = 0
			tile3.x = 139
			tile3.y = 395
			tile3.alpha = 0
			pla1.x = 257
			pla1.y = 95
			pla1.alpha = 0
			pla2.x = 227
			pla2.y = 195
			pla2.alpha = 0
			pla3.x = 184
			pla3.y = 315
			pla3.alpha = 0

			text1 = MakeText2("Deep, in the endless depths of the infinite space...", 18)
			text2 = MakeText2("A being resides, travelling for all eternity.", 18)
			text3 = MakeText2("It has no name nor goal of its journey.", 18)
			text4 = MakeText2("Because there is only one thing that matters...", 18)
			text5 = MakeText2("To move further into the space, seeking...", 18)
			text6 = MakeText2("...the Edge of the Fantasy.", 18)
			text7 = MakeText2("Hold mouse/key to speed up, Space to skip.", 18)
			text1.x = 300-text1.width/2
			text1.alpha = 0
			text2.x = 300-text2.width/2
			text2.y = 20
			text2.alpha = 0
			text3.x = 300-text3.width/2
			text3.y = 40
			text3.alpha = 0
			text4.x = 300-text4.width/2
			text4.y = 60
			text4.alpha = 0
			text5.x = 300-text5.width/2
			text5.y = 80
			text5.alpha = 0
			text6.x = 300-text6.width/2
			text6.y = 100
			text6.alpha = 0
			text7.x = 300-text7.width/2
			text7.y = 570

			l.addChild(tile1)
			l.addChild(tile2)
			l.addChild(tile3)
			l.addChild(pla1)
			l.addChild(pla2)
			l.addChild(pla3)
			l.addChild(text1)
			l.addChild(text2)
			l.addChild(text3)
			l.addChild(text4)
			l.addChild(text5)
			l.addChild(text6)
			l.addChild(text7)
		}
		override public function update(): void{
			switch(state){
				case(0):
					if (text1.alpha < 1){text1.alpha += 0.02*mul}
					break
				case(1):
					if (text2.alpha < 1){text2.alpha += 0.02*mul}
					if (tile1.alpha < 1){tile1.alpha += 0.02*mul}
					if (tile2.alpha < 1){tile2.alpha += 0.02*mul}
					if (tile3.alpha < 1){tile3.alpha += 0.02*mul}
					if (pla1.alpha < 1){pla1.alpha += 0.02*mul}
					break
				case(2):
					if (text7.alpha > 0){text7.alpha -= 0.02*mul}
					if (text3.alpha < 1){text3.alpha += 0.02*mul}
					break
				case(3):
					if (text4.alpha < 1){text4.alpha += 0.02*mul}
					if (tile1.alpha > 0){tile1.alpha -= 0.02*mul}
					if (pla1.alpha > 0){pla1.alpha -= 0.02*mul}
					if (pla2.alpha < 1){pla2.alpha += 0.02*mul}
					break
				case(4):
					if (text5.alpha < 1){text5.alpha += 0.02*mul}
					break
				case(5):
					if (text6.alpha < 1){text6.alpha += 0.02*mul}
					if (tile2.alpha > 0){tile2.alpha -= 0.02*mul}
					if (pla2.alpha > 0){pla2.alpha -= 0.02*mul}
					if (pla3.alpha < 1){pla3.alpha += 0.02*mul}
					break
				case(7):
					if (tile3.alpha > 0){tile3.alpha -= 0.02*mul}
					if (pla3.alpha > 0){pla3.alpha -= 0.02*mul}
					text1.alpha = 2
					text2.alpha = 1.8
					text3.alpha = 1.6
					text4.alpha = 1.4
					text5.alpha = 1.2
					text6.alpha = 1
					break
				case(8):
					if (tile2.alpha > 0){tile2.alpha -= 0.02*mul}
					if (pla2.alpha > 0){pla2.alpha -= 0.02*mul}
					if (tile1.alpha > 0){tile1.alpha -= 0.02*mul}
					if (pla1.alpha > 0){pla1.alpha -= 0.02*mul}
					if (tile3.alpha > 0){tile3.alpha -= 0.02*mul}
					if (pla3.alpha > 0){pla3.alpha -= 0.02*mul}
					if (text1.alpha > 0){text1.alpha -= 0.02*mul}
					if (text2.alpha > 0){text2.alpha -= 0.02*mul}
					if (text3.alpha > 0){text3.alpha -= 0.02*mul}
					if (text4.alpha > 0){text4.alpha -= 0.02*mul}
					if (text5.alpha > 0){text5.alpha -= 0.02*mul}
					if (text6.alpha > 0){text6.alpha -= 0.02*mul}
					if (text7.alpha > 0){text7.alpha -= 0.02*mul}
					break
				case(9):
					TD.setScene(TMenuScene)
					return
					break
			}
			wait += 1*mul
			if (wait >= 160){
				wait = 0
				state++
			}
		}
		private function speedUp(e:*): void{
			if ((e as KeyboardEvent)!=null){
				if (e.keyCode == Keyboard.SPACE && state < 8){
					state = 8
					wait = 100
					award = false
					return
				}
			}
			mul = 10
		}
		private function speedDown(e:*): void{
			mul = 1
		}
		override public function add(): void{
			TD.addLayer(TD.layerBg)
			TD.addLayer(l)
			TD.STG.addEventListener(KeyboardEvent.KEY_DOWN, speedUp)
			TD.STG.addEventListener(KeyboardEvent.KEY_UP, speedDown)
			TD.STG.addEventListener(MouseEvent.MOUSE_DOWN, speedUp)
			TD.STG.addEventListener(MouseEvent.MOUSE_UP, speedDown)

		}
		override public function remove(): void{
			if (award){
				TAchievementsPanel.awardAchievement(6)
			}
			TD.removeLayer(TD.layerBg)
			TD.removeLayer(l)
			TD.STG.removeEventListener(KeyboardEvent.KEY_DOWN, speedUp)
			TD.STG.removeEventListener(KeyboardEvent.KEY_UP, speedDown)
			TD.STG.removeEventListener(MouseEvent.MOUSE_DOWN, speedUp)
			TD.STG.removeEventListener(MouseEvent.MOUSE_UP, speedDown)
		}
	}
}