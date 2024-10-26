package src{
	import flash.display.*
	public class floor extends Sprite{
		public var f:uint
		public function floor(_x:Number, _y:Number, _w:uint, _floor:uint){
			x=_x
			y=_y
			
			if (_floor>3 && Main.optsCoins){
				new COIN(x+20+Math.random()*(_w-1)*25, y-30)
			}
			
			f=_floor
			var c:Bitmap
			var i:uint
			switch(Math.floor(_floor/100)%3){
				case (0):
					c=new Bitmap(new __FLOOR_1_1(25,25))
					addChild(c)
					for (i=1; i<_w-1; i++){
						c=new Bitmap(new __FLOOR_1_2(25,25))
						c.x=i*25
						addChild(c)
					}
					c=new Bitmap(new __FLOOR_1_3(25,25))
					c.x=i*25
					break;
				case (1):
					c=new Bitmap(new __FLOOR_2_1(25,25))
					addChild(c)
					for (i=1; i<_w-1; i++){
						c=new Bitmap(new __FLOOR_2_2(25,25))
						c.x=i*25
						addChild(c)
					}
					c=new Bitmap(new __FLOOR_2_3(25,25))
					c.x=i*25
					break;
				case (2):
					c=new Bitmap(new __FLOOR_3_1(25,25))
					addChild(c)
					for (i=1; i<_w-1; i++){
						c=new Bitmap(new __FLOOR_3_2(25,25))
						c.x=i*25
						addChild(c)
					}
					c=new Bitmap(new __FLOOR_3_3(25,25))
					c.x=i*25
					break;
			}
			addChild(c)
			if (_floor%10==0){
				var gla:HEIGHTER=new HEIGHTER()
				gla.x=width/2
				gla.y=height/2
				addChild(gla)
			}
		}
		public function update():void{
			if (y>Main.lev_y+510){
				Main.makeFloor()
				Main.display.removeChild(this)
			}
		}
	}
}