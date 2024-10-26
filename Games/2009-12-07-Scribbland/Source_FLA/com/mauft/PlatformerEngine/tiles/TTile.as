package com.mauft.PlatformerEngine.tiles{
	import com.mauft.PlatformerEngine.Engine;
	import com.mauft.PlatformerEngine.objects.TObject;
	import com.mauft.PlatformerEngine.objects.TPlayer;
	
	import flash.errors.*;
	public class TTile{
		public function get friction():Number{return 1}
		public function get maxSpeed():Number{return 1}
		public function get maxJump():Number{return 1}
		public function get gravity():Number{return 1}
		public function get blockUncrouch():Boolean{return true}
		public function TTile(){}
		public function stomped(o:TObject):void{
			o.StopFall()
			
			o.floorSet(friction,maxSpeed,maxJump,gravity)
		}
		public function landed(o:TObject):void{stomped(o)}
		public function headbutt(o:TObject):void{
			o.StopJump()
		}
		public function pokedLeft(o:TObject):void{
			o.StopHorizontal()	
		}
		public function pokedRight(o:TObject):void{pokedLeft(o)}
	}
}