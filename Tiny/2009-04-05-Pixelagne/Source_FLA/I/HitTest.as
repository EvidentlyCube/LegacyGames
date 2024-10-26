 
package{

	public class HitTest {
		import flash.display.DisplayObject;
		import flash.display.BitmapData;
		import flash.geom.ColorTransform;
		import flash.geom.Matrix;
		import flash.geom.Rectangle;
		
		static public function hitTestObject(object1:DisplayObject, object2:DisplayObject):Boolean {
			var distance2: Number = Math.pow(object2.x - object1.x, 2) + Math.pow(object2.y- object1.y, 2);
			
			return distance2 < Math.pow(object1.width * 0.4, 2) + Math.pow(object2.width * 0.4, 2);
		}
	}
}
