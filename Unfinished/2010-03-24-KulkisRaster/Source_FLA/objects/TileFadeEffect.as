package objects{
	import flash.display.MovieClip;
	
	public class TileFadeEffect extends Updaters{
		
		private var gfx:MovieClip;
		
		public function TileFadeEffect(gfx:MovieClip){
			this.gfx = gfx;
			
			Level.addObj(this);
		}
		
		override public function update():void{
			gfx.alpha -= 0.04;
			if (gfx.alpha <= 0){
				Level.remGFX(gfx);
				Level.remObj(this);
				trace('killa');
			}
		}
	}
}