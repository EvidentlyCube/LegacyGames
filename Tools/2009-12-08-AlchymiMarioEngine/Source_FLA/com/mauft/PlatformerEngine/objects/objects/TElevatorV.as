package com.mauft.PlatformerEngine.objects.objects{
	import com.mauft.PlatformerEngine.Engine;
	
	import flash.display.MovieClip;
	public class TElevatorV extends TElevator{
		private var speed:Number
		public function TElevatorV(_x:Number, _y:Number, _gfx:MovieClip, _speed:Number){
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
				if (Engine.getTileFree(x, y+height+speed-1) || Engine.getTileFree(x+width-1, y+height+speed-1) || TElevator.Collide(this)){
					speed=-speed
				}
				y+=speed
				if (hook){Engine.player.y+=speed}
			} else {
				if (Engine.getTileFree(x, y+speed-1-(hook?Engine.player.height:0)) || Engine.getTileFree(x+width-1, y+speed-1-(hook?Engine.player.height:0)) || TElevator.Collide(this)){
					speed=-speed
				}
				y+=speed
				if (hook){Engine.player.y+=speed}
			}
			gfx.x=x
			gfx.y=y
		}
	}
}