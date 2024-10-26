package Classes{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.display.PixelSnapping

	public class Grid9 extends Sprite{
		public var partUL: Bitmap;
		public var part_L: Bitmap;
		public var part_R: Bitmap;
		public var part_D: Bitmap;
		public var part_U: Bitmap;
		public var part_C: Bitmap;
		public var partUR: Bitmap;
		public var partDL: Bitmap;
		public var partDR: Bitmap;
		public var minWid: uint
		public var minHei: uint
		public var overlap: Number;
		public function Grid9(gridData: Grid9Data, _overlap: Number = 1){
			overlap = _overlap;
			var data: Array = gridData.data
			partUL = new Bitmap(data[0],PixelSnapping.ALWAYS, false)
			part_U = new Bitmap(data[1],PixelSnapping.ALWAYS, false)
			partUR = new Bitmap(data[2],PixelSnapping.ALWAYS, false)
			part_L = new Bitmap(data[3],PixelSnapping.ALWAYS, false)
			part_C = new Bitmap(data[4],PixelSnapping.ALWAYS, false)
			part_R = new Bitmap(data[5],PixelSnapping.ALWAYS, false)
			partDL = new Bitmap(data[6],PixelSnapping.ALWAYS, false)
			part_D = new Bitmap(data[7],PixelSnapping.ALWAYS, false)
			partDR = new Bitmap(data[8],PixelSnapping.ALWAYS, false)
			addChild(part_C)
			addChild(part_U)
			addChild(part_L)
			addChild(part_R)
			addChild(part_D)
			addChild(partUL)
			addChild(partUR)
			addChild(partDL)
			addChild(partDR)
			minWid = partUL.width+partUR.width
			minHei = partUL.height+partDL.height
			refreshPosition()

			cacheAsBitmap = true;
		}
		private function refreshPosition(): void{
			part_U.x = partUL.width - overlap
			partUR.x = part_U.x+part_U.width - overlap * 2

			part_L.y = partUL.height - overlap
			part_C.x = part_U.x
			part_C.y = part_L.y
			part_R.x = partUR.x
			part_R.y = part_L.y

			partDL.y = part_L.y+part_L.height - overlap * 2;
			part_D.x = part_U.x
			part_D.y = partDL.y
			partDR.x = partUR.x
			partDR.y = partDL.y
		}
		override public function set width(value: Number): void{
			value = Math.floor(value)
			value = Math.max(value, minWid)
			value = value-minWid

			part_U.width = value + overlap * 2
			part_C.width = value + overlap * 2
			part_D.width = value + overlap * 2
			refreshPosition()
		}
		override public function set height(value: Number): void{
			value = Math.floor(value)
			value = Math.max(value, minHei)
			value = value-minHei
			part_L.height = value + overlap * 2
			part_C.height = value + overlap * 2
			part_R.height = value + overlap * 2
			refreshPosition()
		}
		override public function set scaleX(value: Number): void{
			value = Math.floor(value)
			part_U.scaleX = value
			part_C.scaleX = value
			part_D.scaleX = value
			refreshPosition()
		}
		override public function set scaleY(value: Number): void{
			value = Math.floor(value)
			part_L.scaleY = value
			part_C.scaleY = value
			part_R.scaleY = value
			refreshPosition()
		}
	}
}
