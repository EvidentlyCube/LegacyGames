package com.mauft.PlatformerEngine.objects.enemies{
		import com.mauft.PlatformerEngine.Engine;
		import com.mauft.PlatformerEngine.Geometry;
		import com.mauft.PlatformerEngine.Settings;
		import com.mauft.PlatformerEngine.objects.TObject;
		import com.mauft.PlatformerEngine.objects.effects.TObjectKilled;
		
		import flash.display.MovieClip;
	public class TBouncer extends TObject{
		override public function get xMod():Number{return 0}
		override public function get yMod():Number{return 0}
		private var _animate:Boolean=false
		private var _anim:uint=0
		private var _startX:Number
		private var _startY:Number
		public function TBouncer(setX:Number, setY:Number, _gfx:MovieClip){
			_startX=x=setX
			_startY=y=setY
			
			gfx=_gfx
			gfx.parent.removeChild(gfx)
			gfx.x=x-xMod
			gfx.y=y-yMod
			Engine.layerObjects.addChild(gfx)
			
			width=14
			height=14
			
			Engine.listObjects.push(this)
		}
		override public function Step():void{
			if (Engine.started==2){
				_gravity+=Settings.GRAVITY
				Push(0,_gravity)
				if (Geometry.RectRect1(this, Engine.player)){
					Engine.player.kill()
				}
				if (Engine.getTileFree(x,y+height+_gravity*3)){_animate=true}
				if (_animate){
					_anim++
					if (_anim==3){
						if (gfx.currentFrame<4){
							gfx.gotoAndStop(gfx.currentFrame+1)
						} else {
							gfx.gotoAndStop(1)
							_animate=false
						}
						_anim=0
					}
				}
			}
			if (gfx.alpha<1){gfx.alpha+=0.1}
			gfx.x=x-xMod
			gfx.y=y-yMod
		}
		override public function StopFall():void{
			if (_gravity<=0){return}
			var t:Number=_gravity*-1
			super.StopFall()
			_gravity=t
		}
		override public function StopJump():void{
			super.StopJump()
			_gravity=0
		}
		override public function Reappear():void{
			new TObjectKilled(gfx, 0, _gravity)
			gfx=new _O_BOUNCER
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