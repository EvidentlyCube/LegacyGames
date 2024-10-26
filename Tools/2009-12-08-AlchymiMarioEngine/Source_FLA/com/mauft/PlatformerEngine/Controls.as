/*Platformer Engine by Mauft.com
__Controls__
This static class controls all controls-related things. 
*/

package com.mauft.PlatformerEngine{
	import flash.events.KeyboardEvent;
	public class Controls{
		private static var _hitUp:uint=0
		private static var _hitDown:uint=0
		private static var _hitLeft:uint=0
		private static var _hitRight:uint=0
		private static var _hitJump:uint=0
		private static var _hitFire:uint=0
		
		public static var holdUp:Boolean=false
		public static var holdDown:Boolean=false
		public static var holdLeft:Boolean=false
		public static var holdRight:Boolean=false
		public static var holdJump:Boolean=false
		public static var holdFire:Boolean=false
		
		public static var disabled:Boolean=false		//If set to true, the game stops reading Input signals, use puppet() to control player then
		
		public function Controls():void{}
		public static function Update():void{
			if (_hitUp==1){_hitUp=2} else {_hitUp=0}
			if (_hitDown==1){_hitDown=2} else {_hitDown=0}
			if (_hitLeft==1){_hitLeft=2} else {_hitLeft=0}
			if (_hitRight==1){_hitRight=2} else {_hitRight=0}
			if (_hitJump==1){_hitJump=2} else {_hitJump=0}
			if (_hitFire==1){_hitFire=2} else {_hitFire=0}
		}
		public static function get hitUp():Boolean{
			if (_hitUp==2){
				return true
			} else {
				return false
			}
		}
		public static function get hitDown():Boolean{
			if (_hitDown==2){
				return true
			} else {
				return false
			}
		}
		public static function get hitLeft():Boolean{
			if (_hitLeft==2){
				return true
			} else {
				return false
			}
		}
		public static function get hitRight():Boolean{
			if (_hitRight==2){
				return true
			} else {
				return false
			}
		}
		public static function get hitJump():Boolean{
			if (_hitJump==2){
				return true
			} else {
				return false
			}
		}
		public static function get hitFire():Boolean{
			if (_hitFire==2){
				return true
			} else {
				return false
			}
		}
		
		public static function listenerDown(e:KeyboardEvent):void{
			if (disabled){return}
			switch (e.keyCode){
				case(Settings.KEY_LEFT):
					if (_hitLeft==0){_hitLeft=1}
					holdLeft=true
					break;
				case(Settings.KEY_RIGHT):
					if (_hitRight==0){_hitRight=1}
					holdRight=true
					break;
				case(Settings.KEY_UP):
					if (_hitUp==0){_hitUp=1}
					holdUp=true
					break;
				case(Settings.KEY_DOWN):
					if (_hitDown==0){_hitDown=1}
					holdDown=true
					break;
				case(Settings.KEY_JUMP):
					if (_hitJump==0){_hitJump=1}
					holdJump=true
					break;
				case(Settings.KEY_FIRE):
					if (_hitFire==0){_hitFire=1}
					holdFire=true
					break;
			}
		}
		public static function listenerUp(e:KeyboardEvent):void{
			if (disabled){return}
			switch (e.keyCode){
				case(Settings.KEY_LEFT):
					holdLeft=false
					break;
				case(Settings.KEY_RIGHT):
					holdRight=false
					break;
				case(Settings.KEY_UP):
					holdUp=false
					break;
				case(Settings.KEY_DOWN):
					holdDown=false
					break;
				case(Settings.KEY_JUMP):
					holdJump=false
					break;
				case(Settings.KEY_FIRE):
					holdFire=false
					break;
			}
		}
		/*Puppet - with this little fella you can control player.
		As KEY pass the key value from Settings (say, Settings.KEY_LEFT).
		As UP pass TRUE to RELEASE the key, or FALSE to PUSH the key!
		If you want to make the player move right, pass puppet(Settings.KEY_RIGHT,false)
		If you want to stop him then, pass puppet(Settings.KEY_RIGHT,true)
		*/
		public static function puppet(key:uint,up:Boolean):void{
			if (up){
				switch (key){
					case(Settings.KEY_LEFT):
						holdLeft=false
						break;
					case(Settings.KEY_RIGHT):
						holdRight=false
						break;
					case(Settings.KEY_UP):
						holdUp=false
						break;
					case(Settings.KEY_DOWN):
						holdDown=false
						break;
					case(Settings.KEY_JUMP):
						holdJump=false
						break;
					case(Settings.KEY_FIRE):
						holdFire=false
						break;
				}
			} else {
				switch (key){
					case(Settings.KEY_LEFT):
						if (_hitLeft==0){_hitLeft=1}
						holdLeft=true
						break;
					case(Settings.KEY_RIGHT):
						if (_hitRight==0){_hitRight=1}
						holdRight=true
						break;
					case(Settings.KEY_UP):
						if (_hitUp==0){_hitUp=1}
						holdUp=true
						break;
					case(Settings.KEY_DOWN):
						if (_hitDown==0){_hitDown=1}
						holdDown=true
						break;
					case(Settings.KEY_JUMP):
						if (_hitJump==0){_hitJump=1}
						holdJump=true
						break;
					case(Settings.KEY_FIRE):
						if (_hitFire==0){_hitFire=1}
						holdFire=true
						break;
				}
			}
		}
	}
}