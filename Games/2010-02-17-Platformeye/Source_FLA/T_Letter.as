package {
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.display.MovieClip;
	import flash.display.Bitmap
	import flash.events.MouseEvent
	public class T_Letter extends MovieClip {
		private var ltr:uint;
		private var vspd:Number
		public static var thereIs:uint=0;
		public function T_Letter(_x:uint,_y:uint):void {
			addChild(new Bitmap(new B1(20,20)))
			thereIs++;
			vspd=Math.random()*3+1
			Game.stg.addEventListener(Event.ENTER_FRAME,step);
			x=_x
			y=_y
			alpha=0
		}
		private function step(e:Event):void{
			if (alpha<1){alpha+=0.1}
		}
		public function kill():void {
			parent.removeChild(this);
			Game.stg.removeEventListener(Event.ENTER_FRAME,step);
			Game.makeEffect(x,y)
			thereIs--;
		}
	}
}