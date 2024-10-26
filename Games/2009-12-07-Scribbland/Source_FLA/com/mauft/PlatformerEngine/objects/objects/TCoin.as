package com.mauft.PlatformerEngine.objects.objects{
	import com.mauft.PlatformerEngine.Engine;
	import com.mauft.PlatformerEngine.Geometry;
	import com.mauft.PlatformerEngine.objects.SFX;
	
	import flash.display.MovieClip;
	public class TCoin{
		private var gfx:MovieClip
		private var spd:Number
		private var num:Number=0
		private var size:Number
		private var y:Number
		public function TCoin(_gfx:MovieClip){
			gfx=_gfx
			gfx.parent.removeChild(gfx)
			Engine.layerBackground.addChild(gfx)
			
			spd=(Math.random()-Math.random())*Math.PI/20
			size=Math.random()*4
			
			y=gfx.y
			Engine.listObjects.push(this)
		}
		public function Step():void{
			num+=spd
			gfx.y=Math.round(y+Math.sin(num)*size)
			if (gfx.alpha>0 && Geometry.RectRect3(gfx.x-7, gfx.y-11, 15, 15, Engine.player)){
				Engine.gotCoin()
				SFX.playClock()
				gfx.alpha=0
			}
			if (gfx.alpha<1 && gfx.alpha>0){
				gfx.alpha+=Engine.started==2?0.1:0.01	
			}
		}
		public function Reappear():void{
			if (gfx.alpha==0){gfx.alpha=0.01}
		}
	}
}