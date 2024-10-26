package Editor{
	import Classes.Menu.*;
	import Classes.Data.*;
	import Classes.MenuButton;
	import Classes.Scenes.TEditorScene;
	import Classes.Scenes.TSelfmadeScene;
	import Classes.TLevData;
	import Classes.TLevel;

	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	public class TopPanelMonster{
		private static var changeAuthorButton:MenuButton;
		public static var authorTextField:TextField
		private static var changeNameButton:MenuButton
		public static var nameTextField:TextField
		private static var saveButton:MenuButton
		private static var helpButton:MenuButton
		private static var reloadButton:MenuButton
		private static var loadCodeButton:MenuButton
		private static var testButton:MenuButton
		private static var exitButton:MenuButton
		private static var bgMoveTextField:TextField
		private static var buttonBgMoveH:MenuButton
		public static var backgroundHSpeedTextField:TextField
		private static var buttonBgMoveV:MenuButton
		public static var backgroundVSpeedTextField:TextField
		public static var editing:Boolean = false
		public static var created:Boolean = false
		private static var win:TEnterWindow
		public static var levFinished:Boolean = false
		public static var helper:THelpMenu
		public function TopPanelMonster(){
			if (!created){
				saveButton = new MenuButton("Save Level",18,130)
				saveButton.x = 150
				saveButton.y = 530
				saveButton.addEventListener(MouseEvent.CLICK,onClickSave)

				reloadButton = new MenuButton("Reload Level",18,130)
				reloadButton.x = 295
				reloadButton.y = 530
				reloadButton.addEventListener(MouseEvent.CLICK,onClickReload)

				testButton = new MenuButton("Test Level",18,130)
				testButton.x = 440
				testButton.y = 530
				testButton.addEventListener(MouseEvent.CLICK,onClickTest)

				helpButton = new MenuButton("Help",18,130)
				helpButton.x = 150
				helpButton.y = 564
				helpButton.addEventListener(MouseEvent.CLICK,onClickHelp)

				loadCodeButton = new MenuButton("Load Code",18,130)
				loadCodeButton.x = 295
				loadCodeButton.y = 564
				loadCodeButton.addEventListener(MouseEvent.CLICK,onClickLoad)

				exitButton = new MenuButton("Exit",18,130)
				exitButton.x = 440
				exitButton.y = 564
				exitButton.addEventListener(MouseEvent.CLICK,onClickExit)

                authorTextField = MakeText2("Unnamed",16)
				authorTextField.x = 200
				authorTextField.y = 14
				changeAuthorButton = new MenuButton("Change Author", 18, 170)
				changeAuthorButton.x = 35
				changeAuthorButton.y = 12
				changeAuthorButton.addEventListener(MouseEvent.CLICK,onClickAuthorChange)

				nameTextField = MakeText2("Unnamed",16)
				nameTextField.x = 200
				nameTextField.y = 54
				changeNameButton = new MenuButton("Change Name", 18, 170)
				changeNameButton.x = 35
				changeNameButton.y = 52
				changeNameButton.addEventListener(MouseEvent.CLICK,onClickNameChange)

				bgMoveTextField = MakeText2("Background Movement:",16)
				bgMoveTextField.x = 365 - bgMoveTextField.width / 2
				bgMoveTextField.y = 460

				buttonBgMoveH = new MenuButton("Horizontal",16,100)
				buttonBgMoveH.x = 180
				buttonBgMoveH.y = 490
				buttonBgMoveH.addEventListener(MouseEvent.CLICK,onClickMoveX)
				buttonBgMoveV = new MenuButton("Vertical",16,100)
				buttonBgMoveV.x = 380
				buttonBgMoveV.y = 490
				buttonBgMoveV.addEventListener(MouseEvent.CLICK,onClickMoveY)

				backgroundHSpeedTextField = MakeText2("0",16)
				backgroundHSpeedTextField.x = 290
				backgroundHSpeedTextField.y = 490

				backgroundVSpeedTextField = MakeText2("0",16)
				backgroundVSpeedTextField.x = 490
				backgroundVSpeedTextField.y = 490

				helper = new THelpMenu(true)
				Game.STG.addEventListener(Event.ENTER_FRAME,helper.update)
			}

			TEditorScene.panelTop.addChild(changeAuthorButton)
			TEditorScene.panelTop.addChild(authorTextField)
			TEditorScene.panelTop.addChild(changeNameButton)
			TEditorScene.panelTop.addChild(nameTextField)
			TEditorScene.panelBottom.addChild(helpButton)
			TEditorScene.panelBottom.addChild(saveButton)
			//TEditorScene.panelBottom.addChild(reloadButton)
			TEditorScene.panelBottom.addChild(loadCodeButton)
			TEditorScene.panelBottom.addChild(testButton)
			TEditorScene.panelBottom.addChild(exitButton)
			TEditorScene.panelBottom.addChild(bgMoveTextField)
			TEditorScene.panelBottom.addChild(buttonBgMoveH)
			TEditorScene.panelBottom.addChild(buttonBgMoveV)
			TEditorScene.panelBottom.addChild(backgroundHSpeedTextField)
			TEditorScene.panelBottom.addChild(backgroundVSpeedTextField)

			created = true
		}
		private function onClickNameChange(e:MouseEvent):void{
			var window:* = new TEnterWindow(
				"Please type Level Name\n(Max 32 characters):",
				nameTextField.text,
				500,
				32
			);

			editing = true
			window.addEventListener(TWindow.CLOSED, function():void {
				editing = false
				if (window.result != "" && window.result.replace(" ","").length > 0){
					nameTextField.htmlText = "<font face='fonter' color='#FFFFFF' size='16'>" + window.result + "</font>";
				}
				Game.refocus()
			}, false, 0, true);
		}
		private function onClickAuthorChange(e:MouseEvent):void{
			var window:* = new TEnterWindow(
				"Please type Level Author\n(Max 32 characters):",
				authorTextField.text,
				500,
				32
			);

			editing = true
			window.addEventListener(TWindow.CLOSED, function():void {
				editing = false
				if (window.result != "" && window.result.replace(" ","").length > 0){
					authorTextField.htmlText = "<font face='fonter' color='#FFFFFF' size='16'>" + window.result + "</font>";
				}
				Game.refocus()
			}, false, 0, true);
		}

		private function onClickExit(e:MouseEvent):void{
			if (!TEditorScene.madeChanges) {
				editing = false
				TEditorScene.madeChanges = false
				Game.setScene(TSelfmadeScene)
				return;
			}

			var window:* = new TSelectWindow(
				"If you leave, all unsaved data will be lost.\nAre you sure you want to leave?",
				"Yes",
				"No"
			);

			editing = true

			window.addEventListener(TWindow.CHOICE1, function():void {
				editing = false
				TEditorScene.madeChanges = false
				Game.setScene(TSelfmadeScene)
			}, false, 0, true);
			window.addEventListener(TWindow.CHOICE2, function():void {
				editing = false
			}, false, 0, true);
		}

		private function onClickSave(e:MouseEvent):void{
			var code: String = SaveLevel();
			if (!LevelDatabase.saveUserLevel(TLevData.lastSelected.id, code)) {
				new TNote("Whoops!", "Save failed for unknown reason, sorry.");
				return;
			}

			if (levFinished && !TEditorScene.madeChanges) {
				TAchievementsPanel.awardAchievement(3);
			}

			new TNote("Ta-dah!!", "Level saved.");
			TLevData.lastSelected.code = code;

			levFinished = false;
			TEditorScene.madeChanges = false;
		}

		private function onClickMoveX(e:MouseEvent):void{
			var window: * = new TEnterWindow(
				"Please enter horizontal background movement speed.\n" +
				"Range from -4000 to 4000.",
				backgroundHSpeedTextField.text,
				500
			);

			editing = true
			window.addEventListener(TWindow.CLOSED, function(): void {
				editing = false
				Game.refocus()
				if (window.result !== "" && window.result.replace(" ","").length > 0){
					var value: Number = parseInt(window.result);
					if (isNaN(value)) {
						new TNote("Whoops!", "Given speed is not a number.");
						return;
					}
					value = Math.max(-4000, value);
					value = Math.min(4000, value);
					backgroundHSpeedTextField.htmlText =
						"<font face='fonter' color='#FFFFFF' size='16'>" +
						value.toString()
					 	+ "</font>";
				}
			}, false, 0, true)
		}
		private function onClickMoveY(e:MouseEvent):void{
			var window: * = new TEnterWindow(
				"Please enter vertical background movement speed.\n" +
				"Range from -4000 to 4000.",
				backgroundVSpeedTextField.text,
				500
			);

			editing = true
			window.addEventListener(TWindow.CLOSED, function(): void {
				editing = false
				Game.refocus()
				if (window.result !== "" && window.result.replace(" ","").length > 0){
					var value: Number = parseInt(window.result);
					if (isNaN(value)) {
						new TNote("Whoops!", "Given speed is not a number.");
						return;
					}
					value = Math.max(-4000, value);
					value = Math.min(4000, value);
					backgroundVSpeedTextField.htmlText = "<font face='fonter' color='#FFFFFF' size='16'>" +
						value.toString()
					 	+ "</font>";
				}
			}, false, 0, true)
		}
		private function onClickReload(e:MouseEvent):void{
			if (TLevData.lastSelected.code) {
				LoadLevel(TLevData.lastSelected.code)
			}
		}
		private function onClickHelp(e:MouseEvent):void{
			helper.animate = 1
			helper.visible = true
		}
		private function onClickLoad(e:MouseEvent):void{
			var window:* = new TEnterWindow(
				"Please paste here the code of a level\nwhich you would like to load and edit.",
				Editor.SaveLevel(),
				500
			);

			editing = true
			window.addEventListener(TWindow.CLOSED,function(): void {
				editing = false
				if (window.result != ""){
					if (ValidateLevel(window.result)) {
						LoadLevel(window.result);
					} else {
						new TNote("Whoops!", "Invalid level code.");
					}
				}
				Game.refocus()
			}, false, 0, true);
		}
		private function onClickTest(e:MouseEvent):void{
			var helpButton:String = SaveLevel()
			TLevel.playLevel(helpButton,0)
			TEditorScene.display = false
		}
	}
}