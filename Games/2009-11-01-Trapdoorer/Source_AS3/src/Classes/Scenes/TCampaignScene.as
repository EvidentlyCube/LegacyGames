package Classes.Scenes{
	import Classes.Grid9;
	import Classes.Menu.TAlertWindow;
	import Classes.Menu.TAchievementsPanel;
	import Classes.Menu.TWindow;
	import Classes.Menu.WindowHandler;
	import Classes.MenuButton;
	import Classes.PagingButton;
	import Classes.TLevData;
	import Classes.TLevel;

	import Editor.MakeText;

	import LoadingDir.Loading;

	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;

	import mx.core.BitmapAsset;
	public class TCampaignScene extends TScene{
		[Embed("../../../assets/gfx/by_maurycy/ui/Menu_04.png")] public static var gLevelListBgSrc: Class;
		[Embed("../../../assets/gfx/by_maurycy/ui/pagingA.png")] public static var gPaginationFirstSrc: Class;
		[Embed("../../../assets/gfx/by_maurycy/ui/pagingB.png")] public static var gPaginationPrevSrc: Class;
		[Embed("../../../assets/gfx/by_maurycy/ui/pagingC.png")] public static var gPaginationNextSrc: Class;
		[Embed("../../../assets/gfx/by_maurycy/ui/pagingD.png")] public static var gPaginationLastSrc: Class;
		private static var gfx: Sprite = new Sprite
		private static var back: BitmapAsset;
		private static var backGrid: Grid9
		private static var created: Boolean = false
		private static var levelsArr: Array = new Array()

		private static var pages: uint = 0
		private static var page: uint = 1

		private static var caption: TextField

		private static var paginatorFirst: PagingButton
		private static var paginatorPrev: PagingButton
		private static var paginatorNext: PagingButton
		private static var paginatorLast: PagingButton

		private static var butPlay: MenuButton
		private static var butReturn: MenuButton
		public function TCampaignScene(){
			if (created){return}
			caption = MakeText("Campaign", 32)
			caption.x = 300-caption.width/2
			caption.y = 3

			created = true
			paginatorFirst = new PagingButton(gPaginationFirstSrc)
			paginatorPrev = new PagingButton(gPaginationPrevSrc)
			paginatorNext = new PagingButton(gPaginationNextSrc)
			paginatorLast = new PagingButton(gPaginationLastSrc)

			paginatorFirst.addEventListener(MouseEvent.CLICK, onClickPaginateFirst)
			paginatorPrev.addEventListener(MouseEvent.CLICK, onClickPaginatePrev)
			paginatorNext.addEventListener(MouseEvent.CLICK, onClickPaginateNext)
			paginatorLast.addEventListener(MouseEvent.CLICK, onClickPaginateLast)

			paginatorLast.y = paginatorNext.y = paginatorPrev.y = paginatorFirst.y = 490
			paginatorFirst.x = 35
			paginatorPrev.x = 75
			paginatorNext.x = 485
			paginatorLast.x = 525

			butPlay = new MenuButton("Play Level")
			butPlay.x = 126
			butPlay.y = 495
			butPlay.addEventListener(MouseEvent.CLICK, clickPlay)

			butReturn = new MenuButton("Return to Title")
			butReturn.x = 348
			butReturn.y = 495
			butReturn.addEventListener(MouseEvent.CLICK, clickReturn)

			backGrid = new Grid9(TWindow.Grid9DataMenu)
			backGrid.width = 550
			backGrid.height = 600
			backGrid.x = 25
			back = new gLevelListBgSrc
			back.x = 35
			back.y = 50
			gfx.addChild(backGrid)
			gfx.addChild(back)
			gfx.addChild(paginatorFirst)
			gfx.addChild(paginatorPrev)
			gfx.addChild(paginatorNext)
			gfx.addChild(paginatorLast)
			gfx.addChild(butPlay)
			gfx.addChild(butReturn)
			gfx.addChild(caption)


			page = SimpleSave.read('campaign-last-page', 1);

			pages = 15
			displayDeadLevs()
		}
		public function clickPlay(e: MouseEvent): void{
			if (TLevData.lastSelected){
				TLevel.playLevel(TLevData.lastSelected.code, 1)
			} else {
				new TAlertWindow("No level selected!")
			}
		}
		private function clickReturn(e: MouseEvent): void{
			TD.setScene(TMenuScene)
		}
		private function onClickPaginateFirst(e: MouseEvent): void{
			page = 1
			displayDeadLevs()
		}
		private function onClickPaginatePrev(e: MouseEvent): void{
			page -= 1
			displayDeadLevs()
		}
		private function onClickPaginateNext(e: MouseEvent): void{
			page += 1
			displayDeadLevs()
		}
		private function onClickPaginateLast(e: MouseEvent): void{
			page = pages
			displayDeadLevs()
		}
		override public function add(): void{
			TD.addLayer(TD.layerBg)
			TD.addLayer(gfx)
		}
		override public function remove(): void{
			TD.removeLayer(TD.layerBg)
			TD.removeLayer(gfx)
		}
		private function displayDeadLevs(): void{
			while (levelsArr.length){
				gfx.removeChild(levelsArr.pop())
			}
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

			WindowHandler.popWindow();

			showDeadLevel((page-1) * 5, 65);
			showDeadLevel((page-1) * 5 + 1, 147);
			showDeadLevel((page-1) * 5 + 2, 229);
			showDeadLevel((page-1) * 5 + 3, 311);
			showDeadLevel((page-1) * 5 + 4, 393);
		}
		private function showDeadLevel(id: uint, _y: uint): void{
			var levDat: TLevData = TLevData.campaign[id];
			levDat.x = 51
			levDat.y=_y+1
			levelsArr.push(levDat)
			gfx.addChild(levDat)
		}
	}
}
