package Classes{
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard
	public class ControlsHandler{
		public static var UP:Boolean
		public static var DOWN:Boolean
		public static var LEFT:Boolean
		public static var RIGHT:Boolean
		public function ControlsHandler(){
			Game.STG.addEventListener(KeyboardEvent.KEY_DOWN,keyHit)
			Game.STG.addEventListener(KeyboardEvent.KEY_UP,keyUp)
		}
		public static function xTile():void{
			UP = false
			DOWN = false
			LEFT = false
			RIGHT = false
		}
		private function keyHit(e:KeyboardEvent):void{
			switch(e.keyCode){
				case(87):
				case(Keyboard.UP):
					UP = true
					break;
				case(83):
				case(Keyboard.DOWN):
					DOWN = true
					break
				case(65):
				case(Keyboard.LEFT):
					LEFT = true
					break
				case(68):
				case(Keyboard.RIGHT):
					RIGHT = true
					break
			}
		}
		private function keyUp(e:KeyboardEvent):void{
			switch(e.keyCode){
				case(87):
				case(Keyboard.UP):
					UP = false
					break;
				case(83):
				case(Keyboard.DOWN):
					DOWN = false
					break
				case(65):
				case(Keyboard.LEFT):
					LEFT = false
					break
				case(68):
				case(Keyboard.RIGHT):
					RIGHT = false
					break
			}
		}
	}
}