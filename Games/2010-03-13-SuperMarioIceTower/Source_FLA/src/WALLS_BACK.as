package src{
	import flash.display.MovieClip;
	import flash.events.Event;
	public class WALLS_BACK extends MovieClip{
		private var id:uint
		public function WALLS_BACK(_id:uint):void{
			id=_id
			y=(-Main.lev_y/3+id*364)%1092-364
			addEventListener(Event.ENTER_FRAME, step)
			addEventListener(Event.REMOVED_FROM_STAGE, kill)
		}
		private function step(e:Event):void{
			y=(-Main.lev_y/3+id*364)%1092-364
		}
		private function kill(e:Event):void{
			removeEventListener(Event.ENTER_FRAME, step)
			removeEventListener(Event.REMOVED_FROM_STAGE, kill)
		}
	}
}