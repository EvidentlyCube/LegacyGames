package com.mauft.PlatformerEngine.objects.objects{
	import com.mauft.PlatformerEngine.Engine;
	
	import flash.display.MovieClip;
	public class TElevatorH extends TElevator{
		private var speed:Number
		public function TElevatorH(_x:Number, _y:Number, _gfx:MovieClip, _speed:Number){
			x=_x
			y=_y
			
			gfx=_gfx
			gfx.parent.removeChild(gfx)
			Engine.layerObjects.addChild(gfx)
			
			width=gfx.width
			height=gfx.height
			
			speed=_speed
			
			Engine.listObjects.push(this)
		}
		override public function Update():void{
			if (speed>0){
				if (Engine.getTileFree(x+width+speed-1, y) || Engine.getTileFree(x+width+speed-1, y+height-1) || TElevator.Collide(this)){
					speed=-speed
				}
				x+=speed
				if (hook){Engine.player.x+=speed}
			} else {
				if (Engine.getTileFree(x+speed, y) || Engine.getTileFree(x+speed, y+height-1) || TElevator.Collide(this)){
					speed=-speed
				}
				x+=speed
				if (hook){Engine.player.x+=speed}
			}
			gfx.x=x
			gfx.y=y
		}
	}
}