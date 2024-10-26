/*Platformer Engine by Mauft.com
__Controls__
This static class controls all controls-related things.
*/

package com.mauft.PlatformerEngine{
	import com.mauft.PlatformerEngine.objects.SFX;

	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.ui.Keyboard;
	public class Controls{
		public static var cheatAltControls: Boolean = false;
		public static var isDownRight:Boolean = false
		public static var isDownLeft:Boolean = false
		public static var isJump:Boolean = false

		public static function get isAnyInput() {
			return isDownRight || isDownLeft || isJump;
		}

		public static var disabled:Boolean=false		//If set to true, the game stops reading Input signals, use puppet() to control player then

		public function Controls():void{}
		public static function Update():void{
			if (!cheatAltControls) {
				isDownLeft = false;
				isJump = false;
			}
		}

		public static function listenerDown(e:KeyboardEvent):void{
			if(Engine._stage.focus as TextField){return}
			if (disabled){return}
			
			switch (e.keyCode){
				case(Keyboard.SPACE): // Space
				case(Keyboard.Z): // Z
					if (cheatAltControls) {
						isJump = true;
					} else {
						isDownRight = true;
					}
					break;
				case(Keyboard.LEFT):
					if (cheatAltControls) {
						isDownLeft = true;
					}
					break;
				case(Keyboard.RIGHT):
					if (cheatAltControls) {
						isDownRight = true;
					}
					break;
				case(Keyboard.UP):
					if (cheatAltControls) {
						isJump = true;
					}
					break;
				case(83):
					if (SFX.sfx==true){SFX.sfx=false} else {SFX.sfx=true}
					break;
				case(77):
					if (SFX.mus==true){SFX.mus=false} else {SFX.mus=true}
					break;
				case(Keyboard.ESCAPE):
				case(Keyboard.Q):
					if (Engine._gamefield.currentFrame<5){return}
					disabled=true
					Engine.bgFaderTo=1
					Engine.bgFaderState=2
					break;
			}
		}
		public static function listenerUp(e:KeyboardEvent):void{
			if (disabled){return}
			switch (e.keyCode){
				case(Keyboard.SPACE): // Space
				case(Keyboard.Z): // Z
					if (cheatAltControls) {
						isJump = false;
					} else {
						isDownRight = false;
					}
					break;
				case(Keyboard.LEFT):
					if (cheatAltControls) {
						isDownLeft = false;
					}
					break;
				case(Keyboard.RIGHT):
					if (cheatAltControls) {
						isDownRight = false;
					}
					break;
				case(Keyboard.UP):
					if (cheatAltControls) {
						isJump = false;
					}
					break;
			}
		}
		public static function mouseDown(e:MouseEvent):void{
			if (disabled){return}
			if (!cheatAltControls) {
				isDownRight = true;
			}
		}
		public static function mouseUp(e:MouseEvent):void{
			if (disabled){return}
			if (!cheatAltControls) {
				isDownRight = false;
				isJump = true;
			}
		}
		public static function endLevel():void{
			isDownLeft = false;
			isDownRight = false;
			isJump = false;
		}
	}
}