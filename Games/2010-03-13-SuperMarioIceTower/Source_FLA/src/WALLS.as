package src{
	import flash.display.MovieClip;
	import flash.events.Event;
	public class WALLS extends MovieClip{
		private var id:uint
		public function WALLS(_id:uint):void{
			id=_id
			y=(-Main.lev_y+id*364)%1092-364
			addEventListener(Event.ENTER_FRAME, step)
			addEventListener(Event.REMOVED_FROM_STAGE, kill)
		}
		private function step(e:Event):void{
			y=(-Main.lev_y+id*364)%1092-364
		}
		private function kill(e:Event):void{
			removeEventListener(Event.ENTER_FRAME, step)
			removeEventListener(Event.REMOVED_FROM_STAGE, kill)
		}
	}
}