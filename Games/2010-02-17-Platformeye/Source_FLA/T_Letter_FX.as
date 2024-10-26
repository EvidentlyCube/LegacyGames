package{
	import flash.display.MovieClip
	import flash.events.Event
	import flash.display.Bitmap
	import flash.display.BitmapData
	public class T_Letter_FX extends MovieClip{
		private var speed:Number
		public function T_Letter_FX(_x:Number,_y:Number,_txt:String,_spd:Number){
			speed=_spd
			x=_x
			y=_y
			LETTER.text=_txt
			Game.stg.addEventListener(Event.ENTER_FRAME,step)
		}
		private function step(e:Event):void{
			y+=speed
			alpha-=0.02
			if (alpha<=0){
				Game.stg.removeEventListener(Event.ENTER_FRAME,step)
				parent.removeChild(this)
			}
		}
	}
}