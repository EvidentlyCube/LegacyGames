package Classes.Scenes{
	import Classes.Data.LocalStorageLevelData;
	import Classes.Data.LevelDatabase;
	import Classes.Grid9;
	import Classes.SFX;
	import Classes.Menu.TAlertWindow;
	import Classes.Menu.TAchievementsPanel;
	import Classes.Menu.TSelectWindow;
	import Classes.Menu.TWindow;
	import Classes.Menu.WindowHandler;
	import Classes.Menu.TNote;
	import Classes.MenuButton;
	import Classes.TLevData;
	import Classes.PagingButton;

	import Editor.LoadLevel;
	import Editor.MakeText;
	import Editor.MakeThumbnail;
	import Editor.ExtractDetails;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.system.System;

	import mx.core.BitmapAsset;
	public class TSelfmadeScene extends TScene{
		private static var gfx: Sprite = new Sprite
		private static var back: BitmapAsset;
		private static var levelListBackground: Grid9
		private static var created: Boolean = false
		private static var levelsArr: Array = new Array()

		private static var caption: TextField
		private static var selWin: TSelectWindow
		private static var pages: Number;
		private static var page: Number = 1;

		private static var paginatorFirst: PagingButton
		private static var paginatorPrev: PagingButton
		private static var paginatorNext: PagingButton
		private static var paginatorLast: PagingButton

		private static var buttonEditLevel: MenuButton
		private static var buttonDeleteLevel: MenuButton
		private static var buttonExportLevel: MenuButton
		private static var buttonReturn: MenuButton
		public function TSelfmadeScene(){
			if (created){
				if (TLevData.lastSelected){
					TLevData.lastSelected.unselect()
				}
				displayLevs();
				return
			}
			created = true
			paginatorFirst = new PagingButton(TCampaignScene.gPaginationFirstSrc)
			paginatorPrev = new PagingButton(TCampaignScene.gPaginationPrevSrc)
			paginatorNext = new PagingButton(TCampaignScene.gPaginationNextSrc)
			paginatorLast = new PagingButton(TCampaignScene.gPaginationLastSrc)

			paginatorFirst.addEventListener(MouseEvent.CLICK, onClickPaginateFirst)
			paginatorPrev.addEventListener(MouseEvent.CLICK, onClickPaginatePrev)
			paginatorNext.addEventListener(MouseEvent.CLICK, onClickPaginateNext)
			paginatorLast.addEventListener(MouseEvent.CLICK, onClickPaginateLast)

			paginatorLast.y = paginatorNext.y = paginatorPrev.y = paginatorFirst.y = 490
			paginatorFirst.x = 35
			paginatorPrev.x = 75
			paginatorNext.x = 485
			paginatorLast.x = 525

			caption = MakeText("Level Editor", 32)
			caption.x = 300-caption.width/2
			caption.y = 3



			buttonEditLevel = new MenuButton("Edit")
			buttonEditLevel.y = 495
			buttonEditLevel.addEventListener(MouseEvent.CLICK, clickEditLevel)

			buttonExportLevel = new MenuButton("Export")
			buttonExportLevel.y = 495
			buttonExportLevel.addEventListener(MouseEvent.CLICK, clickExportLevel)

			buttonDeleteLevel = new MenuButton("Delete")
			buttonDeleteLevel.y = 495
			buttonDeleteLevel.addEventListener(MouseEvent.CLICK, clickDeleteLevel)

			buttonReturn = new MenuButton("Return")
			buttonReturn.y = 495
			buttonReturn.addEventListener(MouseEvent.CLICK, clickReturn)

			levelListBackground = new Grid9(TWindow.Grid9DataMenu)
			levelListBackground.width = 550
			levelListBackground.height = 600
			levelListBackground.x = 25
			back = new TCampaignScene.gLevelListBgSrc
			back.x = 35
			back.y = 50
			gfx.addChild(levelListBackground)
			gfx.addChild(back)

			var buttonsPadding: Number = (
				paginatorNext.x - (paginatorPrev.x + paginatorPrev.width)
				- buttonEditLevel.width
				- buttonExportLevel.width
				- buttonDeleteLevel.width
				- buttonReturn.width
			) / 4;
			buttonEditLevel.x = paginatorPrev.x + paginatorPrev.width + buttonsPadding;
			buttonExportLevel.x = buttonEditLevel.x + buttonEditLevel.width + buttonsPadding;
			buttonDeleteLevel.x = buttonExportLevel.x + buttonExportLevel.width + buttonsPadding;
			buttonReturn.x = buttonDeleteLevel.x + buttonDeleteLevel.width + buttonsPadding;

			gfx.addChild(buttonEditLevel)
			gfx.addChild(buttonExportLevel)
			gfx.addChild(buttonDeleteLevel)
			gfx.addChild(buttonReturn)
			gfx.addChild(paginatorFirst)
			gfx.addChild(paginatorPrev)
			gfx.addChild(paginatorNext)
			gfx.addChild(paginatorLast)
			gfx.addChild(caption)

			displayLevs();
		}
		private function onClickPaginateFirst(e: MouseEvent): void{
			page = 1
			displayLevs()
		}
		private function onClickPaginatePrev(e: MouseEvent): void{
			page -= 1
			displayLevs()
		}
		private function onClickPaginateNext(e: MouseEvent): void{
			page += 1
			displayLevs()
		}
		private function onClickPaginateLast(e: MouseEvent): void{
			page = pages
			displayLevs()
		}
		public function clickEditLevel(e: MouseEvent): void{
			if (!TLevData.lastSelected) {
				new TNote("Whoops!", "No level selected.")
				return;
			}

			TD.setScene(TEditorScene)
			if (TLevData.lastSelected.code) {
				LoadLevel(TLevData.lastSelected.code)
			} else {
				LoadLevel("TPDBEG&nonam(Unnamed!!!TPDEND")
			}
		}
		public function clickExportLevel(e: MouseEvent): void {
			if (!TLevData.lastSelected) {
				new TNote("Whoops!", "No level selected.")

			} else if (!TLevData.lastSelected.code) {
				new TNote("Whoops!", "This level is empty.")

			} else {
				System.setClipboard(TLevData.lastSelected.id + TLevData.lastSelected.code);
				new TNote("T-dah!!", "Level copied to the clipboard.")
			}
		}
		private function clickDeleteLevel(e: MouseEvent): void {
			if (!TLevData.lastSelected) {
				new TNote("Whoops!", "No level selected.")
				return;

			} else if (!TLevData.lastSelected.code) {
				new TNote("Whoops!", "This level is empty.")
				return;
			}

			var window: TSelectWindow = new TSelectWindow(
				"Do you want to delete this level?",
				"Yes",
				"No"
			);

			window.addEventListener(TWindow.CHOICE1, function(e:*):void {
				SFX.Play('hit2');
				LevelDatabase.deleteUserMadeLevel(TLevData.lastSelected.id);
				displayLevs();
				window.kill();

			}, false, 0, true);
			window.addEventListener(TWindow.CHOICE2, function(e:*): void {
				window.kill();

			}, false, 0, true);

		}
		private function clickReturn(e: MouseEvent): void{
			TD.setScene(TMenuScene)
		}
		override public function add(): void{
			TD.addLayer(TD.layerBg)
			TD.addLayer(gfx)
		}
		override public function remove(): void{
			TD.removeLayer(TD.layerBg)
			TD.removeLayer(gfx)
		}
		private function displayLevs(): void{
			if (TLevData.lastSelected){
				TLevData.lastSelected.unselect()
				TLevData.lastSelected = null;
			}

			while (levelsArr.length){
				gfx.removeChild(levelsArr.pop())
			}

			pages = Math.ceil((LevelDatabase.userLevels.length + 1) / 5);

			if (page == pages){
				paginatorNext.visible = false;
				paginatorLast.visible = false
			} else {
				paginatorNext.visible = true;
				paginatorLast.visible = true;
			}
			if (page == 1){
				paginatorFirst.visible = false;
				paginatorPrev.visible = false;
			} else {
				paginatorFirst.visible = true;
				paginatorPrev.visible = true;
			}

			var levelDatas:Array = LevelDatabase.userLevels.slice((page - 1) * 5, page * 5);

			if (levelDatas[0]){ showLevel(levelDatas[0], 65 )} else { showLevel(null, 65)}
			if (levelDatas[1]){ showLevel(levelDatas[1], 147 )} else { showLevel(null, 147)}
			if (levelDatas[2]){ showLevel(levelDatas[2], 229 )} else { showLevel(null, 229)}
			if (levelDatas[3]){ showLevel(levelDatas[3], 311 )} else { showLevel(null, 311)}
			if (levelDatas[4]){ showLevel(levelDatas[4], 393 )} else { showLevel(null, 393)}
		}
		private function showLevel(data: LocalStorageLevelData, _y: uint): void{
			var levDat: TLevData;
			if (data) {
				levDat = new TLevData(data.id, data.name, data.author, data.code);
			} else {
			 	levDat = new TLevData(LevelDatabase.generateEditorId(), "", "", "")
			}
			levDat.x = 51
			levDat.y = _y + 1
			levelsArr.push(levDat)
			gfx.addChild(levDat)
		}
	}
}
