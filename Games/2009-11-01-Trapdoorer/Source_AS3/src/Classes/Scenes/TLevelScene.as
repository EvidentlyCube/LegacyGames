package Classes.Scenes
{
	import Classes.Interactivers.TEffect;
	import Classes.Interactivers.TPlayer;
	import Classes.Menu.TAchievementsPanel;
	import Classes.Menu.TSelectWindow;
	import Classes.Menu.TWindow;
	import Classes.Menu.WindowHandler;
	import Classes.TKeys;
	import Classes.TLevel;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.ui.Keyboard;
	public class TLevelScene extends TScene{

		public static var KEYS: TKeys
		public static var i: int = 0
		public static var breakUpdate: Boolean = false
		public static var g: Sprite
		public var selWin: TSelectWindow
		public var scale: Number = 1
		public static var mx: Number = 0
		public static var my: Number = 0
		public var toScale: Number = 1
		public var isScrollingAround: Boolean = false
		public var viewX: Number = 0
		public var viewY: Number = 0
		public var layerHolder: Sprite = new Sprite
		public static var scrollMode: uint = 1
		private var forceSnap: Boolean = false;
		public function TLevelScene(){
			if (!KEYS){
				KEYS = new TKeys
				KEYS.y = 20
				KEYS.addEventListener("esc", function(): void{
					selWin = new TSelectWindow("Do you want to Quit Level?", "Continue Playing", TLevel.levelType == 0?"Return to Editor": "Return to Level Selection")
					selWin.addEventListener(TWindow.CHOICE1, menuReturn)
					selWin.addEventListener(TWindow.CHOICE2, menuQuit)
					TScene.paused = true
				})
			}
			g = new Sprite
			g.graphics.beginFill(0xFFFFFF, 0.7)
			g.graphics.drawRect(0, 0,25, 25)
			g.graphics.endFill()

			TD.STG.addEventListener(KeyboardEvent.KEY_DOWN, this.hitEscape)
			TD.STG.addEventListener(MouseEvent.MOUSE_WHEEL, this.wheel)
			TD.STG.addEventListener(MouseEvent.MOUSE_DOWN, this.down)
			TD.STG.addEventListener(MouseEvent.MOUSE_UP, this.up)
			TD.refocus()
		}
		override public function update(): void{
			KEYS.Update()
			if (TScene.paused){return}
			for (var i: int = TD.layerEffects.numChildren-1;i >= 0;i--){
				var e: TEffect = TD.layerEffects.getChildAt(i) as TEffect
				if (e == null){continue}
				e.update()
			}
			if (Math.abs(toScale - scale) > 0.01) {
				scale += (toScale-scale)/2
				forceSnap = true;
			} else if (toScale != scale) {
				scale = toScale;
				forceSnap = true;
			}

			var tomx: Number = 0
			var tomy: Number = 0

			if (TPlayer.active){
				g.visible = false
			} else {
				g.visible = true
			}
			//if (toScale == 1){
				if (scrollMode){
					if (isScrollingAround && TPlayer.active && TD.self.mouseY > 70){
						viewX += 6 * (TD.self.mouseX-300)/100
						viewY += 6 * (TD.self.mouseY-300)/100
					} else {
						viewX/=2
						viewY/=2
					}
					if (TPlayer.active){
						tomx=(TPlayer.x+12.5-300/scale)*scale
						tomy=(TPlayer.y+12.5-300/scale)*scale
					} else {
						tomx=(TD.self.mouseX/600)*Math.max(1, 1350-600/scale)-50
						tomy=(TD.self.mouseY/600)*Math.max(1, 1350-600/scale)-50
					}

					mx+=(tomx-mx)*0.3
					my+=(tomy-my)*0.3

					if (forceSnap) {
						mx = tomx;
						my = tomy;
					}

					if (Math.abs(mx-tomx)<2){mx = tomx}
					if (Math.abs(my-tomy)<2){my = tomy}

					TD.layerEffects.x = TD.layerAbove.x = TD.layerBlocks.x = -mx-viewX
					TD.layerEffects.y = TD.layerAbove.y = TD.layerBlocks.y = -my-viewY

					TD.layerAbove.addChild(g)
					g.x = Math.floor((-TD.layerAbove.x/scale+TD.self.mouseX/scale)/25)*25
					g.y = Math.floor((-TD.layerAbove.y/scale+TD.self.mouseY/scale)/25)*25
				} else {
					if (isScrollingAround && TPlayer.active && TD.self.mouseY > 70){
						viewX += 6 * ((TD.self.mouseX-300)/100)
						viewY += 6 * ((TD.self.mouseY-300)/100)
					}
					if (TPlayer.active){
						tomx = mx
						tomy = my
					} else {
						tomx=(TD.self.mouseX/600)*Math.max(1, 1350-600/scale)-50
						tomy=(TD.self.mouseY/600)*Math.max(1, 1350-600/scale)-50
					}

					mx+=(tomx-mx)*0.3
					my+=(tomy-my)*0.3
					if (Math.abs(mx-tomx)<2){mx = tomx}
					if (Math.abs(my-tomy)<2){my = tomy}

					TD.layerEffects.x = TD.layerAbove.x = TD.layerBlocks.x = -mx-viewX
					TD.layerEffects.y = TD.layerAbove.y = TD.layerBlocks.y = -my-viewY

					TD.layerAbove.addChild(g)
					g.x = Math.floor((-TD.layerAbove.x/scale+TD.self.mouseX/scale)/25)*25
					g.y = Math.floor((-TD.layerAbove.y/scale+TD.self.mouseY/scale)/25)*25
				}
			//}
			if ((viewX-TPlayer.x)*(viewX-TPlayer.x)+(viewY-TPlayer.y)*(viewY-TPlayer.y)>9999999){
				TAchievementsPanel.awardAchievement(7)
			}
			TD.layerEffects.scaleX = TD.layerAbove.scaleX = TD.layerBlocks.scaleX = scale
			TD.layerEffects.scaleY = TD.layerAbove.scaleY = TD.layerBlocks.scaleY = scale
			if (layerHolder.alpha < 1){layerHolder.alpha += 0.05}
			if (TD.layerFader.alpha > 0){TD.layerFader.alpha -= 0.05}
			forceSnap = false;
		}
		public function wheel(e: MouseEvent): void{
			if (e.delta > 0){
				toScale += 0.1
			} else if (e.delta < 0){
				toScale -= 0.1
			}
			if (toScale > 2){toScale = 2}
			if (toScale < 0.4){toScale = 0.4}
			forceSnap = true;
		}
		public function down(e: MouseEvent): void{
			if (!TPlayer.active){
				TPlayer.drop(g.x/25, g.y/25)
			} else if (!TScene.paused){
				isScrollingAround = true
				g.visible = false
			}
		}
		public function up(e: MouseEvent): void{
			isScrollingAround = false
		}
		public function hitEscape(e: KeyboardEvent): void{
			if (WindowHandler.winCount){return;}
			if (e.keyCode == 82){
				TLevel.Restart()
			}
			if (e.keyCode == Keyboard.P || e.keyCode == Keyboard.ESCAPE){
				//TLevel.endLevel(false)
				//Game.STG.removeEventListener(KeyboardEvent.KEY_DOWN, this.hitEscape)
				selWin = new TSelectWindow("Do you want to Quit Level?", "Continue Playing", TLevel.levelType == 0?"Return to Editor": "Return to Level Selection")
				selWin.addEventListener(TWindow.CHOICE1, menuReturn)
				selWin.addEventListener(TWindow.CHOICE2, menuQuit)
				TScene.paused = true
			}
		}
		public function menuReturn(e: Event): void{
			selWin.removeEventListener(TWindow.CHOICE1, menuReturn)
			selWin.removeEventListener(TWindow.CHOICE2, menuQuit)
			selWin = null
			TScene.paused = false
		}
		public function menuQuit(e: Event): void{
			selWin.removeEventListener(TWindow.CHOICE1, menuReturn)
			selWin.removeEventListener(TWindow.CHOICE2, menuQuit)
			selWin = null
			TScene.paused = false
			TLevel.endLevel(false)
		}
		override public function add(): void{
			//TPlayer.canMove = true
			TD.addLayer(TD.layerBg)
			layerHolder.addChild(TD.layerBlocks)
			layerHolder.addChild(TD.layerEffects)
			layerHolder.addChild(TD.layerAbove)
			layerHolder.addChild(TD.layerPanel)
			TD.addLayer(layerHolder)
			TD.addLayer(TD.layerFader)
			TD.layerFader.alpha = 1
			layerHolder.alpha = 0
			TD.addLayer(KEYS)

		}
		override public function remove(): void{
			TD.removeLayer(KEYS)

			TD.removeLayer(TD.layerFader)
			TD.layerFaderData.fillRect(new Rectangle(0, 0,600, 600), 0x00000000)
			//TD.layerFaderData.draw(layerHolder)
			TLevel.Clear()
			TD.STG.removeEventListener(KeyboardEvent.KEY_DOWN, this.hitEscape)
			TD.STG.removeEventListener(MouseEvent.MOUSE_WHEEL, this.wheel)
			TD.STG.removeEventListener(MouseEvent.MOUSE_DOWN, this.down)
			TD.STG.removeEventListener(MouseEvent.MOUSE_UP, this.up)
			TD.removeLayer(TD.layerBg)
			layerHolder.removeChild(TD.layerBlocks)
			layerHolder.removeChild(TD.layerEffects)
			layerHolder.removeChild(TD.layerAbove)
			layerHolder.removeChild(TD.layerPanel)
		}
	}
}