package com.mauft.PlatformerEngine.objects.enemies{
		import com.mauft.PlatformerEngine.Engine;
		import com.mauft.PlatformerEngine.Geometry;
		import com.mauft.PlatformerEngine.Settings;
		import com.mauft.PlatformerEngine.objects.TEnemy;
		import com.mauft.PlatformerEngine.objects.effects.TObjectKilled;
		
		import flash.display.MovieClip;
	public class TSpiker extends TEnemy{
		override public function get type():uint{return 1}
		override public function get xMod():Number{return -9}
		override public function get yMod():Number{return 0}
		private var _animate:Boolean=false
		private var _anim:uint=0
		private var _startX:Number
		private var _startY:Number
		public function TSpiker(setX:Number, setY:Number, _gfx:MovieClip){
			_startX=x=setX
			_startY=y=setY
			
			gfx=_gfx
			gfx.parent.removeChild(gfx)
			gfx.x=x-xMod
			gfx.y=y-yMod
			Engine.layerObjects.addChild(gfx)
			
			width=24
			height=19
			
			Engine.listEnemies.push(this)
		}
		override public function Step():void{
			if (x<Engine.player.x-Engine.player.width/2){
				_speed=1
			}
			if (x>Engine.player.x+Engine.player.width/2){
				_speed=-1
			}
			if (Engine.started==2){
				CheckBounce()
				_gravity+=Settings.GRAVITY
				Push(_speed,_gravity)
				if (Geometry.RectRect1(this, Engine.player)){
					Engine.player.kill()
				}
				_anim++
				if (_anim==6){
					if (gfx.currentFrame<5){
						gfx.gotoAndStop(gfx.currentFrame+1)
					} else {
						gfx.gotoAndStop(1)
					}
					_anim=0
				}
			}
			if (gfx.alpha<1){gfx.alpha+=0.1}
			if (_speed>0){gfx.scaleX=1} else {gfx.scaleX=-1}
			gfx.x=x-xMod
			gfx.y=y-yMod
		}
		override public function Bounce(dir:int=0):void{
			_speed=0
		}
		override public function Reappear():void{
			new TObjectKilled(gfx, -_speed, _gravity)
			gfx=new _O_SPIKER
			gfx.mouseEnabled=false
			Engine.layerObjects.addChild(gfx)
			x=_startX
			y=_startY
			_gravity=0
			_anim=0
			_animate=false
			gfx.gotoAndStop(1)
			gfx.alpha=0
		}
	}
}