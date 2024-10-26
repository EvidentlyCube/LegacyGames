package Classes.Scenes{
	import Classes.Data.LevelDatabase;
	import Classes.Data.LocalStorageLevelData;
	import Classes.Grid9;
	import Classes.Menu.TAlertWindow;
	import Classes.Menu.TAchievementsPanel;
	import Classes.Menu.TWindow;
	import Classes.Menu.WindowHandler;
	import Classes.Menu.TNote;
	import Classes.Menu.TEnterWindow;
	import Classes.Menu.TSelectWindow;
	import Classes.MenuButton;
	import Classes.PagingButton;
	import Classes.TLevData;
	import Classes.TLevel;
	import Classes.SFX;

	import Editor.MakeText;

	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;

	import mx.core.BitmapAsset;
	public class TCustomScene extends TScene{
		private static var gfx: Sprite = new Sprite
		private static var back: BitmapAsset;
		private static var backGrid: Grid9
		private static var created: Boolean = false
		private static var displayLevDatas: Array = new Array()

		private static var caption: TextField

		private static var pages: uint = 0
		private static var page: uint = 1

		private static var paginatorFirst: PagingButton
		private static var paginatorPrev: PagingButton
		private static var paginatorNext: PagingButton
		private static var paginatorLast: PagingButton

		private static var buttonPlay: MenuButton
		private static var buttonDelete: MenuButton
		private static var buttonImport: MenuButton
		private static var buttonReturn: MenuButton
		public function TCustomScene(){
			if (created){
				displayLevs();
				return;
			}
			created = true
			caption = MakeText("Usermade Levels", 32)
			caption.x = 300-caption.width/2
			caption.y = 3

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

			buttonPlay = new MenuButton("Play")
			buttonPlay.x = 126
			buttonPlay.y = 495
			buttonPlay.addEventListener(MouseEvent.CLICK, clickPlay)

			buttonDelete = new MenuButton("Delete")
			buttonDelete.x = 236
			buttonDelete.y = 495
			buttonDelete.addEventListener(MouseEvent.CLICK, clickDelete)

			buttonImport = new MenuButton("Import")
			buttonImport.x = 348
			buttonImport.y = 495
			buttonImport.addEventListener(MouseEvent.CLICK, clickImport)

			buttonReturn = new MenuButton("Return")
			buttonReturn.x = 348
			buttonReturn.y = 495
			buttonReturn.addEventListener(MouseEvent.CLICK, clickReturn)

			backGrid = new Grid9(TWindow.Grid9DataMenu)
			backGrid.width = 550
			backGrid.height = 600
			backGrid.x = 25
			back = new TCampaignScene.gLevelListBgSrc
			back.x = 35
			back.y = 50
			gfx.addChild(backGrid)
			gfx.addChild(back)
			gfx.addChild(paginatorFirst)
			gfx.addChild(paginatorPrev)
			gfx.addChild(paginatorNext)
			gfx.addChild(paginatorLast)
			gfx.addChild(buttonPlay)
			gfx.addChild(buttonImport)
			gfx.addChild(buttonDelete)
			gfx.addChild(buttonReturn)
			gfx.addChild(caption)


			var buttonsPadding: Number = (
				paginatorNext.x - (paginatorPrev.x + paginatorPrev.width)
				- buttonPlay.width
				- buttonImport.width
				- buttonDelete.width
				- buttonReturn.width
			) / 4;
			buttonPlay.x = paginatorPrev.x + paginatorPrev.width + buttonsPadding;
			buttonImport.x = buttonPlay.x + buttonPlay.width + buttonsPadding;
			buttonDelete.x = buttonImport.x + buttonImport.width + buttonsPadding;
			buttonReturn.x = buttonDelete.x + buttonDelete.width + buttonsPadding;


			displayLevs();
		}
		public function clickPlay(e: MouseEvent): void{
			if (!TLevData.lastSelected) {
				new TNote("Whoops!", "No level selected.")
				return;
			}

			TLevel.playLevel(TLevData.lastSelected.code, 2)
		}
		private function clickDelete(e: MouseEvent): void{
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
				LevelDatabase.deleteCustomLevel(TLevData.lastSelected.id);
				displayLevs();
				window.kill();

			}, false, 0, true);
			window.addEventListener(TWindow.CHOICE2, function(e:*): void {
				window.kill();

			}, false, 0, true);
		}

		private function clickImport(e: MouseEvent): void{
			var win:* = new TEnterWindow("Paste the level:", "", 500, 0);
			win.addEventListener(TWindow.CLOSED, function():void {
				if (LevelDatabase.saveCustomLevel(win.result)) {
					new TNote("Ta-dah!", "Level imported.")
					displayLevs();
				} else {
					new TNote("Whoops!", "Import failed.")
				}

			}, false, 0, true);
		}

		private function clickReturn(e: MouseEvent): void{
			TD.setScene(TMenuScene)
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

			while (displayLevDatas.length){
				gfx.removeChild(displayLevDatas.pop())
			}

			pages = Math.ceil((LevelDatabase.customLevels.length + 1) / 5);
			trace(LevelDatabase.customLevels.length);

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

			var levelDatas:Array = LevelDatabase.customLevels.slice((page - 1) * 5, page * 5);

			if (levelDatas[0]){ showLevel(levelDatas[0], 65 )}
			if (levelDatas[1]){ showLevel(levelDatas[1], 147 )}
			if (levelDatas[2]){ showLevel(levelDatas[2], 229 )}
			if (levelDatas[3]){ showLevel(levelDatas[3], 311 )}
			if (levelDatas[4]){ showLevel(levelDatas[4], 393 )}
		}
		private function showLevel(data: LocalStorageLevelData, _y: uint): void{
			var levDat: TLevData;
			levDat = new TLevData(data.id, data.name, data.author, data.code);
			levDat.x = 51
			levDat.y = _y + 1
			displayLevDatas.push(levDat)
			gfx.addChild(levDat)
		}
	}
}
