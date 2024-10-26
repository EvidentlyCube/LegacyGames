package Classes.Menu{
	import Classes.GFX;

	import flash.display.Sprite;

	import mx.core.BitmapAsset;
	public class WindowHandler{
		private static var windowsList: Array = new Array()
		private static var darkened: Boolean = false
		public function WindowHandler(){}
		public static function Update(): void{
			if (windowsList.length > 0){
				var wins: Sprite = TD.windows
				if (!darkened){
					var bAsset: BitmapAsset = new (GFX.dark)
					wins.graphics.beginBitmapFill(bAsset.bitmapData)
					wins.graphics.drawRect(0, 0,600, 600)
					wins.graphics.endFill()
					darkened = true
				}
				if (wins.numChildren == 0){
					wins.addChild(windowsList[0])
				}
			} else if(darkened){
				TD.windows.graphics.clear()
				darkened = false
			}
		}
		public static function get winCount(): uint{
			return windowsList.length;
		}
		public static function newWindow(win: TWindow): void{
			windowsList.push(win)
			Update()
		}
		public static function popWindow(): void{
			TD.hotkeys = true
			if (windowsList.length > 0){
				var wins: Sprite = TD.windows
				if (wins.contains(windowsList[0])){
					wins.removeChildAt(0)
					windowsList.shift()
				}
			}
		}
		public static function removeWindow(window: *): void {
			var index: Number = windowsList.indexOf(window);
			if (index !== -1) {
				windowsList.splice(index, 1);
			}

			if (TD.windows.contains(window)) {
				TD.windows.removeChild(window);
			}

		}
	}
}