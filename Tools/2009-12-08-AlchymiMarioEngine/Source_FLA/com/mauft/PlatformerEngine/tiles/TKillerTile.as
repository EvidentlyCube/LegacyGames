/*Platformer Engine by Mauft.com
__TKillerTile_

This tile kills player when he touches it. Used for pits.
Please look out to not put it too much below the screen, as the level height is limited and if the tile is placed below the maximum Y position it won't work! 
*/

package com.mauft.PlatformerEngine.tiles{
	import com.mauft.PlatformerEngine.Engine;
	import com.mauft.PlatformerEngine.objects.TObject;
	import com.mauft.PlatformerEngine.objects.TPlayer;
	
	import flash.display.MovieClip;
	
	public class TKillerTile extends TTile{
		public function TKillerTile(setX:Number, setY:Number, gfx:MovieClip){
			Engine.tileSet(setX,setY,this)
			gfx.parent.removeChild(gfx)	//Since this tile is in essence invisible, we can remove the graphic alltogether
		}
		override public function landed(o:TObject):void{
			if (o as TPlayer){
				Engine.player.kill()
			}
		}

	}
}