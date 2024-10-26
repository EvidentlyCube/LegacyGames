/*Platformer Engine by Mauft.com
__TWall__

This is your very average wall block
*/

package com.mauft.PlatformerEngine.tiles{
	import com.mauft.PlatformerEngine.Engine;
	import com.mauft.PlatformerEngine.Settings;
	import com.mauft.PlatformerEngine.objects.SFX;
	import com.mauft.PlatformerEngine.objects.TObject;
	import com.mauft.PlatformerEngine.objects.TPlayer;
	
	import flash.display.MovieClip;
	
	public class TWall extends TTile{
		/*All we do here is add the tile to the Level array and relocate the graphic to the Tiles layer
		*/
		public function TWall(_x:Number,_y:Number,_gfx:MovieClip=null){
			Engine.tileSet(_x,_y,this)
			//Engine.layerTiles.addChild(_gfx)
		}
		override public function landed(o:TObject):void{
			if (o as TPlayer && o.gravity>0){
				(o as TPlayer).___anim=0
			}
			super.landed(o)
		}
		override public function stomped(o:TObject):void{
			super.stomped(o)
			if (o as TPlayer && (o as TPlayer).___anim==15){
				(o as TPlayer).___anim++
			}
		}
	}
}