/*Platformer Engine by Mauft.com
__TCoin__

Just your usual coin!
*/
package com.mauft.PlatformerEngine.objects.objects{
	import com.mauft.PlatformerEngine.Engine;
	import com.mauft.PlatformerEngine.Geometry;
	import com.mauft.PlatformerEngine.Settings;
	import com.mauft.PlatformerEngine.objects.SFX;
	import com.mauft.PlatformerEngine.objects.TObject;
	import com.mauft.PlatformerEngine.objects.effects.TMessage;
	
	import flash.display.MovieClip;
	
	public final class TCoin extends TObject	{
		private var ___anim:uint=0		//For animation
		private var _sector:uint
		public function TCoin(_x:Number, _y:Number, _gfx:MovieClip){
			gfx=_gfx
			gfx.parent.removeChild(gfx)
			Engine.layerObjects.addChild(gfx)
			
			x=_x
			y=_y
			
			_sector=Math.floor(x/Settings.SCREEN_WIDTH)+Math.floor(y/Settings.SCREEN_HEIGHT)*5
			___anim=Math.floor(Math.random()*3)
			gfx.gotoAndStop(Math.floor(Math.random()*4+1))
			
			width=9
			height=9
			
			Push(0,Settings.TILE_HEIGHT)
			
			gfx.x=x
			gfx.y=y
			
			Engine.listObjects.push(this)
		}
		override public function Step():void{
			
			
			
			if (Engine.player.sector==_sector){
				___anim++
				if (___anim==4){
					___anim=0
					gfx.gotoAndStop(gfx.currentFrame==4?1:gfx.currentFrame+1)
				}
				if  (Geometry.RectRect1(this,Engine.player)){
					if (SFX.sfx){SFX.COIN.play()}
					Engine.removeObject(this)
					gfx.parent.removeChild(gfx)
					Engine.coinsCollected++
					new TMessage(Engine.player.midX,Engine.player.y, "Coin Collected", 0x66FF66)
				}
			}
		}
	}
}