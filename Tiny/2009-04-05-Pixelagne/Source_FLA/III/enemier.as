package{
	import flash.display.Sprite
	import flash.filters.GlowFilter
	import flash.events.*
	public class enemier extends Sprite{
		private var size:uint=0
		private var spd:Number=0
		private var grav:Number=0
		public function enemier():void{
			size=3+Math.random()*17
			x=180+size
			y=20+Math.random()*140
			spd=0.1+Math.random()*2
			graphics.beginFill(0xFFFFFF)
			graphics.drawRect(-size/2,-size/2,size,size)
			graphics.endFill()
			var arr:Array=filters
			arr.push(new GlowFilter(0xFFFFFF,1,5,5,1))
			filters=arr
			addEventListener(Event.ENTER_FRAME,step)
			addEventListener(Event.REMOVED_FROM_STAGE,kill)
		}
		
		private function step(e:Event):void{
			x-=spd
			rotation+=spd*5
			grav+=0.1
			y+=grav
			if(y>=175){grav*=-1;y=175}
			if (HitTest.hitTestObject(this,Pixelagne3.player)){
				Pixelagne3.self.gotoAndStop(2)
			}
			if (x<-size){
				Pixelagne3.s++
				Pixelagne3.self.foolproofSA(null,1)
				parent.removeChild(this)
			}
		}
		private function kill(e:Event):void{
			removeEventListener(Event.REMOVED_FROM_STAGE,kill)
			removeEventListener(Event.ENTER_FRAME,step)
		}
	}
}