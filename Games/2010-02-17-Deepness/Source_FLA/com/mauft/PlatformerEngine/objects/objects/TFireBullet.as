package com.mauft.PlatformerEngine.objects.objects{
	import com.mauft.PlatformerEngine.Engine;
	import com.mauft.PlatformerEngine.Geometry;
	import com.mauft.PlatformerEngine.Settings;
	import com.mauft.PlatformerEngine.objects.TObject;
	import com.mauft.PlatformerEngine.objects.effects.TFlame;
	
	import flash.display.BlendMode;
	
	public class TFireBullet extends TObject{
		override public function get xMod():Number{return -3}
		override public function get yMod():Number{return -3}
		private var _dead:Boolean=false
		private var ___timer:uint=0
		private var _sector:uint
		public function TFireBullet(setX:Number, setY:Number, ang:Number, spd:Number){
			x=setX+xMod
			y=setY+yMod
			
			gfx=new MC_BULLET_FIREBALL
			gfx.x=x-xMod
			gfx.y=y-yMod
			gfx.blendMode=BlendMode.SCREEN
			Engine.layerObjects.addChild(gfx)
			
			_speed=Math.cos(ang*Math.PI/180)*spd
			_gravity=Math.sin(ang*Math.PI/180)*spd
			
			_sector=Math.floor(x/Settings.SCREEN_WIDTH)+Math.floor(y/Settings.SCREEN_HEIGHT)*5
			
			width=6
			height=6
			
			Engine.listObjects.push(this)
		}
		override public function Step():void{
			var s:uint=Math.floor(x/Settings.SCREEN_WIDTH)+Math.floor(y/Settings.SCREEN_HEIGHT)*5
			if (s!=_sector || _sector!=Engine.player.sector){Kill();return}
			___timer++
			if (___timer==10){
				___timer=0
				new TFlame(x-xMod,y-yMod,Math.atan2(-_gravity,-_speed)*180/Math.PI,2,0.1)
			}
			Push(_speed, _gravity)
			if (_dead){return}
			if (Geometry.RectRect1(this,Engine.player)){
				Engine.player.Damaged(3)
				Kill()
				return				
			}
			gfx.x=x-xMod
			gfx.y=y-yMod
		}
		override public function StopHorizontal():void{
			super.StopHorizontal()
			Kill()
		}
		override public function StopFall():void{
			super.StopFall()
			Kill()
		}
		override public function StopJump():void{
			super.StopJump()
			Kill()
		}
		private function Kill():void{
			if (_dead){return}
			Engine.layerObjects.removeChild(gfx)
			Engine.removeObject(this)
			new TFlame(x-xMod,y-yMod,0,0,0.3)
			new TFlame(x-xMod,y-yMod,Math.random()*360,Math.random(),0.2)
			new TFlame(x-xMod,y-yMod,Math.random()*360,Math.random(),0.2)
			new TFlame(x-xMod,y-yMod,Math.random()*360,Math.random(),0.2)
			_dead=true
		}
	}
}