package com.mauft.PlatformerEngine.objects.objects{
	import com.mauft.PlatformerEngine.Engine;
	import com.mauft.PlatformerEngine.Geometry;
	
	import flash.display.MovieClip;
	import flash.geom.Point;
	public class TElevator{
		public static var blockers:Array=new Array
		protected var x:Number
		protected var y:Number
		protected var width:Number
		protected var height:Number
		protected var hook:Boolean=false
		protected var gfx:MovieClip
		public function TElevator(){
			
		}
		public function Step():void{
			if (Engine.player.sequence!=0){return}
			if (Geometry.RectRect3(x, y, width, height, Engine.player)){
				if (Engine.player.y+Engine.player.height-Engine.player.gravity-2<y){
					hook=true
					Engine.player.isStanding=true
					Engine.player.gravity=0
				}
			}
			if (hook){
				if (!Engine.player.isStanding || Engine.player.x+Engine.player.width-1<x || Engine.player.x>x+width-1){
					hook=false
					
				} else {
					Engine.player.y=y-Engine.player.height
					Engine.player.gravity=0
				}
			}
			Update()
		}
		public function Update():void{}
		public static function Collide(o:TElevator):Boolean{
			var p:Point
			for (var i:uint=0; i<blockers.length; i++){
				p=blockers[i]
				if (Geometry.RectRect2(o.x, o.y, o.width, o.height, p.x, p.y, 1, 1)){
					return true
				}
			}
			return false
			
		}
	}
}