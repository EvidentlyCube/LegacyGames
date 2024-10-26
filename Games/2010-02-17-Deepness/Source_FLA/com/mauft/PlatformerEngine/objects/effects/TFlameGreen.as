package com.mauft.PlatformerEngine.objects.effects{
	import com.mauft.PlatformerEngine.Engine;
	
	import flash.display.BlendMode;
	import flash.display.MovieClip;
	import flash.geom.ColorTransform;
	
	public class TFlameGreen{
		private var x:Number
		private var y:Number
		private var moveX:Number
		private var moveY:Number
		private var gfx:MovieClip
		private var ___anim:Number=0
		private var ___life:Number
		public function TFlameGreen(_x:Number, _y:Number, _ang:Number, _spd:Number, _scale:Number){
			x=_x
			y=_y
			moveX=Math.cos(_ang*Math.PI/180)*_spd
			moveY=Math.sin(_ang*Math.PI/180)*_spd
			
			switch(Math.floor(Math.random()*8)){
				case(0):gfx=new MC_EXPLO_00;break;
				case(1):gfx=new MC_EXPLO_01;break;
				case(2):gfx=new MC_EXPLO_02;break;
				case(3):gfx=new MC_EXPLO_03;break;
				case(4):gfx=new MC_EXPLO_04;break;
				case(5):gfx=new MC_EXPLO_05;break;
				case(6):gfx=new MC_EXPLO_06;break;
				case(7):gfx=new MC_EXPLO_07;break;
			}
			gfx.scaleX=gfx.scaleY=_scale
			gfx.blendMode=BlendMode.SCREEN
			gfx.x=x
			gfx.y=y
			gfx.rotation=Math.random()*360
			
			var ct:ColorTransform=gfx.transform.colorTransform
			ct.redMultiplier=0
			ct.greenMultiplier=1
			ct.blueMultiplier=0
			gfx.transform.colorTransform=ct
			
			___life=14+Math.random()*14
			
			Engine.listObjects.push(this)
			Engine.layerObjects.addChild(gfx)
		}
		public function Step():void{
			x+=moveX
			y+=moveY
			moveX*=0.98
			moveY*=0.98
			
			___anim++
			if (___anim>=___life){
				Engine.removeObject(this)
				Engine.layerObjects.removeChild(gfx)
				return
			}
			
			gfx.x=x
			gfx.y=y
			gfx.gotoAndStop(Math.floor(___anim*8/___life))
		}
	}
}