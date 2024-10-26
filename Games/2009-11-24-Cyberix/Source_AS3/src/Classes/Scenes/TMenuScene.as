package Classes.Scenes{
	import Classes.Grid9;
	import Classes.Menu.*;
	import Classes.PagingButton;
	import Classes.SFX;

	import Editor.MakeText;

	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.text.TextField;

	import mx.core.BitmapAsset;
	public class TMenuScene extends TScene{
		[Embed("../../../assets/gfx/ui/Menu_03.png")] public static var g_bg:Class;
		[Embed("../../../assets/gfx/ui/logo1.png")] private static var g_logo1:Class;
		[Embed("../../../assets/gfx/ui/logo2.png")] private static var g_logo2:Class;
		[Embed("../../../assets/gfx/ui/Logo.png")] private static var g_logo:Class;
		public static var created:Boolean = false
		public static var backGround:BitmapAsset
		public static var logo:Sprite = new Sprite
		public static var logoA:Number = 1
		public static var logoFall:Boolean = false
		public static var menuMain:TMainMenu
		public static var menuLog:TDescMenu
		public static var menuHelp:THelpMenu
		public static var container:Sprite
		public static var bBack:Grid9
		public static var bTxt:TextField
		public static var bSfx:PagingButton
		public static var bMus:PagingButton
		public static var bLogo1:PagingButton
		public static var bLogo2:PagingButton

		public function TMenuScene(){
			if (created){
                container.alpha = 0;
                return
            }

			container = new Sprite
			container.alpha = 1
			backGround = new g_bg
			logo.addChild(new g_logo)
			logo.x = 300 - logo.width / 2
			logo.y = 20
			logo.addEventListener(MouseEvent.ROLL_OVER,logoOver)
			logo.addEventListener(MouseEvent.ROLL_OUT,logoOut)

			menuMain = new TMainMenu()
			menuLog = new TDescMenu()
			menuHelp = new THelpMenu()
			created = true
			//container.addChild(backGround)
			container.addChild(logo)
			container.addChild(menuMain)
			//container.addChild(menuLog)

			bBack = new Grid9(TWindow.Grid9DataMenu)
			bTxt = Editor.MakeText("Audio Options")
			bSfx = new PagingButton(TPauseWindow.g_sfx)
			bMus = new PagingButton(TPauseWindow.g_mus)
			bSfx.addEventListener(MouseEvent.CLICK,function():void{
				if (SFX.sfx){
					SFX.sfx = false
				} else {
					SFX.sfx = true
				}
				SimpleSave.writeFlush('option-sfx', SFX.sfx ? 1 : 0);
			})
			bMus.addEventListener(MouseEvent.CLICK,function():void{
				if (SFX.mus){
					SFX.mus = false
				} else {
					SFX.mus = true
				}

				SimpleSave.writeFlush('option-music', SFX.mus ? 1 : 0);
			})

			bBack.x = 230
			bBack.y = 430
			bBack.width = 140
			bBack.height = 110

			bTxt.x = 300 - bTxt.width / 2
			bTxt.y = 432

			bSfx.x = 250
			bMus.x = 300
			bMus.y = bSfx.y = 480

			container.addChild(bBack)
			container.addChild(bTxt)
			container.addChild(bSfx)
			container.addChild(bMus)

			bLogo1 = new PagingButton(g_logo1)
			bLogo1.x = 20
			bLogo1.y = 430
			bLogo1.addEventListener(MouseEvent.CLICK,function():void{navigateToURL(new URLRequest("http://mauft.com"), "_blank")})

			bLogo2 = new PagingButton(g_logo2)
			bLogo2.x = 415
			bLogo2.y = 430
			bLogo2.addEventListener(MouseEvent.CLICK,function():void{navigateToURL(new URLRequest("http://kowalczyk.mauft.com"), "_blank")})

			container.addChild(bLogo1)
			container.addChild(bLogo2)

			container.addChild(menuHelp)

		}
		override public function update():void{
			if (container.alpha < 1){container.alpha += 0.05}

			menuLog.update()
			menuMain.update()
			menuHelp.update()
			for (var i:int = Game.layerMenuBg.numChildren - 1;i >= 0;i--){
				var child:*=Game.layerMenuBg.getChildAt(i)
				child.Update()
			}
			if (logoFall){
				if (logoA > 0){logoA -= 0.08}
			}
			if (!logoFall){
				if (logoA < 1){logoA += 0.08}
			}
			bBack.alpha = logoA
			bTxt.alpha = logoA
			if (SFX.sfx){bSfx.alpha = logoA} else {bSfx.alpha = Math.min(0.4,logoA)}
			if (SFX.mus){bMus.alpha = logoA} else {bMus.alpha = Math.min(0.4,logoA)}
			bLogo1.alpha = logoA
			bLogo2.alpha = logoA
			//logo.alpha = logoA
			menuMain.alpha = logoA
		}
		override public function add():void{
			Game.addLayer(Game.layerMenuBg)
			Game.addLayer(container)

		}
		override public function remove():void{
			Game.removeLayer(Game.layerMenuBg)
			Game.removeLayer(container)
		}
		private function logoOver(e:MouseEvent):void{
			logoFall = true
		}
		private function logoOut(e:MouseEvent):void{
			logoFall = false
		}
	}
}