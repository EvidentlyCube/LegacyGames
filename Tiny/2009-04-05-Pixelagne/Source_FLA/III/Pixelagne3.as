package{
	import flash.display.*
	import flash.events.*
	import flash.filters.*
	import flash.geom.*
	import flash.net.*
	import enemier;
	import flash.text.*
	public class Pixelagne3 extends MovieClip{
		public static var self:Pixelagne3
		public static var player:MovieClip
		public static var s:uint
		public static var lBoom:Sprite=new Sprite
		public function Pixelagne3():void{
			self=this
			addChildAt(lBoom,0)
		}
	}
}