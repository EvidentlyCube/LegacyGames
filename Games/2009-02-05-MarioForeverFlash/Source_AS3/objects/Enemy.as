/**
* ...
* @author Default
* @version 0.1
*/

package objects {
	import flash.display.*;
	import mx.core.BitmapAsset;
	import flash.media.Sound;
	public class Enemy {
		public var isShell:Boolean=false;
		public var eX:Number;
		public var eY:Number;
		public var eWid:uint;
		public var eHei:uint;
		public var dir:int;
		public var gravity:Number = 0;
		public var active:Boolean = false;
		public var stomped:Boolean = false;
		public var bounce:Boolean = true;
		public var alive:Boolean = true;
		public var SFXKick:Sound=new (Mario.classSFX.accessSFX("kick"));
		public function Enemy() {
		}
		public function Update(myID:uint):void{
		}
		public function Fire(myID:uint,dir:int):Boolean{
			return false;
		}
		public function Stomp(myID:uint):void{
		}
		public function FireballHit(myID:uint,dir:int):Boolean{
			Fire(myID,dir);
			Mario.instEffects.push(new Points(eX+10,eY-5,"200"));
			if (Mario.sounds){SFXKick.play();}
			return true;
		}
	}
}
