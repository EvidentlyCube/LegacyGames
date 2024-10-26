/*Platformer Engine by Mauft.com
__TCoin__

Just your usual coin!
*/
package com.mauft.PlatformerEngine.objects.objects{
	import com.mauft.PlatformerEngine.DebugDraw;
	import com.mauft.PlatformerEngine.Engine;
	import com.mauft.PlatformerEngine.Geometry;
	import com.mauft.PlatformerEngine.objects.TObject;
	import flash.display.MovieClip;
	
	public final class TCoin extends TObject	{
		private var ___anim:uint=0		//For animation
		public function TCoin(_x:Number, _y:Number, _gfx:MovieClip){
			gfx=_gfx
			gfx.parent.removeChild(gfx)
			Engine.layerObjects.addChild(gfx)
			
			x=_x+6
			y=_y+3
			
			width=gfx.width-12
			height=gfx.height-6
			
			Engine.listObjects.push(this)
		}
		override public function Step():void{
			___anim++
			if (___anim==6){
				___anim=0
				gfx.gotoAndStop(gfx.currentFrame==3?1:gfx.currentFrame+1)
			}
			if (Geometry.RectRect1(this,Engine.player)){		//If collides with player, remove
				Engine.removeObject(this)
				gfx.parent.removeChild(gfx)
			}
		}
	}
}