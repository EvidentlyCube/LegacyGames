package com.mauft.PlatformerEngine.objects{
	import com.mauft.PlatformerEngine.Engine;
	import com.mauft.PlatformerEngine.LEVEL_ROOM;
	import com.mauft.PlatformerEngine.Settings;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	
	public class TGfxEater	{
		public function TGfxEater(mc:MovieClip){
			var d:DisplayObject
			for (var i:int=mc.numChildren-1;i>=0;i--){
				d=mc.getChildAt(i)
				if (d as LEVEL_ROOM){
					mc.removeChild(d)
					Engine.fillSector(d, Math.floor(d.x/Settings.SCREEN_WIDTH)+Math.floor(d.y/Settings.SCREEN_HEIGHT)*5)
				}
			}
		}

	}
}