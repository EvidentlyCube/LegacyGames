package com.mauft.PlatformerEngine.objects.enemies{
	import com.mauft.PlatformerEngine.Engine;
	import com.mauft.PlatformerEngine.Geometry;
	import com.mauft.PlatformerEngine.Settings;
	import com.mauft.PlatformerEngine.objects.SFX;
	import com.mauft.PlatformerEngine.objects.TEnemy;
	import com.mauft.PlatformerEngine.objects.effects.TFlameGreen;
	import com.mauft.PlatformerEngine.objects.effects.TMessage;
	
	import flash.display.MovieClip;

	public class TBlob4 extends TEnemy{
		override public function get xMod():Number{return -8}
		override public function get yMod():Number{return -19}
		private var _sequence:uint=1
		private var _timer:Number=0
		public function TBlob4(setX:Number, setY:Number, _gfx:MovieClip){
			x=setX
			y=setY
			
			_hp=10
			
			_sector=Math.floor(x/Settings.SCREEN_WIDTH)+Math.floor(y/Settings.SCREEN_HEIGHT)*5
			
			width=16
			height=16
			
			gfx=_gfx
			gfx.parent.removeChild(gfx)
			Engine.layerEnemies.addChild(gfx)
			
			___CT=gfx.transform.colorTransform
			
			Engine.listEnemies.push(this)
		}
		override public function Update():void{
			switch(_sequence){
				case(0):
					_timer+=Math.PI/10
					gfx.scaleX=1+Math.sin(_timer)/2
					gfx.scaleY=1-Math.sin(_timer)/2
					if (_timer>=Math.PI){
						gfx.scaleX=1
						gfx.scaleY=1
						_timer=0
						_gravity=-5-Math.random()*5
						_sequence=1
					}
					break;
				case(1):
					if (Engine.player.x>x){
						if (_speed<4){_speed+=0.05}
					}
					if (Engine.player.x<x){
						if (_speed>-4){_speed-=0.05}
					}
					_gravity+=Settings.GRAVITY
					Push(_speed,_gravity)
					if (Geometry.RectRect1(this,Engine.player)){
						Engine.player.Damaged(4)
					}
					break
			}
			gfx.x=x-xMod
			gfx.y=y-yMod
			blinkUpdate()
		}
		override public function StopFall():void{
			super.StopFall()
			_timer=0
			_gravity=0
			_sequence=0
		}
		override public function StopHorizontal():void{
			super.StopHorizontal()
			_speed*=-0.9
		}
		override public function damage(_dam:uint):void{
			super.damage(_dam)
			if (_hp<=0){
				if (SFX.sfx){SFX.BLOB_KILL.play()}
				new TMessage(x-xMod,y-yMod/2,"Killed!",0xFF6666)
				new TMessage(Engine.player.midX,Engine.player.y, "+30 Points", 0x66FF66)
				Engine.enemyPoints+=30
				Engine.removeEnemy(this)
				Engine.layerEnemies.removeChild(gfx)
				for (var i:uint=0;i<10;i++){
					new TFlameGreen(x-xMod,y-yMod/2,Math.random()*360,Math.random(),Math.random()/4+0.1)
				}
			} else {
				new TFlameGreen(x-xMod,y-yMod/2,Math.random()*360,Math.random(),Math.random()/4+0.1)
				new TMessage(x-xMod,y-yMod/2,_hp.toString()+" HP",0xFF6666)
				blink()
				if (SFX.sfx){SFX.BLOB_HIT.play()}
			}
		}
	}
}