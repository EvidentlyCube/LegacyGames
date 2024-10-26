/*Platformer Engine by Mauft.com
__TGoomba__

The major dumbass-enemy of all mario games.
*/

package com.mauft.PlatformerEngine.objects.enemies{
	import com.mauft.PlatformerEngine.DebugDraw;
	import com.mauft.PlatformerEngine.Engine;
	import com.mauft.PlatformerEngine.Settings;
	import com.mauft.PlatformerEngine.objects.TEnemy;
	import flash.display.MovieClip;
	
	public final class TGoomba extends TEnemy{
		override public function get xMod():Number{return -10}
		override public function get yMod():Number{return -20}

		private var _bounced:Boolean=false	//Has the enemy bounced already in this turn?
		private var _dead:Boolean=false		//Is the enemy in the "dying" sequence?
		
		private var ___anim:uint=0				//Aniation wise variable
		public function TGoomba(setX:Number, setY:Number, _gfx:MovieClip){
			x=setX
			y=setY
			
			width=20
			height=20
			
			_speed=1
			
			gfx=_gfx
			gfx.parent.removeChild(gfx)
			Engine.layerEnemies.addChild(gfx)
			
			Engine.listEnemies.push(this)
		}
		override public function Update():void{
			if (_dead){ //If the enemy is dying, let's make him disappear slowly...
				___anim++
				if (___anim>100){
					gfx.alpha-=0.03
					if (gfx.alpha<0){
						Engine.removeEnemy(this)
						Engine.layerEnemies.removeChild(gfx)	
					}
				}
			} else {
				_bounced=false

				_gravity+=Settings.GRAVITY
				_gravity=Math.min(_gravity,Settings.FALL)
				Push(_speed,_gravity)
				
				CheckBounce()	//Check when bouncing against enemies
				CheckPlayer()	//Check if colliding with player
				
				DebugDraw.Rect(x,y,width,height)	//Some debugging
				
				gfx.x=Math.round(x)-xMod
				gfx.y=Math.round(y)-yMod
				
				___anim++
				if (___anim==12){
					___anim=0
					gfx.scaleX*=-1
				}
			}
		}
		override public function StopHorizontal():void{
			if (_bounced){return}
			_speed*=-1
			_bounced=true
		}
		override public function hitFireball(dir:int):void{
			if (!_dead){
				super.hitFireball(dir)
			}
		}
		override public function hitShell(dir:int):void{
			if (!_dead){
				super.hitShell(dir)
			}
		}
		override public function Stomped():void{
			super.Stomped()
			_dead=true		//Set dying to true
			gfx.scaleY=0.2
			bounceTurning=false
			___anim=0
		}
	}
}