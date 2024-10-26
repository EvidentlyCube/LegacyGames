package src{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundTransform;
	public class CIUF extends MovieClip{
		private var ycza:Number
		private var r:Number;
		private var s:Number;
		private var a:Number;
		public function CIUF(x:Number, y:Number):void{
			ycza = y-Math.random()*25
			this.x=x+Math.random()*15//-Math.random()*15
			this.y=ycza-Main.lev_y

			rotation = Math.random()*360
			scaleX = scaleY = 1-Math.random()/10;
			
			r = Math.random()*5 - Math.random()*5;
			a = Math.random()/50
			s = 1-Math.random()/10;
			addEventListener(Event.ENTER_FRAME, step)
			Main.self.addChildAt(this, 0)
		}
		public function step(e:Event):void{
			rotation += r;
			scaleX *= s;
			scaleY *= s;
			alpha -= a;
			
			y=ycza-Main.lev_y
			
			if (y>550 || a<=0){
				removeEventListener(Event.ENTER_FRAME, step)
					if (Main.self.contains(this)){Main.self.removeChild(this)}
			}
		}
	}
}