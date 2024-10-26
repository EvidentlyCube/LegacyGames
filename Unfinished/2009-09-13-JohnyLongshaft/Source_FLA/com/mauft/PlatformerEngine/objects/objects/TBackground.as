/*Platformer Engine by Mauft.com
__TBackground__

An animated background object. You just pass the graphic and aniation speed!
For static ones, check the .Fla->Library->BACKGROUND_FENCE_LEFT
*/

package com.mauft.PlatformerEngine.objects.objects{
	import com.mauft.PlatformerEngine.Engine;
	
	import flash.display.MovieClip;
	
	public class TBackground{
		private var gfx:MovieClip
		private var ___anim:uint=0
		private var ___animSpeed:uint
		public function TBackground(_gfx:MovieClip, _speed:uint){
			___animSpeed=_speed
			gfx=_gfx
			gfx.parent.removeChild(gfx)
			Engine.layerBackground.addChild(gfx)
			Engine.listObjects.push(this)
		}
		public function Step():void{
			___anim++
			if (___anim>=___animSpeed){
				___anim=0
				gfx.gotoAndStop(gfx.currentFrame==gfx.totalFrames?1:gfx.currentFrame+1)
			}
		}
	}
}