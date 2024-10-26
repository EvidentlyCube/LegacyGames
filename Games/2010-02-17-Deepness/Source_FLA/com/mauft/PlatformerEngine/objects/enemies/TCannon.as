package com.mauft.PlatformerEngine.objects.enemies{
	import com.mauft.PlatformerEngine.Engine;
	import com.mauft.PlatformerEngine.Settings;
	import com.mauft.PlatformerEngine.objects.SFX;
	import com.mauft.PlatformerEngine.objects.TEnemy;
	import com.mauft.PlatformerEngine.objects.effects.TDebris;
	import com.mauft.PlatformerEngine.objects.effects.TFlame;
	import com.mauft.PlatformerEngine.objects.effects.TMessage;
	import com.mauft.PlatformerEngine.objects.objects.TFireBullet;
	
	import flash.display.BlendMode;
	import flash.display.MovieClip;

	public class TCannon extends TEnemy{
		override public function get xMod():Number{return 4}
		override public function get yMod():Number{return 4}
		private var type:uint
		private var timer:uint=0
		private var midX:Number
		private var midY:Number
		private var midGfx:MovieClip
		public function TCannon(setX:Number, setY:Number, _gfx:MovieClip, _type:uint){
			x=setX+4
			y=setY+4
			
			midX=x+8.5
			midY=y+8.5

			_sector=Math.floor(x/Settings.SCREEN_WIDTH)+Math.floor(y/Settings.SCREEN_HEIGHT)*5
			type=_type
			
			width=17
			height=17
			
			_hp=15
			
			gfx=_gfx
			gfx.parent.removeChild(gfx)
			___CT=gfx.transform.colorTransform
			Engine.layerEnemies.addChild(gfx)
			
			midGfx=new MC_BULLET_FIREBALL
			midGfx.x=midX
			midGfx.y=midY
			midGfx.alpha=0
			midGfx.blendMode=BlendMode.SCREEN
			Engine.layerEnemies.addChild(midGfx)
			
			gfx.x=x-xMod
			gfx.y=y-yMod
			
			Engine.listEnemies.push(this)
		}
		override public function Update():void{
			timer++
			if (midGfx.alpha<1){midGfx.alpha+=0.005}
			if (timer>200){
				if (Math.random()<timer/20000){
					timer=0
					midGfx.alpha=0
					if (SFX.sfx){SFX.CANNON.play()}
					var an:Number
					switch(type){
						case(0)://Single Bullet Slow
							new TFireBullet(midX,midY,Math.atan2(Engine.player.midY-midY,Engine.player.midX-midX)*180/Math.PI,2)
							break;
						case(1)://Single Bullet Fast
							new TFireBullet(midX,midY,Math.atan2(Engine.player.midY-midY,Engine.player.midX-midX)*180/Math.PI,5)
							break;
						case(2)://Triple Bullet Fast
							an=Math.atan2(Engine.player.midY-midY,Engine.player.midX-midX)*180/Math.PI
							new TFireBullet(midX,midY,an,3.5)
							new TFireBullet(midX,midY,an-45,3.5)
							new TFireBullet(midX,midY,an+45,3.5)
							break;
						case(3)://Triple Bullet Seq
							an=Math.atan2(Engine.player.midY-midY,Engine.player.midX-midX)*180/Math.PI
							new TFireBullet(midX,midY,an,4)
							new TFireBullet(midX,midY,an,3)
							new TFireBullet(midX,midY,an,2)
							break;
					}
				}
			}
			blinkUpdate()
		}
		override public function damage(_dam:uint):void{
			_hp-=_dam
			if (_hp<=0){
				if (SFX.sfx){SFX.CHOPPER_CRASH.play()}
				new TMessage(midX,y,"Destroyed!", 0xFF6666)
				for (var i:uint=0;i<15;i++){
					new TDebris(midX,midY,Math.random()*360,Math.random()*4+1,150)
					if(i<8){new TFlame(midX,midY,Math.random()*360,Math.random()*2,Math.random()/3+0.2)}
				}
				new TMessage(Engine.player.midX,Engine.player.y, "+"+(10+4*type).toString()+" Points", 0x66FF66)
				Engine.enemyPoints+=10+4*type
				gfx.gotoAndStop(2)
				___CT.redOffset=0
				___CT.greenOffset=0
				___CT.blueOffset=0
				gfx.transform.colorTransform=___CT
				Engine.layerEnemies.removeChild(gfx)
				Engine.layerEnemies.removeChild(midGfx)
				Engine.layerTiles.addChild(gfx)
				Engine.removeEnemy(this)
				Engine.fillSector(gfx,_sector)
			} else {
				if (SFX.sfx){SFX.CHOPPER_HIT.play()}
				new TMessage(midX,y,_hp.toString()+" HP", 0xFF6666)
				blink()
			}
		}
	}
}