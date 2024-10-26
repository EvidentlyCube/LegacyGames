/*Platformer Engine by Mauft.com
__TBackground__

An animated background object. You just pass the graphic and aniation speed!
For static ones, check the .Fla->Library->BACKGROUND_FENCE_LEFT
*/

package com.mauft.PlatformerEngine.objects.objects{
	import com.mauft.PlatformerEngine.Engine;
	import com.mauft.PlatformerEngine.Settings;
	
	import flash.display.MovieClip;
	
	public class TBackground{
		private var _gfx:MovieClip
		public function TBackground(gfx:MovieClip){
			_gfx=gfx
			Engine.listObjects.push(this)
		}
		public function Step():void{
			_gfx.x=Math.floor(Engine.player.x/Settings.SCREEN_WIDTH)*Settings.SCREEN_WIDTH
			_gfx.y=Math.floor(Engine.player.y/Settings.SCREEN_HEIGHT)*Settings.SCREEN_HEIGHT
		}
	}
}