/*Platformer Engine by Mauft.com
__TEndLevel__

The level ending object. Once the player is beyond it and is standing on the ground, we end the level!
*/
package com.mauft.PlatformerEngine.objects.objects{
	import com.mauft.PlatformerEngine.Engine;
	import com.mauft.PlatformerEngine.objects.TObject;
	import com.mauft.PlatformerEngine.objects.TPlayer;
	
	import flash.display.MovieClip;

	public class TEndLevel extends TObject{
		public function TEndLevel(setX:Number, setY:Number, _gfx:MovieClip){
			x=setX
			y=setY
			
			gfx=_gfx
			gfx.parent.removeChild(gfx)
			Engine.layerObjects.addChild(gfx)
			
			Engine.listObjects.push(this)
		}
		override public function Step():void{
			if (Engine.player.x>x && Engine.player.isStanding){
				Engine.player.endLevel()
				Engine.removeObject(this)
			}
		}
	}
}