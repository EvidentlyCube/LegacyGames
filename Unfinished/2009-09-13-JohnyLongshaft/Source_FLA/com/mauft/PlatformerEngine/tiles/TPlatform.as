/*Platformer Engine by Mauft.com
__TPlatform__

A platform tile stops you only when you fall on top of it.
*/

package com.mauft.PlatformerEngine.tiles{
	import com.mauft.PlatformerEngine.DebugDraw;
	import com.mauft.PlatformerEngine.Engine;
	import com.mauft.PlatformerEngine.Settings;
	import com.mauft.PlatformerEngine.objects.TObject;
	
	import flash.display.MovieClip;
	
	public class TPlatform extends TTile{
		private var x:uint
		private var y:uint	//We need to remember the Y position of the tile for calculations
		public function TPlatform(_x:Number,_y:Number,_gfx:MovieClip){
			x=_x
			y=Math.floor(_y/Settings.TILE_HEIGHT)*Settings.TILE_HEIGHT
			Engine.tileSet(_x,_y,this)
			_gfx.parent.removeChild(_gfx)
			Engine.layerTiles.addChild(_gfx)
			
			
		}
		override public function stomped(o:TObject):void{
			DebugDraw.Rect(x,y,30,30)
			//If the object FALLS onto the tile or he stand on top of it, call the o.StopFall() 
			if (o.y+o.height-o.gravity<=y+Settings.TILE_HEIGHT/10){
				o.StopFall()
			}
		}
		//It doesn't stop you when headbutted, hit from the left or right
		override public function headbutt(o:TObject):void{}
		override public function pokedLeft(o:TObject):void{}
		override public function pokedRight(o:TObject):void{}
	}
}