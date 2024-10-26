package src{
	import flash.display.MovieClip
	import flash.events.Event
	public class BG_LANTERN extends MovieClip{
		private var LL:MovieClip
		private var c:Number=0
		public function BG_LANTERN(_x:Number, _y:Number){
			x=_x
			y=_y
			addEventListener(Event.ENTER_FRAME, step)
			addEventListener(Event.REMOVED_FROM_STAGE, kill)
		}
		public function step(e:Event):void{
			c+=Math.PI/(60+y%31)
			LL.scaleX=LL.scaleY=1+Math.sin(c)/4
		}
		public function kill(e:Event):void{
			removeEventListener(Event.ENTER_FRAME, step)
			removeEventListener(Event.REMOVED_FROM_STAGE, kill)
		}
	}
}