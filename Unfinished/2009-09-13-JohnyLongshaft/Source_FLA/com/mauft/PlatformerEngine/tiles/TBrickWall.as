/*Platformer Engine by Mauft.com
__TBrickWall__

Brick wall is this bricky wall from Mario which can only be destroyed when hit by big mario. It was based on TBonus so consult it for details.
*/

package com.mauft.PlatformerEngine.tiles{
	import com.mauft.PlatformerEngine.Engine;
	import com.mauft.PlatformerEngine.objects.TObject;
	import com.mauft.PlatformerEngine.objects.TPlayer;
	import com.mauft.PlatformerEngine.objects.effects.TFallObject;
	
	import flash.display.MovieClip;
	
	import com.mauft.PlatformerEngine.Settings
	public class TBrickWall extends TTile{
		private var _gfx:MovieClip
		private var _x:Number
		private var _y:Number
		
		
		private var ___anim:uint=0
		private var ___bump:Boolean=false
		
		public function TBrickWall(x:Number,y:Number,gfx:MovieClip){
			_x=x
			_y=y
			
			Engine.tileSet(_x,_y,this)
			
			_gfx=gfx
			_gfx.parent.removeChild(_gfx)
			Engine.layerTiles.addChild(_gfx)
			
			Engine.listObjects.push(this)
		}
		public function Step():void{
			if (___bump){
				___anim+=15
				_gfx.y=_y-Math.sin(___anim/180*Math.PI)*8
				if (___anim==180){
					_gfx.y=_y
					___bump=false
					___anim=0
				}
			}
		}
		override public function headbutt(o:TObject):void{
			super.headbutt(o)
			if (o as TPlayer && !___bump && !TPlayer._hitBonus){
				if (TPlayer._size==0){
					TPlayer._hitBonus=true
					___bump=true
					___anim=0
				} else {
					TPlayer._hitBonus=true
					Engine.removeObject(this)
					Engine.removeTileFree(_x,_y)
					new TFallObject(_gfx.x,_gfx.y,0,Settings.TILE_HEIGHT,_gfx,o.speed)
					//Engine.layerTiles.removeChild(_gfx)
				}
			}
		}
	}
}