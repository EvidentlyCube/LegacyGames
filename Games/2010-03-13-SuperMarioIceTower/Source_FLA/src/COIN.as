package src{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundTransform;
	public class COIN extends MovieClip{
		private var ycza:Number
		private var c:Number
		private var d:Number
		private var cd:Number
		private var dd:Number
		private var dm:Number
		public function COIN(x:Number, y:Number):void{
			ycza=y
			this.x=Math.min(Math.max(100, x), 400)
			this.y=ycza-Main.lev_y

			
			c=Math.random()*Math.PI*2
			d=Math.random()*Math.PI*2
			cd=(Math.random()-Math.random())*Math.PI/20
			dd=(Math.random()-Math.random())*Math.PI/20
			dm=10+Math.random()*50
			scaleY=scaleX=0.7+Math.sin(c)*0.2
			rotation=Math.sin(d)*dm
			
			addEventListener(Event.ENTER_FRAME, step)
			Main.self.addChild(this)
		}
		public function step(e:Event):void{
			c+=cd
			d+=dd
			scaleY=scaleX=0.7+Math.sin(c)*0.2
			rotation=Math.sin(d)*dm
			y=ycza-Main.lev_y
			if (Main.pla){
				if (HitTest.hitTestObject(Main.pla.gfx, this)){
					removeEventListener(Event.ENTER_FRAME, step)
					Main.self.removeChild(this)
					Sound(new SFX_COIN).play(0, 0, new SoundTransform(Main.sfxVol/5))
					Main.coined()
				}
			}
			if (y>550){
				removeEventListener(Event.ENTER_FRAME, step)
					if (Main.self.contains(this)){Main.self.removeChild(this)}
			}
		}
	}
}