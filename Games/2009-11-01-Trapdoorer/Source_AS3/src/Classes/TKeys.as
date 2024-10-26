package Classes{
	import Classes.Interactivers.TPlayer;
	import Classes.Menu.THelpWindow;
	import Classes.Menu.TAchievementsPanel;
	import Classes.Scenes.TLevelScene;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;

	import mx.core.BitmapAsset;

	public class TKeys	 extends Sprite{
		[Embed("../../assets/gfx/by_maurycy/ui/keyEsc.png")] public static var g_esc: Class;
		[Embed("../../assets/gfx/by_maurycy/ui/keyR.png")] public static var g_r: Class;
		[Embed("../../assets/gfx/by_maurycy/ui/keyF.png")] public static var g_f: Class;
		[Embed("../../assets/gfx/by_maurycy/ui/keyM.png")] public static var g_m: Class;
		[Embed("../../assets/gfx/by_maurycy/ui/keyU.png")] public static var g_u: Class;
		[Embed("../../assets/gfx/by_maurycy/ui/keyKeysA.png")] public static var g_ka: Class;
		[Embed("../../assets/gfx/by_maurycy/ui/keyKeysB.png")] public static var g_kb: Class;
		[Embed("../../assets/gfx/by_maurycy/ui/keyScroll.png")] public static var g_sc: Class;
		[Embed("../../assets/gfx/by_maurycy/ui/keyHelp.png")] public static var g_h: Class;
		private var kesc: Sprite
		private var kr: Sprite
		private var kf: Sprite
		private var km: Sprite
		private var ku: Sprite
		private var kkeys: Sprite
		private var ksc: Sprite
		private var kh: Sprite

		private var esc1: BitmapAsset
		private var esc2: BitmapAsset
		private var r1: BitmapAsset
		private var r2: BitmapAsset
		private var f1: BitmapAsset
		private var f2: BitmapAsset
		private var m1: BitmapAsset
		private var m2: BitmapAsset
		private var u1: BitmapAsset
		private var u2: BitmapAsset
		private var sc1: BitmapAsset
		private var sc2: BitmapAsset
		private var ka1: BitmapAsset
		private var ka2: BitmapAsset
		private var kb1: BitmapAsset
		private var kb2: BitmapAsset
		private var h1: BitmapAsset
		private var h2: BitmapAsset

		private var txt: TextField
		public function TKeys(){
			txt = new TextField
			txt.selectable = false
			txt.embedFonts = true
			txt.width = 1
			txt.htmlText="<font face='fonter' color='#FFFFFF' size='22'></font>";
			txt.autoSize = TextFieldAutoSize.CENTER
			var filArr: Array = txt.filters
			var filShad: DropShadowFilter = new DropShadowFilter(1, 45, 0,2, 2,2, 1)
			filArr.push(filShad);
			txt.filters = filArr
			txt.y = 42

			kesc = new Sprite
			kr = new Sprite
			ku = new Sprite
			kf = new Sprite
			km = new Sprite
			kkeys = new Sprite
			ksc = new Sprite
			kh = new Sprite

			kesc.x = 20
			kr.x = 82
			ku.x = 144
			kf.x = 206
			km.x = 268
			kkeys.x = 330
			ksc.x = 420
			kh.x = 510

			kesc.buttonMode = true
			kr.buttonMode = true
			ku.buttonMode = true
			kf.buttonMode = true
			km.buttonMode = true
			kkeys.buttonMode = true
			ksc.buttonMode = true
			kh.buttonMode = true

			esc1 = new g_esc
			esc2 = new g_esc
			r1 = new g_r
			r2 = new g_r
			u1 = new g_u
			u2 = new g_u
			f1 = new g_f
			f2 = new g_f
			m1 = new g_m
			m2 = new g_m
			sc1 = new g_sc
			sc2 = new g_sc
			ka1 = new g_ka
			ka2 = new g_ka
			kb1 = new g_kb
			kb2 = new g_kb
			h1 = new g_h
			h2 = new g_h

			esc2.blendMode="add"
			r2.blendMode="add"
			u2.blendMode="add"
			f2.blendMode="add"
			m2.blendMode="add"
			sc2.blendMode="add"
			ka2.blendMode="add"
			kb2.blendMode="add"
			h2.blendMode="add"

			esc2.alpha = 0
			r2.alpha = 0
			u2.alpha = 0
			f2.alpha = 0
			m2.alpha = 0
			sc2.alpha = 0
			ka2.alpha = 0
			kb2.alpha = 0
			h2.alpha = 0

			kb1.visible = false
			kb2.visible = false

			kesc.addEventListener(MouseEvent.MOUSE_OVER, function(): void{
				SFX.Play("over");
				esc2.alpha = 0.5
				txt.htmlText="<font face='fonter' color='#FFFFFF' size='22'>Quit Level [Shortcut: Escape]</font>";
				txt.x = 300-txt.width/2
				})
			kesc.addEventListener(MouseEvent.MOUSE_OUT, function(): void{
				esc2.alpha = 0
				txt.htmlText="<font face='fonter' color='#FFFFFF' size='22'></font>";
				})
			kr.addEventListener(MouseEvent.MOUSE_OVER, function(): void{
				SFX.Play("over");
				r2.alpha = 0.5
				txt.htmlText="<font face='fonter' color='#FFFFFF' size='22'>Restart Level [Shortcut: R]</font>";
				txt.x = 300-txt.width/2
				})
			kr.addEventListener(MouseEvent.MOUSE_OUT, function(): void{
				r2.alpha = 0
				txt.htmlText="<font face='fonter' color='#FFFFFF' size='22'></font>";
				})
			ku.addEventListener(MouseEvent.MOUSE_OVER, function(): void{
				SFX.Play("over");
				u2.alpha = 0.5
				txt.htmlText="<font face='fonter' color='#FFFFFF' size='22'>Undo Last Move [Shortcut: U, Backspace]</font>";
				txt.x = 300-txt.width/2
				})
			ku.addEventListener(MouseEvent.MOUSE_OUT, function(): void{
				u2.alpha = 0
				txt.htmlText="<font face='fonter' color='#FFFFFF' size='22'></font>";
				})
			kf.addEventListener(MouseEvent.MOUSE_OVER, function(): void{
				SFX.Play("over");
				f2.alpha = 0.5
				txt.htmlText="<font face='fonter' color='#FFFFFF' size='22'>Toggle Sound Effect [Shortcut: F]</font>";
				txt.x = 300-txt.width/2
				})
			kf.addEventListener(MouseEvent.MOUSE_OUT, function(): void{
				f2.alpha = 0
				txt.htmlText="<font face='fonter' color='#FFFFFF' size='22'></font>";
				})
			km.addEventListener(MouseEvent.MOUSE_OVER, function(): void{
				SFX.Play("over");
				m2.alpha = 0.5
				txt.htmlText="<font face='fonter' color='#FFFFFF' size='22'>Toggle Music [Shortcut: M]</font>";
				txt.x = 300-txt.width/2
				})
			km.addEventListener(MouseEvent.MOUSE_OUT, function(): void{
				m2.alpha = 0
				txt.htmlText="<font face='fonter' color='#FFFFFF' size='22'></font>";
				})
			ksc.addEventListener(MouseEvent.MOUSE_OVER, function(): void{
				SFX.Play("over");
				sc2.alpha = 0.5
				txt.htmlText="<font face='fonter' color='#FFFFFF' size='22'>Toggle Auto Scrolling [Shortcut: L]</font>";
				txt.x = 300-txt.width/2
				})
			ksc.addEventListener(MouseEvent.MOUSE_OUT, function(): void{
				sc2.alpha = 0
				txt.htmlText="<font face='fonter' color='#FFFFFF' size='22'></font>";
				})
			kkeys.addEventListener(MouseEvent.MOUSE_OVER, function(): void{
				SFX.Play("over");
				ka2.alpha = 0.5
				kb2.alpha = 0.5
				txt.htmlText="<font face='fonter' color='#FFFFFF' size='22'>Change Keyset [Shortcut: K]</font>";
				txt.x = 300-txt.width/2
				})
			kkeys.addEventListener(MouseEvent.MOUSE_OUT, function(): void{
				ka2.alpha = 0
				kb2.alpha = 0
				txt.htmlText="<font face='fonter' color='#FFFFFF' size='22'></font>";
				})
			kh.addEventListener(MouseEvent.MOUSE_OVER, function(): void{
				SFX.Play("over");
				h2.alpha = 0.5
				txt.htmlText="<font face='fonter' color='#FFFFFF' size='22'>Display Help Screen [Shortcut: H]</font>";
				txt.x = 300-txt.width/2
				})
			kh.addEventListener(MouseEvent.MOUSE_OUT, function(): void{
				h2.alpha = 0
				txt.htmlText="<font face='fonter' color='#FFFFFF' size='22'></font>";
				})

			kesc.addEventListener(MouseEvent.CLICK, function(): void{
				dispatchEvent(new Event("esc"))
				SFX.Play("click")
			})
			kr.addEventListener(MouseEvent.CLICK, function(): void{
				TLevel.Restart()
				SFX.Play("click")
			})
			ku.addEventListener(MouseEvent.CLICK, function(): void{
				UndoHandler.undo()
			})
			kf.addEventListener(MouseEvent.CLICK, function(): void{
				SFX.soundOn = 1-SFX.soundOn
				SFX.Play("click")
			})
			km.addEventListener(MouseEvent.CLICK, function(): void{
				SFX.musicOn = 1-SFX.musicOn
				SFX.Play("click")
			})
			kkeys.addEventListener(MouseEvent.CLICK, function(): void{
				TPlayer.keyMode = 1-TPlayer.keyMode
				SFX.Play("click")
			})
			ksc.addEventListener(MouseEvent.CLICK, function(): void{
				TLevelScene.scrollMode = 1-TLevelScene.scrollMode
				SFX.Play("click")
			})
			kh.addEventListener(MouseEvent.CLICK, function(): void{
				new THelpWindow()
				TAchievementsPanel.awardAchievement(2)
				SFX.Play("click")
			})

			addChild(kesc)
			addChild(kr)
			addChild(ku)
			addChild(kf)
			addChild(km)
			addChild(kkeys)
			addChild(ksc)
			addChild(kh)
			addChild(txt)
			kesc.addChild(esc1)
			kesc.addChild(esc2)
			kr.addChild(r1)
			kr.addChild(r2)
			ku.addChild(u1)
			ku.addChild(u2)
			kf.addChild(f1)
			kf.addChild(f2)
			km.addChild(m1)
			km.addChild(m2)
			ksc.addChild(sc1)
			ksc.addChild(sc2)
			kkeys.addChild(ka1)
			kkeys.addChild(ka2)
			kkeys.addChild(kb1)
			kkeys.addChild(kb2)
			kh.addChild(h1)
			kh.addChild(h2)


		}
		public function	Update(): void{
			if (TPlayer.keyMode == 1){
				ka1.visible = true
				ka2.visible = true
				kb1.visible = false
				kb2.visible = false
			} else {
				ka1.visible = false
				ka2.visible = false
				kb1.visible = true
				kb2.visible = true
			}
			if (TLevelScene.scrollMode){
				sc1.alpha = 1
			} else {
				sc1.alpha = 0.5
			}
			if (SFX.musicOn){
				m1.alpha = 1
			} else {
				m1.alpha = 0.5
			}
			if (SFX.soundOn){
				f1.alpha = 1
			} else {
				f1.alpha = 0.5
			}
		}
	}
}