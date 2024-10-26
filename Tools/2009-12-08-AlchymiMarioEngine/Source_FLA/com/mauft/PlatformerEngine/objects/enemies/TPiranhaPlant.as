/*Platformer Engine by Mauft.com
__TPiranhaPlant__

The hide-show enemy.
*/
package com.mauft.PlatformerEngine.objects.enemies{
	import com.mauft.PlatformerEngine.DebugDraw;
	import com.mauft.PlatformerEngine.Engine;
	import com.mauft.PlatformerEngine.Geometry;
	import com.mauft.PlatformerEngine.Settings;
	import com.mauft.PlatformerEngine.objects.TEnemy;
	
	import flash.display.MovieClip;
	public class TPiranhaPlant extends TEnemy{
		override public function get xMod():Number{return 2}
		override public function get yMod():Number{return 0}
		private var _state:uint=0
		private var _timer:uint=0
		private var ___anim:uint=0
		public function TPiranhaPlant(setX:Number, setY:Number, _gfx:MovieClip){
			x=setX
			y=setY
			
			width=21
			height=33
			
			gfx=_gfx
			gfx.parent.removeChild(gfx)
			Engine.layerEnemies.addChild(gfx)
			
			Engine.listEnemies.push(this)
		}
		override public function Update():void{
			/*STATE:
			0 - Waits on top
			1 - Slides in
			2 - Waits inside
			3 - Slides out
			*/

			switch (_state){
				case(0):
					_timer++
					if (_timer==100){
						_timer=0
						_state=1
					}
					break;
				case(1):
					y++
					_timer++
					if (_timer==40){
						_timer=0
						_state=2
					}
					break;
				case(2):
					_timer++
					if (_timer>120 && (Engine.player.x<x-Settings.TILE_WIDTH*2 || Engine.player.x>x+width+Settings.TILE_WIDTH*2)){//Wait until player is far enough
						_timer=0
						_state=3
					}
					break;
				case(3):
					_timer++
					y--
					if (_timer==40){
						_timer=0
						_state=0
					}
					break;
			}
			DebugDraw.Rect(x,y,width,height)
			if (Geometry.RectRect1(this,Engine.player)){
				Engine.player.Damaged()
			}
			gfx.x=x-xMod
			gfx.y=y-yMod
			___anim++
			if (___anim==15){
				___anim=0
				gfx.gotoAndStop(3-gfx.currentFrame)
			}
		}
	}
}