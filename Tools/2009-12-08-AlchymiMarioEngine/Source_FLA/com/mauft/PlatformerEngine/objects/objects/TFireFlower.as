/*Platformer Engine by Mauft.com
__TFireFlower__

The fire flower bonus. It just pops, leaves the bonus tile and checks to look for collision
*/
package com.mauft.PlatformerEngine.objects.objects{
	import com.mauft.PlatformerEngine.DebugDraw;
	import com.mauft.PlatformerEngine.Engine;
	import com.mauft.PlatformerEngine.Geometry;
	import com.mauft.PlatformerEngine.Settings;
	import com.mauft.PlatformerEngine.objects.TObject;
	
	public class TFireFlower extends TObject{
		override public function get xMod():Number{return -1}
		override public function get yMod():Number{return -2}
		private var _bounced:Boolean=false
		private var ___anim:uint=0
		private var ___slide:uint=0
		public function TFireFlower(setX:Number, setY:Number){
			x=setX+1
			y=setY+2
			
			gfx=new MC_FIREFLOWER
			
			width=23
			height=23
			
			Engine.layerObjects.addChild(gfx)
			Engine.listObjects.push(this)
		}
		override public function Step():void{
			if (___slide<Settings.TILE_HEIGHT){
				___slide++
				y--
				gfx.x=Math.round(x)-xMod
				gfx.y=Math.round(y)-yMod
			}

			if (Engine.player.sequence==0 && Geometry.RectRect1(this,Engine.player)){
				Engine.player.makeFlowery()
				Engine.removeObject(this)
				Engine.layerObjects.removeChild(gfx)
				return
			}
			
			gfx.x=Math.round(x)-xMod
			gfx.y=Math.round(y)-yMod
			
			___anim++
			if (___anim==4){
				gfx.gotoAndStop(gfx.currentFrame==4?1:gfx.currentFrame+1)
				___anim=0
			}
		} 
	}
}