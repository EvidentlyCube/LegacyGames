/*Platformer Engine by Mauft.com
__TGoomba__

The major dumbass-enemy of all mario games.
*/

package com.mauft.PlatformerEngine.objects.enemies{
	import com.mauft.PlatformerEngine.DebugDraw;
	import com.mauft.PlatformerEngine.Engine;
	import com.mauft.PlatformerEngine.Geometry;
	import com.mauft.PlatformerEngine.Settings;
	import com.mauft.PlatformerEngine.TPath;
	import com.mauft.PlatformerEngine.objects.SFX;
	import com.mauft.PlatformerEngine.objects.TEnemy;
	import com.mauft.PlatformerEngine.objects.effects.TChopperFall;
	import com.mauft.PlatformerEngine.objects.effects.TDebris;
	import com.mauft.PlatformerEngine.objects.effects.TFlame;
	import com.mauft.PlatformerEngine.objects.effects.TMessage;
	
	public final class TChopperPath extends TEnemy{
		override public function get xMod():Number{return -5}
		override public function get yMod():Number{return -5}

		private var _dead:Boolean=false		//Is the enemy in the "dying" sequence?
		private var _path:TPath
		private var ___anim:uint=0				//Aniation wise variable
		public function TChopperPath(setX:Number, setY:Number, _p:TPath){
			x=setX
			y=setY
			
			_sector=Math.floor(x/Settings.SCREEN_WIDTH)+Math.floor(y/Settings.SCREEN_HEIGHT)*5
			_path=_p
			
			width=10
			height=11
			
			_hp=8
			
			_speed=1
			
			gfx=new MC_ENEMY_CHOPPER
			___CT=gfx.transform.colorTransform
			Engine.layerEnemies.addChild(gfx)
			
			Engine.listEnemies.push(this)
		}
		override public function Update():void{
			_path.update()
			x=_path.x
			y=_path.y
			___anim++
			if (Geometry.RectRect1(this,Engine.player)){
				Engine.player.Damaged(3)
			}
			if (___anim==3){
				gfx.gotoAndStop(gfx.currentFrame==6?1:gfx.currentFrame+1)
				___anim=0
			}
			gfx.x=x-xMod
			gfx.y=y-yMod
			blinkUpdate()
			DebugDraw.Rect(x,y,width,height)
		}
		override public function damage(_dam:uint):void{
			super.damage(_dam)
			if (_hp<=0){
				if (SFX.sfx){SFX.CHOPPER_KILL.play()}
				new TMessage(x,y,"Destroyed!",0xFF6666)
				new TMessage(Engine.player.midX,Engine.player.y, "+3 Points", 0x66FF66)
				Engine.enemyPoints+=3
				Engine.removeEnemy(this)
				Engine.layerEnemies.removeChild(gfx)
				new TChopperFall(x-xMod,y-yMod,gfx)
				for (var i:uint=0;i<3;i++){
					new TDebris(x-xMod,y-yMod,-Math.random()*360,1+Math.random()*4,50)
					new TFlame(x-xMod,y-yMod,Math.random()*360,Math.random(),Math.random()/4+0.1)
				}
			} else {
				if (SFX.sfx){SFX.CHOPPER_HIT.play()}
				new TDebris(x-xMod,y-yMod,-Math.random()*180,1+Math.random()*4,20)
				new TMessage(x,y,_hp.toString()+" HP",0xFF6666)
				blink()
			}
		}
	}
}