package Editor{
	import Classes.Data.*;
	import Classes.Menu.TAlertWindow;
	import Classes.Menu.TEnterWindow;
	import Classes.Menu.TAchievementsPanel;
	import Classes.Menu.TSelectWindow;
	import Classes.Menu.TWindow;
	import Classes.Menu.TNote;
	import Classes.Menu.WindowHandler;
	import Classes.MenuButton;
	import Classes.SFX;
	import Classes.Scenes.TEditorScene;
	import Classes.Scenes.TSelfmadeScene;
	import Classes.TLevData;
	import Classes.TLevel;

	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	public class TopPanelMonster{
		private static var author: MenuButton
		private static var authorButton: MenuButton
		public static var authorText: TextField
		private static var nameButton: MenuButton
		public static var nameText: TextField
		private static var save: MenuButton
		private static var code: MenuButton
		private static var reload: MenuButton
		private static var load: MenuButton
		private static var test: MenuButton
		private static var exitButton: MenuButton
		private static var rant: TextField
		public static var editing: Boolean = false
		public static var created: Boolean = false
		private static var win: TEnterWindow
		public static var levFinished: Boolean = false
		public var wantToExitWindow: TSelectWindow
		public function TopPanelMonster(){
			if (!created){
				save = new MenuButton("Save Level", 22, 170 )
				save.x = 32.5+10
				save.y = 487
				save.addEventListener(MouseEvent.CLICK, clickSave)

				reload = new MenuButton("Reload Level", 22, 170)
				reload.x = 215+10
				reload.y = 487
				reload.addEventListener(MouseEvent.CLICK, clickReload)

				test = new MenuButton("Test Level", 22, 170)
				test.x = 397.5+10
				test.y = 487
				test.addEventListener(MouseEvent.CLICK, clickTest)

				code = new MenuButton("Get Code", 22, 170)
				code.x = 32.5+10
				code.y = 529
				code.addEventListener(MouseEvent.CLICK, clickCode)
				code.visible = false

				load = new MenuButton("Load from Code", 22, 170)
				load.x = 215+10
				load.y = 529
				load.addEventListener(MouseEvent.CLICK, clickLoad)
				load.visible = false

				exitButton = new MenuButton("Return to Menu", 22, 170)
				exitButton.x = 397.5+10
				exitButton.y = 529
				exitButton.addEventListener(MouseEvent.CLICK, onClickExit)

				authorText = MakeText2("You", 16)
				authorText.x = 160
				authorText.y = 32
				authorButton = new MenuButton("Level Author", 18, 120)
				authorButton.x = 40
				authorButton.y = 30
				authorButton.addEventListener(MouseEvent.CLICK, clickAuthor)

				nameText = MakeText2("Unnamed", 16)
				nameText.x = 160
				nameText.y = 72
				nameButton = new MenuButton("Level Title", 18, 120)
				nameButton.x = 40
				nameButton.y = 70
				nameButton.addEventListener(MouseEvent.CLICK, clickName)
				rant = MakeText2("<b > Editor Controls:</b>\n" +
						"Click on the item icon to select it,\n" +
						"Then draw on the field as if in drawing program.\n" +
						"<u> Space</u> - Show/Hide this menu\n" +
						"<u> S</u> - Set player start position, press twice to set to none\n" +
						"<u> X</u> - Delete item under Cursor\n" +
						"<u> C</u> - Set item under Cursor as drawing item\n" +
						"<u> Escape</u> - Leave Editor\n" +
						"Don't forget to save level before quiting!", 16)
				rant.x = 50
				rant.y = 300
			}
			TEditorScene.panel.addChild(authorButton)
			TEditorScene.panel.addChild(authorText)
			TEditorScene.panel.addChild(nameButton)
			TEditorScene.panel.addChild(nameText)
			TEditorScene.panel.addChild(code)
			TEditorScene.panel.addChild(save)
			TEditorScene.panel.addChild(reload)
			TEditorScene.panel.addChild(load)
			TEditorScene.panel.addChild(test)
			TEditorScene.panel.addChild(exitButton)
			TEditorScene.panel.addChild(rant)

			created = true
		}
		private function clickAuthor(e: MouseEvent): void{
			win = new TEnterWindow("Please type your name/nick\n(Max 16 characters): ", authorText.text, 500, 16)
			editing = true
			SFX.hotkeys = false
			win.addEventListener(TWindow.CLOSED, finAuthor)
		}
		private function clickName(e: MouseEvent): void{
			win = new TEnterWindow("Please type level title\n(Max 32 characters): ", nameText.text, 500, 32)
			editing = true
			SFX.hotkeys = false
			win.addEventListener(TWindow.CLOSED, finName)
		}
		private function clickSave(e: MouseEvent): void{
			var code: String = SaveLevel();
			if (!LevelDatabase.saveUserLevel(TLevData.lastSelected.id, code)) {
				new TNote("Whoops!", "Save failed for unknown reason, sorry.");
				return;
			}

			new TNote("Ta-dah!!", "Level saved.");
			TLevData.lastSelected.code = code;


			if (levFinished && !TEditorScene.madeChanges) {
				TAchievementsPanel.awardAchievement(1)
			}

			TEditorScene.madeChanges = false;
		}
		private function clickReload(e: MouseEvent): void{
			LoadLevel(TLevData.lastSelected.code)
			new TNote("Ta-dah!!", "Level reloaded.");
		}
		private function clickCode(e: MouseEvent): void{
			win = new TEnterWindow("This is the current level's code.\nCopy and paste it into text editor to save it.\nLevels can be uploaded to the online server from main menu.\n(Click on code, press Ctrl+A, then Ctrl+C to copy)", SaveLevel(), 500)
			editing = true
			SFX.hotkeys = false
			win.addEventListener(TWindow.CLOSED, finSave)
		}
		private function clickLoad(e: MouseEvent): void{
			win = new TEnterWindow("Plese paste here the code of a level\nwhich you would like to load and edit.", "", 500)
			editing = true
			SFX.hotkeys = false
			win.addEventListener(TWindow.CLOSED, finLoad)
		}
		private function onClickExit(e: MouseEvent): void{
			editing = true
			SFX.hotkeys = false

			if (TEditorScene.madeChanges) {
				wantToExitWindow = new TSelectWindow("If you leave, all unsaved data will be lost.\nAre you sure you want to leave?", "Yes", "No")
				wantToExitWindow.addEventListener(TWindow.CHOICE1, onWantToQuitYes)
				wantToExitWindow.addEventListener(TWindow.CHOICE2, onWantToQuitNo)
			} else {
				onWantToQuitYes(null);
			}
		}

		public function clearAreYouSureQuitWindow(): void {
			if (!wantToExitWindow) {
				return;
			}

			wantToExitWindow.removeEventListener(TWindow.CHOICE1, onWantToQuitYes)
			wantToExitWindow.removeEventListener(TWindow.CHOICE2, onWantToQuitNo)
			wantToExitWindow.kill();
			wantToExitWindow = null;
		}
		public function onWantToQuitYes(e: Event): void{
			clearAreYouSureQuitWindow();

			editing = false
			SFX.hotkeys = true
			TEditorScene.madeChanges = false
			TD.setScene(TSelfmadeScene)
		}
		public function onWantToQuitNo(e: Event): void{
			clearAreYouSureQuitWindow();

			editing = false
			SFX.hotkeys = true
		}
		private function clickTest(e: MouseEvent): void{
			var code: String = SaveLevel()
			TLevel.playLevel(code, 0)
			TEditorScene.display = false
		}
		private function finAuthor(e: Event): void{
			win.removeEventListener(TWindow.CLOSED, finAuthor)
			editing = false
			SFX.hotkeys = true
			if (win.result!="" && win.result.replace(" ", "").length > 0){
				authorText.htmlText="<font face='fonter' color='#FFFFFF' size='16'>"+win.result+"</font>";
				}
			TD.refocus()
		}
		private function finName(e: Event): void{
			win.removeEventListener(TWindow.CLOSED, finName)
			editing = false
			if (win.result!="" && win.result.replace(" ", "").length > 0){
				nameText.htmlText="<font face='fonter' color='#FFFFFF' size='16'>"+win.result+"</font>";
				}
			TD.refocus()
		}
		private function finSave(e: Event): void{
			win.removeEventListener(TWindow.CLOSED, finSave)
			editing = false
			SFX.hotkeys = true
			TD.refocus()
		}
		private function finLoad(e: Event): void{
			TAchievementsPanel.awardAchievement(8)
			win.removeEventListener(TWindow.CLOSED, finLoad)
			editing = false
			SFX.hotkeys = true
			if (win.result!=""){LoadLevel(win.result)}
			TD.refocus()
		}
	}
}