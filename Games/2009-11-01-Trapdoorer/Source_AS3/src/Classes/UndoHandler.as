package Classes{
	import Classes.Interactivers.TPlayer;
	import Classes.Items.TItem;

	import flash.display.Sprite;

	public class UndoHandler{
		private static var steps: Array = new Array
		private static var _step: UndoStep = new UndoStep();
		public static function commitStep(): void {
			steps.push(_step);
			trace("Undo step committed")
			_step = new UndoStep();
		}
		public static function prune(): void{
			steps.length = 0;
			_step = new UndoStep();
		}
		public static function add(i: TItem): void{
			trace("Added to undo")
			_step.add(i);
		}
		public static function undo(): void{
			trace("Attempting undo")
			_step.undo();
			_step = steps.pop();
			if (!_step) {
				_step = new UndoStep();
			}
		}
	}
}