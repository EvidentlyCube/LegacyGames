package Classes.Scenes{
	import Classes.Menu.WindowHandler;
	import Classes.SFX;

	import Editor.MakeText2;

	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;

	public class TEndingScene extends TScene{
		private var t0: TextField
		private var t1: TextField
		private var t2: TextField
		private var t3: TextField
		private var t4: TextField
		private var t5: TextField
		private var t6: TextField
		private var t7: TextField
		private var ta: TextField
		private var tb: TextField
		private var tc: TextField
		private var td: TextField
		private var te: TextField
		private var tf: TextField
		private var tg: TextField
		private var g: Sprite
		private var waiter: uint = 80
		private var scene: uint = 0
		public static var mustate: uint
		private var isSpeedUp: Boolean = false;
		public function TEndingScene(){
			mustate = SFX.musicOn
			g = new Sprite
			t0 = MakeText2("When an endless journey comes to an end...")
			t1 = MakeText2("When unexistant goal is reached...")
			t2 = MakeText2("...That moment marks the beginning...")
			t3 = MakeText2("The beginning of an endless journey...")
			t4 = MakeText2("Which sets unexistant goal...")
			t5 = MakeText2("The time sweeps...")
			t6 = MakeText2("The history sweeps...")
			t7 = MakeText2("..And everything starts again... one more time...")
			ta = MakeText2("For what had no beginning...")
			tb = MakeText2("...Shall have no end...")
			tc = MakeText2("...Forever frozen in an endless journey.")
			td = MakeText2("The boundless fantasy remains.")
			te = MakeText2("And the guide remains.")
			tf = MakeText2("Do you have enough courage...")
			tg = MakeText2("...to voyage further into it?")
			t0.x = 300-t0.width/2
			t1.x = 300-t1.width/2
			t2.x = 300-t2.width/2
			t3.x = 300-t3.width/2
			t4.x = 300-t4.width/2
			t5.x = 300-t5.width/2
			t6.x = 300-t6.width/2
			t7.x = 300-t7.width/2
			ta.x = 300-ta.width/2
			tb.x = 300-tb.width/2
			tc.x = 300-tc.width/2
			td.x = 300-td.width/2
			te.x = 300-te.width/2
			tf.x = 300-tf.width/2
			tg.x = 300-tg.width/2
			t0.y = 40
			t1.y = 110
			t2.y = 180
			t3.y = 250
			t4.y = 320
			t5.y = 390
			t6.y = 460
			t7.y = 530
			ta.y = 285
			tb.y = 285
			tc.y = 285
			td.y = 285
			te.y = 285
			tf.y = 285
			tg.y = 285
			t0.alpha = 0
			t1.alpha = 0
			t2.alpha = 0
			t3.alpha = 0
			t4.alpha = 0
			t5.alpha = 0
			t6.alpha = 0
			t7.alpha = 0
			ta.alpha = 0
			tb.alpha = 0
			tc.alpha = 0
			td.alpha = 0
			te.alpha = 0
			tf.alpha = 0
			tg.alpha = 0
			g.addChild(t0)
			g.addChild(t1)
			g.addChild(t2)
			g.addChild(t3)
			g.addChild(t4)
			g.addChild(t5)
			g.addChild(t6)
			g.addChild(t7)
			g.addChild(ta)
			g.addChild(tb)
			g.addChild(tc)
			g.addChild(td)
			g.addChild(te)
			g.addChild(tf)
			g.addChild(tg)


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
			if (TD.layerFader.alpha > 0){
				TD.layerFader.alpha -= 0.04
			} else if (TD.layerBg.alpha > 0){
				TD.layerBg.alpha -= 0.03
			} else {
				if (WindowHandler.winCount > 0){return}
				waiter++
				if (isSpeedUp) {
					waiter += 7;
				}
				if (waiter >= 160){
					waiter = 0
					scene++
					switch(scene){
						case(1):
							SFX.Play("complete")
							t0.alpha = 2
							break
						case(2):
						SFX.Play("complete")
							t1.alpha = 2
							break
						case(3):
						SFX.Play("complete")
							t2.alpha = 2
							break
						case(4):
						SFX.Play("complete")
							t3.alpha = 2
							break
						case(5):
						SFX.Play("complete")
							t4.alpha = 2
							break
						case(6):
						SFX.Play("complete")
							t5.alpha = 2
							break
						case(7):
						SFX.Play("complete")
							t6.alpha = 2
							break
						case(8):
						SFX.Play("complete")
							t7.alpha = 2
							break
						case(10):
						waiter = 80
							ta.alpha = 2
							break
						case(11):
						waiter = 80
							tb.alpha = 2
							break
						case(12):
						waiter = 80
							tc.alpha = 2
							break
						case(13):
						waiter = 80
							td.alpha = 2
							break
						case(14):
						waiter = 80
							te.alpha = 2
							break
						case(15):
						waiter = 80
							tf.alpha = 2
							break
						case(16):
							tg.alpha = 2
							break
						case(18):
							TD.setScene(TCreditsScene)
							return
					}
				}
			}
			var dealphaSpeed:Number = 0.002;
			if (isSpeedUp) {
				dealphaSpeed *= 8;
			}
			t0.alpha -= dealphaSpeed
			t1.alpha -= dealphaSpeed
			t2.alpha -= dealphaSpeed
			t3.alpha -= dealphaSpeed
			t4.alpha -= dealphaSpeed
			t5.alpha -= dealphaSpeed
			t6.alpha -= dealphaSpeed
			t7.alpha -= dealphaSpeed
			ta.alpha -= dealphaSpeed * 10
			tb.alpha -= dealphaSpeed * 10
			tc.alpha -= dealphaSpeed * 10
			td.alpha -= dealphaSpeed * 10
			te.alpha -= dealphaSpeed * 10
			tf.alpha -= dealphaSpeed * 10
			tg.alpha -= dealphaSpeed * 4;

			SFX.musicOn = 0
		}
		override public function add(): void{
			TD.addLayer(TD.layerBg)
			TD.addLayer(TD.layerFader)
			TD.addLayer(g)
			TD.layerFader.alpha = 1
		}
		override public function remove(): void{
			SFX.Play("END")
			SFX.musicOn = mustate
			TD.removeLayer(TD.layerBg)
			TD.removeLayer(TD.layerFader)
			TD.removeLayer(g)
		}
	}
}