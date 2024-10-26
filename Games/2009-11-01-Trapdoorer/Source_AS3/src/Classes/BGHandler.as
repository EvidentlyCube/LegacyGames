package Classes{
	import flash.display.Shape;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.display.BitmapData

	import mx.core.BitmapAsset;

	public class BGHandler{
		[Embed("../../assets/gfx/by_others/bg.png")] private var gfx: Class;
		private static var g: Shape
		private static var m: Matrix
		private static var b: BitmapData
		private static var moveX: int
		private static var moveY: int
		private static var waitX: uint
		private static var waitY: uint
		private static var maxX: uint
		private static var maxY: uint
		public static function get Graphic(): Shape{
			return g;
		}
		public function BGHandler(stg: Stage){
			var _b: BitmapAsset = new gfx
			b=_b.bitmapData
			m = new Matrix(1, 0,0, 1,0, 0)
			g = new Shape
			moveX = Math.random()>0.5?1: -1
			moveY = Math.random()>0.5?1: -1
			waitX = 0
			waitY = 0
			maxX = Math.random()*80+40
			maxY = Math.random()*80+40
			stg.addEventListener(Event.ENTER_FRAME, update)
			redraw()
		}
		public static function update(e: Event): void{
			waitX++
			waitY++
			if (waitX > maxX){
				waitX = 0
				m.tx += moveX
			}
			if (waitY > maxY){
				waitY = 0
				m.ty += moveY
			}
			if (waitX == 0 || waitY == 0){redraw()}
		}
		public static function redraw(): void{
			g.graphics.clear()
			g.graphics.beginBitmapFill(b, m)
			g.graphics.drawRect(0, 0,600, 600)
		}

	}
}