package com.mauft.PlatformerEngine.objects.effects{
	import com.mauft.PlatformerEngine.Engine;
	import com.mauft.PlatformerEngine.Settings;
	import com.mauft.PlatformerEngine.objects.TObject;
	
	import flash.display.MovieClip;
	public class TPlayerKilled{
		private var gfx:MovieClip
		private var speed:Number
		private var gravity:Number=-3
		public function TPlayerKilled(_gfx:MovieClip, _spd:Number){
			if (_spd>0){
				speed=-2
			} else if (_spd<0){
				speed=2
			} else {
				speed=_gfx.scaleX*-2
			}
			
			gfx=_gfx

			Engine.listObjects.push(this)
		}
		public function Step():void{
			gravity+=Settings.GRAVITY/2
			gfx.alpha-=Engine.started==2?0.1:0.01
			gfx.x+=speed
			gfx.y+=gravity
			if (gfx.alpha<0){
				gfx.parent.removeChild(gfx)
				Engine.removeObject(this)
			}
		}
		public function Reappear():void{}
	}
}