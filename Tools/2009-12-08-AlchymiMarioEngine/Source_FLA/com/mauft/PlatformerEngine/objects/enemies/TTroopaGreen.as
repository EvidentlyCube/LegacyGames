/*Platformer Engine by Mauft.com
__TTroopaGreen__

This is the Green Koopa Troopa, the enemy which once stomped on hides in the shell.
*/

package com.mauft.PlatformerEngine.objects.enemies{
	import com.mauft.PlatformerEngine.DebugDraw;
	import com.mauft.PlatformerEngine.Engine;
	import com.mauft.PlatformerEngine.Geometry;
	import com.mauft.PlatformerEngine.Settings;
	import com.mauft.PlatformerEngine.objects.TEnemy;
	
	import flash.display.MovieClip;
	
	public final class TTroopaGreen extends TEnemy{
		override public function get xMod():Number{return -10}
		override public function get yMod():Number{return 0}
		
		private var _bounced:Boolean=false
		private var _state:uint=0		//0 - Walks; 1 - Shell; 2 - Moving Shell
		private var _safe:uint=0
		
		private var ___anim:uint=0
		public function TTroopaGreen(setX:Number, setY:Number, _gfx:MovieClip){
			x=setX
			y=setY
			
			width=20
			height=21
			
			_speed=1
			
			gfx=_gfx
			gfx.parent.removeChild(gfx)
			Engine.layerEnemies.addChild(gfx)
			
			Engine.listEnemies.push(this)
		}
		override public function Update():void{
			switch(_state){
				case(0):	//Walks
					stopsShell=false
					_bounced=false
					_gravity+=Settings.GRAVITY
					_gravity=Math.min(_gravity,Settings.FALL)
					
					Push(_speed,_gravity)

					CheckBounce()
					CheckPlayer()
					
					DebugDraw.Rect(x,y,width,height)
					
					gfx.x=Math.round(x)-xMod
					gfx.y=Math.round(y)-yMod
					
					___anim++
					if (_speed>0){gfx.scaleX=1} else {gfx.scaleX=-1}
					if (___anim==12){
						___anim=0
						gfx.gotoAndStop(3-gfx.currentFrame)
					}
					break;
				case(1):	//Shell standing
					stopsShell=false
					_gravity+=Settings.GRAVITY

					Push(0,_gravity)
				
					CheckPlayer()
					___anim++
					DebugDraw.Rect(x,y,width,height)
					if (___anim>250){
						gfx.x=Math.round(x)-xMod+Math.sin(___anim/2)
						gfx.y=Math.round(y)-yMod
						if (___anim>400){	//Return to the Walking state!
							gfx.gotoAndStop(1)
							___anim=0
							if (Engine.player.x>x){_speed=1} else {_speed=-1}
							_state=0
						}
					} else {
						gfx.x=Math.round(x)-xMod
						gfx.y=Math.round(y)-yMod
					}
					break
				case(2):	//Shell moving
					stopsShell=true
					if (_safe>0){	//This makes sure that if you push the shell, it can't hurt you until it stops touching you, then it becames dangerous!
						_safe++
						if (_safe==3){_safe=0}
					}
					_bounced=false
					_gravity+=Settings.GRAVITY

					Push(_speed,_gravity)

					CheckBounce()
					CheckPlayer()
					DebugDraw.Rect(x,y,width,height)
					___anim++
					if (_speed>0){gfx.scaleX=1} else {gfx.scaleX=-1}
					if (___anim==3){
						___anim=0
						gfx.gotoAndStop(gfx.currentFrame==6?3:gfx.currentFrame+1)
					}
					gfx.x=Math.round(x)-xMod
					gfx.y=Math.round(y)-yMod
					break;
			}
		}
		override public function StopHorizontal():void{
			super.StopHorizontal()
			if (_bounced){return}
			_speed*=-1
			_bounced=true
		}
		override public function Bounce(dir:int=0):void{
			if (_state==0){super.Bounce(dir)}
		}
		override public function CheckBounce():void{
			if (_state<2){
				super.CheckBounce()
			} else { //if moving shell it kills enemies
				var e:TEnemy
				for (var i:uint;i<Engine.listEnemies.length;i++){
					e=Engine.listEnemies[i]
					if (e==this){continue}
					if (Geometry.RectRect1(this,e)){
						e.hitShell(_speed)
						if (e.blocksShell){_speed*=-1;}
						if (e.stopsShell){hitShell(-_speed)}	//If the enemy is a moving shell too, kill self
						return
					}
				}
			}
		}
		override public function Stomped():void{
			//super.Stomped()
			Engine.player.Stomped(y)
			switch(_state){
				case(0):	//Walking
					_state=1
					gfx.gotoAndStop(3)
					___anim=0
					break;
				case(1):	//Shell standing
					Touched()
					break;
				case(2):	//Shell moving
					_state=1
					___anim=0
					gfx.gotoAndStop(3)
					break;
			}
		}
		override public function Touched():void{
			switch(_state){
				case(0):	//Walking
					super.Touched()
					break;
				case(1):	//Shell Standing
					_safe=1
					_state=2
					___anim=0
					if (Engine.player.x+Engine.player.width/2<x+width/2){
						_speed=5
					} else {
						_speed=-5
					}
					break;
				case(2):	//Shell Moving
					if (_safe==0){
						super.Touched()
					} else {
						_safe=1
					}
					break;
			}
		}
	}
}