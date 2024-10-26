package com.mauft.PlatformerEngine.objects{
	import flash.media.Sound;
	import flash.media.SoundChannel;
	
	public class SFX{
		public static var STEP1:Sound
		public static var STEP2:Sound
		public static var STEP3:Sound
		public static var STEP4:Sound
		public static var STEP5:Sound
		public static var STEP6:Sound
		public static var CLOCK1:Sound
		public static var CLOCK2:Sound
		public static var CLOCK3:Sound
		public static var CLOCK4:Sound
		public static var JUMP1:Sound
		public static var JUMP2:Sound
		public static var JUMP3:Sound
		public static var DIE1:Sound
		public static var DIE2:Sound
		public static var DIE3:Sound
		public static var END:Sound
		public static var MUSIC:Sound
		public static var CLICK:Sound
		public static var ROVER:Sound
		
		public static var mus:Boolean=true
		public static var sfx:Boolean=true
		public static var mch:SoundChannel
		public function SFX(){
			STEP1=new SFX_STEP_1
			STEP2=new SFX_STEP_2
			STEP3=new SFX_STEP_3
			STEP4=new SFX_STEP_4
			STEP5=new SFX_STEP_5
			STEP6=new SFX_STEP_6
			CLOCK1=new SFX_CLOCK_1
			CLOCK2=new SFX_CLOCK_2
			CLOCK3=new SFX_CLOCK_3
			CLOCK4=new SFX_CLOCK_4
			JUMP1=new SFX_JUMP_1
			JUMP2=new SFX_JUMP_2
			JUMP3=new SFX_JUMP_3
			DIE1=new SFX_DIE_1
			DIE2=new SFX_DIE_2
			DIE3=new SFX_DIE_3
			END=new SFX_END
			MUSIC=new SFX_MUSIC
			CLICK=new SFX_CLICK
			ROVER=new SFX_ROVER
		}
		public static function playEnd():void{
			if (sfx){
				END.play()
			}
		}
		public static function playStep():void{
			if(sfx){
				switch(Math.floor(Math.random()*6)){
					case(0):STEP1.play();break;
					case(1):STEP2.play();break;
					case(2):STEP3.play();break;
					case(3):STEP4.play();break;
					case(4):STEP5.play();break;
					case(5):STEP6.play();break;
				}
			}
		}
		public static function playClock():void{
			if(sfx){
				switch(Math.floor(Math.random()*4)){
					case(0):CLOCK1.play();break;
					case(1):CLOCK2.play();break;
					case(2):CLOCK3.play();break;
					case(3):CLOCK4.play();break;
				}
			}
		}
		public static function playJump():void{
			if(sfx){
				switch(Math.floor(Math.random()*3)){
					case(0):JUMP2.play();break;
					case(1):JUMP2.play();break;
					case(2):JUMP3.play();break;
				}
			}
		}
		public static function playDie():void{
			if(sfx){
				switch(Math.floor(Math.random()*3)){
					case(0):DIE1.play();break;
					case(1):DIE2.play();break;
					case(2):DIE3.play();break;
				}
			}
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