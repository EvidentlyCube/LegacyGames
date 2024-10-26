package Classes.Scenes{
	import Classes.*;
	import Classes.Menu.*;
	import Classes.Scenes.*;
	import Classes.Items.*;
	import Classes.Interactivers.*;
	import Classes.Data.*;
	import Editor.*;

	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;

	import mx.core.BitmapAsset;
	public class TCampaignScene extends TScene{
		[Embed("../../../assets/gfx/ui/Menu_04.png")] public static var gBack:Class;
		[Embed("../../../assets/gfx/ui/paginationFirst.png")] public static var gPA:Class;
		[Embed("../../../assets/gfx/ui/paginationPrev.png")] public static var gPB:Class;
		[Embed("../../../assets/gfx/ui/paginationNext.png")] public static var gPC:Class;
		[Embed("../../../assets/gfx/ui/paginationLast.png")] public static var gPD:Class;
		private static var gfx:Sprite = new Sprite
		private static var back:BitmapAsset;
		private static var backGrid:Grid9
		private static var created:Boolean = false
		private static var levelRowGraphics:Array = new Array()

		private static var pages:uint = 0
		private static var page:uint = 1

		private static var caption:TextField

		private static var paginationFirst:PagingButton
		private static var paginationPrev:PagingButton
		private static var paginationNext:PagingButton
		private static var paginationLast:PagingButton

		private static var butPlay:MenuButton
		private static var butReturn:MenuButton
		public function TCampaignScene(){
			if (created){
				displayDeadLevs();
				return
			}
			caption = MakeText("Campaign Level Selection",22)
			caption.x = 300 - caption.width / 2
			caption.y = 0

			created = true
			paginationFirst = new PagingButton(gPA)
			paginationPrev = new PagingButton(gPB)
			paginationNext = new PagingButton(gPC)
			paginationLast = new PagingButton(gPD)

			paginationFirst.addEventListener(MouseEvent.CLICK,onClickPaginationFirst)
			paginationPrev.addEventListener(MouseEvent.CLICK,onClickPaginationPrev)
			paginationNext.addEventListener(MouseEvent.CLICK,onClickPaginationNext)
			paginationLast.addEventListener(MouseEvent.CLICK,onClickPaginationLast)

			paginationLast.y = paginationNext.y = paginationPrev.y = paginationFirst.y = 493
			paginationFirst.x = 35
			paginationPrev.x = 75
			paginationNext.x = 485
			paginationLast.x = 525

			butPlay = new MenuButton("Play Level")
			butPlay.x = 126
			butPlay.y = 495
			butPlay.addEventListener(MouseEvent.CLICK,onClickPlay)

			butReturn = new MenuButton("Return to Title")
			butReturn.x = 348
			butReturn.y = 495
			butReturn.addEventListener(MouseEvent.CLICK,onClickReturn)

			backGrid = new Grid9(TWindow.Grid9DataMenu)
			backGrid.width = 550
			backGrid.height = 600
			backGrid.x = 25
			back = new gBack
			back.x = 35
			back.y = 50
			gfx.addChild(backGrid)
			gfx.addChild(back)
			gfx.addChild(paginationFirst)
			gfx.addChild(paginationPrev)
			gfx.addChild(paginationNext)
			gfx.addChild(paginationLast)
			gfx.addChild(butPlay)
			gfx.addChild(butReturn)
			gfx.addChild(caption)

			page = SimpleSave.read('last-page-campaign', 1);

			displayDeadLevs()

		}
		override public function update():void{
			for (var i:int = Game.layerMenuBg.numChildren - 1;i >= 0;i--){
				var child:*=Game.layerMenuBg.getChildAt(i)
				child.Update()
			}
		}
		public function onClickPlay(e:MouseEvent):void{
			if (TLevData.lastSelected){
				TLevel.playLevel(TLevData.lastSelected.code, 1)
			} else {
				new TNote("Whoops!", "No level selected.");
			}
		}
		private function onClickReturn(e:MouseEvent):void{
			Game.setScene(TMenuScene)
		}
		private function onClickPaginationFirst(e:MouseEvent):void{
			page = 1
			displayDeadLevs()
		}
		private function onClickPaginationPrev(e:MouseEvent):void{
			page -= 1
			displayDeadLevs()
		}
		private function onClickPaginationNext(e:MouseEvent):void{
			page += 1
			displayDeadLevs()
		}
		private function onClickPaginationLast(e:MouseEvent):void{
			page = pages
			displayDeadLevs()
		}
		override public function add():void{
			Game.addLayer(Game.layerMenuBg)
			Game.addLayer(gfx)
		}
		override public function remove():void{
			Game.removeLayer(Game.layerMenuBg)
			Game.removeLayer(gfx)
		}

		private function displayDeadLevs():void{
			if (TLevData.lastSelected){
				TLevData.lastSelected.unselect()
				TLevData.lastSelected = null
			}

			while (levelRowGraphics.length){
				gfx.removeChild(levelRowGraphics.pop())
			}

			pages = Math.ceil(LevelDatabase.campaignLevels.length / 5)
			page = Math.max(1, page);
			page = Math.min(page, pages);

			if (page == pages){
				paginationNext.visible = false;
				paginationLast.visible = false;
			} else {
				paginationNext.visible = true;
				paginationLast.visible = true;
			}
			if (page == 1){
				paginationFirst.visible = false;
				paginationPrev.visible = false;
			} else {
				paginationFirst.visible = true;
				paginationPrev.visible = true;
			}

			SimpleSave.writeFlush('last-page-campaign', page);

			var levels: Array = LevelDatabase.campaignLevels.slice((page - 1) * 5, page * 5);

			WindowHandler.popWindow()
			showDeadLevel(levels[0], 65)
			showDeadLevel(levels[1], 147)
			showDeadLevel(levels[2], 229)
			showDeadLevel(levels[3], 311)
			showDeadLevel(levels[4], 393)
		}

		private function showDeadLevel(level:LocalStorageLevelData, _y:uint):void{
			if (!level) {
				return;
			}

			var levelData:TLevData = new TLevData(level.id, level.name, level.author, level.code);
			levelData.x = 51;
			levelData.y = _y + 1;
			levelRowGraphics.push(levelData);
			gfx.addChild(levelData);
		}
	}
}
