package com.mauft.PlatformerEngine.objects.effects{
	import com.mauft.PlatformerEngine.Engine;
	
	import flash.display.MovieClip;
	import flash.text.TextField;
	
	public class TMessage{
		private static var current:TMessage=null
		private var gfx:MovieClip
		private var timer:uint=0
		public function TMessage(_x:Number, _y:Number, _mess:String, _col:Number){
			if (current && (current.gfx.getChildAt(0) as TextField).textColor==_col){
				current.timer=50
				current.gfx.alpha=1
			}
			current=this
			gfx=new MC_MESSAGE
			gfx.x=_x
			gfx.y=_y
			gfx.alpha=0
			var t:TextField=gfx.getChildAt(0) as TextField
			t.text=_mess
			t.textColor=_col
			
			Engine.listObjects.push(this)
			Engine.layerForeground.addChild(gfx)
		}
		public function Step():void{
			timer++
			if(timer<50 && gfx.alpha<1){
				gfx.alpha+=0.05
				gfx.y-=1-gfx.alpha
			}
			if(timer>50){
				gfx.alpha-=0.04
				if (gfx.alpha<0){
					Engine.removeObject(this)
					Engine.layerForeground.removeChild(gfx)
				}
			}
		}
	}
}