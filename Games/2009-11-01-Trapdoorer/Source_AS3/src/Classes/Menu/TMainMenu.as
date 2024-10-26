package Classes.Menu{
	import Classes.SFX;
	import Classes.Scenes.TEndingScene;
	import Classes.Scenes.TCreditsScene;
	import Classes.Scenes.*;
	import Classes.TFanaticBadge;
	import Classes.MenuButton;

	import LoadingDir.Loading;

	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.text.TextField;
	import flash.filters.ColorMatrixFilter;

	public class TMainMenu extends TMenu{
		[Embed("../../../assets/gfx/by_maurycy/ui/Pocket1.png")] private var g1: Class;
		[Embed("../../../assets/gfx/by_maurycy/ui/Pocket2.png")] private var g2: Class;
		[Embed("../../../assets/gfx/by_maurycy/ui/Pocket3.png")] private var g3: Class;
		[Embed("../../../assets/gfx/by_maurycy/ui/LogoMus.png")] private var g4: Class;
		[Embed("../../../assets/gfx/by_maurycy/ui/LogoSfx.png")] private var g5: Class;
		[Embed("../../../assets/gfx/by_maurycy/ui/LogoM.png")] private var g6: Class;

		public var title: TextField
		public var animate: int = 1
		private var butCamp: Sprite
		private var butCamp2: Sprite
		private var butCust: Sprite
		private var butCust2: Sprite
		public static var buttonLevelEditor: Sprite
		public static var buttonCustomLevels: Sprite
		private var butMus: Sprite
		private var butMus2: Sprite
		private var butSfx: Sprite
		private var butSfx2: Sprite
		private var butM: Sprite
		private var butM2: Sprite
		private var butCredits: MenuButton
		private var butEnding: MenuButton
		private var butS: TAchievementsPanel

		public static var fan: TFanaticBadge
		public function TMainMenu(){
			fan = new TFanaticBadge

			butCamp = new Sprite
			butCamp.addChild(new g3)
			butCamp.x = 37;
			butCamp.y = 145
			butCamp2 = new Sprite
			butCamp2.y = butCamp.y
			butCamp2.addChild(new g3)
			butCamp2.addEventListener(MouseEvent.CLICK, clickCampaign)
			butCamp2.addEventListener(MouseEvent.MOUSE_OVER, function(): void{SFX.Play("over");butCamp2.alpha = 0.3})
			butCamp2.addEventListener(MouseEvent.MOUSE_OUT, function(): void{butCamp2.alpha = 0})
			butCamp2.buttonMode = true
			butCamp2.alpha = 0
			butCamp2.blendMode="add"

			butCust = new Sprite
			butCust.addChild(new g2)
			butCust.x = 225
			butCust.y = 145
			butCust2 = new Sprite
			butCust2.addChild(new g2)
			butCust2.y = butCust.y
			butCust2.blendMode="add"
			butCust2.addEventListener(MouseEvent.MOUSE_OVER, function(): void{SFX.Play("over");butCust2.alpha = 0.3})
			butCust2.addEventListener(MouseEvent.MOUSE_OUT, function(): void{butCust2.alpha = 0})
			butCust2.addEventListener(MouseEvent.CLICK, clickCustom)
			butCust2.buttonMode = true
			butCust2.alpha = 0

			buttonLevelEditor = new Sprite
			buttonLevelEditor.addChild(new g1)
			buttonLevelEditor.x = 412.5
			buttonLevelEditor.y = 145
			buttonCustomLevels = new Sprite
			buttonCustomLevels.addChild(new g1)
			buttonCustomLevels.y = buttonLevelEditor.y
			buttonCustomLevels.blendMode="add"
			buttonCustomLevels.addEventListener(MouseEvent.MOUSE_OVER, function(): void{SFX.Play("over");buttonCustomLevels.alpha = 0.3})
			buttonCustomLevels.addEventListener(MouseEvent.MOUSE_OUT, function(): void{buttonCustomLevels.alpha = 0})
			buttonCustomLevels.addEventListener(MouseEvent.CLICK, clickEditor)
			buttonCustomLevels.buttonMode = true
			buttonCustomLevels.alpha = 0

			butCredits = new MenuButton("Credits", 22, 150);
			butCredits.addEventListener(MouseEvent.CLICK, function(): void {
				TD.setScene(TCreditsScene)
			});
			butEnding = new MenuButton("Ending", 22, 150);
			butEnding.addEventListener(MouseEvent.CLICK, function(): void {
				TD.setScene(TEndingScene)
			});
			butMus = new Sprite
			butMus.addChild(new g4)
			butMus.x = 120
			butMus.y = 250
			butMus2 = new Sprite
			butMus2.addChild(new g4)
			butMus2.y = butMus.y
			butMus2.blendMode="add"
			butMus2.addEventListener(MouseEvent.MOUSE_OVER, function(): void{SFX.Play("over");butMus2.alpha = 0.3})
			butMus2.addEventListener(MouseEvent.MOUSE_OUT, function(): void{butMus2.alpha = 0})
			butMus2.addEventListener(MouseEvent.CLICK, function(): void{SFX.Play("click");SFX.toggleMusic()})
			butMus2.buttonMode = true
			butMus2.alpha = 0

			butSfx = new Sprite
			butSfx.addChild(new g5)
			butSfx.x = 360
			butSfx.y = 250
			butSfx2 = new Sprite
			butSfx2.addChild(new g5)
			butSfx2.y = butSfx.y
			butSfx2.blendMode="add"
			butSfx2.addEventListener(MouseEvent.MOUSE_OVER, function(): void{SFX.Play("over");butSfx2.alpha = 0.3})
			butSfx2.addEventListener(MouseEvent.MOUSE_OUT, function(): void{butSfx2.alpha = 0})
			butSfx2.addEventListener(MouseEvent.CLICK, function(): void{SFX.Play("click");SFX.toggleSound()})
			butSfx2.buttonMode = true
			butSfx2.alpha = 0

			butM = new Sprite
			butM.addChild(new g6)
			butM.x = 10
			butM.y = 430
			butM2 = new Sprite
			butM2.addChild(new g6)
			butM2.y = butM.y
			butM2.blendMode="add"
			butM2.addEventListener(MouseEvent.MOUSE_OVER, function(): void{SFX.Play("over");butM2.alpha = 0.3})
			butM2.addEventListener(MouseEvent.MOUSE_OUT, function(): void{butM2.alpha = 0})
			butM2.addEventListener(MouseEvent.CLICK, function(): void{
				SFX.Play("click");
				navigateToURL(new URLRequest("http://mauft.com"), "_blank")
				})
			butM2.buttonMode = true
			butM2.alpha = 0

			butS = TAchievementsPanel.self
			butS.x = 150
			butS.y = 350

			addChild(butCamp)
			addChild(butCamp2)
			addChild(butCust)
			addChild(butCust2)
			addChild(buttonLevelEditor)
			addChild(buttonCustomLevels)
			addChild(butCredits)
			addChild(butEnding)
			addChild(butMus)
			addChild(butMus2)
			addChild(butSfx)
			addChild(butSfx2)
			addChild(butM)
			addChild(butM2)
			addChild(butS)
			addChild(fan)

			alpha = 0
		}
		public function clickCampaign(e: MouseEvent): void{
			SFX.Play("click")
			TD.setScene(TCampaignScene)
		}
		public function clickCustom(e: MouseEvent): void{
			SFX.Play("click")
			TD.setScene(TCustomScene)
		}
		public function clickEditor(e: MouseEvent): void{
			SFX.Play("click")
			TD.setScene(TSelfmadeScene)
		}
		public function update(): void{
			butEnding.visible = SimpleSave.read('has-completed-game', 0) === 1;
			butCamp2.x = butCamp.x = 37.5
			butCust2.x = butCust.x = 225
			buttonCustomLevels.x = buttonLevelEditor.x = 412.5
			butMus2.x = butMus.x = 120
			butSfx2.x = butSfx.x = 360
			butM2.x = butM.x = 17

			butCredits.y = butSfx.y + butSfx.height + 15;
			butEnding.y = butCredits.y;
			butCredits.x = 15 + butMus.x + butMus.width / 2 - butCredits.width / 2 | 0;
			butEnding.x = 15 + butSfx.x + butSfx.width / 2 - butEnding.width / 2 | 0;

			if (SFX.musicOn){butMus.alpha = 1} else {butMus.alpha = 0.5}
			if (SFX.soundOn){butSfx.alpha = 1} else {butSfx.alpha = 0.5}
			if (animate > 0){
				if (alpha < 1){
					alpha += 0.05
					visible = true
				}
			} else if (animate < 0){
				if (alpha > 0){
					alpha -= 0.05
				} else {visible = false}
			}
		}
	}
}
