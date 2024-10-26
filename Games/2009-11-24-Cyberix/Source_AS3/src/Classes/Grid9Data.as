package Classes{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	public class Grid9Data{
		public var data:Array = new Array(9)
		public function Grid9Data(bitmap:BitmapData,rect:Rectangle){
			var image0Data:BitmapData = new BitmapData(rect.left,rect.top,true)
			var image1Data:BitmapData = new BitmapData(rect.width,rect.top,true)
			var image2Data:BitmapData = new BitmapData(bitmap.width - rect.right,rect.top,true)
			var image3Data:BitmapData = new BitmapData(rect.left,rect.height,true)
			var image4Data:BitmapData = new BitmapData(rect.width,rect.height,true)
			var image5Data:BitmapData = new BitmapData(bitmap.width - rect.right,rect.height,true)
			var image6Data:BitmapData = new BitmapData(rect.left,bitmap.height - rect.bottom,true)
			var image7Data:BitmapData = new BitmapData(rect.width,bitmap.height - rect.bottom,true)
			var image8Data:BitmapData = new BitmapData(bitmap.width - rect.right,bitmap.height - rect.bottom,true)
			var pt:Point = new Point(0,0)
			image0Data.copyPixels(bitmap,new Rectangle(0,0,rect.left,rect.top),pt,null,null,false)
			image1Data.copyPixels(bitmap,new Rectangle(rect.left,0,rect.width,rect.top),pt,null,null,false)
			image2Data.copyPixels(bitmap,new Rectangle(rect.right,0,bitmap.width - rect.right,rect.top),pt,null,null,false)
			image3Data.copyPixels(bitmap,new Rectangle(0,rect.top,rect.left,rect.height),pt,null,null,false)
			image4Data.copyPixels(bitmap,new Rectangle(rect.left,rect.top,rect.width,rect.height),pt,null,null,false)
			image5Data.copyPixels(bitmap,new Rectangle(rect.right,rect.top,bitmap.width - rect.right,rect.height),pt,null,null,false)
			image6Data.copyPixels(bitmap,new Rectangle(0,rect.bottom,rect.left,bitmap.height - rect.bottom),pt,null,null,false)
			image7Data.copyPixels(bitmap,new Rectangle(rect.left,rect.bottom,rect.width,bitmap.height - rect.bottom),pt,null,null,false)
			image8Data.copyPixels(bitmap,new Rectangle(rect.right,rect.bottom,bitmap.width - rect.right,bitmap.height - rect.bottom),pt,null,null,false)
			data[0]=image0Data
			data[1]=image1Data
			data[2]=image2Data
			data[3]=image3Data
			data[4]=image4Data
			data[5]=image5Data
			data[6]=image6Data
			data[7]=image7Data
			data[8]=image8Data
		}
	}
}