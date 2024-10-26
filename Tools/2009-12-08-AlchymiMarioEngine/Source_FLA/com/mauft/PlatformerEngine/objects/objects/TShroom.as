/*Platformer Engine by Mauft.com
__TShroom__

This is the mushroom bonus, it leaves the bonus tile and start bouncing left-right looking for collision.
*/
package com.mauft.PlatformerEngine.objects.objects{
	import com.mauft.PlatformerEngine.DebugDraw;
	import com.mauft.PlatformerEngine.Engine;
	import com.mauft.PlatformerEngine.Geometry;
	import com.mauft.PlatformerEngine.Settings;
	import com.mauft.PlatformerEngine.objects.TObject;
	
	public class TShroom extends TObject{
		override public function get xMod():Number{return 0}
		override public function get yMod():Number{return 0}
		private var _bounced:Boolean=false
		private var ___anim:uint=0
		public function TShroom(setX:Number, setY:Number){
			x=setX+3
			y=setY+3
			
			gfx=new MC_SHROOM
			
			_speed=(Engine.player.x>x?1:-1)
			
			width=19
			height=22
			
			Engine.layerObjects.addChild(gfx)
			Engine.listObjects.push(this)
		}
		override public function Step():void{
			if (___anim<Settings.TILE_HEIGHT){
				___anim++
				y--
				gfx.x=Math.round(x)-xMod
				gfx.y=Math.round(y)-yMod
			} else {
				_bounced=false
				_gravity+=Settings.GRAVITY
	
				Push(_speed,_gravity)
				
				DebugDraw.Rect(x,y,width,height)
				
				if (Engine.player.sequence==0 && Geometry.RectRect1(this,Engine.player)){
					Engine.player.makeBig()
					Engine.removeObject(this)
					Engine.layerObjects.removeChild(gfx)
					return
				}
				
				gfx.x=Math.round(x)-xMod
				gfx.y=Math.round(y)-yMod
			}
		} 
		override public function StopHorizontal():void{
			if (_bounced){return}
			super.StopHorizontal()
			_speed*=-1
			_bounced=true
		}
	}
}