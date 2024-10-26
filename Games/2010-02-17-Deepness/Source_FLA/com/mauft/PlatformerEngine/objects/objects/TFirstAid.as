/*Platformer Engine by Mauft.com
__TCoin__

Just your usual coin!
*/
package com.mauft.PlatformerEngine.objects.objects{
	import com.mauft.PlatformerEngine.Engine;
	import com.mauft.PlatformerEngine.Geometry;
	import com.mauft.PlatformerEngine.Settings;
	import com.mauft.PlatformerEngine.objects.TObject;
	import com.mauft.PlatformerEngine.objects.effects.TMessage;
	
	import flash.display.MovieClip;
	
	public final class TFirstAid extends TObject	{
		private var ___anim:uint=0		//For animation
		private var _sector:uint
		public function TFirstAid(_x:Number, _y:Number, _gfx:MovieClip){
			gfx=_gfx
			gfx.parent.removeChild(gfx)
			Engine.layerObjects.addChild(gfx)
			
			x=_x
			y=_y
			
			_sector=Math.floor(x/Settings.SCREEN_WIDTH)+Math.floor(y/Settings.SCREEN_HEIGHT)*5
			
			width=20
			height=10
			
			Push(0,Settings.TILE_HEIGHT)
			
			gfx.x=x
			gfx.y=y
			
			Engine.listObjects.push(this)
		}
		override public function Step():void{
			/*
			___anim++
			if (___anim==6){
				___anim=0
				gfx.gotoAndStop(gfx.currentFrame==3?1:gfx.currentFrame+1)
			}
			*/
			if (Engine.player.sector==_sector && Geometry.RectRect1(this,Engine.player)){
				Engine.removeObject(this)
				gfx.parent.removeChild(gfx)
				Engine.player.aidKit()
			}
		}
	}
}