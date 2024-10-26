package com.mauft.PlatformerEngine.objects.enemies{
	import com.mauft.PlatformerEngine.Engine;
	import com.mauft.PlatformerEngine.Geometry;
	import com.mauft.PlatformerEngine.objects.effects.TObjectKilled;
	
	import flash.display.MovieClip;
	public class TSpinner{
		private var width:Number
		private var height:Number
		private var gfx:MovieClip
		private var x:uint
		private var y:uint
		public function TSpinner(setX:Number, setY:Number, _gfx:MovieClip){
			x=setX+5
			y=setY+5
			
			gfx=_gfx
			gfx.parent.removeChild(gfx)
			gfx.x=x
			gfx.y=y
			Engine.layerObjects.addChild(gfx)
			
			width=20
			height=20
			
			Engine.listObjects.push(this)
		}
		public function Step():void{
			if (Geometry.RectRect3(x, y, width, height, Engine.player)){
				Engine.player.kill()
			}
			if (gfx.alpha<1){gfx.alpha+=0.1}
			gfx.x=x-5
			gfx.y=y-5
		}
		public function Reappear():void{
			new TObjectKilled(gfx, Math.random()-Math.random(), -2-Math.random()*3)
			gfx=new _O_SPINNER
			gfx.mouseEnabled=false
			Engine.layerObjects.addChild(gfx)
			gfx.gotoAndStop(1)
			gfx.alpha=0
		}
	}
}