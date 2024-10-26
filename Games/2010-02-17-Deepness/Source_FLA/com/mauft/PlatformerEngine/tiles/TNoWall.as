/*Platformer Engine by Mauft.com
__TBrickWall__

Brick wall is this bricky wall from Mario which can only be destroyed when hit by big mario. It was based on TBonus so consult it for details.
*/

package com.mauft.PlatformerEngine.tiles{
	import com.mauft.PlatformerEngine.Engine;
	import com.mauft.PlatformerEngine.Settings;
	
	import flash.display.MovieClip;;
	public class TNoWall extends TTile{
		public function TNoWall(_x:Number,_y:Number,_gfx:MovieClip){
			_gfx.parent.removeChild(_gfx)
			Engine.fillSector(_gfx,Math.floor(_x/Settings.SCREEN_WIDTH)+Math.floor(_y/Settings.SCREEN_HEIGHT)*5)
		}
	}
}