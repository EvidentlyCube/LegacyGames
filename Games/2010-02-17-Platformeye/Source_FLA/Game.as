package{
	import flash.display.*
	import flash.events.*
	import flash.media.*
	import flash.text.*
	import flash.ui.Keyboard
	import flash.net.navigateToURL
	import flash.net.URLRequest
	dynamic public class Game extends MovieClip{
		public static var lvl:Array
		public static var coins:uint=0
		public static var coinArr:Array=new Array()
		public static var p:*
		public static var pX:uint
		public static var pY:uint
		public static var anim:MovieClip
		public static var layer_enemies:Sprite
		public static var self:Game
		public static var nextLev:uint=0
		public static var unlocked:Array
		public static var sfx:Boolean=true
		public static var sc:SoundChannel=null
		public static var kills:uint = 0;
		public function Game():void{
			unlocked=[0,0,0,0,0,0,0]
			self=this
			lvl=new Array(17)
			for (var i:uint=0;i<17;i++){
				lvl[i]=new Array(13)
			}
			stop()
		}
		public static function checkTile(ix:int,iy:int):Boolean{
			if (ix<0 || iy<0 || ix>16 || iy>12){
				return true;
			}
			if (lvl[ix][iy]){return true} else {return false}
		}
		public static function fill(ix:int,iy:int):void{
			if (ix<0 || iy<0 || ix>16 || iy>12){
				return;
			}
			lvl[ix][iy]=1
		}
		public static function Clear():void{
			lvl=new Array(17)
			for (var i:uint=0;i<17;i++){
				lvl[i]=new Array(13)
			}
		}
	}
}