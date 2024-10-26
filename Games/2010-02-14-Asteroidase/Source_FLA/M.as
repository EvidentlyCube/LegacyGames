package{
	import flash.display.MovieClip;
	import flash.events.Event
	import flash.display.Sprite
	import flash.display.StageScaleMode
	import com.mauft.DataVault.Vault;
	import flash.media.SoundChannel
	dynamic public class M extends MovieClip{
		private static const STAREZ:int = 100
		private var _stars:Vector.<Star> = new Vector.<Star>(STAREZ, true);
		
		public static var layerStars:Sprite = new Sprite;
		
		public static var sfx:Boolean = true
		public static var player:Object;
		public static var self:M;
		public static var started:Boolean = false;
		public static var scoring:Boolean = false;
		public static var waiter:int = 0;
		public static var musa:SoundChannel = null;
		public function M():void{
			self = this;
			
			var i:uint
			for (i = 0; i<STAREZ; i++){
				_stars[i] = new Star();
				layerStars.addChild(_stars[i]);
			}
			
			Vault.setValue("score", 0);
			Vault.setValue("multi", 1000);
		}
		private function step(e:Event):void{
			if (!contains(layerStars)){
				addChildAt(layerStars, 1);
			}
			setChildIndex(BGer, 0)
			if (!player){return}
			if (sfx){
				if (!musa){
					musa = (new MUSIC).play(0, 1000);
				}
			} else {
				if (musa){
					musa.stop();
					musa = null;
				}
			}
					
			for each(var star:Star in _stars){
				star.update();
			}
			if (M.player.anim == false && started){
				Vault.setValue("score", Vault.retrieveValue("score")+1);
				Vault.setValue("multi", Math.max(1000, Vault.retrieveValue("multi")-3));
			}
			
			waiter++;
			if (waiter == 100){
				waiter = 0;
				var c:ENEMY = new ENEMY;
				c.x = 520+Math.random()*100;
				c.y = Math.random()*400;
				trace(getChildIndex(layerStars));
				self.addChildAt(c, getChildIndex(layerStars)+1);
			}
		}
		
		public static function get playerBreaks():Number{ return 0.92; }
		
		public static function addScore():void{
			Vault.setValue("score", Vault.retrieveValue("score") + Math.floor(1*Vault.retrieveValue("multi")/1000));
			Vault.setValue("multi", Vault.retrieveValue("multi")+20+Math.floor(Math.abs(player.hSpeed) + Math.abs(player.vSpeed)));
		}
		
		public static function getScore():uint{
			return Vault.retrieveValue("score");
		}
		public static function getMulti():String{
			var st:String = (Vault.retrieveValue("multi")%1000).toString();
			while (st.length<3){
				st = "0"+st;
			}
			return Math.floor(Vault.retrieveValue("multi")/1000)+"."+st;
		}
	}
}