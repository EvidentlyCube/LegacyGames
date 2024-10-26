package Classes.Menu{
	import Classes.Grid9;
	import Classes.MenuButton;
	import Classes.Scenes.*;

	import Editor.MakeText;

	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;

	import mx.core.BitmapAsset;
	public class TMainMenu extends TMenu{
		[Embed("../../../assets/gfx/ui/icon_play.png")] private var ico1:Class;
		[Embed("../../../assets/gfx/ui/icon_play2.png")] private var ico2:Class;
		[Embed("../../../assets/gfx/ui/icon_build.png")] private var ico3:Class;
		[Embed("../../../assets/gfx/ui/icon_help.png")] private var ico4:Class;
		private static var bg:Grid9
		private static var title:TextField
		public var animate:int = 1
		private static var butCamp:MenuButton
		public static  var butCust:MenuButton
		public static  var butYour:MenuButton
		private static var butInfo:MenuButton
		private static var pla:TAchievementsPanel
		private static var i1:Sprite = new Sprite
		public static  var i2:Sprite = new Sprite
		public static  var i3:Sprite = new Sprite
		private static var i4:Sprite = new Sprite
		private static var si1:Number = 0
		private static var si2:Number = 0
		private static var si3:Number = 0
		private static var si4:Number = 0
		private static var on1:Boolean = false
		private static var on2:Boolean = false
		private static var on3:Boolean = false
		private static var on4:Boolean = false
		private static var created:Boolean = false
		public function TMainMenu(){
			alpha = 0
			if (created){
				return
			}

			bg = new Grid9(TWindow.Grid9DataMenu)
			bg.width = 270
			bg.height = 270
			addChild(bg)

			title = MakeText("Main Menu:",19)
			title.x = width / 2-title.width / 2

			butCamp = new MenuButton("Play Campaign",18,220)
			butCamp.x = 50
			butCamp.y = 50
			butCamp.addEventListener(MouseEvent.CLICK,clickCampaign)
			butCamp.addEventListener(MouseEvent.MOUSE_OVER,function ():void{on1 = true})
			butCamp.addEventListener(MouseEvent.MOUSE_OUT,function ():void{on1 = false})

			butCust = new MenuButton("Play Custom Levels",18,220)
			butCust.x = 50
			butCust.y = 110
			butCust.addEventListener(MouseEvent.CLICK,clickCustom)
			butCust.addEventListener(MouseEvent.MOUSE_OVER,function ():void{on2 = true})
			butCust.addEventListener(MouseEvent.MOUSE_OUT,function ():void{on2 = false})

			butYour = new MenuButton("Make your own Levels",18,220)
			butYour.x = 50
			butYour.y = 170
			butYour.addEventListener(MouseEvent.CLICK,clickEditor)
			butYour.addEventListener(MouseEvent.MOUSE_OVER,function ():void{on3 = true})
			butYour.addEventListener(MouseEvent.MOUSE_OUT,function ():void{on3 = false})

			butInfo = new MenuButton("Help / Controls",18,220)
			butInfo.x = 50
			butInfo.y = 230
			butInfo.addEventListener(MouseEvent.CLICK,clickHelp)
			butInfo.addEventListener(MouseEvent.MOUSE_OVER,function ():void{on4 = true})
			butInfo.addEventListener(MouseEvent.MOUSE_OUT,function ():void{on4 = false})

			var b:BitmapAsset = new ico1
			b.x=-b.width / 2
			b.y=-b.height / 2
			b.smoothing = true
			i1.x = 11 + b.width / 2
			i1.y = 46 + b.height / 2
			i1.addChild(b)
			b = new ico2
			b.x=-b.width / 2
			b.y=-b.height / 2
			b.smoothing = true
			i2.x = 4+b.width / 2
			i2.y = 106 + b.height / 2
			i2.addChild(b)
			i2.addEventListener(MouseEvent.MOUSE_OVER,function ():void{on2 = true})
			i2.addEventListener(MouseEvent.MOUSE_OUT,function ():void{on2 = false})
			b = new ico3
			b.x=-b.width / 2
			b.y=-b.height / 2
			b.smoothing = true
			i3.x = 9+b.width / 2
			i3.y = 166 + b.height / 2
			i3.addChild(b)
			i3.addEventListener(MouseEvent.MOUSE_OVER,function ():void{on3 = true})
			i3.addEventListener(MouseEvent.MOUSE_OUT,function ():void{on3 = false})
			b = new ico4
			b.x=-b.width / 2
			b.y=-b.height / 2
			b.smoothing = true
			i4.x = 16 + b.width / 2
			i4.y = 226 + b.height / 2
			i4.addChild(b)
			i4.addEventListener(MouseEvent.MOUSE_OVER,function ():void{on4 = true})
			i4.addEventListener(MouseEvent.MOUSE_OUT,function ():void{on4 = false})


			pla = new TAchievementsPanel
			pla.x = 300
			pla.y = 0
			addChild(pla)


			addChild(title)
			addChild(butCamp)
			addChild(butCust)
			addChild(butYour)
			addChild(butInfo)
			addChild(i1)
			addChild(i2)
			addChild(i3)
			addChild(i4)


			x = 15
			y = 150
			alpha = 0

			created = true
		}
		public function reset():void{
			si1 = 0
			si2 = 0
			si3 = 0
			si4 = 0
			on1 = false
			on2 = false
			on3 = false
			on4 = false
			i1.scaleX = i1.scaleY = 1
			i2.scaleX = i2.scaleY = 1
			i3.scaleX = i3.scaleY = 1
			i4.scaleX = i4.scaleY = 1
		}
		public function clickCampaign(e:MouseEvent):void{
			Game.setScene(TCampaignScene)
		}
		public function clickCustom(e:MouseEvent):void{
			Game.setScene(TCustomScene)
		}
		public function clickEditor(e:MouseEvent):void{
			Game.setScene(TSelfmadeScene)
            // Game.setScene(TEditorScene);

		}
		public function clickHelp(e:MouseEvent):void{
			TAchievementsPanel.awardAchievement(0)
			TMenuScene.menuHelp.animate = 1
		}
		public function update():void{
			if (si1 > 0 || on1){
				si1 += 0.2
				if (si1 > Math.PI * 2){
					if(on1){
						si1 -= Math.PI * 2
					} else {
						si1 = 0
					}
				}
				i1.scaleY = i1.scaleX = 1.2 + Math.cos(si1 + Math.PI) / 5
			}
			if (si2 > 0 || on2){
				si2 += 0.2
				if (si2 > Math.PI * 2){
					if(on2){
						si2 -= Math.PI * 2
					} else {
						si2 = 0
					}
				}
				i2.scaleY = i2.scaleX = 1.2 + Math.cos(si2 + Math.PI) / 5
			}
			if (si3 > 0 || on3){
				si3 += 0.2
				if (si3 > Math.PI * 2){
					if(on3){
						si3 -= Math.PI * 2
					} else {
						si3 = 0
					}
				}
				i3.scaleY = i3.scaleX = 1.2 + Math.cos(si3 + Math.PI) / 5
			}
			if (si4 > 0 || on4){
				si4 += 0.2
				if (si4 > Math.PI * 2){
					if(on4){
						si4 -= Math.PI * 2
					} else {
						si4 = 0
					}
				}
				i4.scaleY = i4.scaleX = 1.2 + Math.cos(si4 + Math.PI) / 5
			}
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