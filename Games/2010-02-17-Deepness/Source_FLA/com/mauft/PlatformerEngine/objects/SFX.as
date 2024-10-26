package com.mauft.PlatformerEngine.objects{
	import flash.media.Sound;
	import flash.media.SoundChannel;
	
	public class SFX{
		public static var STEP_GROUND:Sound
		public static var BLASTER:Sound
		public static var BLOB_KILL:Sound
		public static var BLOB_HIT:Sound
		public static var CANNON:Sound
		public static var CHOPPER_HIT:Sound
		public static var CHOPPER_KILL:Sound
		public static var CHOPPER_CRASH:Sound
		public static var FOOTSTEP:Sound
		public static var MUSIC:Sound
		public static var DEAD:Sound
		public static var COIN:Sound
		public static var GROAN:Sound
		public static var JUMP:Sound
		public static var mus:Boolean=true
		public static var sfx:Boolean=true
		public static var mch:SoundChannel
		public function SFX(){
			STEP_GROUND=new SFX_STEP_GROUND
			CANNON=new SFX_CANNON
			BLASTER=new SFX_BLASTER
			BLOB_KILL=new SFX_BLOB_KILL
			BLOB_HIT=new SFX_BLOB_HIT
			DEAD=new SFX_DEAD
			CHOPPER_HIT=new SFX_CHOPPER_HIT
			CHOPPER_KILL=new SFX_CHOPPER_KILL
			CHOPPER_CRASH=new SFX_CHOPPER_CRASH
			COIN=new SFX_COIN
			MUSIC=new SFX_MUSIC
			GROAN=new SFX_GROAN
			JUMP=new SFX_JUMP
			FOOTSTEP=new SFX_FOOTSTEP
		}
		public static function musUpdate():void{
			if (mus){
				if (!mch){
					mch=MUSIC.play(0,1000)
				}
			} else {
				if (mch){
					mch.stop()
					mch=null
				}
			}
		}
	}
}