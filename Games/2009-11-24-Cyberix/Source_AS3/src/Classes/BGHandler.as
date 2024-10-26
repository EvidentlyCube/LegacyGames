package Classes{
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.geom.Matrix;

	import mx.core.BitmapAsset;
	public class BGHandler	{
		private static var backgroundContainer:Shape
		private static var backgroundMatrix:Matrix
		private static var backgroundBitmapData:BitmapData
		private static var _speedX: Number = 0;
		private static var _speedY: Number = 0;
		private static var _offsetX: Number = 0;
		private static var _offsetY: Number = 0;
		public function BGHandler(){
			backgroundMatrix = new Matrix(1,0,0,1,0,0)
			backgroundContainer = new Shape
			Game.STG.addEventListener(Event.ENTER_FRAME,update)
		}
		public static function get Graphic():Shape{
			return backgroundContainer;
		}
		public static function update(e:Event):void{
			if (backgroundBitmapData == null){return}
			_offsetX += _speedX / 200;
			_offsetY += _speedY / 200;

			while (_offsetX > 600) {
				_offsetX -= 600;
			}
			while (_offsetX < 600) {
				_offsetX += 600;
			}
			while (_offsetY > 600) {
				_offsetY -= 600;
			}
			while (_offsetY < 600) {
				_offsetY += 600;
			}

			var newTX: Number = _offsetX | 0;
			var newTY: Number = _offsetY | 0;

			if (newTX !== backgroundMatrix.tx || newTY !== backgroundMatrix.ty) {
				backgroundMatrix.tx = newTX;
				backgroundMatrix.ty = newTY;
				redraw();
			}
		}
		public static function redraw():void{
			backgroundContainer.graphics.clear()
			backgroundContainer.graphics.beginBitmapFill(backgroundBitmapData, backgroundMatrix)
			backgroundContainer.graphics.drawRect(0,0,600,600)
		}
		public static function Reset(_x:int,_y:int,_id:uint):void{
			_speedX = _x - 4000;
			_speedY = _y - 4000;
			_offsetX = Math.random() * 600;
			_offsetY = Math.random() * 600;

			var bitmap:BitmapAsset
			switch (_id){
				case(0):bitmap = new (GFX.bg0);break;
				case(1):bitmap = new (GFX.bg1);break;
				case(2):bitmap = new (GFX.bg2);break;
				case(3):bitmap = new (GFX.bg3);break;
				case(4):bitmap = new (GFX.bg4);break;
				case(5):bitmap = new (GFX.bg5);break;
				case(6):bitmap = new (GFX.bg6);break;
				case(7):bitmap = new (GFX.bg7);break;
				case(8):bitmap = new (GFX.bg8);break;
			}
			backgroundBitmapData=bitmap.bitmapData
			redraw()
			Game.layerBg.addChild(backgroundContainer)
		}
	}
}