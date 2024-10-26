package com.mauft.PlatformerEngine.objects
{
	import com.mauft.PlatformerEngine.Controls;
	import com.mauft.PlatformerEngine.Engine;
	import com.mauft.PlatformerEngine.Geometry;
	
	import flash.display.MovieClip;
	public class TExit extends TObject{
		override public function get xMod():Number{return 0}
		override public function get yMod():Number{return 0}
		public function TExit(setX:Number, setY:Number, _gfx:MovieClip){
			x=setX
			y=setY
			
			gfx=_gfx
			gfx.parent.removeChild(gfx)
			Engine.layerObjects.addChild(gfx)
			
			width=30
			height=30
			
			Engine.listObjects.push(this)
		}
		override public function Step():void{
			if (Engine.bgFaderState==2){return}
		 	if (Geometry.RectRect1(Engine.player,this)){
		 		SFX.playEnd()
		 		Engine.bgFaderState=2
		 		Engine.bgFaderTo=0
		 		Engine.player.endLevel()
		 		Controls.endLevel()
		 	}
		}
	}
}