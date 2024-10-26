/*Platformer Engine by Mauft.com
__TWall__

This is your very average wall block
*/

package com.mauft.PlatformerEngine.tiles{
	import com.mauft.PlatformerEngine.Engine;
	
	import flash.display.MovieClip;
	
	public class TWall extends TTile{
		/*All we do here is add the tile to the Level array and relocate the graphic to the Tiles layer
		*/
		public function TWall(_x:Number,_y:Number,_gfx:MovieClip){
			Engine.tileSet(_x,_y,this)
			_gfx.parent.removeChild(_gfx)
			Engine.layerTiles.addChild(_gfx)
		}
		
	}
}