/**/package{
	import flash.display.MovieClip
	import flash.events.Event
	import flash.display.Bitmap
	import flash.display.BitmapData
	public class T_Fall_FX extends MovieClip{
		private var speed:Number
		public function T_Fall_FX(_x:Number,_y:Number){
			addChild(new Bitmap(new B1(20,20)))
			x=_x
			y=_y
			Game.stg.addEventListener(Event.ENTER_FRAME,step)
		}
		private function step(e:Event):void{
			alpha-=0.1
			if (alpha<=0){
				Game.stg.removeEventListener(Event.ENTER_FRAME,step)
				parent.removeChild(this)
			}
		}
	}
}