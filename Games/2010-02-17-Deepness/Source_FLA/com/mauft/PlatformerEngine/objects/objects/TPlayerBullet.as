package com.mauft.PlatformerEngine.objects.objects {
	import com.mauft.PlatformerEngine.Engine;
	import com.mauft.PlatformerEngine.Geometry;
	import com.mauft.PlatformerEngine.objects.TEnemy;
	import com.mauft.PlatformerEngine.objects.TObject;

	import flash.display.BlendMode;
	public class TPlayerBullet extends TObject{
		public static var damage: uint = 1;
		public static var bigBullets: Boolean = false;
		public static var waveBeam: Boolean = false;
		public static var rangeCheat: Boolean = false;
		override public function get xMod():Number{return 0}
		override public function get yMod():Number{return 0}
		private var dead:Boolean=false
		private var tim:uint=0
		private var sector:uint
		public function TPlayerBullet(_x:Number, _y:Number, _dir:Number, _vdir:Number){
			x=_x
			y=_y

			width=8
			height=8

			if (_dir==0){
				_speed=Math.random()/2-0.25
				_gravity=-5
			} else {
				_speed=_dir>0?5:-5
				_gravity=Math.random()/2-0.25
			}



			sector=Engine.player.sector



			gfx=new MC_BULLET_001
			gfx.blendMode=BlendMode.SCREEN
			Engine.layerObjects.addChild(gfx)

			if (bigBullets) {
				gfx.scaleX = 2;
				gfx.scaleY = 2;
			}

			Engine.listObjects.push(this)
		}
		override public function Step():void{
			if (Engine.player.sector!=sector){
				tim=30
				gfx.alpha=0
			}
			if (waveBeam) {
				x += _speed
				y += _gravity;
			} else {
				Push(_speed,_gravity)
			}
			if (dead){return}
			gfx.x=x-xMod
			gfx.y=y-yMod
			if (bigBullets) {
				gfx.x -= 5;
				gfx.y -= 5;
			}
			tim++
			if (tim> (rangeCheat ? 40 : 20)){
				_speed*=0.85
				_gravity*=0.85
				gfx.alpha-=0.05
				if (gfx.alpha<=0){
					Engine.removeObject(this)
					Engine.layerObjects.removeChild(gfx)
					return
				}
			}

			if (bigBullets) {
				this.width = 16;
				this.height = 16;
				this.x -= 4;
				this.y -= 4;
			}
			gfx.gotoAndStop(Math.floor(Math.random()*3)+1)
			var e:TEnemy
			for (var i:int=Engine.listEnemies.length-1;i>=0;i--){
				e=Engine.listEnemies[i]
				if (Geometry.RectRect1(this,e) && e.sector==sector){
					e.damage(damage)
					Engine.removeObject(this)
					Engine.layerObjects.removeChild(gfx)
					return
				}
			}
			if (bigBullets) {
				this.width = 8;
				this.height = 8;
				this.x += 4;
				this.y += 4;
			}

		}
		override public function StopHorizontal():void{
			if (waveBeam) {
				return;
			}
			if (dead){return}
			dead=true
			Engine.removeObject(this)
			Engine.layerObjects.removeChild(gfx)
		}

		override public function StopFall():void{
			if (waveBeam) {
				return;
			}

			super.StopFall();
		}
	}
}