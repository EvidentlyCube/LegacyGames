/* Platformer Engine by Mauft.com
__Geometry__
Some basic geometry.
*/
package com.mauft.PlatformerEngine{
	import com.mauft.PlatformerEngine.objects.TObject;
	
	public class Geometry{
		private static var tempX:Number
		private static var tempY:Number
		public function Geometry(){}
		/*This function returns true if o1 and o2 intersect
		*/
		public static function RectRect1(o1:TObject, o2:TObject):Boolean{
			return RectRect2(o1.x, o1.y, o1.width, o1.height, o2.x, o2.y, o2.width, o2.height)
		}
		/*This function returns true if provided dimensions intersect
		*/
		public static function RectRect2(x1:Number, y1:Number, w1:Number, h1:Number, x2:Number, y2:Number, w2:Number, h2:Number):Boolean{
			tempX=x2-x1
			tempY=y2-y1
			if (tempX>=-w2 && tempX<=w1 && tempY>=-h2 && tempY<=h1){
				return true
			} else {
				return false
			}
		}
		/*This function return true if provided dimensions intersect agains provided object
		*/
		public static function RectRect3(x:Number, y:Number, w:Number, h:Number, o:TObject):Boolean{
			return RectRect2(x, y, w, h, o.x, o.y, o.width, o.height)
		}
	}
}