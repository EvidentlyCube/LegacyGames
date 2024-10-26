package com.mauft.PlatformerEngine.objects.effects{
	import com.mauft.PlatformerEngine.Engine;
	import com.mauft.PlatformerEngine.Settings;
	import com.mauft.PlatformerEngine.objects.TObject;
	public class TDebris extends TObject{
		private var _sector:uint
		private var _life:uint
		private var _still:Boolean=false
		private var _ignore:Boolean=false
		public function TDebris(setX:Number, setY:Number, _ang:Number, _spd:Number, life:uint){
			x=setX
			y=setY
			
			_speed=Math.cos(_ang*Math.PI/180)*_spd
			_gravity=Math.sin(_ang*Math.PI/180)*_spd
			_life=life
			
			_sector=Engine.player.sector
			
			width=1
			height=1
			
			gfx=new MC_DEBRIS
			gfx.x=x
			gfx.y=y
			gfx.rotation=Math.random()*360
			Engine.layerObjects.addChild(gfx)
			
			Engine.listObjects.push(this)
		}
		override public function Step():void{
			_ignore=false
			var s:uint=Math.floor(x/Settings.SCREEN_WIDTH)+Math.floor(y/Settings.SCREEN_HEIGHT)*5
			if (Engine.player.sector!=_sector || s!=_sector){
				Engine.layerObjects.removeChild(gfx)
				Engine.removeObject(this)
				return
			}
			if (!_still){
				_gravity+=Settings.GRAVITY/4
				Push(_speed,_gravity)
			} else {
				_speed*=0.5
			}
			if (_life>0){
				_life--
			} else {
				gfx.alpha-=0.02
				if (gfx.alpha<=0){
					Engine.layerObjects.removeChild(gfx)
					Engine.removeObject(this)
					return
				}
			}
			gfx.x=x
			gfx.y=y
			gfx.rotation+=_speed
		}
		override public function StopHorizontal():void{
			if (_ignore){return}
			_ignore=true
			super.StopHorizontal()
			_speed*=-0.5
		}
		override public function StopFall():void{
			if (_gravity<0){return}
			var g:Number=-_gravity*0.5
			super.StopFall()
			_gravity=g
			_speed/=2
			if (_gravity>-1){
				_gravity=0
				_still=true
			}
		}
	}
}