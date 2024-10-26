/*Platformer Engine by Mauft.com
__TPlatform__

A platform tile stops you only when you fall on top of it.
*/

package com.mauft.PlatformerEngine.tiles{
	import com.mauft.PlatformerEngine.Engine;
	import com.mauft.PlatformerEngine.Settings;
	import com.mauft.PlatformerEngine.objects.SFX;
	import com.mauft.PlatformerEngine.objects.TObject;
	import com.mauft.PlatformerEngine.objects.TPlayer;
	
	import flash.display.MovieClip;
	
	public class TPlatform extends TTile{
		private var y:uint	//We need to remember the Y position of the tile for calculations
		public function TPlatform(_x:Number,_y:Number,_gfx:MovieClip){
			y=Math.floor(_y/Settings.TILE_HEIGHT)*Settings.TILE_HEIGHT
			Engine.tileSet(_x,_y,this)
		}
		override public function stomped(o:TObject):void{
			//If the object FALLS onto the tile or he stand on top of it, call the o.StopFall() 
			if (o as TPlayer && o.y+o.height-o.gravity<=y+Settings.TILE_HEIGHT/10){
				o.StopFall()
				if (o as TPlayer && (o as TPlayer).___anim==15){
					(o as TPlayer).___anim++
				}
			}
		}
		override public function landed(o:TObject):void{
			if (o as TPlayer && o.gravity>0 && o.y+o.height-o.gravity<=y+Settings.TILE_HEIGHT/10){
				(o as TPlayer).___anim=0
			}
			super.landed(o)
		}
		//It doesn't stop you when headbutted, hit from the left or right
		override public function headbutt(o:TObject):void{}
		override public function pokedLeft(o:TObject):void{}
		override public function pokedRight(o:TObject):void{}
	}
}