//Please keep in mind that the crate dimensions are those of the graphic

package com.mauft.PlatformerEngine.objects.objects{
	import com.mauft.PlatformerEngine.Engine;
	import com.mauft.PlatformerEngine.Geometry;
	import com.mauft.PlatformerEngine.Settings;
	import com.mauft.PlatformerEngine.objects.TEnemy;
	import com.mauft.PlatformerEngine.objects.TObject;
	
	import flash.display.MovieClip;
	
	public final class TCrate extends TEnemy	{
		public static var _crates:Array=new Array
		private var ___anim:uint=0		//For animation
		public function TCrate(_x:Number, _y:Number, _gfx:MovieClip){
			gfx=_gfx
			gfx.parent.removeChild(gfx)
			Engine.layerEnemies.addChild(gfx)
			
			blocksShell=true
			
			x=_x
			y=_y
			
			width=gfx.width
			height=gfx.height
			
			Engine.listEnemies.push(this)
			_crates.push(this)
		}
		override public function Step():void{
			_gravity+=Settings.GRAVITY*2
			
			if (Geometry.RectRect1(this, Engine.player)){
				if (Engine.player.y+Engine.player.height-3-Engine.player.gravity<=y){
					Engine.player.y=y-Engine.player.height+1
					Engine.player.isStanding=true
					Engine.player.gravity=0	
				} else if (Engine.player.y-Engine.player.gravity>=y+height-3){
					Engine.player.y=y+height
					Engine.player.gravity=0	
					Engine.player._jumpHold=0
				}
				if (Engine.player.x+Engine.player.width-2-Engine.player.speed<=x){
					Engine.player.x=x-Engine.player.width
					_speed=Math.max(2, Engine.player.speed)
					Engine.player.speed=0
				} else if(Engine.player.x-Engine.player.speed>=x+width-2){
					Engine.player.x=x+width
					_speed=Math.min(-2, Engine.player.speed)
					Engine.player.speed=0
				}
			}
			x+=_speed
			if (_speed>0){
				var e:TEnemy
				for (var i:uint;i<Engine.listEnemies.length;i++){
					e=Engine.listEnemies[i]
					if (e==this || !e.bounceTurning){continue}
					if (Geometry.RectRect1(this,e)){
						x-=_speed
						_speed=0
						break;
					}
				}
			}
			x-=_speed
			y+=_gravity
			if (Collides(this)){
				y-=_gravity
				_gravity=0
			}
			y-=_gravity
			Push(_speed, _gravity)
			_speed*=0.8
			gfx.x=x
			gfx.y=y
		}
		public static function Collides(o:TObject):Boolean{
			if (!o){
				return false;
			}
			for(var i:uint=0; i<_crates.length; i++){
				if (_crates[i]==o){continue}
				if (Geometry.RectRect1(o, _crates[i])){
					return true
				}
			}
			return false
		}
		override public function hitShell(dir:int):void{
			return;
		}
	}
}