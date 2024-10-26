package com.mauft.PlatformerEngine.objects.effects{
	import com.mauft.PlatformerEngine.Engine;
	
	import flash.display.MovieClip;
	public class TLightTile{
		private var gfx:MovieClip
		private var tim:Number
		private var spd:Number
		private var broken:Number
		private var breaks:uint=0
		public function TLightTile(_gfx:MovieClip){
			gfx=_gfx

			tim=Math.random()*Math.PI
			spd=Math.random()*Math.PI/60
			broken=Math.random()

			Engine.listObjects.push(this)
		}
		public function Step():void{
			tim+=spd
			gfx.alpha=0.8+Math.sin(tim)*0.2
			if (breaks){
				breaks--
				gfx.alpha=0
				return
			}
			if (broken<0.2 && Math.random()<broken/5){gfx.alpha=0;breaks=5}
		}
	}
}