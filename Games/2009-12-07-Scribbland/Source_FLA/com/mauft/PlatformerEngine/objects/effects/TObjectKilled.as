package com.mauft.PlatformerEngine.objects.effects{
	import com.mauft.PlatformerEngine.Engine;
	import com.mauft.PlatformerEngine.Settings;
	
	import flash.display.MovieClip;
	public class TObjectKilled{
		private var gfx:MovieClip
		private var speed:Number
		private var gravity:Number=-3
		public function TObjectKilled(_gfx:MovieClip, _spd:Number, _grav:Number=-3){
			speed=_spd
			gravity=_grav
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