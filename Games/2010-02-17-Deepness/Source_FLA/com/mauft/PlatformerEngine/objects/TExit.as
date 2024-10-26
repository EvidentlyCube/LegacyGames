package com.mauft.PlatformerEngine.objects
{
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
			
			width=25
			height=25
			
			Engine.listObjects.push(this)
		}
		override public function Step():void{
		 	if (Geometry.RectRect1(Engine.player,this)){
		 		Engine.ending=true
		 	}
		}
	}
}