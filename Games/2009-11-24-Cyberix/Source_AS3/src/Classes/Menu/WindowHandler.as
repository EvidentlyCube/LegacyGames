package Classes.Menu{
	import Classes.GFX;

	import flash.display.Sprite;

	import mx.core.BitmapAsset;
	public class WindowHandler{
		private static var windowsList:Array = new Array()
		private static var darkened:Boolean = false
		public function WindowHandler(){
			var wins:Sprite = Game.windows
			var bAsset:BitmapAsset = new GFX.dark
			wins.graphics.beginBitmapFill(bAsset.bitmapData)
			wins.graphics.drawRect(0,0,600,600)
			wins.graphics.endFill()
			wins.alpha = 0
			wins.visible = false
		}
		public static function Update():void{
			var wins:Sprite = Game.windows
			if (windowsList.length > 0){
				if (wins.alpha < 1){
					wins.alpha += 0.1
				}
				if (!darkened){
					wins.visible = true
					darkened = true
					if (wins.numChildren > 0){
						wins.removeChildAt(0)
					}
				}
				if (wins.numChildren == 0){
					wins.addChild(windowsList[0])
				}
			} else if(wins.alpha > 0){
				//wins.graphics.clear()
				wins.alpha -= 0.1
				darkened = false
				if (wins.alpha <= 0){
					wins.visible = false
					if (wins.numChildren > 0){wins.removeChildAt(0)}
				}
			}
		}
		public static function get windowsCount():uint{
			return windowsList.length;
		}
		public static function newWindow(win:TWindow):void{
			windowsList.push(win)
			Update()
		}
		public static function popWindow():void{
			if (windowsList.length > 0){
				var wins:Sprite = Game.windows
				if (wins.contains(windowsList[0])){
					wins.removeChildAt(0)
					windowsList.shift()
				}
			}
		}
	}
}