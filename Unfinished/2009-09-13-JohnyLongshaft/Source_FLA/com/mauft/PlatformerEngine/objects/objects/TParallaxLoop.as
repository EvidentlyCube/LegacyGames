/*Platformer Engine by Mauft.com
__TParallaxLoop__

This class takes two identical MovieClips and turns them into parallaxly moving background.
_percentage is a value between 0 and 1. The smaller it is, the slower the background moves.
*/
package com.mauft.PlatformerEngine.objects.objects{
	import com.mauft.PlatformerEngine.Engine;
	import com.mauft.PlatformerEngine.Settings;
	
	import flash.display.MovieClip;
	
	public class TParallaxLoop	{
		private var gfx1:MovieClip
		private var gfx2:MovieClip
		private var percentage:Number
		public function TParallaxLoop(_gfx1:MovieClip, _gfx2:MovieClip, _percentage:Number){
			gfx1=_gfx1
			gfx2=_gfx2
			percentage=_percentage
			gfx1.parent.removeChild(gfx1)
			gfx2.parent.removeChild(gfx2)
			Engine.layerParallax.addChildAt(gfx1,0)
			Engine.layerParallax.addChildAt(gfx2,0)
			Engine.listObjects.push(this)
		}
		public function Step():void{
			gfx1.x=-(-Engine.scrollX*percentage)%Settings.SCREEN_WIDTH
			gfx2.x=Settings.SCREEN_WIDTH-(-Engine.scrollX*percentage)%Settings.SCREEN_WIDTH
		}
	}
}