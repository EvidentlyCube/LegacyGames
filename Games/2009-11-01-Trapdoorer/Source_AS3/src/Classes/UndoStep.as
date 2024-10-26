package Classes{
	import Classes.Interactivers.TPlayer;
	import Classes.Items.TItem;

	import flash.display.Sprite;

	public class UndoStep{
		private var list: Array = new Array
		private var px: int = -1
		private var py: int = -1
		public function UndoStep() {
			px = TPlayer.x
			py = TPlayer.y
		}
		public function add(i: TItem): void{
			list.push(i)
		}
		public function undo(): void{
			if (px == -1 || py == -1 || !TPlayer.active){
				return
			}
			TPlayer.x = px
			TPlayer.y = py
			TPlayer.z = 0
			TPlayer.moveX = 0
			TPlayer.moveY = 0
			TPlayer.moveZ = 0
			for (var i: Number = 0; i < list.length; i++) {
				var item: TItem = list[i];
				if (item == null){continue}
				item.Undo()
			}
		}
	}
}