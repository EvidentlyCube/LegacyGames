/*Platformer Engine by Mauft.com
__TFallObject__

This is just an effect object. Note you don't have to extends TObject even if you want to push it to listObjects! You only need a Step() function.
*/

package com.mauft.PlatformerEngine.objects.effects{
	import com.mauft.PlatformerEngine.Engine;
	import com.mauft.PlatformerEngine.Settings;
	import com.mauft.PlatformerEngine.objects.SFX;
	import com.mauft.PlatformerEngine.objects.TObject;
	
	import flash.display.MovieClip;
	
	public class TChopperFall extends TObject {
		private var ___anim:uint=0
		private var ___flame:uint=0
		public function TChopperFall(setX:Number, setY:Number, _gfx:MovieClip){
			x=setX
			y=setY
			_gravity=0
			_speed=(1+Math.random())*(Math.random()<0.5?1:-1)
			gfx=_gfx
			Engine.layerObjects.addChild(gfx)
			Engine.listObjects.push(this)
		}
		override public function Step():void{
			_gravity+=Settings.GRAVITY/3
			Push(0,_gravity)
			
			gfx.x=x
			gfx.y=y
			gfx.rotation+=_speed
			___anim++
			___flame++
			if (___flame==13){
				___flame=0
				new TFlame(x,y,-70-Math.random()*40,Math.random()+1,0.2)
			}
			if (___anim==3){
				gfx.gotoAndStop(gfx.currentFrame==6?1:gfx.currentFrame+1)
				___anim=0
			}
		}
		override public function StopFall():void{
			if (SFX.sfx){SFX.CHOPPER_CRASH.play()}
			super.StopFall()
			Engine.removeObject(this)
			Engine.layerObjects.removeChild(gfx)
			for (var i:uint=0;i<10;i++){
				new TDebris(x,y,Math.random()*360,Math.random()*4+1,150)
				if(i<5){new TFlame(x,y,Math.random()*360,Math.random()*2,Math.random()/3+0.2)}
			}
		}
	}
}