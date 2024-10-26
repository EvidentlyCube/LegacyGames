package Classes{
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.geom.Matrix;

	import mx.core.BitmapAsset;
	public class MenuBG extends Shape{
		private var m:Matrix
		private var b:BitmapData
		private var moveX:int = 0
		private var moveY:int = 0
		private var waitX:uint = 0
		private var waitY:uint = 0
		private var maxX:uint = 0
		private var maxY:uint = 0
		private var waiter:uint = 0
		public function MenuBG(){
			m = new Matrix(1,0,0,1,0,0)
			maxX = Math.random() * 80 + 40
			maxY = Math.random() * 80 + 40
			alpha = 0
			Reset()
			Game.layerMenuBg.addChild(this)
		}
		public function Update():void{
			waiter++
			if (waiter < 180){
				if (alpha < 1){
					alpha += 0.01
				}
			} else {
				if (waiter == 180){
					new MenuBG()
				}
				if (alpha > 0){
					alpha -= 0.01
				} else {
					Game.layerMenuBg.removeChild(this)
				}
			}
			waitX++
			waitY++
			if (waitX > maxX){
				waitX = 0
				m.tx += moveX
				if (m.tx > 600){m.tx -= 600} else if (m.tx < 0){m.tx += 600}
			}
			if (waitY > maxY){
				waitY = 0
				m.ty += moveY
				if (m.ty > 600){m.ty -= 600} else if (m.ty < 0){m.ty += 600}
			}
			if (waitX == 0 || waitY == 0){redraw()}
		}
		public function redraw():void{
			graphics.clear()
			graphics.beginBitmapFill(b,m)
			graphics.drawRect(0,0,600,600)
		}
		public function Reset():void{
			var _x:int
			var _y:int
			_x = 180 + Math.random() * 420
			_y = 180 + Math.random() * 420
			_x *= Math.random() > 0.5?1:-1
			_y *= Math.random() > 0.5?1:-1
			if (Math.abs(_x) < 200){
				moveX=_x > 0?1:(_x == 0?0:-1)
				maxX = 200 - Math.abs(_x)
			} else {
				moveX=_x / 200
				maxX = 0
			}
			if (Math.abs(_y) < 200){
				moveY=_y > 0?1:(_y == 0?0:-1)
				maxY = 200 - Math.abs(_y)
			} else {
				moveY=_y / 200
				maxY = 0
			}
			var _b:BitmapAsset
			switch (Math.floor(Math.random() * 9)){
				case(0):_b = new (GFX.bg0);break;
				case(1):_b = new (GFX.bg1);break;
				case(2):_b = new (GFX.bg2);break;
				case(3):_b = new (GFX.bg3);break;
				case(4):_b = new (GFX.bg4);break;
				case(5):_b = new (GFX.bg5);break;
				case(6):_b = new (GFX.bg6);break;
				case(7):_b = new (GFX.bg7);break;
				case(8):_b = new (GFX.bg8);break;
			}
			b=_b.bitmapData
			waitX = 0
			waitY = 0
			redraw()
		}
	}
}