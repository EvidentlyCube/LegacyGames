package com.mauft.PlatformerEngine.objects.objects{
	import com.mauft.PlatformerEngine.Engine;
	import com.mauft.PlatformerEngine.Settings;
	
	import flash.display.MovieClip;
	public class TBgRose{
		private var gfx:MovieClip
		private var ___step:Number
		private var ___ang:Number
		private var ___speed:Number
		public function TBgRose(setX:Number, setY:Number, _gfx:MovieClip){
			gfx=_gfx
			gfx.x=setX
			gfx.y=setY
			if (Math.random()<0.5){
				gfx.scaleX=-1
			}
			
			___step=Math.random()*Math.PI*2
			___ang=Math.random()*40
			___speed=Math.random()*Math.PI/120

			Engine.listObjects.push(this)
		}
		public function Step():void{
			___step+=___speed
			gfx.rotation=Math.sin(___step)*___ang
		}
	}
}