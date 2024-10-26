/**
* ...
* @author Default
* @version 0.1
*/

package objects {
	import flash.display.*;
	import mx.core.BitmapAsset;
	import flash.media.Sound;
	public class Block{
		internal var bX:Number;
		internal var bY:Number;
		internal var SFXBrick:Sound=new (Mario.classSFX.accessSFX("brick"));
		public function Block(){
		}
		public function Update(myID:uint):void{
		}
		public function Headbutt(myID:uint):void{
			
		}
	}
}