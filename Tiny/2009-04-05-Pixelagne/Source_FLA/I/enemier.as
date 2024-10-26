package{
	import flash.display.Sprite
	import flash.filters.GlowFilter
	import flash.events.*
	public class enemier extends Sprite{
		private var size:uint
		private var spd:Number
		private var rot:Number
		public function enemier():void{
			size=3+Math.random()*17
			x=205+size
			y=Math.random()*(200-size)+size/2
			spd=0.5+Math.random()*3
			graphics.beginFill(0xFFFFFF)
			graphics.drawRect(-size/2,-size/2,size,size)
			graphics.endFill()
			var arr:Array=filters
			arr.push(new GlowFilter(0xFFFFFF,1,5,5,1))
			filters=arr
			rot=(Math.random()>=0.5?Math.random()*5:-Math.random()*5)
			addEventListener(Event.ENTER_FRAME,step)
			addEventListener(Event.REMOVED_FROM_STAGE,kill)
		}
		private function step(e:Event):void{
			x-=spd
			rotation+=rot
			if (x<-size-5){
				parent.removeChild(this)
			}
			if (HitTest.hitTestObject(this,Pixelagne1.player)){
				Pixelagne1.self.gotoAndStop(5)
			}
		}
		private function kill(e:Event):void{
			removeEventListener(Event.REMOVED_FROM_STAGE,kill)
			removeEventListener(Event.ENTER_FRAME,step)
		}
	}
}