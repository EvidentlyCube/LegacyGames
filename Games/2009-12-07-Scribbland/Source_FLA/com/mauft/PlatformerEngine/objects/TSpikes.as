package com.mauft.PlatformerEngine.objects{	
	import com.mauft.PlatformerEngine.Engine;
	import com.mauft.PlatformerEngine.Geometry;
	import com.mauft.PlatformerEngine.Settings;
	
	import flash.display.MovieClip;
	public class TSpikes{
		private var x:Number
		private var y:Number
		private var gfx:MovieClip
		private var down:Boolean
		public function TSpikes(setX:Number, setY:Number, _gfx:MovieClip, _down:Boolean=false){
			x=setX
			y=setY+(_down?15:0)
			down=_down
			
			gfx=_gfx
			gfx.parent.removeChild(gfx)
			Engine.layerObjects.addChild(gfx)
			
			Engine.listObjects.push(this)
		}
		public function Step():void{
			if (Geometry.RectRect3(x,y,30,15,Engine.player) && ((down && Engine.player.gravity>0) || (Engine.player.gravity<0 && !down))){
				Engine.player.kill()
			}
		}
		public function Reappear():void{}
	}
}