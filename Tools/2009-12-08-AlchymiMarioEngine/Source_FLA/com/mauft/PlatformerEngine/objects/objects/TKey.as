/*Platformer Engine by Mauft.com
__TCoin__

Just your usual coin!
*/
package com.mauft.PlatformerEngine.objects.objects{
	import com.mauft.PlatformerEngine.Engine;
	import com.mauft.PlatformerEngine.Geometry;
	import com.mauft.PlatformerEngine.objects.TObject;
	
	import flash.display.MovieClip;
	
	public final class TKey extends TObject	{
		private var color:uint
		public function TKey(_x:Number, _y:Number, _gfx:MovieClip, _color:uint){
			gfx=_gfx
			gfx.parent.removeChild(gfx)
			Engine.layerObjects.addChild(gfx)
			
			x=_x+6
			y=_y+3
			
			width=gfx.width
			height=gfx.height
			
			color=_color
			
			Engine.listObjects.push(this)
		}
		override public function Step():void{
			if (Geometry.RectRect1(this,Engine.player)){		//If collides with player, remove
				Engine.removeObject(this)
				gfx.parent.removeChild(gfx)
				Engine.player.keys[color]=true
			}
		}
	}
}