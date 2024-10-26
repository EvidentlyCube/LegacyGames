package Classes.Menu{
	import Classes.Grid9;
	import Classes.MenuButton;
	import Classes.PagingButton;
	import Classes.SFX;
	import Classes.Scenes.TScene;
	import Classes.TLevel;

	import Editor.MakeText;

	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;

	public class TPauseWindow extends TWindow{
		[Embed("../../../assets/gfx/ui/b_sound.png")] public static var g_sfx:Class;
		[Embed("../../../assets/gfx/ui/b_music.png")] public static var g_mus:Class;
		[Embed("../../../assets/gfx/ui/b_help.png")] public static var g_hlp:Class;
		private var tit:TextField
		private var bg:Grid9
		private var bCont:MenuButton
		private var bRest:MenuButton
		private var bQuit:MenuButton
		private var bMus:PagingButton
		private var bSfx:PagingButton
		private var bHlp:PagingButton
		private var hlp:THelpMenu
		public function TPauseWindow(){
			tit = MakeText("Game Paused!")
			bg = new Grid9(TWindow.Grid9DataMenu)
			bCont = new MenuButton("Unpause")
			bRest = new MenuButton("Restart Level")
			bQuit = new MenuButton("Exit Level")
			bMus = new PagingButton(g_mus)
			bSfx = new PagingButton(g_sfx)
			bHlp = new PagingButton(g_hlp)
			hlp = new THelpMenu()

			bg.width = 240
			bg.height = 260

			tit.x = 120 - tit.width / 2
			bCont.x = 120 - bCont.width / 2+3
			bRest.x = 120 - bRest.width / 2+3
			bQuit.x = 120 - bQuit.width / 2+3
			bMus.x = 120 - bMus.width / 2
			bSfx.x = 60 - bSfx.width / 2
			bHlp.x = 180 - bHlp.width / 2

			tit.y = 3
			bCont.y = 60
			bRest.y = 100
			bQuit.y = 140
			bMus.y = bSfx.y = bHlp.y = 190

			addChild(bg)
			addChild(tit)
			addChild(bCont)
			addChild(bRest)
			addChild(bQuit)
			addChild(bMus)
			addChild(bSfx)
			addChild(bHlp)

			x = 300 - width / 2
			y = 300 - height / 2

			hlp.x -= x
			hlp.y -= y
			addChild(hlp)

			TScene.paused = true

			if (!SFX.sfx){bSfx.alpha = 0.4}
			if (!SFX.mus){bMus.alpha = 0.4}

			bCont.addEventListener(MouseEvent.CLICK,cCont,false,0,true)
			bRest.addEventListener(MouseEvent.CLICK,cRest,false,0,true)
			bQuit.addEventListener(MouseEvent.CLICK,cQuit,false,0,true)
			bSfx.addEventListener(MouseEvent.CLICK,cSfx,false,0,true)
			bMus.addEventListener(MouseEvent.CLICK,cMus,false,0,true)
			bHlp.addEventListener(MouseEvent.CLICK,cHlp,false,0,true)

			Game.STG.addEventListener(Event.ENTER_FRAME,hlp.update)

			WindowHandler.newWindow(this)
		}
		private function cCont(e:MouseEvent):void{
			Game.STG.removeEventListener(Event.ENTER_FRAME,hlp.update)
			WindowHandler.popWindow()
			TScene.paused = false
		}
		private function cRest(e:MouseEvent):void{
			Game.STG.removeEventListener(Event.ENTER_FRAME,hlp.update)
			WindowHandler.popWindow()
			TScene.paused = false
			TLevel.Restart()
		}
		private function cQuit(e:MouseEvent):void{
			Game.STG.removeEventListener(Event.ENTER_FRAME,hlp.update)
			WindowHandler.popWindow()
			TScene.paused = false
			TLevel.endLevel(false)
		}
		private function cSfx(e:MouseEvent):void{
			if (SFX.sfx){
				SFX.sfx = false
				bSfx.alpha = 0.4
			} else {
				SFX.sfx = true
				bSfx.alpha = 1
			}

			SimpleSave.writeFlush('option-sfx', SFX.sfx ? 1 : 0);
		}
		private function cMus(e:MouseEvent):void{
			if (SFX.mus){
				SFX.mus = false
				bMus.alpha = 0.4
			} else {
				SFX.mus = true
				bMus.alpha = 1
			}

			SimpleSave.writeFlush('option-music', SFX.mus ? 1 : 0);
		}
		private function cHlp(e:MouseEvent):void{
			hlp.animate = 1
			hlp.visible = true
			TAchievementsPanel.awardAchievement(0)
		}
	}
}