package Obs
{
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import mx.core.BitmapAsset;
	/**
	 * ...
	 * @author DefaultUser (Tools -> Custom Arguments...)
	 */
	public class Sounder{
		[Embed(source = "/../assets/gfx/gfx7.png")] private var G1:Class;
		[Embed(source = "/../assets/gfx/gfx8.png")] private var G2:Class;
		[Embed(source = "/../assets/music/omogenic/omogenic.mp3")] private var S1:Class;
		public static var mus:Sound;
		public static var chan:SoundChannel;
		public static var GFX1:BitmapAsset;
		public static var GFX2:BitmapAsset
		public static var on:uint=1
		public function Sounder(){
			GFX1 = new G1
			GFX2 = new G2
			mus=new S1;
			GFX1.x=GFX1.y=GFX2.x=GFX2.y=540
			GFX1.alpha=GFX2.alpha=0.6
			Game.layertop.addChild(GFX2)
			chan=mus.play(0,1000)
		}
		public static function Update():void{
			if (Pointer.x>17&& Pointer.y>17){
				GFX1.alpha=GFX2.alpha=1
			} else {
				GFX1.alpha=GFX2.alpha=0.6
			}
		}
		public static function Click():void{
			if (Pointer.x>17 && Pointer.y>17){
				if (on==1){
					Game.layertop.removeChild(GFX2)
					Game.layertop.addChild(GFX1)
					chan.stop()
				} else {
					Game.layertop.removeChild(GFX1)
					Game.layertop.addChild(GFX2)
					chan=mus.play(0,1000)
				}
				on=1-on
			}
		}
	}

}