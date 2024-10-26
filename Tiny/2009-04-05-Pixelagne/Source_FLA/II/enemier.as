package{
	import flash.display.Sprite
	import flash.filters.GlowFilter
	import flash.events.*
	public class enemier extends Sprite{
		private var size:uint
		private var spd:Number
		private var rot:Number
		private var broken:Boolean=false
		private var dir:Number
		public function enemier():void{
			size=3+Math.random()*17
			if (Math.random()>=0.5){
				x=Math.random()*(180-size)+size/2
				y=Math.random()>=0.5?-size:180+size
			} else {
				x=Math.random()>=0.5?-size:180+size
				y=Math.random()*(180-size)+size/2
			}
			
			spd=0.1+Math.random()
			graphics.beginFill(0xFFFFFF)
			graphics.drawRect(-size/2,-size/2,size,size)
			graphics.endFill()
			var arr:Array=filters
			arr.push(new GlowFilter(0xFFFFFF,1,5,5,1))
			filters=arr
			rot=(Math.random()>=0.5?Math.random()*5:-Math.random()*5)
			addEventListener(Event.ENTER_FRAME,step)
			addEventListener(Event.REMOVED_FROM_STAGE,kill)
			dir=Math.atan2(Pixelagne2.player.y-y,Pixelagne2.player.x-x)
		}
		private function step(e:Event):void{
			if (broken){
				alpha-=0.02
				if (alpha<0){
					parent.removeChild(this)
				}
				return
			}
			x+=Math.cos(dir)*spd
			y+=Math.sin(dir)*spd
			rotation+=rot
			if (HitTest.hitTestObject(this,Pixelagne2.player)){
				Pixelagne2.self.gotoAndStop(5)
			}
			for (var i:int=Pixelagne2.lBoom.numChildren-1;i>=0;i--){
				if (HitTest.hitTestObject(this,Pixelagne2.lBoom.getChildAt(i))){
					broken=true
					Pixelagne2.s++
					Pixelagne2.self.foolproofSA(null,1)
					return
				}
			}
		}
		private function kill(e:Event):void{
			removeEventListener(Event.REMOVED_FROM_STAGE,kill)
			removeEventListener(Event.ENTER_FRAME,step)
		}
	}
}