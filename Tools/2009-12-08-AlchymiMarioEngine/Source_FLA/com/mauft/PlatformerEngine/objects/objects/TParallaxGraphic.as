/*Platformer Engine by Mauft.com
__TParallaxGraphic__

This class takes an image and turns it into parallax background object.
_percentage is a value between 0 and 1. The smaller it is, the slower the background moves.
*/
package com.mauft.PlatformerEngine.objects.objects{	
	import com.mauft.PlatformerEngine.Engine;
	import com.mauft.PlatformerEngine.Settings;
	
	import flash.display.MovieClip;
	
	public class TParallaxGraphic{
		private var x:Number
		private var gfx:MovieClip
		private var percentage:Number
		public function TParallaxGraphic(_x:Number, _gfx:MovieClip, _percentage:Number){
			x=_x
			gfx=_gfx
			percentage=_percentage
			gfx.parent.removeChild(gfx)
			Engine.layerParallax.addChild(gfx)
			Engine.listObjects.push(this)
		}
		public function Step():void{
			gfx.x=x-(-Engine.scrollX)*percentage
		}
	}
}