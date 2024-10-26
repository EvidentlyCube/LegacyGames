package objects {
		import flash.media.Sound
		import flash.media.SoundChannel;
	/**
	* ...
	* @author Default
	*/
	public class SFX {
		public var playingMus:SoundChannel
		public var Musics:Array=new Array(6);
		[Embed(source='../SFX/BowserHit.mp3')]				private var SFX_BOWSERHIT:Class;
		[Embed(source='../SFX/DeadBowser.mp3')]				private var SFX_BOWSERKILL:Class;
		[Embed(source='../SFX/brickshatter.mp3')]			private var SFX_BRICK:Class;
		[Embed(source='../SFX/Bump.mp3')]					private var SFX_BUMP:Class;
		[Embed(source='../SFX/Cannon.mp3')]					private var SFX_CANNON:Class;
		[Embed(source='../SFX/coin.mp3')]					private var SFX_COIN:Class;
		[Embed(source='../SFX/die.mp3')]					private var SFX_DEATH:Class;
		[Embed(source='../SFX/fireball.mp3')]				private var SFX_FIREBALL:Class;
		[Embed(source='../SFX/GameOver.mp3')]				private var SFX_GAMEOVER:Class;
		[Embed(source='../SFX/Growl.mp3')]					private var SFX_GROWL:Class;
		[Embed(source='../SFX/hurry.mp3')]					private var SFX_HURRY:Class;
		[Embed(source='../SFX/jump.mp3')]					private var SFX_JUMP:Class;
		[Embed(source='../SFX/kick.mp3')]					private var SFX_KICK:Class;
		[Embed(source='../SFX/LakituThrow.mp3')]			private var SFX_LAKITU:Class;
		[Embed(source='../SFX/levelcomplete.mp3')]			private var SFX_LEVEL_COMPLETE:Class;
		[Embed(source='../SFX/1up.mp3')]					private var SFX_LIFE:Class;
		[Embed(source='../SFX/Points.mp3')]					private var SFX_POINTS:Class;
		[Embed(source='../SFX/powerdown.mp3')]				private var SFX_POWERDOWN:Class;
		[Embed(source='../SFX/powerup.mp3')]				private var SFX_POWERUP:Class;
		[Embed(source='../SFX/itemsprout.mp3')]				private var SFX_SPROUT:Class;
		[Embed(source='../SFX/stomp.mp3')]					private var SFX_STOMP:Class;
		[Embed(source='../SFX/stomp2.mp3')]					private var SFX_STOMP2:Class;
		[Embed(source='../SFX/mus1.mp3')]					private var SFX_MUS1:Class;
		[Embed(source='../SFX/mus2.mp3')]					private var SFX_MUS2:Class;
		[Embed(source='../SFX/mus3.mp3')]					private var SFX_MUS3:Class;
		[Embed(source='../SFX/mus4.mp3')]					private var SFX_MUS4:Class;
		[Embed(source='../SFX/mus5.mp3')]					private var SFX_MUS5:Class;
		[Embed(source='../SFX/mus6.mp3')]					private var SFX_MUS6:Class;
		[Embed(source='../SFX/mus7.mp3')]					private var SFX_MUS7:Class;
		[Embed(source='../SFX/mus8.mp3')]					private var SFX_MUS8:Class;
		[Embed(source='../SFX/mus9.mp3')]					private var SFX_MUS9:Class;
		public function SFX() {
			Musics[0]=new SFX_MUS1
			Musics[1]=new SFX_MUS2
			Musics[2]=new SFX_MUS3
			Musics[3]=new SFX_MUS4
			Musics[4]=new SFX_MUS5
			Musics[5]=new SFX_MUS6
			Musics[6]=new SFX_MUS7
			Musics[7]=new SFX_MUS8
			Musics[8]=new SFX_MUS9
		}
		public function accessSFX(text:String):Class{
			switch(text){
				case("bowser_hit"):				return SFX_BOWSERHIT;
				case("bowser_kill"):			return SFX_BOWSERKILL;
				case("brick"):					return SFX_BRICK;
				case("bump"):					return SFX_BUMP;
				case("coin"):					return SFX_COIN;
				case("cannon"):					return SFX_CANNON;
				case("death"):					return SFX_DEATH;
				case("radish"):					return SFX_FIREBALL;
				case("gameover"):				return SFX_GAMEOVER;
				case("growl"):					return SFX_GROWL;
				case("hurry"):					return SFX_HURRY;
				case("jump"):					return SFX_JUMP;
				case("kick"):					return SFX_KICK;
				case("lakitu"):					return SFX_LAKITU;
				case("level_complete"):			return SFX_LEVEL_COMPLETE;
				case("life"):					return SFX_LIFE;
				case("points"):					return SFX_POINTS;
				case("powerdown"):				return SFX_POWERDOWN;
				case("powerup"):				return SFX_POWERUP;
				case("sprout"):					return SFX_SPROUT;
				case("stomp"):					return SFX_STOMP;
				case("stompduck"):				return SFX_STOMP2;
			}
			return new Class;
		}
		public function Play(music:int=-1,loops:uint=100):void{
			if (playingMus!=null){
				playingMus.stop()
			}
			if (Mario.music==false){
				return;
			}
			if (music>-1){
				playingMus=Musics[music].play(0,loops)
			}
		}
	}

}