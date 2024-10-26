/*Platformer Engine by Mauft.com
__TFireball__

The fireball the player fires.
*/
package com.mauft.PlatformerEngine.objects.objects{
	import com.mauft.PlatformerEngine.DebugDraw;
	import com.mauft.PlatformerEngine.Engine;
	import com.mauft.PlatformerEngine.Geometry;
	import com.mauft.PlatformerEngine.Settings;
	import com.mauft.PlatformerEngine.objects.TEnemy;
	import com.mauft.PlatformerEngine.objects.TObject;
	
	public class TFireball extends TObject{
		override public function get xMod():Number{return -4}
		override public function get yMod():Number{return -4}
		public static var _count:uint=0
		private var _jumps:uint
		public function TFireball(setX:Number, setY:Number, dir:Number){
			_count++
			if (_count>Settings.FIREBALL_MAX){
				_count--
				return;
			}
			x=setX
			y=setY	
			
			width=8
			height=8
			
			_jumps=Settings.FIREBALL_BOUNCE_COUNT

			speed=dir>0?Settings.FIREBALL_SPEED:-Settings.FIREBALL_SPEED
			
			gfx=new MC_FIREBALL
			gfx.x=x-xMod
			gfx.y=y-yMod
			Engine.layerObjects.addChild(gfx)
			
			Engine.listObjects.push(this)
		}
		override public function Step():void{
			//Remove if beyond the screen
			if (!Geometry.RectRect3(x-Settings.SCREEN_WIDTH*2/3, y-Settings.SCREEN_HEIGHT*2/3, Settings.SCREEN_WIDTH*4/3, Settings.SCREEN_HEIGHT*4/3, Engine.player)){
				Kill()
				return
			}
			
			_gravity+=Settings.FIREBALL_GRAVITY
			_gravity=Math.min(_gravity,Settings.FIREBALL_FALL)
			
			Push(_speed,_gravity)
			
			//Check agains enemies
			var e:TEnemy
			for(var i:uint=0;i<Engine.listEnemies.length;i++){
				e=Engine.listEnemies[i]
				if (Geometry.RectRect1(this,e)){
					e.hitFireball(_speed)
					Kill()
					return
				}
			}
			
			gfx.x=x-xMod
			gfx.y=y-yMod
			gfx.rotation+=speed*5
			
			DebugDraw.Rect(x,y,width,height)
		}
		override public function StopJump():void{
			if (Settings.FIREBALL_HEADBUTT_KILLS){
				Kill()
			} else {
				super.StopJump()
				_gravity=0
			}
		}
		override public function StopFall():void{
			if (_gravity<0){return}
			if (_jumps==0){Kill();return}
			_jumps--
			var g:Number=_gravity*-1
			super.StopFall()
			_gravity=Math.max(g,-Settings.FIREBALL_JUMP)
		}
		override public function StopHorizontal():void{
			Kill()
		} 
		private function Kill():void{
			if (!Engine.layerObjects.contains(gfx)){return}
			Engine.removeObject(this)
			Engine.layerObjects.removeChild(gfx)
			_count--
		}
	}
}