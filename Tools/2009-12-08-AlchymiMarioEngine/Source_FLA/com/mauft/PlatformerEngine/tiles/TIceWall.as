/*Platformer Engine by Mauft.com
__TIceWall__

This object is essentially identical to the TWall. The only difference here is that we have overriden the
friction() getter to return 0.3 instead of 1, so the player slides more.
*/ 
package com.mauft.PlatformerEngine.tiles{
	import com.mauft.PlatformerEngine.Engine;
	import com.mauft.PlatformerEngine.Settings;
	import com.mauft.PlatformerEngine.objects.TObject;
	import com.mauft.PlatformerEngine.objects.TPlayer;
	
	import flash.display.MovieClip;
	
	public class TIceWall extends TTile{
		override public function get friction():Number{return 0.3}
		public function TIceWall(_x:Number,_y:Number,_gfx:MovieClip){
			Engine.tileSet(_x,_y,this)
			_gfx.parent.removeChild(_gfx)
			Engine.layerTiles.addChild(_gfx)
		}
	}
}