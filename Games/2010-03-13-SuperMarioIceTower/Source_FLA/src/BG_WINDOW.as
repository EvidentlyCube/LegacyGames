package src{
	import flash.display.MovieClip
	import flash.events.Event
	public class BG_WINDOW extends MovieClip{
		public function BG_WINDOW(_x:Number, _y:Number){
			x=_x
			y=_y
			addEventListener(Event.ENTER_FRAME, step)
			addEventListener(Event.REMOVED_FROM_STAGE, kill)
		}
		public function step(e:Event):void{
			
			if (y>Main.lev_y/3+600){
				Main.bg.removeChild(this)
			}
		}
		public function kill(e:Event):void{
			removeEventListener(Event.ENTER_FRAME, step)
			removeEventListener(Event.REMOVED_FROM_STAGE, kill)
		}
	}
}