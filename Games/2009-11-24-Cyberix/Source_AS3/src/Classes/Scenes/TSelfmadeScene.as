package Classes.Scenes{
	import Classes.*;
	import Classes.Data.*;
	import Classes.Menu.*;
	import Classes.TLevData;
	import Classes.Data.LevelDatabase;

	import Editor.LoadLevel;
	import Editor.MakeText;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.system.System;

	import mx.core.BitmapAsset;
	public class TSelfmadeScene extends TScene{
		[Embed("../../../assets/gfx/ui/Menu_04.png")] public static var gBack:Class;
		[Embed("../../../assets/gfx/ui/paginationFirst.png")] public static var gPA:Class;
		[Embed("../../../assets/gfx/ui/paginationPrev.png")] public static var gPB:Class;
		[Embed("../../../assets/gfx/ui/paginationNext.png")] public static var gPC:Class;
		[Embed("../../../assets/gfx/ui/paginationLast.png")] public static var gPD:Class;
		private static var gfx:Sprite = new Sprite
		private static var back:BitmapAsset;
		private static var backGrid:Grid9
		private static var created:Boolean = false
		private static var levelsArr:Array = new Array()

		private static var caption:TextField
		private static var selWin:TSelectWindow

		private static var paginationFirst:PagingButton
		private static var paginationPrev:PagingButton
		private static var paginationNext:PagingButton
		private static var paginationLast:PagingButton

		private static var buttonEdit:MenuButton
		private static var buttonExport:MenuButton
		private static var buttonDelete:MenuButton
		private static var buttonReturn:MenuButton

		public var page: Number;
		public var pages: Number;
		public function TSelfmadeScene(){
			if (created){
				displayLevels();
				return
			}
			caption = MakeText("Level Editor Menu",22)
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

			buttonEdit = new MenuButton("Edit")
			buttonEdit.y = 495
			buttonEdit.addEventListener(MouseEvent.CLICK,onClickPlay)

			buttonExport = new MenuButton("Export")
			buttonExport.y = 495
			buttonExport.addEventListener(MouseEvent.CLICK, onClickExport)

			buttonDelete = new MenuButton("Delete")
			buttonDelete.y = 495
			buttonDelete.addEventListener(MouseEvent.CLICK, onClickDelete)

			buttonReturn = new MenuButton("Return")
			buttonReturn.y = 495
			buttonReturn.addEventListener(MouseEvent.CLICK,onClickReturn)

			backGrid = new Grid9(TWindow.Grid9DataMenu)
			backGrid.width = 550
			backGrid.height = 600
			backGrid.x = 25
			back = new gBack
			back.x = 35
			back.y = 50
			gfx.addChild(backGrid)
			gfx.addChild(back)
			gfx.addChild(buttonEdit)
			gfx.addChild(buttonExport)
			gfx.addChild(buttonDelete)
			gfx.addChild(buttonReturn)
			gfx.addChild(caption)
			gfx.addChild(paginationFirst);
			gfx.addChild(paginationPrev);
			gfx.addChild(paginationNext);
			gfx.addChild(paginationLast);

			var buttonsPadding: Number = (
				paginationNext.x - (paginationPrev.x + paginationPrev.width)
				- buttonEdit.width
				- buttonExport.width
				- buttonDelete.width
				- buttonReturn.width
			) / 4;
			buttonEdit.x = paginationPrev.x + paginationPrev.width + buttonsPadding;
			buttonExport.x = buttonEdit.x + buttonEdit.width + buttonsPadding;
			buttonDelete.x = buttonExport.x + buttonExport.width + buttonsPadding;
			buttonReturn.x = buttonDelete.x + buttonDelete.width + buttonsPadding;

			page = SimpleSave.read('last-page-self', 1);

			displayLevels()
		}
		override public function update():void{
			for (var i:int = Game.layerMenuBg.numChildren - 1;i >= 0;i--){
				var child:*=Game.layerMenuBg.getChildAt(i)
				child.Update()
			}
		}
		private function onClickPaginationFirst(e:MouseEvent):void{
			page = 1
			displayLevels()
		}
		private function onClickPaginationPrev(e:MouseEvent):void{
			page -= 1
			displayLevels()
		}
		private function onClickPaginationNext(e:MouseEvent):void{
			page += 1
			displayLevels()
		}
		private function onClickPaginationLast(e:MouseEvent):void{
			page = pages
			displayLevels()
		}
		public function onClickPlay(e:MouseEvent):void{
			if (TLevData.lastSelected){
				Game.setScene(TEditorScene)
				LoadLevel(
					TLevData.lastSelected.code,
					TLevData.lastSelected.isFauxLevel
				)

			} else {
				new TAlertWindow("No level selected!")
			}
		}

		public function onClickExport(e:MouseEvent):void{
			if (!TLevData.lastSelected) {
				new TNote("Whoops!", "No level selected.")

			} else if (TLevData.lastSelected.isFauxLevel) {
				new TNote("Whoops!", "This level is empty.")

			} else {
				System.setClipboard(TLevData.lastSelected.id + TLevData.lastSelected.code);
				new TNote("T-dah!!", "Level copied to the clipboard.")
			}
		}

		public function onClickDelete(e:MouseEvent): void {
			if (!TLevData.lastSelected) {
				new TNote("Whoops!", "No level selected.")
				return;

			} else if (TLevData.lastSelected.isFauxLevel) {
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
				displayLevels();
				window.kill();

			}, false, 0, true);
			window.addEventListener(TWindow.CHOICE2, function(e:*): void {
				window.kill();

			}, false, 0, true);
		}

		private function onClickReturn(e:MouseEvent):void{
			Game.setScene(TMenuScene)
		}
		override public function add():void{
			Game.addLayer(Game.layerMenuBg)
			Game.addLayer(gfx)
		}
		override public function remove():void{
			Game.removeLayer(Game.layerMenuBg)
			Game.removeLayer(gfx)
		}
		private function displayLevels():void{
			if (TLevData.lastSelected){
				TLevData.lastSelected.unselect()
				TLevData.lastSelected = null
			}

			while (levelsArr.length){
				gfx.removeChild(levelsArr.pop())
			}

			pages = Math.ceil((LevelDatabase.userLevels.length + 1) / 5);
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

			SimpleSave.writeFlush('last-page-self', page);

			var levels: Array = LevelDatabase.userLevels.slice((page - 1) * 5, page * 5);

			if (levels[0]){showLevel(levels[0],65)} else {showLevel(null,65)}
			if (levels[1]){showLevel(levels[1],147)} else {showLevel(null,147)}
			if (levels[2]){showLevel(levels[2],229)} else {showLevel(null,229)}
			if (levels[3]){showLevel(levels[3],311)} else {showLevel(null,311)}
			if (levels[4]){showLevel(levels[4],393)} else {showLevel(null,393)}
		}
		private function showLevel(l:LocalStorageLevelData, _y:uint):void{
			var levDat:TLevData;
			if (l) {
				levDat = new TLevData(
					l.id,
					l.name,
					l.author,
					l.code
				)
			} else {
				levDat = new TLevData(
					LevelDatabase.generateEditorId(),
					"Empty Slot",
					"",
					LevelDatabase.EMPTY_LEVEL_CODE
				)
				levDat.thumbnail.visible = false;
				levDat.isFauxLevel = true;
			}

			levDat.x = 51
			levDat.y=_y + 1
			levelsArr.push(levDat)
			gfx.addChild(levDat)
		}
	}
}
