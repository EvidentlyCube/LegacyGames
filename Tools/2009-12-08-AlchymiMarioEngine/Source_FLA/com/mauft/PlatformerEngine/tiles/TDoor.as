/*Platformer Engine by Mauft.com
__TDoor__
*/

package com.mauft.PlatformerEngine.tiles{
	import com.mauft.PlatformerEngine.Engine;
	import com.mauft.PlatformerEngine.objects.TObject;
	import com.mauft.PlatformerEngine.objects.TPlayer;
	
	import flash.display.MovieClip;
	
	public class TDoor extends TTile{
		private var color:uint
		private var x:Number
		private var y:Number
		private var gfx:MovieClip
		public function TDoor(_x:Number,_y:Number,_gfx:MovieClip, _color:uint){
			Engine.tileSet(_x,_y,this)
			_gfx.parent.removeChild(_gfx)
			Engine.layerTiles.addChild(_gfx)
			color=_color
			x=_x
			y=_y
			gfx=_gfx
		}
		override public function headbutt(o:TObject):void{
			if (o as TPlayer && Engine.player.keys[color]){
				Engine.layerTiles.removeChild(gfx)
				Engine.tileSet(x, y, null)
			} else {
				super.headbutt(o)
			}
		}
		override public function pokedLeft(o:TObject):void{
			if (o as TPlayer && Engine.player.keys[color]){
				Engine.layerTiles.removeChild(gfx)
				Engine.tileSet(x, y, null)
			} else {
				super.pokedLeft(o)
			}
		}
		override public function pokedRight(o:TObject):void{
			if (o as TPlayer && Engine.player.keys[color]){
				Engine.layerTiles.removeChild(gfx)
				Engine.tileSet(x, y, null)
			} else {
				super.pokedLeft(o)
			}
		}
		override public function stomped(o:TObject):void{
			if (o as TPlayer && Engine.player.keys[color]){
				Engine.layerTiles.removeChild(gfx)
				Engine.tileSet(x, y, null)
			} else {
				super.stomped(o)
			}
		}
	}
}